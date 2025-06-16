package com.guihang2.bbs_forum.common.typehandler;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BlobTypeHandler extends BaseTypeHandler<byte[]> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, byte[] parameter, JdbcType jdbcType) throws SQLException {
        if (parameter == null) {
            ps.setNull(i, java.sql.Types.BLOB);
        } else {
            ps.setBytes(i, parameter);
        }
    }

    @Override
    public byte[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
        Blob blob = rs.getBlob(columnName);
        return blob != null ? blob.getBytes(1, (int) blob.length()) : null;
    }

    @Override
    public byte[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        Blob blob = rs.getBlob(columnIndex);
        return blob != null ? blob.getBytes(1, (int) blob.length()) : null;
    }

    @Override
    public byte[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        Blob blob = cs.getBlob(columnIndex);
        return blob != null ? blob.getBytes(1, (int) blob.length()) : null;
    }
}
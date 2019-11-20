Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166D0104347
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 19:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfKTSYw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 13:24:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36972 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfKTSYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 13:24:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id p24so145144pfn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yONqXE/ZzZ3UHCn/pHjqPw1n04MfzutYZUQfl0J7kV8=;
        b=nyuH4pxkmcthI3U1da1IboUnNNmwnt/Lz9Guaw3nuEMvn1s+FZN19a+paXm+bpCut7
         8uH0ne3LzPElbqpjz1RSsSl1XvbB32r+MY0LY83J6uBx+Ie5Io/g8iL9v9fIk7NSClAB
         MxK6j6ZYX7MpzxaK5oFhYvEz7eLJ8r5HvWh53auVjIHBwcQA/WreqqgeMr7FHvUyjmcZ
         w/DYY++4wtJcov3AvKpCKinQUWDN6N32gTY5YYGzKx9yo1B8QAtGq3z8gdzEWCB1oVPL
         dQly2CL4WK+7Uq+cgUQH8mhKHP0blMKXmSb1rL4bTHIAn/y5E6Xkol9Lfum6p1bOidJl
         GfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yONqXE/ZzZ3UHCn/pHjqPw1n04MfzutYZUQfl0J7kV8=;
        b=O38aiI6cHGe0SLivEltZucls5B11qnXaYrMbfCIKngigxO1bTlK4tE1qpn7vc8+QoR
         CJi3S+GYWQiEUEqiezCiAnBb2tgMMdci3+EinHS3EC0qznVxpFjENImBcTBO7WGqdhUJ
         s89a/K/lWu6cY8WGLdfR3VJC2Y/tZzbKZsoJvkPGYBu+Yble+LZ+kR0ubNFS9MB1utvx
         rumIjKL3BPHmg1I9QRl4sH78QCOS6DU94yCUa3a8tVwy8SHgVaDABq2N6uoPrOKVbulh
         JwwdA+xrFVJbaCdWjhTQFRm3WGTv0elwq6cPK+rLwyQ7O6DtPrJjWZFK6cJPaHoJFTeM
         kLHA==
X-Gm-Message-State: APjAAAWtkGXmYXt5A30Rd/XFjGj80Fk6UUKi3nBIVY/zUvzXT/Jqwiyy
        kbKf3tsYHCZ655oCQlfSqhbSQQ==
X-Google-Smtp-Source: APXvYqwPrCNhnnUwsu+TaAZ6UojdpAzc6BUtV4rd4hSw+NW1U4rd6BhqnbQU22NYeoexbrI2wBqJCA==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr5787937pfq.142.1574274289330;
        Wed, 20 Nov 2019 10:24:49 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:48 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH man-pages v2] Document encoded I/O
Date:   Wed, 20 Nov 2019 10:24:19 -0800
Message-Id: <4d5bf2e4c2a22a6c195c79e0ae09a4475f1f9bdc.1574274173.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574273658.git.osandov@fb.com>
References: <cover.1574273658.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds a new page, encoded_io(7), providing an overview of encoded
I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
reference it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 man2/fcntl.2      |  10 +-
 man2/open.2       |  13 ++
 man2/readv.2      |  64 ++++++++++
 man7/encoded_io.7 | 308 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+), 1 deletion(-)
 create mode 100644 man7/encoded_io.7

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index fce4f4c2b..a9a4c0776 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -222,8 +222,9 @@ On Linux, this command can change only the
 .BR O_ASYNC ,
 .BR O_DIRECT ,
 .BR O_NOATIME ,
+.BR O_NONBLOCK ,
 and
-.B O_NONBLOCK
+.B O_ALLOW_ENCODED
 flags.
 It is not possible to change the
 .BR O_DSYNC
@@ -1803,6 +1804,13 @@ Attempted to clear the
 flag on a file that has the append-only attribute set.
 .TP
 .B EPERM
+Attempted to set the
+.B O_ALLOW_ENCODED
+flag and the calling process did not have the
+.B CAP_SYS_ADMIN
+capability.
+.TP
+.B EPERM
 .I cmd
 was
 .BR F_ADD_SEALS ,
diff --git a/man2/open.2 b/man2/open.2
index b0f485b41..a68576d31 100644
--- a/man2/open.2
+++ b/man2/open.2
@@ -421,6 +421,14 @@ was followed by a call to
 .BR fdatasync (2)).
 .IR "See NOTES below" .
 .TP
+.B O_ALLOW_ENCODED
+Open the file with encoded I/O permissions;
+see
+.BR encoded_io (7).
+The caller must have the
+.B CAP_SYS_ADMIN
+capability.
+.TP
 .B O_EXCL
 Ensure that this call creates the file:
 if this flag is specified in conjunction with
@@ -1168,6 +1176,11 @@ did not match the owner of the file and the caller was not privileged.
 The operation was prevented by a file seal; see
 .BR fcntl (2).
 .TP
+.B EPERM
+The
+.B O_ALLOW_ENCODED
+flag was specified, but the caller was not privileged.
+.TP
 .B EROFS
 .I pathname
 refers to a file on a read-only filesystem and write access was
diff --git a/man2/readv.2 b/man2/readv.2
index af27aa63e..8b5458023 100644
--- a/man2/readv.2
+++ b/man2/readv.2
@@ -265,6 +265,11 @@ the data is always appended to the end of the file.
 However, if the
 .I offset
 argument is \-1, the current file offset is updated.
+.TP
+.BR RWF_ENCODED " (since Linux 5.7)"
+Read or write encoded (e.g., compressed) data.
+See
+.BR encoded_io (7).
 .SH RETURN VALUE
 On success,
 .BR readv (),
@@ -284,6 +289,13 @@ than requested (see
 and
 .BR write (2)).
 .PP
+If
+.B
+RWF_ENCODED
+was specified in
+.IR flags ,
+then the return value is the number of encoded bytes.
+.PP
 On error, \-1 is returned, and \fIerrno\fP is set appropriately.
 .SH ERRORS
 The errors are as given for
@@ -314,6 +326,58 @@ is less than zero or greater than the permitted maximum.
 .TP
 .B EOPNOTSUPP
 An unknown flag is specified in \fIflags\fP.
+.TP
+.B EOPNOTSUPP
+.B RWF_ENCODED
+is specified in
+.I flags
+and the filesystem does not implement encoded I/O.
+.TP
+.B EPERM
+.B RWF_ENCODED
+is specified in
+.I flags
+and the file was not opened with the
+.B O_ALLOW_ENCODED
+flag.
+.PP
+.BR preadv2 ()
+can fail for the following reasons:
+.TP
+.B E2BIG
+.B RWF_ENCODED
+is specified in
+.I flags
+and
+.I iov[0]
+is not large enough to return the encoding metadata.
+.TP
+.B ENOBUFS
+.B RWF_ENCODED
+is specified in
+.I flags
+and the buffers in
+.I iov
+are not big enough to return the encoded data.
+.PP
+.BR pwritev2 ()
+can fail for the following reasons:
+.TP
+.B E2BIG
+.B RWF_ENCODED
+is specified in
+.I flags
+and
+.I iov[0]
+contains non-zero fields
+after the kernel's
+.IR "sizeof(struct\ encoded_iov)" .
+.TP
+.B EINVAL
+.B RWF_ENCODED
+is specified in
+.I flags
+and the alignment and/or size requirements are not met.
 .SH VERSIONS
 .BR preadv ()
 and
diff --git a/man7/encoded_io.7 b/man7/encoded_io.7
new file mode 100644
index 000000000..7be264f6b
--- /dev/null
+++ b/man7/encoded_io.7
@@ -0,0 +1,308 @@
+.\" Copyright (c) 2019 by Omar Sandoval <osandov@fb.com>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.\"
+.TH ENCODED_IO  7 2019-10-14 "Linux" "Linux Programmer's Manual"
+.SH NAME
+encoded_io \- overview of encoded I/O
+.SH DESCRIPTION
+Several filesystems (e.g., Btrfs) support transparent encoding
+(e.g., compression, encryption) of data on disk:
+written data is encoded by the kernel before it is written to disk,
+and read data is decoded before being returned to the user.
+In some cases, it is useful to skip this encoding step.
+For example, the user may want to read the compressed contents of a file
+or write pre-compressed data directly to a file.
+This is referred to as "encoded I/O".
+.SS Encoded I/O API
+Encoded I/O is specified with the
+.B RWF_ENCODED
+flag to
+.BR preadv2 (2)
+and
+.BR pwritev2 (2).
+If
+.B RWF_ENCODED
+is specified, then
+.I iov[0].iov_base
+points to an
+.I
+encoded_iov
+structure, defined in
+.I <linux/fs.h>
+as:
+.PP
+.in +4n
+.EX
+struct encoded_iov {
+    __aligned_u64 len;
+    __aligned_u64 unencoded_len;
+    __aligned_u64 unencoded_offset;
+    __u32 compression;
+    __u32 encryption;
+};
+.EE
+.in
+.PP
+This may be extended in the future, so
+.I iov[0].iov_len
+must be set to
+.I "sizeof(struct\ encoded_iov)"
+for forward/backward compatibility.
+The remaining buffers contain the encoded data.
+.PP
+.I compression
+and
+.I encryption
+are the encoding fields.
+.I compression
+is one of
+.B ENCODED_IOV_COMPRESSION_NONE
+(zero),
+.BR ENCODED_IOV_COMPRESSION_ZLIB ,
+.BR ENCODED_IOV_COMPRESSION_LZO ,
+or
+.BR ENCODED_IOV_COMPRESSION_ZSTD .
+.I encryption
+is currently always
+.B ENCODED_IOV_ENCRYPTION_NONE
+(zero).
+.PP
+.I unencoded_len
+is the length of the unencoded (i.e., decrypted and decompressed) data.
+.I unencoded_offset
+is the offset into the unencoded data where the data in the file begins
+(strictly less than
+.IR unencoded_len ).
+.I len
+is the length of the data in the file.
+.PP
+In most cases,
+.I len
+is equal to
+.I unencoded_len
+and
+.I unencoded_offset
+is zero.
+However, it may be necessary to refer to a subset of the unencoded data,
+usually because a read occurred in the middle of an encoded extent,
+because part of an extent was overwritten or deallocated in some
+way (e.g., with
+.BR write (2),
+.BR truncate (2),
+or
+.BR fallocate (2))
+or because part of an extent was added to the file (e.g., with
+.BR ioctl_ficlonerange (2)
+or
+.BR ioctl_fideduperange (2)).
+For example, if
+.I len
+is 300,
+.I unencoded_len
+is 1000,
+and
+.I unencoded_offset
+is 600,
+then the encoded data is 1000 bytes long when decoded,
+of which only the 300 bytes starting at offset 600 are used;
+the first 600 and last 100 bytes should be ignored.
+.PP
+Additionally,
+.I len
+may be greater than
+.I unencoded_len
+-
+.IR unencoded_offset;
+in this case, the data in the file is longer than the unencoded data,
+and the difference is zero-filled.
+.PP
+If the unencoded data is actually longer than
+.IR unencoded_len ,
+then it is truncated;
+if it is shorter, then it is extended with zeroes.
+.PP
+For
+.BR pwritev2 (),
+the metadata should be specified in
+.IR iov[0] .
+If
+.I iov[0].iov_len
+is less than
+.I "sizeof(struct\ encoded_iov)"
+in the kernel,
+then any fields unknown to userspace are treated as if they were zero;
+if it is greater and any fields unknown to the kernel are non-zero,
+then this returns -1 and sets
+.I errno
+to
+.BR E2BIG .
+The encoded data should be passed in the remaining buffers.
+This returns the number of encoded bytes written (that is, the sum of
+.I iov[n].iov_len
+for 1 <=
+.I n
+<
+.IR iovcnt ;
+partial writes will not occur).
+If the
+.I offset
+argument to
+.BR pwritev2 ()
+is -1, then the file offset is incremented by
+.IR len .
+At least one encoding field must be non-zero.
+Note that the encoded data is not validated when it is written;
+if it is not valid (e.g., it cannot be decompressed),
+then a subsequent read may return an error.
+.PP
+For
+.BR preadv2 (),
+the metadata is returned in
+.IR iov[0] .
+If
+.I iov[0].iov_len
+is less than
+.I "sizeof(struct\ encoded_iov)"
+in the kernel and any fields unknown to userspace are non-zero,
+then this returns -1 and sets
+.I errno
+to
+.BR E2BIG ;
+if it is greater,
+then any fields unknown to the kernel are returned as zero.
+The encoded data is returned in the remaining buffers.
+If the provided buffers are not large enough to return an entire encoded
+extent,
+then this returns -1 and sets
+.I errno
+to
+.BR ENOBUFS .
+This returns the number of encoded bytes read.
+Note that a return value of zero does not indicate end of file;
+one should refer to
+.I len
+(for example, a hole in the file has a non-zero
+.I len
+but a zero return value).
+A
+.I len
+of zero indicates end of file.
+If the
+.I offset
+argument to
+.BR preadv2 ()
+is -1, then the file offset is incremented by
+.IR len .
+This will only return one encoded extent per call.
+This can also read data which is not encoded;
+all encoding fields will be zero in that case.
+.SS Security
+Encoded I/O creates the potential for some security issues:
+.IP * 3
+Encoded writes allow writing arbitrary data which the kernel will decode on
+a subsequent read. Decompression algorithms are complex and may have bugs
+which can be exploited by maliciously crafted data.
+.IP *
+Encoded reads may return data which is not logically present in the file
+(see the discussion of
+.I len
+vs.
+.I unencoded_len
+above).
+It may not be intended for this data to be readable.
+.PP
+Therefore, encoded I/O requires privilege.
+Namely, the
+.B RWF_ENCODED
+flag may only be used when the file was opened with the
+.B O_ALLOW_ENCODED
+flag to
+.BR open (2),
+which requires the
+.B CAP_SYS_ADMIN
+capability.
+.B O_ALLOW_ENCODED
+may be set and cleared with
+.BR fcntl (2).
+Note that it is not cleared on
+.BR fork (2)
+or
+.BR execve (2);
+one may wish to use
+.B O_CLOEXEC
+with
+.BR O_ALLOW_ENCODED .
+.SS Filesystem support
+Encoded I/O is supported on the following filesystems:
+.TP
+Btrfs (since Linux 5.7)
+.IP
+Btrfs supports encoded reads and writes of compressed data.
+The data is encoded as follows:
+.RS
+.IP * 3
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_ZLIB ,
+then the encoded data is a single zlib stream.
+.IP *
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_LZO ,
+then the encoded data is compressed page by page with LZO1X
+and wrapped in the format documented in the Linux kernel source file
+.IR fs/btrfs/lzo.c .
+.IP *
+If
+.I compression
+is
+.BR ENCODED_IOV_COMPRESSION_ZSTD ,
+then the encoded data is a single zstd frame compressed with the
+.I windowLog
+compression parameter set to no more than 17.
+.RE
+.IP
+Additionally, there are some restrictions on
+.BR pwritev2 ():
+.RS
+.IP * 3
+.I offset
+(or the current file offset if
+.I offset
+is -1) must be aligned to the sector size of the filesystem.
+.IP *
+.I len
+must be aligned to the sector size of the filesystem
+unless the data ends at or beyond the current end of the file.
+.IP *
+.I unencoded_len
+and the length of the encoded data must each be no more than 128 KiB.
+This limit may increase in the future.
+.IP *
+The length of the encoded data must be less than or equal to
+.IR unencoded_len .
+.RE
-- 
2.24.0


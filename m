Return-Path: <linux-btrfs+bounces-6705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B0093CB3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD8B281B70
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A89149018;
	Thu, 25 Jul 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="ZFMMooUq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9572146A8A
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950125; cv=none; b=XIMVA7ExCFizC7Dl+yttG9FcJlqveeJ/3siH3VbIR7mzEkuv7aNnfS1Q8gSUpqZMD/6AGM1ZfkOg0ASDLR0fgJNAub/iDm1E/Y9gOecvqQTmnk9yg4y6aj1yyUMYG3AMN7Si9m1ys7IgCezhga1NyYO5crxthU2COwHazMHLajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950125; c=relaxed/simple;
	bh=hGUoZw8LfPE8qs1EV7nuu37M1T/dA1Ezptw4UH7H3ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAb06OvGN9kwc6UiFCYiQW4jaaOKo4UGl80kuMZunZBQ0nwTLwIgcADVzOFOQfRHM4NDiaIKqVQzlTeTO1qKkAcIuRmPLknHIM66wxHAMsLJfoSPe4VzJRfONP9seIkITjg6Bx3hrMXIXVxKp6dil/jip1kaKSrj9eFzG0G5YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=ZFMMooUq; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db15d73f04so258964b6e.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1721950122; x=1722554922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGPCoDxoXJIOgWXDzzxDZ6NSt90MIVYpVAZmNfRyy8Q=;
        b=ZFMMooUq6QUWXp82FUUKj1YpU1roj9GquTgfRMEIao8x4lGPt43M/2kt2aUXDe578T
         tpvADNke8YSLvb78zebtsqC8W9f7HyyOlTVAMJEs3xXXCOg/hGm1vbfaX1SExFtVDiA2
         vMdYYPFA83KlsEO5svPAAldHg2xt/XZWzCPXvPhUVDhJGb+bJQxlhB53G/Q0T25iNxY6
         alSLw3PA3/GqGLmABL69VfIZren0oWHi/8rauVkW4Fcy92jpktSBzfBexBePJugy/8Yh
         kY5F8nzt4zrqvGSpIkeREyJQROoVA3SzukWlWimQDqO6Kbhl9IV3AjIkqyYfi7oiqdk4
         GIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721950122; x=1722554922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGPCoDxoXJIOgWXDzzxDZ6NSt90MIVYpVAZmNfRyy8Q=;
        b=cdQAMpEFOPCOb6DehzhP0iG2D6CY2lbNFF7bZuKgAMzeyNkPqsMpKHs3IAi1vnV75+
         47BCf0jA9DLHvNrgbHxuLb9Ez0ih4vpizgxztI/ul6Yr5jdhvFpdsfyHjqsHB/ksHggZ
         uA27wy0rOHkdAcvhT2xs/1iZnwh3tY+8K3D5Xqv+fexucrCorS7AB/2zRvxSg76tysba
         xGfqH7eOKi/M27nvbwJt8+uAskCJRqtG7e6iHRRRHR0VNe3zD0qYacfX26MnYY1nUPjl
         vpRbHyVeX2ic+9j+7H801OUJkiHdO1V6mM1VR1WGxE4Z/PcBbGGtQtc8EUt5bNHOdJm9
         lg8A==
X-Gm-Message-State: AOJu0Yw/8Z783ywQ4O27X3wDVL/4Mpz4LtfAwxOouY/PAbrEW8vF/rRR
	HuBjMBoHDK8oA0yEMFZ/BmR4XMr/oaAyrJCefI7EUscToFzo+uQ5Bw0hzp9RMLjcUMPYAOCEHjh
	R
X-Google-Smtp-Source: AGHT+IHaztsrJZTHENawOldX9g57sT2RMpLiCEQfqQJoi5iJjzpPF4PrajBdl6ZaLp+c7G5uWfi8dw==
X-Received: by 2002:a05:6808:1924:b0:3d9:4004:ff27 with SMTP id 5614622812f47-3db14118421mr3418295b6e.21.1721950122525;
        Thu, 25 Jul 2024 16:28:42 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::5:d3b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8849aa8sm1457540a12.53.2024.07.25.16.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:28:41 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com,
	Neal Gompa <neal@gompa.dev>,
	Sam James <sam@gentoo.org>
Subject: [PATCH] libbtrfsutil: python: fix build on Python 3.13
Date: Thu, 25 Jul 2024 16:28:35 -0700
Message-ID: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Python 3.13, currently in beta, removed the internal
_PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
it in the path_converter() function because it was based on internal
path_converter() function in CPython [1]. This is causing build failures
on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
version that only uses public functions based on the one in drgn [4].

1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22c69056ffc73/Modules/posixmodule.c#L1253
2: https://bugzilla.redhat.com/show_bug.cgi?id=2245650
3: https://github.com/kdave/btrfs-progs/issues/838
4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/libdrgn/python/util.c#L81

Reported-by: Neal Gompa <neal@gompa.dev>
Reported-by: Sam James <sam@gentoo.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 libbtrfsutil/python/btrfsutilpy.h |  7 +--
 libbtrfsutil/python/module.c      | 98 ++++++++++---------------------
 2 files changed, 33 insertions(+), 72 deletions(-)

diff --git a/libbtrfsutil/python/btrfsutilpy.h b/libbtrfsutil/python/btrfsutilpy.h
index ee70c23a..49702dcc 100644
--- a/libbtrfsutil/python/btrfsutilpy.h
+++ b/libbtrfsutil/python/btrfsutilpy.h
@@ -40,16 +40,13 @@ extern PyTypeObject SubvolumeInfo_type;
 extern PyTypeObject SubvolumeIterator_type;
 extern PyTypeObject QgroupInherit_type;
 
-/*
- * Helpers for path arguments based on posixmodule.c in CPython.
- */
 struct path_arg {
 	bool allow_fd;
-	char *path;
 	int fd;
+	char *path;
 	Py_ssize_t length;
 	PyObject *object;
-	PyObject *cleanup;
+	PyObject *bytes;
 };
 int path_converter(PyObject *o, void *p);
 void path_cleanup(struct path_arg *path);
diff --git a/libbtrfsutil/python/module.c b/libbtrfsutil/python/module.c
index 2657ee28..9b0b86b5 100644
--- a/libbtrfsutil/python/module.c
+++ b/libbtrfsutil/python/module.c
@@ -44,85 +44,49 @@ static int fd_converter(PyObject *o, void *p)
 int path_converter(PyObject *o, void *p)
 {
 	struct path_arg *path = p;
-	int is_index, is_bytes, is_unicode;
-	PyObject *bytes = NULL;
-	Py_ssize_t length = 0;
-	char *tmp;
 
 	if (o == NULL) {
 		path_cleanup(p);
 		return 1;
 	}
 
-	path->object = path->cleanup = NULL;
-	Py_INCREF(o);
-
 	path->fd = -1;
+	path->path = NULL;
+	path->length = 0;
+	path->bytes = NULL;
+	if (path->allow_fd && PyIndex_Check(o)) {
+		PyObject *fd_obj;
+		int overflow;
+		long fd;
 
-	is_index = path->allow_fd && PyIndex_Check(o);
-	is_bytes = PyBytes_Check(o);
-	is_unicode = PyUnicode_Check(o);
-
-	if (!is_index && !is_bytes && !is_unicode) {
-		_Py_IDENTIFIER(__fspath__);
-		PyObject *func;
-
-		func = _PyObject_LookupSpecial(o, &PyId___fspath__);
-		if (func == NULL)
-			goto err_format;
-		Py_DECREF(o);
-		o = PyObject_CallFunctionObjArgs(func, NULL);
-		Py_DECREF(func);
-		if (o == NULL)
+		fd_obj = PyNumber_Index(o);
+		if (!fd_obj)
 			return 0;
-		is_bytes = PyBytes_Check(o);
-		is_unicode = PyUnicode_Check(o);
-	}
-
-	if (is_unicode) {
-		if (!PyUnicode_FSConverter(o, &bytes))
-			goto err;
-	} else if (is_bytes) {
-		bytes = o;
-		Py_INCREF(bytes);
-	} else if (is_index) {
-		if (!fd_converter(o, &path->fd))
-			goto err;
-		path->path = NULL;
-		goto out;
+		fd = PyLong_AsLongAndOverflow(fd_obj, &overflow);
+		Py_DECREF(fd_obj);
+		if (fd == -1 && PyErr_Occurred())
+			return 0;
+		if (overflow > 0 || fd > INT_MAX) {
+			PyErr_SetString(PyExc_OverflowError,
+					"fd is greater than maximum");
+			return 0;
+		}
+		if (fd < 0) {
+			PyErr_SetString(PyExc_ValueError, "fd is negative");
+			return 0;
+		}
+		path->fd = fd;
 	} else {
-err_format:
-		PyErr_Format(PyExc_TypeError, "expected %s, not %s",
-			     path->allow_fd ? "string, bytes, os.PathLike, or integer" :
-			     "string, bytes, or os.PathLike",
-			     Py_TYPE(o)->tp_name);
-		goto err;
+		if (!PyUnicode_FSConverter(o, &path->bytes)) {
+			path->object = path->bytes = NULL;
+			return 0;
+		}
+		path->path = PyBytes_AS_STRING(path->bytes);
+		path->length = PyBytes_GET_SIZE(path->bytes);
 	}
-
-	length = PyBytes_GET_SIZE(bytes);
-	tmp = PyBytes_AS_STRING(bytes);
-	if ((size_t)length != strlen(tmp)) {
-		PyErr_SetString(PyExc_TypeError,
-				"path has embedded nul character");
-		goto err;
-	}
-
-	path->path = tmp;
-	if (bytes == o)
-		Py_DECREF(bytes);
-	else
-		path->cleanup = bytes;
-	path->fd = -1;
-
-out:
-	path->length = length;
+	Py_INCREF(o);
 	path->object = o;
 	return Py_CLEANUP_SUPPORTED;
-
-err:
-	Py_XDECREF(o);
-	Py_XDECREF(bytes);
-	return 0;
 }
 
 PyObject *list_from_uint64_array(const uint64_t *arr, size_t n)
@@ -150,8 +114,8 @@ PyObject *list_from_uint64_array(const uint64_t *arr, size_t n)
 
 void path_cleanup(struct path_arg *path)
 {
+	Py_CLEAR(path->bytes);
 	Py_CLEAR(path->object);
-	Py_CLEAR(path->cleanup);
 }
 
 static PyMethodDef btrfsutil_methods[] = {
-- 
2.45.2



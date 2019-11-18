Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72C8FFE86
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 07:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfKRGbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 01:31:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:38350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfKRGbD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 01:31:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 793B2B246;
        Mon, 18 Nov 2019 06:31:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com
Subject: [PATCH 2/4] btrfs-progs: libbtrfsutil: Convert to designated initialization for BtrfsUtilError_type
Date:   Mon, 18 Nov 2019 14:30:50 +0800
Message-Id: <20191118063052.56970-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118063052.56970-1-wqu@suse.com>
References: <20191118063052.56970-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When compiling btrfs-progs with libbtrfsutil on a python3.8 system, we
got the following warning:

  error.c:169:2: warning: initialization of ‘long int’ from ‘void *’ makes integer from pointer without a cast [-Wint-conversion]
    169 |  NULL,      /* tp_print */
        |  ^~~~
  error.c:169:2: note: (near initialization for ‘BtrfsUtilError_type.tp_vectorcall_offset’)

[CAUSE]
C definition of PyTypeObject changed in python 3.8.
Now at the old tp_print, we have tp_vectorcall_offset.

So we got above warning.

[FIX]
C has designated initialization, which can assign values to each named
member, without hard coding to match the offset.
Also, uninitialized values will be 0, so we can also save a lot of
unneeded "= 0" or "= NULL" lines.

Just use that awesome feature to avoid any future breakage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/error.c | 49 +++++++++----------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/libbtrfsutil/python/error.c b/libbtrfsutil/python/error.c
index 0876c9b42c81..b2076e6bf4d6 100644
--- a/libbtrfsutil/python/error.c
+++ b/libbtrfsutil/python/error.c
@@ -162,41 +162,16 @@ static PyMemberDef BtrfsUtilError_members[] = {
 
 PyTypeObject BtrfsUtilError_type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
-	"btrfsutil.BtrfsUtilError",			/* tp_name */
-	sizeof(BtrfsUtilError),				/* tp_basicsize */
-	0,						/* tp_itemsize */
-	(destructor)BtrfsUtilError_dealloc,		/* tp_dealloc */
-	NULL,						/* tp_print */
-	NULL,						/* tp_getattr */
-	NULL,						/* tp_setattr */
-	NULL,						/* tp_as_async */
-	NULL,						/* tp_repr */
-	NULL,						/* tp_as_number */
-	NULL,						/* tp_as_sequence */
-	NULL,						/* tp_as_mapping */
-	NULL,						/* tp_hash  */
-	NULL,						/* tp_call */
-	(reprfunc)BtrfsUtilError_str,			/* tp_str */
-	NULL,						/* tp_getattro */
-	NULL,						/* tp_setattro */
-	NULL,						/* tp_as_buffer */
-	Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE | Py_TPFLAGS_HAVE_GC,	/* tp_flags */
-	BtrfsUtilError_DOC,				/* tp_doc */
-	(traverseproc)BtrfsUtilError_traverse,		/* tp_traverse */
-	(inquiry)BtrfsUtilError_clear,			/* tp_clear */
-	NULL,						/* tp_richcompare */
-	0,						/* tp_weaklistoffset */
-	NULL,						/* tp_iter */
-	NULL,						/* tp_iternext */
-	NULL,						/* tp_methods */
-	BtrfsUtilError_members,				/* tp_members */
-	NULL,						/* tp_getset */
-	NULL,						/* tp_base */
-	NULL,						/* tp_dict */
-	NULL,						/* tp_descr_get */
-	NULL,						/* tp_descr_set */
-	offsetof(BtrfsUtilError, os_error.dict),	/* tp_dictoffset */
-	NULL,						/* tp_init */
-	NULL,						/* tp_alloc */
-	BtrfsUtilError_new,				/* tp_new */
+	.tp_name		= "btrfsutil.BtrfsUtilError",
+	.tp_basicsize		= sizeof(BtrfsUtilError),
+	.tp_dealloc		= (destructor)BtrfsUtilError_dealloc,
+	.tp_str			= (reprfunc)BtrfsUtilError_str,
+	.tp_flags		=  Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE |
+				   Py_TPFLAGS_HAVE_GC,
+	.tp_doc			= BtrfsUtilError_DOC,
+	.tp_traverse		= (traverseproc)BtrfsUtilError_traverse,
+	.tp_clear		= (inquiry)BtrfsUtilError_clear,
+	.tp_members		= BtrfsUtilError_members,
+	.tp_dictoffset		= offsetof(BtrfsUtilError, os_error.dict),
+	.tp_new			= BtrfsUtilError_new,
 };
-- 
2.24.0


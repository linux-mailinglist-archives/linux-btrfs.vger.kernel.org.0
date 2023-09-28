Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B57B28AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI1XQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:16:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB319F;
        Thu, 28 Sep 2023 16:15:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 30CF05C0130;
        Thu, 28 Sep 2023 19:15:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 28 Sep 2023 19:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695942958; x=
        1696029358; bh=j+KD/sriX+e/wWHTpgo0NBnggBDG5I8dvFVim9K0Vrc=; b=C
        CwtEzJBU0ClN02vR025tZLjVxXMkSFvztoIMIUttAicixX8vbX66NA+RjNJEynbL
        /iRs7zpI2brcDZdm9A5GCNsIhRIw8okh/i7DWItw3jmRc0NlwQyHBuujIRpZIgth
        Je9qZ1qeY1MdLx92eXBnYGa3xkPZsuXJQyDpU17jJQdXVWUKNB6TBruBVqr0XcTb
        nUT5pGtLBpV3lDpSrn6Spn6oYpmAJL6J1VQyB7/DeA+noyh38WE0UDJjno4KGT5p
        6UvMyQZ8TiRnFlSDEZgkSP/hFI/10AkEZiYOh5Uf5V0nQ9QrypGj2pMGoNW8T6eC
        EkP03qbwft2xeICjiVsaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695942958; x=1696029358; bh=j
        +KD/sriX+e/wWHTpgo0NBnggBDG5I8dvFVim9K0Vrc=; b=OSOKL0UUCx2EIE+tT
        07ai3oeD9sFpwd+rz5Jurv2w1oiIVZ7itO7zAwOQrln0H06pgGrj0YXcvD8ClyYd
        +XcVx1KJ58/N/Ijx8inzg/vdWUwkS1oTQhFKZbewoDiI/0eyLYG2uviFbFySyb2b
        dI07dEvtR0KEYCA+5GCpz6KLbEFQi2yIGTebXEGrM3aOW0L+W6eLPZHJ46GNU1Y3
        +qIJLVIN2f/acb+GNHHaLLo3z2Q04v3hmg9LkgA/WRh3JVrOJniTWy0kwsKjcDCo
        iMsDTBEGYbMiAuwWF7H4Dx9xnLf8Po4bDkY9rlW2pjLiUtbnHeAAIaIEORSP6SFo
        jMDxQ==
X-ME-Sender: <xms:LQkWZbj-ylGitZRN1oVyVgpJsDX-77upJBYgiecgzggUbAiWGndPyA>
    <xme:LQkWZYDg3d0I6f2jSeGwhIxWTQiQRUjYxDmnbjd0kpcezyiQFU50hWgDeK57z2S7C
    a0dEIx39ItDK21Hhc4>
X-ME-Received: <xmr:LQkWZbHui7x8_0lcaxFp2FWDQXCXLlery89J1FUoGMmoQpmG6ZQitJcl9XuvaemTFgRrGZosE9ZRTVlAmfmOsdThrDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LQkWZYQTF85e3LKEvnasJyjeyG9suZkgWte7YVgRWsuJ-XAAoGpZ5Q>
    <xmx:LQkWZYyrTy0fnMsi8uAQWWgI1RkwvR8QvRXOVgsVXNzisvqYj5NoiQ>
    <xmx:LQkWZe5uAu2uWUbyaIMQSfPgPnoqpkd4ki0m6_-lhm_eEGds_E1Vow>
    <xmx:LgkWZVqLg8_jfEIKfCJbk7Ti1bdZDTVMISGIBVauD6wukX1dmjPS5w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Sep 2023 19:15:57 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4 1/6] common: refactor sysfs_attr functions
Date:   Thu, 28 Sep 2023 16:16:43 -0700
Message-ID: <0714f6b21000181ab43d3085903859b8ae1e1a32.1695942727.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695942727.git.boris@bur.io>
References: <cover.1695942727.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Expand the has/get/require functions to allow passing a dev by
parameter, and implement the test_dev specific one in terms of the new
generic one.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/rc | 127 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 45 deletions(-)

diff --git a/common/rc b/common/rc
index 1618ded54..c3cd53546 100644
--- a/common/rc
+++ b/common/rc
@@ -4689,47 +4689,33 @@ run_fsx()
 	rm -f $tmp.fsx
 }
 
-# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
+_require_statx()
+{
+	$here/src/stat_test --check-statx ||
+	_notrun "This test requires the statx system call"
+}
+
+# Get the path to the sysfs directory for the fs on a device
 #
 # Only one argument is needed:
-#  - attr: path name under /sys/fs/$FSTYP/DEV
+#  - dev: mounted block device for the fs
 #
 # Usage example:
-#   _require_fs_sysfs error/fail_at_unmount
-_has_fs_sysfs()
+#   _fs_sysfs_dname /dev/mapper/scratch-dev
+_fs_sysfs_dname()
 {
-	local attr=$1
-	local dname
+	local dev=$1
+
+	if [ ! -b "$dev" ]; then
+		_fail "Usage: _fs_sysfs_dname <mounted_device>"
+	fi
 
 	case "$FSTYP" in
 	btrfs)
-		dname=$(findmnt -n -o UUID $TEST_DEV) ;;
+		findmnt -n -o UUID ${dev} ;;
 	*)
-		dname=$(_short_dev $TEST_DEV) ;;
+		_short_dev $dev ;;
 	esac
-
-	if [ -z "$attr" -o -z "$dname" ];then
-		_fail "Usage: _require_fs_sysfs <sysfs_attr_path>"
-	fi
-
-	test -e /sys/fs/${FSTYP}/${dname}/${attr}
-}
-
-# Require the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
-_require_fs_sysfs()
-{
-	_has_fs_sysfs "$@" && return
-
-	local attr=$1
-	local dname=$(_short_dev $TEST_DEV)
-
-	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr}"
-}
-
-_require_statx()
-{
-	$here/src/stat_test --check-statx ||
-	_notrun "This test requires the statx system call"
 }
 
 # Write "content" into /sys/fs/$FSTYP/$DEV/$ATTR
@@ -4753,13 +4739,7 @@ _set_fs_sysfs_attr()
 		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
 	fi
 
-	local dname
-	case "$FSTYP" in
-	btrfs)
-		dname=$(findmnt -n -o UUID ${dev}) ;;
-	*)
-		dname=$(_short_dev $dev) ;;
-	esac
+	local dname=$(_fs_sysfs_dname $dev)
 
 	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
 }
@@ -4781,17 +4761,74 @@ _get_fs_sysfs_attr()
 		_fail "Usage: _get_fs_sysfs_attr <mounted_device> <attr>"
 	fi
 
-	local dname
-	case "$FSTYP" in
-	btrfs)
-		dname=$(findmnt -n -o UUID ${dev}) ;;
-	*)
-		dname=$(_short_dev $dev) ;;
-	esac
+	local dname=$(_fs_sysfs_dname $dev)
 
 	cat /sys/fs/${FSTYP}/${dname}/${attr}
 }
 
+# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#
+# Usage example:
+#   _has_fs_sysfs_attr /dev/mapper/scratch-dev error/fail_at_unmount
+_has_fs_sysfs_attr()
+{
+	local dev=$1
+	local attr=$2
+
+	if [ ! -b "$dev" -o -z "$attr" ];then
+		_fail "Usage: _get_fs_sysfs_attr <mounted_device> <attr>"
+	fi
+
+	local dname=$(_fs_sysfs_dname $dev)
+
+	test -e /sys/fs/${FSTYP}/${dname}/${attr}
+}
+
+# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#
+# Usage example:
+#   _require_fs_sysfs_attr /dev/mapper/scratch-dev error/fail_at_unmount
+_require_fs_sysfs_attr()
+{
+	_has_fs_sysfs_attr "$@" && return
+
+	local dev=$1
+	local attr=$2
+	local dname=$(_fs_sysfs_dname $dev)
+
+	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr}"
+}
+
+# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
+#
+# Only one argument is needed:
+#  - attr: path name under /sys/fs/$FSTYP/DEV
+#
+# Usage example:
+#   _has_fs_sysfs error/fail_at_unmount
+_has_fs_sysfs()
+{
+	_has_fs_sysfs_attr $TEST_DEV "$@"
+}
+
+# Require the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
+_require_fs_sysfs()
+{
+	_has_fs_sysfs "$@" && return
+
+	local attr=$1
+	local dname=$(_short_dev $TEST_DEV)
+
+	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr}"
+}
+
 # Generic test for specific filesystem feature.
 # Currently only implemented to test overlayfs features.
 _require_scratch_feature()
-- 
2.42.0


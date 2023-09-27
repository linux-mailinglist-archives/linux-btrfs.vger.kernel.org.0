Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF57B0F7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjI0XNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:13:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C8F4;
        Wed, 27 Sep 2023 16:13:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C735A5C290F;
        Wed, 27 Sep 2023 19:13:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 27 Sep 2023 19:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695856420; x=
        1695942820; bh=j+KD/sriX+e/wWHTpgo0NBnggBDG5I8dvFVim9K0Vrc=; b=V
        YxG2yI/3XOa0Ind2FBUSR3z0FIOzhH2p1lC9G2aFBOiUd0rxUIcspGdW960NutVH
        rA+jLuzhOSaeII0LTcm9tfoGHiSlbxY4r4Jlfz0BETZWsPr8SqS9MzksQt+Kdemx
        hi+PEDqEpKqOMo606unxWAvG8bOI7NIBQPIrVltaMRYecOpexxsEvqksAxQ152V7
        GdOZHtt+szHLZoI4UC2ZclD7hrwzhdzc0iqHGzrInYsG0EIVP3Rb2jHBikXfJY84
        jp1YhxdCEPvEWkSMfmAzkvpKEug6mRudw388pEr8yMP5fnbdjNvDNKJ6TEsNowRm
        aALuBD5Umc6h4PfIXvZ/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695856420; x=1695942820; bh=j
        +KD/sriX+e/wWHTpgo0NBnggBDG5I8dvFVim9K0Vrc=; b=FCM/PSDxPpaonLtLx
        D1AhmvuAxQxdLo2neJNBZv2Uqy9OskTHdV72/jPxLCS8wJE5ubHh0Nw0TH1bnBFM
        fazjbcvRQD1Jo5sOFj1VBhVz+U2JO3YUCCPq67pjPwyL7NL+pn4sgiSh6E8NaH82
        1nfg+Vk+dRbFetLT2g8zFeqklKsSMgeQhiqaOG2DrpD4HfGho6fPjHC3Q4nozoo6
        /ymu4HklEkaxNeLvt18IRwkau2jfA+4dywRRS4dvz0THcjLT/E2n5cqFr5OIPROb
        DcEXks/kQ7RVvTcYjyXXci8VjnVUFpdqxHimEjThuVoZZlNEoTQpInMKgG0ESQEs
        /INaA==
X-ME-Sender: <xms:JLcUZQdcn-dHfnUMYaMP6N1fasMT72T-OyaOUxGJPho3iP0sBZA6SQ>
    <xme:JLcUZSOV8vvQimgwUbtiMlYyHCRmpShOBPw7ZjWiBBPMZxZimI321HyUJ99JSN2vI
    WAY55qS7z6l-HKaxdM>
X-ME-Received: <xmr:JLcUZRhK6wUBktyngEPkj-StTed8fZr942XFfaolcvUTi41vawv-O6PhvEis2VQJ_sBJwMppF_8CbzQV51c_0P34rKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:JLcUZV-Iw0y54aXl_VMAnqu2ZwcGozefV32rWmtVMeLpQOIOuh4C9w>
    <xmx:JLcUZcsunrGDwbkfziv7mnsvTVfsV28mgCPBh4YmF3eDygSyOtXJJg>
    <xmx:JLcUZcHqbmxgse_LQx82L0J5VhVq0nQ3ZrcGFODvQZ35dV2J5F5Wzw>
    <xmx:JLcUZZWg-SiWGVlMUJR5N3XiChqY8INfwN1FbZJUunj2H2od3Lc5bA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:13:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3 1/6] common: refactor sysfs_attr functions
Date:   Wed, 27 Sep 2023 16:14:33 -0700
Message-ID: <0714f6b21000181ab43d3085903859b8ae1e1a32.1695856385.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695856385.git.boris@bur.io>
References: <cover.1695856385.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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


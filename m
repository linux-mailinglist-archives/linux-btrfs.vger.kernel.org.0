Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1F7B0F71
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjI0XG0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:06:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A4F4;
        Wed, 27 Sep 2023 16:06:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 04BE15C2931;
        Wed, 27 Sep 2023 19:06:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 27 Sep 2023 19:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695855981; x=
        1695942381; bh=j+KD/sriX+e/wWHTpgo0NBnggBDG5I8dvFVim9K0Vrc=; b=c
        QSNaiwzUYBYCBnWionQ6t9U4tIfwrfKaby21QZnUmREKc11ZVlmYa/82aQTVWwzo
        fh7GGYRGTQGoeDB5KMuigNFb8iPLlWGNBnntHouw3bWw67fnD0CjZ5arLjBRI14f
        wlFJeqbVoYVXiaWA+x+y60sFQykJcB5Lsj9lpbzuiilzireqC6BQ/DUguc1SJaUx
        B/tQJ+ufceSrvYfxey70PdBM41UezRqye2+oS544ELR7T7AImtWA4okbAFGrmyVS
        tLPT23eXK5yUXdanTJWSA5N/1Ql224/A547C6AZLi9JnB/wH82ed4FK1wK4zy7LM
        33el/TEd/b4JfawobYbjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695855981; x=1695942381; bh=j
        +KD/sriX+e/wWHTpgo0NBnggBDG5I8dvFVim9K0Vrc=; b=lVeeJPfvFIDp8SuZO
        mtKCzrFWVGwvteBCKqNPmUw8Q08S/XwPPFk9KPTF/cpFqk9es/lZp5afiLz8euST
        sGQMiqJW2xFyfymVIw08mh4XorgJskrYL+ArcdIGyxaDvhhniXEd/J8w4OOWe//r
        VGjST8wCNQyRVzzLCBau5rmQcI5l1SA/0MNYETdgi1UY6rqfkexvMog7lA3kqD6Q
        KCmra92ivWDHaworCg0JVsBzST6IaImmPgSWT0VWb1iPwKdWK/l+dqx7t5PBa/XM
        Crx5+vWApGyO7hge+6xPor31LbTwuERFKBy9xv0fzjDDoN3MokP6/ve+8JTss8ir
        IhzMw==
X-ME-Sender: <xms:bbUUZV8v8A8Y_wvgtGf-u30FCpAupF3twGnPiSkNimmrXqR0OUllJg>
    <xme:bbUUZZuhXem-8NiA5lyYu56kPZo8rebu54Mg2RiZuD4V6oIG3gUkOOOdHa5HKuu57
    hgtcXwpjZ8Zk_QP0zw>
X-ME-Received: <xmr:bbUUZTBpU9gI04YkldLL9oyKXx4sH7dgeKwJs87UREMm8G5OSHiOC4q_yJPncxPWBa8IilRUsSobtfuJpZgCNw_jAhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:bbUUZZdVKOnRUXGmvqHPgUBxMCvX8oCu3EkQ1eRNzAjmBvi5JXm58Q>
    <xmx:bbUUZaPfiZiG1dC7reT0OOl6xUAEtCVarjIzPhJmEzv0iqNumNTyKQ>
    <xmx:bbUUZblGy9aXzkpGShfz81iwzjLoCN6vlkO79YRpj61SroCa6bS-aA>
    <xmx:bbUUZc3chV6Smm0SOrrCt0_otfrBWhrtS0IsDTFTjumCN3TDntWv-Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:06:21 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2 1/6] common: refactor sysfs_attr functions
Date:   Wed, 27 Sep 2023 16:07:13 -0700
Message-ID: <0714f6b21000181ab43d3085903859b8ae1e1a32.1695855635.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695855635.git.boris@bur.io>
References: <cover.1695855635.git.boris@bur.io>
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


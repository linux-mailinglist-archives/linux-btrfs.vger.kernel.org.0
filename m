Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171DF7B0F7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjI0XNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjI0XNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:13:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324DF4;
        Wed, 27 Sep 2023 16:13:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8399B5C290D;
        Wed, 27 Sep 2023 19:13:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 19:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695856422; x=
        1695942822; bh=sRfaRBBkQ04rg2h5cwv6Nv4bH+399vIqUwVvDWHbYBs=; b=s
        Qy8AeD0kybNmmh33JoIG6zNwKIRfnNkWjNJ/SJ02V4SqPwMLD3Hfxga0rsFW8aVv
        VlIDG2fWbq6aPh6okDPOkID5X/qu0vWy0lhk3rNKHEMN3FDu1j9lLTrxyUSHFjRB
        wNITMrQiu8lB7BAhwsolLAIVdS3H34yJ3enmeSPrJjKoVMKGZ2Tx62K+n4k6j8fT
        2sWWZ0LSdhvdcJQsnJOkrkEVhiJqtYqmhSV0HpCsbKn1lRuQVfxatTi0nabLW6GL
        bvHqzM6clinFIqSQ0skuIiXq5Ma+jC+HYRE7TYyDFttNPEHex9yJjPzpX3fm9d/m
        p15X03Pjynl2MUtie+J2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695856422; x=1695942822; bh=s
        RfaRBBkQ04rg2h5cwv6Nv4bH+399vIqUwVvDWHbYBs=; b=UgfCJLkKxnJDWcN5J
        lz2PHdrQ2kdl8sINhwOP2LiOY0ustMlDOuUfyELHEm7Dr4GZivFPK0k/pXBAEqMT
        16dAUo+h8ly0cwx37EjoLa/XcoHrQcHR6kbpBkLyg0TYydr0W3OwTPwy6ktL7ykI
        ZGIIxcxZZ6MjxhZcx4bZV9afehdSVbvs1XA6gDs5/6NldcPIpKz/AfGZXkEV1zBE
        3xMdJFR0Jx848n9xjjbqS3/OeiuDac1DQukCgrjzqV1jf+u2XlIfZjivy6DMhKIS
        TWaoyVdrYaFruZBKAPd/nlhCZEGmGujOQnqdlQb9D9QjndqC+1+4O7ZO2GNtEhx2
        HWSng==
X-ME-Sender: <xms:JrcUZRNsV8z2yIv2LJc55UN1eAH7iFWSm-AY0cm4q-0WgLY9LYrXJA>
    <xme:JrcUZT8yzO9UpXmfuZICIsQVIYn4mLNy2ISinPCSCbFCAtMzARKUUTQoHy7hisVYp
    D4PNc0lef8TAmBCC9s>
X-ME-Received: <xmr:JrcUZQRXinq-J5Q3ubXlMl1VnHiEYPO_VnLQlsNqSIZ2c9A3ysw-VK4IX_p2_yEUh1ZRkg1j8sizgpq9v6-13DMgV_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:JrcUZdsQqGvh42MocTrteIXRp5T9RYW8lQQ23Hh5I1uytfDcNENf8Q>
    <xmx:JrcUZZez24W4A_zEIkslAaVj0yUUIfIm51B_Lw4BeW1Bz8JKxJbpLA>
    <xmx:JrcUZZ29_2NlDTio6sOwQbPD2_TSKjk_fK4_hrNOvWXsuqVeaa2zKA>
    <xmx:JrcUZZE8INPFR9jp-jg6Q5y23YU2MLMwi84kCM0rc69oSfs5hTF0tQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:13:41 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v3 2/6] btrfs: quota mode helpers
Date:   Wed, 27 Sep 2023 16:14:34 -0700
Message-ID: <3c6f4cd053ccd2deb8ee459f5b0e5eb6fd877487.1695856385.git.boris@bur.io>
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

To facilitate skipping tests depending on the qgroup mode after mkfs,
add support for figuring out the mode. This cannot just rely on the new
sysfs file, since it might not be present on older kernels.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index c9903a413..37796cc6e 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -689,3 +689,41 @@ _require_btrfs_scratch_logical_resolve_v2()
 	fi
 	_scratch_unmount
 }
+
+_qgroup_mode()
+{
+	local dev=$1
+
+	if [ ! -b "$dev" ]; then
+		_fail "Usage: _qgroup_mode <mounted_device>"
+	fi
+
+	if _has_fs_sysfs_attr $dev /qgroups/mode; then
+		_get_fs_sysfs_attr $dev qgroups/mode
+	else
+		echo "disabled"
+	fi
+}
+
+_check_regular_qgroup()
+{
+	_qgroup_mode "$@" | grep -q 'qgroup'
+}
+
+_require_scratch_qgroup()
+{
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_check_regular_qgroup $SCRATCH_DEV || _notrun "not running normal qgroups"
+	_scratch_unmount
+}
+
+_require_scratch_enable_simple_quota()
+{
+    _scratch_mkfs >>$seqres.full 2>&1
+    _scratch_mount
+	_qgroup_mode $SCRATCH_DEV | grep 'squota' && _notrun "cannot enable simple quota; on by default"
+    $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT || _notrun "simple quotas not available"
+	_scratch_unmount
+}
-- 
2.42.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76AC7B0F72
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjI0XG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjI0XGZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:06:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E033F5;
        Wed, 27 Sep 2023 16:06:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B90645C2919;
        Wed, 27 Sep 2023 19:06:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 19:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695855983; x=
        1695942383; bh=sRfaRBBkQ04rg2h5cwv6Nv4bH+399vIqUwVvDWHbYBs=; b=t
        SAq2Aw/Vd06LUEN4CQp/EfYRhocwBz+RDBbOhZHfdkSuxGcwwB0Lam4Y9aMUupoS
        385DmOcvD213WhN9De3p/b4tHnQPda3puH12p6CpkmvJMreM+3wqdoJ7MBUSLu3y
        I+3pjWwL7NtMYTlSmp0KIPWaJV1A8Vj4TS7rvKSfEppRq5+/CsbGa842g/kQx7cf
        +pgkVbz428rcZbbE6NUMsDTpNYgBXFJTXP1pDtuK+sXiJBPxKyzlHYyVLCV9dLC3
        kr2C2dW7QSYzkdIWRnueuPHMl6sszWTqLHegFrjErAoJhpQ9k5bziAsdHzTzwRfx
        ibmWS5+c9biEnVujKECBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695855983; x=1695942383; bh=s
        RfaRBBkQ04rg2h5cwv6Nv4bH+399vIqUwVvDWHbYBs=; b=eLnYg0rToFSha4/YO
        zwyrA4LAO698RVji917Pv+fLREEllw4xkt7O+DY1UZG1OW4QG2mBsVh/iiAyqt9P
        fCzJOHnxz3nY4zI0TpVf7m+0tRPVcojvl4g4rZd7dUFjN2CdQCHlEgMOZWri46Ej
        kAwvS5zUZ6TP4EiUMlL8ffDlF77gjDuFd93sq2hH7QuqMzKeA2i3zUuNVIojlI0e
        fQus+L1wa5poGjxWfaKztpY4LBbo5KyXJ4T6TghODOQcoZ1WmAUUKif5FsLTU2db
        Vbx0fMWU4yjRAo6aWUZYsvPXXLoRne8bto4dlAaLG64zbblsZrQwSpXeBNBMiVRX
        zc/tA==
X-ME-Sender: <xms:b7UUZUuBoAduln2YT9oqZQfMkF0T2Siyu7Wt2VGNH62lUql45eGQ4w>
    <xme:b7UUZReLmvYm9VjQO-8-9wFzRHehebuQLGDwxjNNrQrTLGI5ZW9u_8KmMB776aP4u
    WPoJB-4PEJAk8owNIc>
X-ME-Received: <xmr:b7UUZfw6WPtKatmDGoocEf5tmHLzTE3t0O0HG6VGR4ptLSQpunOcTlL5SbHGxQ_nsRegT9P7M-lY368QuQVCM3Q3Lhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:b7UUZXPxwnbf_eWsDCOQub0KDUXaYcw_Ho3Q134zwJ9KU8QgVrcBYg>
    <xmx:b7UUZU_kNULyelq3-tyh5OCM3hFKQh1vqvR1vPOUCu8q04O3Bl3pHA>
    <xmx:b7UUZfXLyxfqbmwJxPsseWt3CYjHZD0cgAmbkkEsw2YmkNyWRfbf1g>
    <xmx:b7UUZSmYDdFeEC1CzfsYsM2TONv4XQVRof3K585v8kFaVHAlszmXVg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 19:06:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2 2/6] btrfs: quota mode helpers
Date:   Wed, 27 Sep 2023 16:07:14 -0700
Message-ID: <3c6f4cd053ccd2deb8ee459f5b0e5eb6fd877487.1695855635.git.boris@bur.io>
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


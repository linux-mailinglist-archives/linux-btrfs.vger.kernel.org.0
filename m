Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9597491E9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGEXhi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGEXhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF801989
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A82B15C01DF;
        Wed,  5 Jul 2023 19:37:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 19:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600254; x=
        1688686654; bh=buIpC7iBRxM0wR5wWlfVZ/WeCsVSrQ6Zn0VgfCvVNg4=; b=W
        t++Fh4SYF57IYBhj+LaCL6OrfRRwhKM2yNzZjjoJIdEnnnLIBcnFQOc+Ftds6XzB
        wsZYogwq7roTjdtfFoYNyfz+0Amf91DjwPTZ/Qzk0QCk3ZClzBsCAFU36WE0y3kU
        G54ddOPm11XMGSRlNMvGNBxNQojaqCqB0ykfT/RF8gaa9dsCRQjP3pA03gWDnjGi
        nqVP/MO4RpQe0yLqs9mQq76roqvXxFJraTX1Hs3+CABkyx8WtUSAVboJxdmQLpCZ
        NFeDERz91HlmVgFhBeTtWKAM+zm+BtkaJ1It51tP5JdsAThZRBOzz9nRgYmScPBj
        ToaPLT1/6zpEARiXZudjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600254; x=1688686654; bh=b
        uIpC7iBRxM0wR5wWlfVZ/WeCsVSrQ6Zn0VgfCvVNg4=; b=Hu+eI0BhTPyJWLvb0
        eIonbuqtOVjNuIhT7/5HK5KAbIRw335KGLp/BPVFmHARA3ndiWizQdI+a0dXNZQJ
        HZPGHWJx5NwGiWVQpGIN/eCMyFfesnP23u/6kfQXrJDNPKFx8QMXTaZWMwDyQtkl
        aEzmciBSJYU6mI1UzqLqqxjiOs4NGTVp/FEBAEHjNgixUs50bvQxAS3jN9INcYN+
        DpH9TpLzKiMpV3lmgUJdqsaYSwtlSghNKYls9fMybjoVgyjk8K8/Gk7RNBFMmeNr
        VgFfUsmujWUFcyXYUPNi7t5keoVFCZ56u2roqCtGS5l6RHHtt23AxMi0Ynj8eBeZ
        IOLCA==
X-ME-Sender: <xms:vv6lZDKE7optEBH1l4qz985qp2NC4usLK8yoioI2fw1d3RN1yVYQDw>
    <xme:vv6lZHJRYfSNWT2KVTXPcFLbFKZfXwMi2k5yYVj2afEE0gataacJectmWDNcAGoC_
    MMkFGfn4nH_BUPytTs>
X-ME-Received: <xmr:vv6lZLtxFGVJ__emn7RUF3daiLmScu6200rlZ_l9Ezb0qcls6H8k1hlhhN-5L84vEG8aKwkoUtMEcxwIqJZB8kd1wvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:vv6lZMbaKa890-zkNyCUJoIGqucXLt-07cDhmLVBaDWyp4VzLDju5A>
    <xmx:vv6lZKbOK87M45TT9bmYCktZ4JBq0RI1q-xcMq69aP4joVRHbUsuKw>
    <xmx:vv6lZAC9PhqbZSRPqB-ly_Jkxsx1fOUs3F3jk0f_yntUKHyyd8IIwQ>
    <xmx:vv6lZDDrmXe4YuKlRyJy-EJvz-lz4WmCWrDOxr5Ml2SIjTcMZzVUxA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:34 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs-progs: document squotas
Date:   Wed,  5 Jul 2023 16:36:20 -0700
Message-ID: <8f44931fc285453f18956cc6601568816d7dcf69.1688599734.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688599734.git.boris@bur.io>
References: <cover.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Document the new options in btrfs quota and mkfs.btrfs. Also, add a
section to the long form qgroups document about squotas.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Documentation/btrfs-quota.rst    |  7 +++-
 Documentation/ch-quota-intro.rst | 59 ++++++++++++++++++++++++++++++++
 Documentation/mkfs.btrfs.rst     |  6 ++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-quota.rst b/Documentation/btrfs-quota.rst
index 830e9059a..d5e08330e 100644
--- a/Documentation/btrfs-quota.rst
+++ b/Documentation/btrfs-quota.rst
@@ -47,9 +47,14 @@ SUBCOMMAND
 disable <path>
         Disable subvolume quota support for a filesystem.
 
-enable <path>
+enable [options] <path>
         Enable subvolume quota support for a filesystem.
 
+        ``Options``
+
+	-s|--simple
+		use simple quotas (squotas) instead of qgroups
+
 rescan [options] <path>
         Trash all qgroup numbers and scan the metadata again with the current config.
 
diff --git a/Documentation/ch-quota-intro.rst b/Documentation/ch-quota-intro.rst
index 351772d10..a69e35c8a 100644
--- a/Documentation/ch-quota-intro.rst
+++ b/Documentation/ch-quota-intro.rst
@@ -194,3 +194,62 @@ but some snapshots for backup purposes are being created by the system.  The
 user's snapshots should be accounted to the user, not the system.  The solution
 is similar to the one from section 'Accounting snapshots to the user', but do
 not assign system snapshots to user's qgroup.
+
+Simple Quotas (squotas)
+^^^^^^^^^^^^^^^^^^^^^^^
+
+As detailed in this document, qgroups can handle many complex extent sharing
+and unsharing scenarios while maintaining an accurate count of exclusive and
+shared usage. However, this flexibility comes at a cost: many of the
+computations are global, in the sense that we must count up the number of trees
+referring to an extent after its references change. This can slow down
+transaction commits and lead to unacceptable latencies, especially in cases
+where snapshots scale up.
+
+To work around this limitation of qgroups, btrfs also supports a second set of
+quota semantics: simple quotas or squotas. Squotas fully share the qgroups API
+and hierarchical model, but do not track shared vs. exclusive usage. Instead,
+they account all extents to the subvolume that first allocated it. With a bit
+of new bookkeeping, this allows all accounting decisions to be local to the
+allocation or freeing operation that deals with the extents themselves, and
+fully avoids the complex and costly back-reference resolutions.
+
+``Example``
+
+To illustrate the difference between squotas and qgroups, consider the following
+basic example assuming a nodesize of 16KiB.
+
+1. create subvolume 256
+1. rack up 1GiB of data and metadata usage in 256
+2. snapshot 256, creating subvolume 257
+3. CoW 512MiB of the data and metadata in 257
+4. delete everything in 256
+
+At each step, qgroups would have the following accounting:
+1. 0/256: 16KiB excl 0 shared
+2. 0/256: 1GiB excl 0 shared
+3. 0/256: 0 excl 1GiB shared; 0/257: 0 excl 1GiB shared
+4. 0/256: 512MiB excl 512MiB shared; 0/257: 512MiB excl 512MiB shared
+5. 0/256: 16KiB excl 0 shared; 0/257: 1GiB excl 0 shared
+
+Whereas under squotas, the accounting would look like:
+1. 0/256: 16KiB excl 16KiB shared
+2. 0/256: 1GiB excl 1GiB shared
+3. 0/256: 1GiB excl 1GiB shared; 0/257: 16KiB excl 16KiB shared
+4. 0/256: 1GiB excl 1GiB shared; 0/257: 512MiB excl 512MiB shared
+5. 0/256: 512MiB excl 512MiB shared; 0/257: 512MiB excl 512MiB shared
+
+Note that since the original snapshotted 512MiB are still referenced by 257,
+they cannot be freed from 256, even after 256 is emptied, or even deleted.
+
+``Summary``
+
+If you want some of power and flexibility of quotas for tracking and limiting
+subvolume usage, but want to avoid the performance penalty of accurately
+tracking extent ownership lifecycles, then squotas can be a useful option.
+
+Furthermore, squotas is targeted at use cases where the original extent is
+immutable, like image snapshotting for container startup, in which case we avoid
+these awkward scenarios where a subvolume is empty or deleted but still has
+significant extents accounted to it. However, as long as you are aware of the
+accounting semantics, they can handle mutable original extents.
diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index d1626f736..051e8fb1c 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -307,6 +307,12 @@ block-group-tree
 
         Enable the block group tree to greatly reduce mount time for large filesystems.
 
+squota
+	(kernel support since X.X)
+
+	Enable simple quota support (squotas). This is an alternative to qgroups with
+	a smaller performance impact but no notion of shared vs. exclusive usage.
+
 .. _mkfs-section-profiles:
 
 BLOCK GROUPS, CHUNKS, RAID
-- 
2.41.0


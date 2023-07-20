Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05075BAE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGTW67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTW65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:58:57 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849892
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:58:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 870055C0166;
        Thu, 20 Jul 2023 18:58:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Jul 2023 18:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893935; x=
        1689980335; bh=y7dfXB80FTaXuGegrxi9/8KcyxEkaVrI6XucL83bZWs=; b=Y
        OZdu0o+5oUz/W9+LSD28sWoJ1Fp6CrqrUL3KvArAJkAG9+PvILLKMloOQrcneb5H
        PRZ56H11QB7Z287FVKQcVnZwgXj1WlLELeP/URR0IbhDuZvnxq0Qo0XM7I4nLKG8
        u8LJp9SoO6kjPfgx5/AdhMVb7XZ2Oh5w9MOhua80LuI8RCj4uVPsxVcOassGuI5Y
        nwuzx44H3bWAI01N5BHJVJOdIcG+AMzNx8siNTDjVm180Sq7W5WvV4GRPMuZEq7l
        LSWE6eBtRoXVLWKEBHZa71aNcIxyxclvL6W9lJgoA2SUGQfGplegKrH9g1/tXEdN
        8wPe3fEBPfPIKORTGnXkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893935; x=1689980335; bh=y
        7dfXB80FTaXuGegrxi9/8KcyxEkaVrI6XucL83bZWs=; b=L02eFYxyHZsGXv8gq
        fbRq/eYed0d2xQHiFkPcX9rqWb/kVcbRPB8g0jLdtHudhgMhN98ASGfnOj3WeSMN
        APxBjWDKIR+q60kkgBPX/JLVBxTId2eEmD/1iAvozFnwhqHNi0gac6h6xChNLcsx
        IBENO/lSeot3UdUT0T0Q9TLhkj5ipHowRAfrmZpCvlBy9RH2DnRb0n249j/fXxZX
        M/M+FtQqT7v+e9r9v8GI1GCk7WSPJddTbFJrlAa6eKGUvWHHP+Sg8oaWkiWP6pVs
        ibMCZISQq7XTzDtefwu4d/XeA3Uxil9Auu6z8lRepIIMcjXrD52HEVvYzUMZ0kVG
        Wi/nw==
X-ME-Sender: <xms:L7y5ZCNbTAmrgNlpkAflI3Xs6rmLwau10UeRWZFv_cHjtD6rkl98TQ>
    <xme:L7y5ZA9cnjUU4OHi0ARjrznv8jm_Igl_VljOMaXEPeKRDgAqq_4PosxfrtK96r2WE
    lUMix_11pQzDV9zF9w>
X-ME-Received: <xmr:L7y5ZJQEV_KfTPCEL4trcVbHIlLatqsN3kkjV3T5Ue5s0jkZ4me-sOx04cCWc2GXXG-x6qaltypLJ7oCWTWnXo4B_tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:L7y5ZCtXfTKQksa0Isiy5M5KnOZ16iWTA13_HLUQMGR6F1H06vbnrg>
    <xmx:L7y5ZKeDlv0nP9fjCKGykF8k-2NsAjhFm1HeIUZPV5c_NHToIl_o_w>
    <xmx:L7y5ZG20OOTrQIwhcU1JgqmXbbGm_KJesvg59nZNWf9txiU134xSow>
    <xmx:L7y5ZCmgwAajMoY6k-HQQ19Tr5QLLHoxefUElJnOC3fKNYyNbCgJKw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:58:55 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/8] btrfs-progs: document squotas
Date:   Thu, 20 Jul 2023 15:57:17 -0700
Message-ID: <a3fcb5430c03e40b003ea9b8f53ea1a8e2c44e33.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893698.git.boris@bur.io>
References: <cover.1689893698.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 351772d10..fee5c28ce 100644
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
+2. rack up 1GiB of data and metadata usage in 256
+3. snapshot 256, creating subvolume 257
+4. CoW 512MiB of the data and metadata in 257
+5. delete everything in 256
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


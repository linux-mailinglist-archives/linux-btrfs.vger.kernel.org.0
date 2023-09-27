Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B347B0B41
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0Rp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Rp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:45:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A311D
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:45:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 063EB32009AE;
        Wed, 27 Sep 2023 13:45:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 13:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836753; x=
        1695923153; bh=yFWx4Cwk0irAiOCFjO+5YbO/UedhaVkn1He3LKXHkN4=; b=G
        GtYeAwvEKFPcdPs+lp0b5Qy1k09VHUqokjwL4btIyG8ygWepTTiNNSPyWsIBitOD
        P3QG6UWW0M3xIMbUDuWLfDr8eOxQ6vDgSXLX/atpzRRmTM71GBj6n8nXHJRwim7S
        lAd69wozRIOHK/YO29QzfCnUJQgjRm1S6bApigrLvznSO+I2DFUQ+On3u9HlvwYa
        hotrFcLQrZwPj8pb/cD7lzlbDLWCsJNLokfNWxCfPI9349lraU8BViJbMHXAkZjG
        OleX9HJ/W52PcSuUsf7kwKLw9cAhoVAvBuAOa0T7X7i77DSC5aPfVeIJStHuV9ay
        jfbT6o13sbxFrkMJYcZTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836753; x=1695923153; bh=y
        FWx4Cwk0irAiOCFjO+5YbO/UedhaVkn1He3LKXHkN4=; b=h47dPcX6I2iBmFxmE
        r4dlU27wEnY0d4MxFFBdkGVITT8tkZ9McF3VPehdb0hSZJ78o4huaMd2uVseFBJh
        JtWtEFeLsN8Cd9sjIx7xHS1nx64G6U58VDj2lnlRuHYi4KsEiLTzlwreurIA3LYw
        JGu3/WB9Hrc2w1S686o8LTQvzrJZEhli+hNDDM4OyOwcMlpxUOxSJgWXYeI1OyxX
        qmoid6ArWSPI97TFaOsswxJWqaC9ZaUrsGentWwZLt7g0oyYgiY8RxcyBMsyTuA7
        X8L+vhLXtCb5sbN5waKD7a3ai9sBfdCNYyLY4OdghfLzEtqGsIk1rmBGtM+4dsGd
        ISYUw==
X-ME-Sender: <xms:UWoUZQX2qR5ELLdJfBcQTVRl7zRYjQB5HYd_I5piFD3Jhbf0QsKMHg>
    <xme:UWoUZUla-CuGQ227z8JOMcfoqzQNs8vJdYWncMffJwvs8uMRJ9436HD8yJLmMF8kM
    u1GPjIpcY__Hv-hk0o>
X-ME-Received: <xmr:UWoUZUZfiFpzxAH5SJScBysk9AW88MuNpO3ZCz8wrgKuot5WaVBSB6vsqe9IPHRNmAYaRs5lJXqTP-6fyH2_jTKyDY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:UWoUZfXgFN8dxhVGayfzjEv35XavSIH8qEyKvn9_amjEJh0Gx9M8Jg>
    <xmx:UWoUZamqH9Ja2BgqE1K7Qj6YjonhCA-IaFDJU874CL0qFouuLr6q6w>
    <xmx:UWoUZUccgk0mC8ysRpyf1noP0zhiFeC64zgfHfAKKCJWG8Ym3fWU5Q>
    <xmx:UWoUZRvfK8b7x08WiZ1fHQ6iWAbnx4EMW_TId_apfksEi22geYhgWw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:45:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/8] btrfs-progs: document squotas
Date:   Wed, 27 Sep 2023 10:46:42 -0700
Message-ID: <dbf0cd9665b3c8576225f2d9daa047f7d6fa9f1d.1695836680.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695836680.git.boris@bur.io>
References: <cover.1695836680.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 04d53ef53..2103130fd 100644
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
index 1c1228f86..094a510cd 100644
--- a/Documentation/ch-quota-intro.rst
+++ b/Documentation/ch-quota-intro.rst
@@ -188,3 +188,62 @@ but some snapshots for backup purposes are being created by the system.  The
 user's snapshots should be accounted to the user, not the system.  The solution
 is similar to the one from section *Accounting snapshots to the user*, but do
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
index 1fca7448b..da8e708ae 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -326,6 +326,12 @@ block-group-tree
         enabled at *mkfs* time is possible, see :doc:`btrfstune`. Online
         conversion is not possible.
 
+squota
+	(kernel support since X.X)
+
+	Enable simple quota support (squotas). This is an alternative to qgroups with
+	a smaller performance impact but no notion of shared vs. exclusive usage.
+
 .. _mkfs-section-profiles:
 
 BLOCK GROUPS, CHUNKS, RAID
-- 
2.42.0


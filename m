Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04546286767
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgJGSa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 14:30:59 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34845 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgJGSa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Oct 2020 14:30:59 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 14:30:59 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3461CCB1;
        Wed,  7 Oct 2020 14:25:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Oct 2020 14:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=4hcdgYlJYryUM4yKV9ZU8oHSA6
        AqgGeOvNN426newsQ=; b=JlJCWtHuWWl6Ehvg/cbpQ1PU1YxUNO7x6jRlw+6kA8
        S+sn/+Hb2E1O1q+JQpCD4QikwGDP08HoZqI4GKE+8Ck2z0e+3/YzBVP+4gW3y8eq
        Uq1tmWqUQNOFnd2QOMvba9IGrnx1GvEIEmnMzv74sjnNX2oewmV7y0xPgV84BWSe
        9YlW+eRpqI3hi/fepHtRbRdv/2Q9VHJn8JGuGw46FLBAWA+zQYSvJJimyWB9YAqB
        jfeA+Rltl1jSq3Y32ckcrTvexvB0p3UmugYy2LRYnMOpccSM2ZJ82jHiGFGw+DzQ
        IUhsmx7Hug2NJMU7c1OAxlQFdxsnfx2sH9AWw+veL0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4hcdgYlJYryUM4yKV
        9ZU8oHSA6AqgGeOvNN426newsQ=; b=QkQjvphve8NoTrh8HVzmdHL+IGM4XCIEi
        YZxQt3FyflDFfsPy32ok8z+mroK5aJ1f8ehCC4c89AAdRawQ/36qc861qKnVXcip
        2j8BF0gJIeS/9+lqwcHkiOZS8FDVuLNluqJPbxAtPVFgAGLboMr4N1znbv5f/rjh
        vj1aUFREkeP7lQv34bzkmc0p/3HsycMyBcGb5KrXDua7WCTWX6F7xw3Yj7w4MZjM
        J4LfahU2K8ZRx44u9RPnLuq86MVdO9hL2yK4gcAD6IM/b7yjxD8ll+ur+W/hxy21
        f/kO9gJG8RzvRZvFhZDs8ecNFwP/NfRDro9u5BOPjbeV4woLTNAvA==
X-ME-Sender: <xms:NAh-XwVylSyecweXgIs1j4ph-Ez5wpEyGGCc9rlXoEdwDhcSsVmLTw>
    <xme:NAh-X0kmpPoA6ZJzZXsVwT8FCNlpog0i3iFg_BN3XXaMaYu7V1zMgn4bjcC-kngOt
    Q3MOLURynPcezHMHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeeigdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefhvffufffkofgggfestdekredtredttden
    ucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtf
    frrghtthgvrhhnpeegkeefkeejvdegvedvhefgudektefhjedvffetjeduvdefgffgffek
    iefhudfhtdenucffohhmrghinhepughrohhpsghogidrtghomhenucfkphepieelrdduke
    durddutdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:NAh-X0Y79sJbbMe_EfFJ8jqY5f4r7Ry45bUqXVgJgDQEUsR4C1Cimw>
    <xmx:NAh-X_WMg9kh0iYTPGm-wW2_FVcE_1CDgzY3oqaDO7sxfejlJDtrBA>
    <xmx:NAh-X6nmxnF7DBdhh611OYgbIpa1ZvT6LplMKlOumyaLiyseNvAazg>
    <xmx:NAh-X-thQWQ2_qscCjIDNA8GiBQTO_By3rasXtxZyC9lr_UCWnJExw>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57FAE328005E;
        Wed,  7 Oct 2020 14:25:55 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com, josef@toxicpanda.com
Subject: [PATCH] btrfs: Fix divide by zero
Date:   Wed,  7 Oct 2020 11:25:31 -0700
Message-Id: <20201007182531.2201548-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there's no parity and num_stripes < ncopies, an btrfs image can
trigger a divide by zero in calc_stripe_length().

Here's a zstd compressed image to reproduce the error:
https://www.dropbox.com/s/p11kayzhuia80xr/ubsan-divide-by-0.zst?dl=0

The image was generated through fuzzing.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7b1fee630f97..e03c3807921f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -760,18 +760,36 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	u64 type;
 	u64 features;
 	bool mixed = false;
+	int raid_index;
+	int nparity;
+	int ncopies;
 
 	length = btrfs_chunk_length(leaf, chunk);
 	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
 	type = btrfs_chunk_type(leaf, chunk);
+	raid_index = btrfs_bg_flags_to_raid_index(type);
+	ncopies = btrfs_raid_array[raid_index].ncopies;
+	nparity = btrfs_raid_array[raid_index].nparity;
 
 	if (!num_stripes) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk num_stripes, have %u", num_stripes);
 		return -EUCLEAN;
 	}
+	if (num_stripes < ncopies) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk num_stripes < ncopies, have %u < %d",
+			  num_stripes, ncopies);
+		return -EUCLEAN;
+	}
+	if (nparity && num_stripes == nparity) {
+		chunk_err(leaf, chunk, logical,
+			  "invalid chunk num_stripes == nparity, have %u == %d",
+			  num_stripes, nparity);
+		return -EUCLEAN;
+	}
 	if (!IS_ALIGNED(logical, fs_info->sectorsize)) {
 		chunk_err(leaf, chunk, logical,
 		"invalid chunk logical, have %llu should aligned to %u",
-- 
2.28.0


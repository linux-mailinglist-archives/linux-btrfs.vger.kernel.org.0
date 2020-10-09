Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02F2287FC8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 03:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgJIBJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 21:09:39 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43177 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgJIBJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Oct 2020 21:09:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5249ACF3;
        Thu,  8 Oct 2020 21:09:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Oct 2020 21:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=rc3LxcC+ql7LVIx0S3VZ+qlEl/
        KVQV2bM8QDCmLcogE=; b=cC4iWFSazdnIYPZJvMRTzPdy+4pE+0nE5TYiDH7M6s
        UURVU6pIDbEt3glKUcg1vE0KB51c/G3Xg/JlCOgjdmt4+3Z08UBE1yYzMt2ZX4oo
        lUCyhXHZYyOpZY+FPaEASZvBx2ZbflfB28aYoruE4lSpbkARvWZ8ORV0TZYuQS7N
        gR5Srp0BlK2EkuDe4WLpU6Kemklp1yqAMRwTlxW8fbHVeKZDMTYOGdZQUd3Gc1LE
        g0LBlMklbhqnxw/Ud3Lr2GmzPb37dfhP67+g8W1V/kBcO02aqnfJ07RI3b7w7ikd
        E6XlK9K2G5TfISwyeLL7XFrJ/qqEAHf1tq9VOWNjKiNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rc3LxcC+ql7LVIx0S
        3VZ+qlEl/KVQV2bM8QDCmLcogE=; b=DN1ev1Y8EAxRj3aDeKJKUVjv93smSgCuK
        4pXMvAGO1WofvJ3ycZ0pO45bONrDoAzUp3kTUynYS7YLMT6KY+v3+VppziMrlG05
        SjoKm/ROu1vGM2acCVEQx2JXYOf+ttNNw0yDps1eCpONPBz3HHqQgYeWtitL3aYr
        FSpeYyLxg5RqimMHTNEdTvamnCo+XI1uHFs4femsW9q0U3sux/fod8P8DNan3E/I
        TvXj9SzgCEaAqRxEtm8kj2Yds2SviQLIk9hP/BkddQ3/qPydjdUCnJiDz8rkuDxh
        d0cz/lb2n/8Zyr7ePzSqfwhviKPCzXS5Jv/LdBODrnauxzlTWxTWw==
X-ME-Sender: <xms:Ubh_X4MPfdJqbJp411YPYlss_ZBczdfKD4azhQ_-fe99W7RmV5oEwA>
    <xme:Ubh_X-9o6Snri77oG7r1YiZPRVhuCquTm8sW9fGpTLegYrrcSMjPr5Yx-7xulcdxv
    ovGjr27UAlyDj8OPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrhedtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddvfedmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrf
    grthhtvghrnhepteefheetvdeugedtiedtfeduhedufeejteefjeffjeeugfehtdehveel
    vedufeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepieelrddukedurd
    dutdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Ubh_X_S_XIJTjXh6qyUvLygibyqiappIEl8wNuvlCEBdxhYxtMbYcQ>
    <xmx:Ubh_XwtfxqcCEDoRDO9B1FNFUlsvYGNl_qKeFayIb11AXVWnMJhIJw>
    <xmx:Ubh_XwceQg0W2otJIxLr7wz9TT9O6uks4eylySALqZ-H20SYfW454A>
    <xmx:Ubh_X47Rm91tfZOR9iaHHPTsiESwjL0_LHDpZdd2Bt8ez54ntIwUJw>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id A28D5328005E;
        Thu,  8 Oct 2020 21:09:35 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        josef@toxicpanda.com, quwenruo.btrfs@gmx.com,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs: Fix divide by zero
Date:   Thu,  8 Oct 2020 18:09:10 -0700
Message-Id: <20201009010910.270794-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there's no parity and num_stripes < ncopies, an btrfs image can
trigger a divide by zero in calc_stripe_length().

The image (see link) was generated through fuzzing.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=209587
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---

v1->v2:
* Upload test image to kernel bugzilla


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


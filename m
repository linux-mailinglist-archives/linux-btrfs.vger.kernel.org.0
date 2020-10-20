Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86CD29418A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbgJTRiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 13:38:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55763 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391486AbgJTRiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 13:38:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0AD3E9E6;
        Tue, 20 Oct 2020 13:38:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 20 Oct 2020 13:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=pP9mOH/H368yQ2kiTn/y69SBOv
        bbrRmlcrzThb5Czbc=; b=drOooGMnfBtC3xUY5j+76OBoSWm121DfEOUnHZEhFU
        Z+RcR664DBQWKR7jxV+DDF7cSo83XJTdObmqa0RP1LIxBOvaYsKAmbsLW9NXZoCk
        Wsqf4r5+nhLwhCa2R3WrJevw/0BMupnPl7s+k7b6k+v7xBPIBqt/ROEObvocOVQf
        fA/5OH38ANbDVw5BrBE7hPaeNsvZS3focRDCFVXGxkl0tyMPduPIGj10vZ//sHea
        8GrwViQLfoi6Ax9/MtPTgSY5MKpNbWkl+KDcFOYZ+tH6RhBEl7/9YEY5oA2eTcsM
        vwa1217XdNGsykBQLqezagEMfeQi2s7XKAUMx1jgsPIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pP9mOH/H368yQ2kiT
        n/y69SBOvbbrRmlcrzThb5Czbc=; b=BNMKCY98rwAZKV5ICizpcd2H73oWgkxed
        F3ReQzXmTZhuZhoQMHZsNGyzfDO2SBHkNek4x+S/Y2UInyphawAgIzOiRqjSzhZg
        O7Exir/ISwauqPCOI6MaC+4aw4lk5c4rdLN6NzMSDRlmKPcNKb4GrPuzGNwvDGcv
        vzd8QER46bIfcK1lxnVqNUHG83m5Kl8tLXy5VAQiNaKmJlO4pCE6goUqlcXShCR1
        +okgGHwhmaJWxPMIHAdH6Dk6liBIoo3X3D8d8FuusSupJsXWv1ZKUDIA1jZVjteQ
        W1YwLB7b4VFh5tIvl9XxJ/CWC2wMlV4Z5x4m3Q9bIUUkbnUg0Z6Sw==
X-ME-Sender: <xms:fCCPXw69N1jVawdOGJRhheS7qgyy1AobSBswCIV-gqfAEzhIGQELRg>
    <xme:fCCPXx4vdFj_Z0YqvouHOAD6cKGorUyyoxzkt81D7PsvL0YJBlDOsUHv-ohfskvUl
    JMoDsjwEO5vVrO4Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpefhvffufffkofgggfestdekredtredttden
    ucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtf
    frrghtthgvrhhnpeetfeehtedvueegtdeitdefudehudefjeetfeejffejuefghedtheev
    leevudefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedujedvrddvvd
    dvrdduieefrddufeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:fCCPX_db1XaJw9JwdTWbSngm3AEsF4rJPIJwgCcoB32Y40CSMTT8pQ>
    <xmx:fCCPX1J-D4gVssSvCBtzdPBerZ7FE2_WZqoL4LcARiVUVxljf0cXsQ>
    <xmx:fCCPX0I58qU43O2TXJKAzbOkXMpPNvqNC-xAjMKO_q7Mj1XeDaJYGg>
    <xmx:fCCPX5G5mRfGWah4TsmOatHxVo45_LrT2VZygDuuTB1BzUDk_XKHlg>
Received: from localhost.localdomain (172-222-163-134.res.spectrum.com [172.222.163.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A2A9328005E;
        Tue, 20 Oct 2020 13:38:02 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        josef@toxicpanda.com, quwenruo.btrfs@gmx.com,
        Qu Wenruo <wqu@suse.com>
Subject: [RESEND PATCH v2] btrfs: tree-checker: validate number of chunk stripes and parity
Date:   Tue, 20 Oct 2020 10:37:45 -0700
Message-Id: <20201020173745.227665-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there's no parity and num_stripes < ncopies, an btrfs image can
trigger a divide by zero in calc_stripe_length().

The image (see link) was generated through fuzzing.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209587
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f0ffd5ee77bd..8784b74f5232 100644
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
2.26.2


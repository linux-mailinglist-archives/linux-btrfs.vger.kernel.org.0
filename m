Return-Path: <linux-btrfs+bounces-17329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E17BB2386
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA004A0942
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 01:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB154652;
	Thu,  2 Oct 2025 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WfuE8a3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uL5X5g5l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352839FD9
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367410; cv=none; b=I/TFLEDC8jQ7W/L6pco8+qkkedxdKlWCqM/ROu9IzBoKC0cjmf50ps6F/wdoPcX7/7Z1yIak/sxsDGKnlBoyCZqPJZsYbzqQW7+DgIP1q/3NBjmtB4dgV9LcZMSjYpBUEdWpJmwf5fBOZq9CmUjmM8ZZ4jCIdRtinZnNhUDrD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367410; c=relaxed/simple;
	bh=dhGxilhdnYC6MXtHIHHfHVTVR4aA1X454KHgxzOxAG8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S1aCmD394QCQ34ly9DXqYRz3cK+bvcJEtA3csMuY19prZmxUaHaY6jhfYu5FiztTZh41yOTrBz7onyTMWxNOAVQhM7gzUorCJ1033GX4pgA30qkVtOeQeqJgag0pNC2Xsj/WOFCsz1I3f4dbIgw04mU+FdBxCFQDHerIE97pOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WfuE8a3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uL5X5g5l; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 446B71D00446;
	Wed,  1 Oct 2025 21:10:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Oct 2025 21:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1759367405; x=1759453805; bh=4zofVuMaPBY+ovPHvvJA6
	H14UlCnOSXfxdUs59WwXCw=; b=WfuE8a3YKf35RIqE0htLsMrB2U30RLkbG2cIC
	kWna0JWdxVhDGv4QsH1yvCxxLar/rzpxd7EMBgcVWtbYUexx9Y2QAbFbc1D2HhfS
	v2dVr/JPn01uVzPOXORjxgbiqtTELpNT8ODBgB0Sf1vcwP5r4mmQO33xfiUujGF/
	P4IRfjFdirtT9PEWH80uImBY/4VY9+L5CsprcFTYt+on6/9ZRUPUmU5/IoxUWQ79
	3kigcI3FC13MqJNnBMpXdy9tPImIZLR7TOKXz/VMgRhD8aphDrTbXNX2xIUgEPFC
	0vaUWql9am5xbFTNNGjm2f8smK95Lk7BYbw78L+BykfmDR4og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759367405; x=1759453805; bh=4zofVuMaPBY+ovPHvvJA6H14UlCnOSXfxdU
	s59WwXCw=; b=uL5X5g5lVvuHj8/OXiOddm83ywV/zUxbg/HyOQ4vepfLItrfeZp
	7HvC8Hq/utAPUdsELg5MeMAtqW9l3TNDsV0ujPBFsLSL/kcdLOjAfXCU2MZSdnic
	KofitEl19NvHJLAX6PTHjYtVe8Eb4qZ4fQzIM87bFOQd15ncqjZWqf2x0ria2yeH
	CC9CM3Apj0uwbIVuyRklsoMoY+ziqH5IrvnhmkUvUz+ZdXRTZqd1T9zU1xkr/Xi1
	fv3Zxp5gHpbNC9buD7lJq8XmS+FT8I9sKTGFPa7oCVoaoaDXSoKHH5DJeLo6NFP4
	C1hckBT1YKMX3r3Kfy3ykgHvOm/0SxQ2DUg==
X-ME-Sender: <xms:7NDdaLCpWiYbzBCNl9R48MvYKnytWBif8Ml3rT80i3z09qwnIobOFw>
    <xme:7NDdaHj_4a_gIRraf02OvIU_TzYVPLd0U13ALo7xbofVg4nCVaobSTpgl3wPDyM1t
    mOJVSztGXRdGLwl9wQRtPkf9IHKcwwgFpGV23_D8uBoncq5pU_TOw>
X-ME-Received: <xmr:7NDdaEOMqLXcfy8JLYDS6HVKSnDDNXpb3tjKmk08an1lwIOlvSe6mlA-_F_KhF2ARZ00nwnmSr2vSt6KdeX5uQe1LdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:7NDdaI4zZlbnrUfMjt5bck3YDhAbLNbu2rHUwLt5UG-jB5WVf-Yodg>
    <xmx:7NDdaC0FhDCqUPTT0KNHOu8hKgEEq4Ga4jr4GO-M2IgHqSxDwPvTEw>
    <xmx:7NDdaJaN8K1S_Kqq-jFp0MICSFsxGmaiyytpr3uyFXl_X93BB2r1Ng>
    <xmx:7NDdaKC_faTU3LK_FJaaZJWfmLhJVbHwGDCg96PgRezem_0fJ8Jvzw>
    <xmx:7dDdaPlnrTC8Wjaz3AHTSwP73Ya2eqfS1HMfvAnsQE62A3mn45cYB8DZ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 21:10:04 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix racy bitfield write in btrfs_clear_space_info_full()
Date: Wed,  1 Oct 2025 18:10:02 -0700
Message-ID: <0d1622fd106eeefff16ae7f2d1b75a3058c3fa66.1759367390.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From the memory-barriers.txt document regarding memory barrier ordering
guarantees:

 (*) These guarantees do not apply to bitfields, because compilers often
     generate code to modify these using non-atomic read-modify-write
     sequences.  Do not attempt to use bitfields to synchronize parallel
     algorithms.

 (*) Even in cases where bitfields are protected by locks, all fields
     in a given bitfield must be protected by one lock.  If two fields
     in a given bitfield are protected by different locks, the compiler's
     non-atomic read-modify-write sequences can cause an update to one
     field to corrupt the value of an adjacent field.

btrfs_space_info has a bitfield sharing an underlying word consisting of
the fields full, chunk_alloc, and flush:

struct btrfs_space_info {
        struct btrfs_fs_info *     fs_info;              /*     0     8 */
        struct btrfs_space_info *  parent;               /*     8     8 */
        ...
        int                        clamp;                /*   172     4 */
        unsigned int               full:1;               /*   176: 0  4 */
        unsigned int               chunk_alloc:1;        /*   176: 1  4 */
        unsigned int               flush:1;              /*   176: 2  4 */
        ...

Therefore, to be safe from parallel read-modify-writes losing a write to
one of the bitfield members protected by a lock, all writes to all the
bitfields must use the lock. They almost universally do, except for
btrfs_clear_space_info_full() which iterates over the space_infos and
writes out found->full = 0 without a lock.

Imagine that we have one thread completing a transaction in which we
finished deleting a block_group and are thus calling
btrfs_clear_space_info_full() while simultaneously the data reclaim
ticket infrastructure is running do_async_reclaim_data_space():

          T1                                             T2
btrfs_commit_transaction
  btrfs_clear_space_info_full
  data_sinfo->full = 0
  READ: full:0, chunk_alloc:0, flush:1
                                              do_async_reclaim_data_space(data_sinfo)
                                              spin_lock(&space_info->lock);
                                              if(list_empty(tickets))
                                                space_info->flush = 0;
                                                READ: full: 0, chunk_alloc:0, flush:1
                                                MOD/WRITE: full: 0, chunk_alloc:0, flush:0
                                                spin_unlock(&space_info->lock);
                                                return;
  MOD/WRITE: full:0, chunk_alloc:0, flush:1

and now data_sinfo->flush is 1 but the reclaim worker has exited. This
breaks the invariant that flush is 0 iff there is no work queued or
running. Once this invariant is violated, future allocations that go
into __reserve_bytes() will add tickets to space_info->tickets but will
see space_info->flush is set to 1 and not queue the work. After this,
they will block forever on the resulting ticket, as it is now impossible
to kick the worker again.

I also confirmed by looking at the assembly of the affected kernel that
it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
the assembly is:
  andb    $0xfb,0x60(%rbx)
and similarly for setting the full (1st) bit to 0:
  andb    $0xfe,-0x20(%rax)

So I think this is really a bug on practical systems.  I have observed
a number of systems in this exact state, but am currently unable to
reproduce it.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0e5c0c80e0fe..5c2e567f3e9a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -192,7 +192,11 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 	struct btrfs_space_info *found;
 
 	list_for_each_entry(found, head, list)
+	{
+		spin_lock(&found->lock);
 		found->full = 0;
+		spin_unlock(&found->lock);
+	}
 }
 
 /*
-- 
2.50.1



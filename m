Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8E27F2E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgI3UBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgI3UBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4AFC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s131so2831028qke.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wEzleFJyWpAzY7zgXQb5Bktz12VR6UK4w+6PV5xl9s0=;
        b=Qqz7crK8CwJfaZyTySjEyYN+LDi5kDgC7HwhOXkdsCzrevBifhMobYmjuJs0dn/iPe
         2nXaDh5BFFTVeELmXEhOYj4CmoWHrzniau0x+uTlUtybM9psA/WUZ3ovit+dgDktSKu8
         HltXtMnrj/ByK/ViQ4ivTerCG/NH8uShmt+mi06JOZx0ALFAL38l0+0bYZ7meILI5siK
         Izs7upk+Y8eqSx1BGVPGjjghvbOL11qAyz8GtGp9J0fNZjlV8mzNDang13gRP8EXxB3l
         ZEk+tcmcnnABpsQ/GkzSLnXaZ9cta8j4bKVTdQooU71Gh/C8xtWiNzCsKS45TjAJr98H
         oQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEzleFJyWpAzY7zgXQb5Bktz12VR6UK4w+6PV5xl9s0=;
        b=G3U19yoBe5QFogYfrvwUnbJZ8iJNSdcT4oVUQLRaxrJap0wm7oDPZTEAspW/PLO9N9
         np96gQfKQxsK64sYcO7o2C+MKyswG8w8OH5tbJTehbCN2vBAJ2x72MaultYyegTArRQp
         ituY0zTQdxBFFYmgpxQ/fXX1v/T7eMF6HDZ5VSkXDekdlulQqB2ta6Em3heiChe19PO3
         lzEnnkPwaR2z0m04/iZ2iesaaj4UYdM1/l3w3UltxQV8p3fq3k54Ro6tianbXobRAHpC
         Y+w78rtEY06yeHSH2xDG6fwkHul5gNbzZ4kgd7Vc94qVY14rOL2UVI9jffIEAYi0Xxcv
         7xPA==
X-Gm-Message-State: AOAM532xyEXweVCGEKCA1ppPoSCx+hAju5sp7zO4BU5GtTZAhRd4yeXK
        h9XRDkEolJf8DD9r7ppq9QYwsnKArDS1ZP3h
X-Google-Smtp-Source: ABdhPJyuRglrozBHyfCaXLlO2JbOsp+fjE5dyJ3yWNYMvaPuk07nuXQtmgpxLKlS4NdIuN1xb8aS0w==
X-Received: by 2002:a37:65c8:: with SMTP id z191mr4491962qkb.161.1601496100298;
        Wed, 30 Sep 2020 13:01:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b28sm3278560qka.117.2020.09.30.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] btrfs: add a trace class for dumping the current ENOSPC state
Date:   Wed, 30 Sep 2020 16:01:09 -0400
Message-Id: <bf8f40699e24ea12b405a580262d99016ce7ffa0.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Often when I'm debugging ENOSPC related issues I have to resort to
printing the entire ENOSPC state with trace_printk() in different spots.
This gets pretty annoying, so add a trace state that does this for us.
Then add a trace point at the end of preemptive flushing so you can see
the state of the space_info when we decide to exit preemptive flushing.
This helped me figure out we weren't kicking in the preemptive flushing
soon enough.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        |  1 +
 include/trace/events/btrfs.h | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b9735e7de480..6f569a7d2df4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1109,6 +1109,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	/* We only went through once, back off our clamping. */
 	if (loops == 1 && !space_info->reclaim_size)
 		space_info->clamp = max(1, space_info->clamp - 1);
+	trace_btrfs_done_preemptive_reclaim(fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c340bff65450..651ac47a6945 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2027,6 +2027,68 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
 
+DECLARE_EVENT_CLASS(btrfs_dump_space_info,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo),
+
+	TP_ARGS(fs_info, sinfo),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	flags			)
+		__field(	u64,	total_bytes		)
+		__field(	u64,	bytes_used		)
+		__field(	u64,	bytes_pinned		)
+		__field(	u64,	bytes_reserved		)
+		__field(	u64,	bytes_may_use		)
+		__field(	u64,	bytes_readonly		)
+		__field(	u64,	reclaim_size		)
+		__field(	int,	clamp			)
+		__field(	u64,	global_reserved		)
+		__field(	u64,	trans_reserved		)
+		__field(	u64,	delayed_refs_reserved	)
+		__field(	u64,	delayed_reserved	)
+		__field(	u64,	free_chunk_space	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->flags			=	sinfo->flags;
+		__entry->total_bytes		=	sinfo->total_bytes;
+		__entry->bytes_used		=	sinfo->bytes_used;
+		__entry->bytes_pinned		=	sinfo->bytes_pinned;
+		__entry->bytes_reserved		=	sinfo->bytes_reserved;
+		__entry->bytes_may_use		=	sinfo->bytes_may_use;
+		__entry->bytes_readonly		=	sinfo->bytes_readonly;
+		__entry->reclaim_size		=	sinfo->reclaim_size;
+		__entry->clamp			=	sinfo->clamp;
+		__entry->global_reserved	=	fs_info->global_block_rsv.reserved;
+		__entry->trans_reserved		=	fs_info->trans_block_rsv.reserved;
+		__entry->delayed_refs_reserved	=	fs_info->delayed_refs_rsv.reserved;
+		__entry->delayed_reserved	=	fs_info->delayed_block_rsv.reserved;
+		__entry->free_chunk_space	=	atomic64_read(&fs_info->free_chunk_space);
+	),
+
+	TP_printk_btrfs("flags=%s total_bytes=%llu bytes_used=%llu "
+			"bytes_pinned=%llu bytes_reserved=%llu "
+			"bytes_may_use=%llu bytes_readonly=%llu "
+			"reclaim_size=%llu clamp=%d global_reserved=%llu "
+			"trans_reserved=%llu delayed_refs_reserved=%llu "
+			"delayed_reserved=%llu chunk_free_space=%llu",
+			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
+			__entry->total_bytes, __entry->bytes_used,
+			__entry->bytes_pinned, __entry->bytes_reserved,
+			__entry->bytes_may_use, __entry->bytes_readonly,
+			__entry->reclaim_size, __entry->clamp,
+			__entry->global_reserved, __entry->trans_reserved,
+			__entry->delayed_refs_reserved,
+			__entry->delayed_reserved, __entry->free_chunk_space)
+);
+
+DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo),
+	TP_ARGS(fs_info, sinfo)
+);
+
 TRACE_EVENT(btrfs_add_reserve_ticket,
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, int flush,
 		 u64 bytes),
-- 
2.26.2


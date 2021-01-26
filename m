Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C714C304D82
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 01:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbhAZXKA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbhAZVZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FAC0617A7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:25:00 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id l14so87800qvp.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtfFhqLetCDo5PfWyUBopRiiM5NKqrE4VCIJDTPHS6s=;
        b=AwLSYCADwYQR2i2W4NUh52rsu4A+Ll9F/9uw4htSA7SDGYMv2GMtvz0gLuLpMeFdBC
         Y+eqZ9eEBeqbH6HLhnS4LpO6S2QKlsc60LxlSbzE1Y+ME3PvbKQe9wURUqPFHx+/HfBy
         GyPiq6RW680LexVbFg/MYi0l6+SklFyqmfpDUPVtWtrhNfWMr95zBgqHU1nxMNINXZJv
         O1OUsvi/Cr2mqOi9uyVFiMND+f3RIqharuIgP2gM7SPdUKmx0PQRrvHdlj1oeRGWnWXp
         Dpt8P+VJPzLQ+KROHJ4/Gsvw/1dwBT03bQtGHANCWZo4UnyUcYr/5PjJSmBWVHVuvN7t
         hTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtfFhqLetCDo5PfWyUBopRiiM5NKqrE4VCIJDTPHS6s=;
        b=VnUsUuYFftl8JU4MzG7zmZ+iqFgVR6a9nqPlCdOJJzRr0sUmo1wocg7pPdE+UttXXI
         uyKjGe8FtiQ0fLYQFGabS49CAhuVlHPxjrwmPafV5+ApyxiDnIZ0woLTVa360IyY/FM+
         PmUudV+eqosRHIz05frOCHzMKYsSRf3XG/Fftz2kH8FvfyBW0nDjWWroOMzh4jXUxjA7
         isvEZ0i5HVRzf7H2EbogGmSvljjo6uijLP0mEbdqEgxMwvwLntB2j05VchY0EAhsi/4W
         42T3AZYngnti5IFMUhkztokU5CYl+5sg6dCwASKm+lZvcG/Rd6LWLwpn3s+KUFZxOKsM
         oA6Q==
X-Gm-Message-State: AOAM530iQk+WyNQI44L+pBbCU+zE7G4WyM4H847EcsEOni615MMHy8Ch
        RnRqPvbh6JqwMJjsj3G9lcSHM5qQNXj2SPje
X-Google-Smtp-Source: ABdhPJyX3DMEWYj0j7L+R00AMnjWH/nBVP/0hELV3Pqr1A0Y5KFFA3TZWjx+/O0sjL4gG8mKZOW7yw==
X-Received: by 2002:a05:6214:32e:: with SMTP id j14mr7591837qvu.13.1611696299857;
        Tue, 26 Jan 2021 13:24:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v67sm15647989qkd.94.2021.01.26.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 12/12] btrfs: add a trace class for dumping the current ENOSPC state
Date:   Tue, 26 Jan 2021 16:24:36 -0500
Message-Id: <97fadce8246431ef3b9f7cac29716432e690905f.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        |  1 +
 include/trace/events/btrfs.h | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 48c2a4eae235..868fd328bf2d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1134,6 +1134,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	/* We only went through once, back off our clamping. */
 	if (loops == 1 && !space_info->reclaim_size)
 		space_info->clamp = max(1, space_info->clamp - 1);
+	trace_btrfs_done_preemptive_reclaim(fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 74e5cc247b80..d9dbf9af5ef3 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2029,6 +2029,68 @@ TRACE_EVENT(btrfs_convert_extent_bit,
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
 TRACE_EVENT(btrfs_reserve_ticket,
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
 		 u64 start_ns, int flush, int error),
-- 
2.26.2


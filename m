Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9062889CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbgJIN26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbgJIN26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:58 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42391C0613D7
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t20so4738514qvv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTr5aqhEyIRHE9K85alzYsjgkaWjmpYmLjJbpalEuuo=;
        b=0qc36ks7BcjrARp6nLoDBw/77ZWZZWqyybrqkj4pcpG70V9q9Q8jy+TYYl1zJcx1SE
         753nlO6m14cuj8sX8mvLRQTEsmhuuYe5Cf+7vktOkQ55cDFqCEnE9iZzgLqYSyUdiSkf
         NYPAcuNo4r9zj7weIMcEo5Ssoerx0vFnpBnltHM3WxNQU1G/GmGrhOLUBXzI46id9TtW
         DDoZT6AINW/ICrme4H4HSkV735+YmWVzkpuerVjoJNGl9hjkW5al0IF0MD2Hrh9+yuMt
         X6MEtnH8L+3iMoWAZ++0QH/EwJWIxdYYbFnfYOewXdLoT8wT45zhIqRlHXUuw+lxVpOt
         ixmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTr5aqhEyIRHE9K85alzYsjgkaWjmpYmLjJbpalEuuo=;
        b=M4pP+QPWk6f0ggJm6ijZibFI8xXBVxIXtE+A81ATRr7szeSjgPVnCnNQAnIleZH2X+
         WSpifi/W/hoGUte0GA3swQioB64V9FS9OKf+aMfqZ5I5dd3h9NOD533zy8FdMeAwqkBV
         IlQBdu+maq6Zu/hNfk9hNLjt0/y9TbxuZtOi2mh9DHEKuDLL6vYmWF9DXA/fokjkHJHr
         sTrhblFqzPFGpPFCWACOf+ievtG9A4GOMh+2bo9s14Va74MP10rkYtm7OrsENDQTTxpI
         cx0GcwmcoBZFy2kHnL7ImsP8UtH4Gczox1GbL1XvCZ/RzEI8UM75rSVXBASCQEenoxlf
         nPtg==
X-Gm-Message-State: AOAM532O7nwkB+27Qr/AATpkl2fLSskSiAOMEO8gX+BJJBDQhcy7i/ml
        ycXY21FLtMBHiPbFdRT8N2f9+UoxV0RnAYle
X-Google-Smtp-Source: ABdhPJwTx+T9PoJQmtL7NIqCB9u2kTdPmek+u+8Rn4K7nPVohJ56wb6T9jF7QKGJzPpsXMv0Pt1Wiw==
X-Received: by 2002:ad4:42b3:: with SMTP id e19mr12619789qvr.6.1602250135041;
        Fri, 09 Oct 2020 06:28:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k20sm6209420qtm.44.2020.10.09.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 12/12] btrfs: add a trace class for dumping the current ENOSPC state
Date:   Fri,  9 Oct 2020 09:28:29 -0400
Message-Id: <3e5d1e29372cbbdb022185ffb5b10e6823478fc6.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
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
index 30474fa30985..656c46b77250 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1118,6 +1118,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	/* We only went through once, back off our clamping. */
 	if (loops == 1 && !space_info->reclaim_size)
 		space_info->clamp = max(1, space_info->clamp - 1);
+	trace_btrfs_done_preemptive_reclaim(fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 6d93637bae02..74b466dc20ac 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2028,6 +2028,68 @@ TRACE_EVENT(btrfs_convert_extent_bit,
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


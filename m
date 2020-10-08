Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B1287D77
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgJHUtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgJHUtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF30C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s4so8477858qkf.7
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AcOwfXeJzCPo3rQkJuqCG0euPlIHFq1d+mOcr5uXw5o=;
        b=NlLF7uSncO7nQ1QQKSMIOVu12OAs7mlsNWMRXITb80kIRgumYk26TqhSG+5rAt5eUp
         qGmEFRKtjs10jBbVJIYRDrgCQDD028OmWOms/+ANW57iM/VWTGaX6s3JrsvvI9fbjOwB
         rOrAGzRj1xqJ4LPL5ccL39dwwWMbH9cjGSEqaBn/I/77QH7KI82P31dDASabzN3jf31R
         IIH2qfaxZWleBVIG7PEUdKpss/ay7YxU1049zQ23JzBEY2wbWeUiqkcVO3D3RoLkACnQ
         V05qy7Bj6ZplSFoJCPPE4bc/ukNsax99Nt5EMig7fLiKdDHDx74IKi4mRcLF7WP5/sFV
         yPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AcOwfXeJzCPo3rQkJuqCG0euPlIHFq1d+mOcr5uXw5o=;
        b=UBwFVE7hKKDfLChzMWss7r8pNuEVWWuCcLaWxVyHOnoNxlgqQ6lSzfHHvcsby/9A8i
         s/BMbJEG6ulOEGblfG05c2vDMS8zcBhWKPwFYYBRuoBagoe/RSAyPXF4Z5kGYzgza6ti
         x9bUhyxZXfKFJwRYsZ5KFMXMQsan9yZsYnMKcS/nuFR2REAiGrCXH+UaVGuuI7oMDus5
         J/JA99CRysThk3m+60/kcYExAz/Up6neL0sHvmASc9PY91mUFR4XhAuYq3lOhCvEE/DA
         d2DMMlJEn9Y0d9X73shYjS/Iv7pLzBkEP4Xd04doSiWzr8pd+8o8U/89OihdUZEwaKO+
         /nDA==
X-Gm-Message-State: AOAM5307PYDynLEwkl98GUPKR9mU6mYFaIr/wemcwpjJ1HqF+mCPCPEj
        GBGU7aOQYzMwga5YOxlUMfWfzEeojCYXGJg7
X-Google-Smtp-Source: ABdhPJx9/ERdP1RfF4Dt8v7TValekY3HgG5yUospl8ZCxmKqC1n05jyLdP1zmLvnnNW1o0gMnB+veA==
X-Received: by 2002:a37:dc2:: with SMTP id 185mr8029707qkn.103.1602190156957;
        Thu, 08 Oct 2020 13:49:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a66sm4768309qkd.47.2020.10.08.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/11] btrfs: add a trace class for dumping the current ENOSPC state
Date:   Thu,  8 Oct 2020 16:48:55 -0400
Message-Id: <1c3db31ef6d948a07236e63bc7b7b09f4671fbc5.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
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
index c5fc90dd8378..a4ffe8618126 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1123,6 +1123,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
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


Return-Path: <linux-btrfs+bounces-18562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C1C2C36C
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D333A41FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF123064AC;
	Mon,  3 Nov 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5/mqZId"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A530F52B;
	Mon,  3 Nov 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176938; cv=none; b=Q8HuJ8dJv75N+r+NeeJ6ZMY4QfAenteo9KZ5Ym1wKYBARulOwIFFXQ3vsg9SjbwIKRYOYUialKgohr6ijDib05Df8O3PHGhLlhgV2kqiwdkTvzxpSml1H3frXwwSv5z/CaBiQ2jxZXEzOBRDh1wFl+JRzKTRLu8SOMox/Xc9nkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176938; c=relaxed/simple;
	bh=gomlfGWCLgGQ3HJBaETQ13a6X7IFnbJLRFatQgVnJME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP8+q0sfjKkugCDAxM9Abp2fQXmJiLirWadv6+K2eYPu+vo54W/SYti1Lv4/N43hQitP+LX/S5MOipt/0vbyXcqM4zE7nnTiJ5Q7WU1h+jkrJoDz+lIvSLwhQT6+Ec63vYA+f7gLAJXqKUSk66uhUm+MnP7oYWDXAPx9p31ny7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5/mqZId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C922C4CEE7;
	Mon,  3 Nov 2025 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176937;
	bh=gomlfGWCLgGQ3HJBaETQ13a6X7IFnbJLRFatQgVnJME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E5/mqZIda7ydc30NreeKe1jAfSz2ayaa7xmLHHOYF61YE9IMADRACTVkU37pq97cB
	 ISJEKN/dpDrmj3sCa3/bVmz2g0bxFl/TNlkWLg4DQvFwtFz7L2ENYP52TINaH0/1Qg
	 4e8CUDXAbtfgewtXHINKUVZQAZeKMPKggiRmyc9YGg8nV+EGnAUU0u7ZYk7ACCpZDE
	 W5hYwcxIbn8x5cff4jMBDQO1+Mh4htJ4JwkaelAjhwGDMb/EmNEzbLONlPFDCwxdjj
	 oGlWU8EleqXf1UalGI8aeEog1gIXXvcKg24FC3yldye+OAGV+jR7xmIe1hjbvmII9G
	 zRVm9SsQJ165A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 12/15] block: improve zone_wplugs debugfs attribute output
Date: Mon,  3 Nov 2025 22:31:20 +0900
Message-ID: <20251103133123.645038-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the output of the zone_wplugs debugfs attribute file more easily
readable by adding the name of the zone write plugs fields in the
output.

No functional changes.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a2f4aa88747a..8773af89980d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2303,8 +2303,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m,
+		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref,
+		zwp_wp_offset, zwp_bio_list_size);
 }
 
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
-- 
2.51.0



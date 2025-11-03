Return-Path: <linux-btrfs+bounces-18563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DCC2C378
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431A7422180
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF2316193;
	Mon,  3 Nov 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+NfXeWQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A530F52B;
	Mon,  3 Nov 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176940; cv=none; b=GiNMX5strYhOhUUNukXq0ifohTEZatsdctyKa8iqIjUnBY7CZAvkuZ6lrbTUZvqx2mg/9n5w+mAxis8KCg0Y2H5hqUjKQWeytMXBOJXUEKBRLTkDqEdRTtCyGu/iwwQ91lQ0KCFpnJUXbXvXZCERjjWUpt4mGlIzMrdq1bfQOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176940; c=relaxed/simple;
	bh=K3sXqMKFMt+RLh4JOZhVvYF2rGA92o4uAKlp+MpsqJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzPbmd7j6QYd0m4qbTDE4ZUbtN9dbjycqZsyXloG7u1G44gzkFjdzCStlKqkDXQWOXK8z1nuvRcK1vZELapSL4OvTgjz/dVZZdMACgtv0u2HOF+UfThWAQO9xs89Y4dH2zvH3vQdfMoS19tXI3d2SxmGmEt0ZqJC+F0UTh8d3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+NfXeWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC73C4CEFD;
	Mon,  3 Nov 2025 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176940;
	bh=K3sXqMKFMt+RLh4JOZhVvYF2rGA92o4uAKlp+MpsqJM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r+NfXeWQOghrQ1iyE3XfG3ugVEXqhHFQO7sKkjUDNjP3hIJgMwe6Qg4CuNr0jWMMJ
	 gaioMOmTknbWmPxBW8pTEFFVCH4K9Jkhl325QXPV5uG+6EHMP880qtNJdZ1dqOWTCn
	 sniWtCsO2ayarWUvrml4BXYcFL2JqsuTTOrrQHNOkzTIsbg69anqLSvPxX0BT6sG1r
	 wF9aWZBwoIc1qCrfgBI9vjwsKktlXRD34OMMQWLrESBXEy8E2c/2vUZ/GjeAydtyDP
	 1jdpDb6DgYv4TURdDIzuW7tsHlN62AaTu/LgHlYvfsr/uCgZUIIofyNkeerTRiNJmj
	 gJ2CCYRXiSYVQ==
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
Subject: [PATCH v2 13/15] block: add zone write plug condition to debugfs zone_wplugs
Date: Mon,  3 Nov 2025 22:31:21 +0900
Message-ID: <20251103133123.645038-14-dlemoal@kernel.org>
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

Modify queue_zone_wplug_show() to include the condition of a zone write
plug to the zone_wplugs debugfs attribute of a zoned block device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8773af89980d..07553bde7b33 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2293,19 +2293,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
+	unsigned int zwp_cond;
 	unsigned long flags;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwp_zone_no = zwplug->zone_no;
 	zwp_flags = zwplug->flags;
 	zwp_ref = refcount_read(&zwplug->ref);
+	zwp_cond = zwplug->cond;
 	zwp_wp_offset = zwplug->wp_offset;
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	seq_printf(m,
-		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
-		zwp_zone_no, zwp_flags, zwp_ref,
+		"Zone no: %u, flags: 0x%x, ref: %u, cond: 0x%x, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref, zwp_cond,
 		zwp_wp_offset, zwp_bio_list_size);
 }
 
-- 
2.51.0



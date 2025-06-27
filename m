Return-Path: <linux-btrfs+bounces-15025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6EAEB2BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141051893F93
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73D2298CC4;
	Fri, 27 Jun 2025 09:19:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA975298CAB
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015971; cv=none; b=O0WdWzOnY1HKXAhUAPtyffII0YH0Ys/G9+y0qS1dRH1FDE16CTJ9TLhDYGonIAeAHFUPFVLM06KUDjLhz9tp68IOXB73jd9ICAMSsKnTdXD+hI6E5QZTMe2pPqdcLqSU25i2QypTcR64dGkjZcvMm5mmct8XRPnpfpetnU6+vFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015971; c=relaxed/simple;
	bh=1iRZw+MJ0js01DRWM2JZ9TgcPOGc+3d1+51VFJ7YVl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WexnR77j6JI8CfBWoCTCp2URF1Yl3ghiwRsSVQuQk+6+u/T6lKm6AaQ0B4UpokRU6VmqLC9bFaDbQGufLlxubkKOWpGKkkjweaUNb/MKB6oRrXTW2Z6vbTDt33Z4Rj8tmhwDn7h++TqpEOsci+79Q66j4USLI2xuVypp6n+9/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1646343f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015968; x=1751620768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsjjeYmqpGvrK2avxpZC7BOeo7Fl1L8JSbawAeF7ryk=;
        b=vULI4K1ZuZ723PXekSIaJ/B65tm4wv6YfIaLGbiSaKFTTQPiT/BPkF02u8iriGlSr/
         D+FCsfgKyX7y8e8adGIZ6jOMUkIN1/gwOFK/vSwQN4IY7D3jX/yiexkX1UIw7FdRUMQ5
         97YwWqBp5fuqf8OOsFBqXuR7Cyocc2L2avlggm3IjdUfP/5z8tU2/6fk6p3v1zeTfyni
         ejiV8WZ9mwVT1jJ0XxtNA1DH0R2e1mxgUZpQDFvhh824p22nanSxe5QiUgzv0J/nDRr3
         F16dDE/445VFj5AjORXV5x/HoySbIVa+nRWwEm3VsVH0j3NQvsayaqMO4Ut/CrxaJxcU
         LCzQ==
X-Gm-Message-State: AOJu0YwR33aU47ijfGlz4H1/+85T0qgvg4G/kNHPmV+E8tJLw++XIoWr
	kkoLQSRZD9zP3TG7l8Mku1OjqbGUGMKBClLO7APiNXuLG2c5JvjZSHIbBNRzqA==
X-Gm-Gg: ASbGncsASzX/S7x/aIm/hldcX3sit44Aa1mYtwlOK7xIkvTRj+u9OTrJ9pVf71a8ScU
	vWXl/FPcEh6kFpVsaII/M3XNJqjyaFaufmiqn2tWt4pfXdp/WvMC+f27tsEVagb1UdUsq29Pl6I
	PdnwWteog8WK1fqxqbZNOJxPIfziI2yDigOeSjqSxvVKvI3mUD3FKafLDtd9KsTM/9x+7QsVzmi
	cLMq41rfYgm2SlEjLveH8kDnG9l1IiTIEr6Mfxji9UMHKvH6g6Glu84KqVwvCJvpQzRB72GIQgG
	liKKuzFbyEAoMLfZKsfTcWKufotf32uvyBkDvdGm7At8AFD5bxygfoZW1J/zNzc2U26CrPXH9e5
	cw8B68D9KtjDpRKtBJz9pu7nC0/nPPgRbApMJrp+qmmZiWz5o
X-Google-Smtp-Source: AGHT+IHVs0gzWhTM7krj0mKrgB1oSIbAg310n27MnjMIM9KzhgFM8Qot6zB5nxSaxUvspLRvZCsE4w==
X-Received: by 2002:a05:6000:2188:b0:3a4:d79a:35a6 with SMTP id ffacd0b85a97d-3a8f482c094mr1924435f8f.14.1751015967801;
        Fri, 27 Jun 2025 02:19:27 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:27 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 4/9] btrfs: zoned: don't hold space_info lock on zoned allocation
Date: Fri, 27 Jun 2025 11:19:09 +0200
Message-ID: <20250627091914.100715-5-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The zoned extent allocator holds 'struct btrfs_space_info::lock' nearly
over the entirety of the allocation process, but nothing in
do_allocation_zoned() is actually accessing fields of 'struct
btrfs_space_info'.

Furthermore taking lock_stat snapshots in performance testing, always shows
the space_info::lock as the most contented lock in the entire system.

Remove locking the space_info lock during do_allocation_zoned() to reduce
lock contention.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 46358a555f78..da731f6d4dad 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3819,7 +3819,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct btrfs_block_group **bg_ret)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
@@ -3871,7 +3870,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 
 	if (ret)
@@ -3969,7 +3967,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ret && ffe_ctl->for_data_reloc)
 		WRITE_ONCE(fs_info->data_reloc_bg, 0);
 	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
 	return ret;
 }
 
-- 
2.49.0



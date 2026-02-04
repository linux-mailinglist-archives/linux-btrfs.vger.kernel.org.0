Return-Path: <linux-btrfs+bounces-21379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO2CA4q9g2mqtwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21379-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 22:43:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF4ECD28
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 22:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28A93011BE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD6395DB1;
	Wed,  4 Feb 2026 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b="zeXuK7qZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCD38B9A1
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241401; cv=none; b=GbCDRgdbNYZJnjhDj5hh0Vc1i9cNZq4LB1XUL8g4y7OdtzRSZUwVTjY3S/A+NaTUlQToKfRZh6YNLdVAUB9SmIVmTgJxyin33y18OaKDnWi/LjEZLRopg/Ipuq7OhYT0by5YbIju2TKvtgnPa+bFz19f8X9i/sgP1WnpsZy+KtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241401; c=relaxed/simple;
	bh=ZIpfIrBbWKb0C5gdCdpO/J/ImdGuQyKvMWX042XR/V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkogHG1rVhCBbnTgp6rMZj67+gjVTVHXOg/jZoZZcLYQphy8ea1oZDSK8k8t1XEfWK1xOnQbdNE9saM/+F0voR6lDxarpFsD30gSwNHFBbHQ2vra5NWDHe8Apvu7pkCZGol0Wqlwc+5hQv7YDco6hEIaXpnXXzczhZ6MYIHBh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai; spf=fail smtp.mailfrom=jingkai.info; dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b=zeXuK7qZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jingkai.info
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4805ef35864so1934945e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingkai-info.20230601.gappssmtp.com; s=20230601; t=1770241399; x=1770846199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HheE1vWFoGluMsb0CfA37IGgXTVMdttgQxaW2daff5E=;
        b=zeXuK7qZ2WP+2+DSCve66iozD0cYYFjjxsTjd0NKq+kQLQvrq/Il2K4aWyG7MoYcTj
         3VuimmhtpIb7Pmws3Dsl/MCDpalofDN5/vhlFPEcc9wqOMcIWYBZHVdR2C0n4nMaYzf8
         Vjvk7q3m47itQQkMK00/OT3Qo3bKENgFfhtTu71J4zyc2Ix5/ar17vnTv6uYZYZG/5U0
         bw1eQNvk8Boe45rlvZtdNG6oEkmLRGsbXIRaHfFrMZugjCZDHHCveeswRVj52PvBQfzd
         cXybWKc2qd0kj0JviEEiVUnoriL2pAIzvpOuKLU6g19OqwiZF9xBIVi6MdgPbaO8ph6h
         bzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241399; x=1770846199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HheE1vWFoGluMsb0CfA37IGgXTVMdttgQxaW2daff5E=;
        b=kz0SF5B6duKhCupOUp3IAX09/yX1BD9mNLlYrwD8H8DLn1IUNnMXszUqtiw0gmGcMI
         ch4nxSMqdr1/dyghcU0YcVWOIXubKNtUzC0Brix3o6fc8zsQp+Tnb3MyXRlBYUlQNFhn
         l55i6deBQx/rraRx9frkJx6HdpW3Ozxi1VKElQXSzmcvXWt8a3vcVjhOE4ZcBbMFuNTx
         IFT2fJ8ahO9vx/C1EKGa+127VOshI4pUfZh47RK+8HNVn+kR0rKmz/lBDwBt6Av3WBEX
         t9DK0VYvHlOozWD3+WqzM0Y5xmiXQ8ugl8rfhehZ21MfV++U/wWslSK6JPRPmpFEiyA0
         OiXQ==
X-Gm-Message-State: AOJu0Yw+98iN1dTwSS5HoDrsbKV2OHKXqecf+dAL4m0U6MQrx5ZjGfSv
	+hdQQDTvvvt7oHsBnaH5tIBETgD0f1Jxv3tzGu2jdbyy53dfu+MbH2C+/TOYJQNAhx/JlQxxwKY
	F/WiZ
X-Gm-Gg: AZuq6aKFVu+zULUv/ObGz09q5bpxI630YuFXP2FtZ2PpJ/w6FeHZX8tdW2WRVa9ZEDq
	DTLwdQB7A55NywBl2/BU4dJVV5OR9nU646pub2hoBIAZiHlBgP1UWMMvV8xiF/asw4uzLG5G5r4
	Ik/tGE03fqd4QyeXrdgtnQlIRRuxd8K9gX4V5xCzesrsvXV/Yj0P8bPtY5dS1E4l1g6fod5G73r
	h/nAS9Ejmq+oWoYoXPuf2KVMbSgcyF4CCam7lRLrHOgM6yBGpIZGhCF/5N7c5xt6FqapiTD98sh
	kpJVimv2IU8pU4LqlK46msbpeEt1xLBmQvrnT4aSuF6nSHhbMGuZgbY9SHLBba64C9gBOKO2c3Y
	F0NL5Vi56vWUpNOr1GzkqHdwPvxayyrOZCSdqHPq1r+MuEn2aqtKAaEGtL0FHLpwgm9DSOHRviC
	VZPT3H04+b88kiQX8Jj8uxnjGzZQFM59yk0NaHggoWsgZyErQESfixRnEzVwuK0xCtim2rr7TAt
	dRDehe0IZTCvhdUtOr4pqSAyPEzSHwS3FmHfLKgyvg=
X-Received: by 2002:a05:600c:64cf:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-4830e94d4f2mr54392935e9.14.1770241398598;
        Wed, 04 Feb 2026 13:43:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:b002:8300:6d4:c4ff:fe4e:6522])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d4d030sm17449165e9.13.2026.02.04.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:43:18 -0800 (PST)
From: Jingkai Tan <contact@jingk.ai>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.cz,
	Jingkai Tan <contact@jingk.ai>
Subject: [PATCH] btrfs: remove unnecessary errstr variable in btrfs_finish_extent_commit()
Date: Wed,  4 Feb 2026 21:43:08 +0000
Message-ID: <20260204214308.18836-1-contact@jingk.ai>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204143105.GS26902@twin.jikos.cz>
References: <20260204143105.GS26902@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[jingkai-info.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21379-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[jingk.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[contact@jingk.ai,linux-btrfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[jingkai-info.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jingk.ai:mid,jingk.ai:email]
X-Rspamd-Queue-Id: 59FF4ECD28
X-Rspamd-Action: no action

inline the errstr variable in btrfs_finish_extent_commit for consistency.

Signed-off-by: Jingkai Tan <contact@jingk.ai>
---
As requested, remove errstr variable and inline the call to btrfs_decode_error

 fs/btrfs/extent-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 03cf9f242c70..5b71a6955683 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3008,10 +3008,9 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		btrfs_put_block_group(block_group);
 
 		if (ret) {
-			const char *errstr = btrfs_decode_error(ret);
 			btrfs_warn(fs_info,
 			   "discard failed while removing blockgroup: errno=%d %s",
-				   ret, errstr);
+				   ret, btrfs_decode_error(ret));
 		}
 	}
 
-- 
2.52.0



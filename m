Return-Path: <linux-btrfs+bounces-19997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A5CDD2DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 02:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F260E301D0F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 01:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD921FF47;
	Thu, 25 Dec 2025 01:38:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-188.us.a.mail.aliyun.com (out198-188.us.a.mail.aliyun.com [47.90.198.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128C944F
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766626738; cv=none; b=UGeqKRYmepA1Bt0vDzBibvzf1IY9dDCQ+gT48I0PFP7XV1+vUkcVeHTQLtyEhF+T1o3ZQrHC3N+VxDtuOFHsBdg5r78HfKoBp3nCv6DXtwJM3h9uBnRuWMLdneK2N3g6ywRW2ps38d4HYxpIfysc8Ag7qK8kZ9BtdunCOLe/dS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766626738; c=relaxed/simple;
	bh=3xP8XAkcxUmRAYQ15d8GgC8OKsJka9WxGo0w7uL87Hg=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=DVPUM6p6L6J6W2zwdJ6F5VXqtUCHSFLu0hSFsIoauYviioJPX4QqHNQF6nvd1D8VpjPMoLT92OXSrqcQCtCDhzRzChgG55d8WensM5QGN7yIgeohijr4HJfMJSDD/6FeqBAqG6xGJAsFuSivlBBW+Qfa9FwUrCM+63gGL03JyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.fsPAvkR_1766626404 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 09:33:24 +0800
Date: Thu, 25 Dec 2025 09:33:25 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: Re: btrfs ASSERT() error when make C=1, but OK when make C=0
In-Reply-To: <20251222223701.F4A2.409509F4@e16-tech.com>
References: <20251222223701.F4A2.409509F4@e16-tech.com>
Message-Id: <20251225093324.B3F1.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi

> Hi,
> 
> I noticed a lot of make C=1 error of btrfs ASSERT(),
> but make C=0 is OK.
> 
> block-group.c: note: in included file:
> zoned.h:417:9: error: Expected ) in function call
> zoned.h:417:9: error: got __VA_OPT__
> 
> static inline bool btrfs_zoned_bg_is_full(const struct btrfs_block_group *bg)
> {
> L417:    ASSERT(btrfs_is_zoned(bg->fs_info));
>     return (bg->alloc_offset == bg->zone_capacity);
> }
> 
> Any help to fix it?

We can walk around this problem with the flowing patch.
It seems that sparse(make C=1) does yet not support __VA_OPT__.

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index dea30823d61a..8755a5bc7ece 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -111,7 +111,7 @@ static inline void verify_assert_printk_format(const char *fmt, ...) {
  * As ##__VA_ARGS__ cannot be at the beginning of the macro the __VA_OPT__ is needed
  * and supported since GCC 8 and Clang 12.
  */
-#define __REST_ARGS(_, ... ) __VA_OPT__(,) __VA_ARGS__
+#define __REST_ARGS(_, ... ) , ##__VA_ARGS__
 
 #if defined(CONFIG_CC_IS_CLANG) || GCC_VERSION >= 80000
 /*


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/12/25



Return-Path: <linux-btrfs+bounces-12732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A295BA78249
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 20:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4882B188EE2E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 18:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89E20FA9C;
	Tue,  1 Apr 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="mZuiyswl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D8205AC5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532145; cv=none; b=mKf4HgxalyGTaETew/e8HY6UnhF2Q8AxPtiL2Q0P+ZdGNYcJGLl2beNRLAqhVrbL+LTxHqHOchP0Wmu3phSCFQwuyfAFjCCoSs1hEdQ1nUhyVZ4bfez+9V6uXG+TeC17OS3bSnAIZSPed9rQ5CmEhu97EkT5G0/8mQ3n0bt9tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532145; c=relaxed/simple;
	bh=Tq+oZPXmm7VO5Z5XpkjFp/DjCbfPGMJmKajSvGvwL3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dq5WoLO1KDFU4Z2kn8XyJt1QeJoKgcKC8QwwYbspN9oLTr9oxRL3lYIrurxhMJ16pkhdfpem9OvN9slKJs8253H2+SXh3KXKhd9Da8cIqTW32BOlW1H5eSzMmpZ5A0YJmZrcO1SRTWMdGr295uOr9et5P8Q1OAda/X+llmFYTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=mZuiyswl; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 3FCAF834FC;
	Tue,  1 Apr 2025 14:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1743532143; bh=Tq+oZPXmm7VO5Z5XpkjFp/DjCbfPGMJmKajSvGvwL3A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=mZuiyswl17PK7OoD+XozdbFwWT/WRqvqpv1808kZkQ6VQLM2+FVAbshPqbHhtYydr
	 TrXLVgR8BanDc/iASkrOUw62XLF9/XNQvG/gS5UKS6BY2DQQI4Wv45gLs8Isg251JF
	 Oi4ZACTcEkSclusqMlgg4kaj3G0QPySrXsN9YMiD6DpX9nkLo6BkrD26i6VrB4e4aO
	 T4oAtU7n2g50OnRenadzhM/knnX2oeLRkg85KZQ70dybfAZyw9giAYuCLLJVx2lipO
	 SkMvANBqSE4EWXPYYEs76lyAnXcnWeYAbVximxgoTrDmOPT86ia/4oPjEj/ZWuD8Tx
	 dym5BNVFl9eYg==
Message-ID: <d9a0ca0a-bac8-4d80-81ea-98db7b13ed8e@dorminy.me>
Date: Tue, 1 Apr 2025 14:29:02 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] btrfs: two small and safe fixes for large folios
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1743493507.git.wqu@suse.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1743493507.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/25 3:50 AM, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix a bug that page_pgoff() usage lacks left page shift
> 
> Two small and simple fixes.
> 
> The first one is that with large folios, we can have order 6 folios which
> reached our current BITS_PER_LONG limit, triggering a previously
> impossible ASSERT(), which is based on the fact that our largest page
> size (64K) can not reach BITS_PER_LONG blocks per page.
> 
> An easily fix by extending the ASSERT() condition to cover
> blocks_per_folio == BITS_PER_LONG cases.
> 
> The second one is a little more complex, that with large folios, if we
> still go through the single page bio vec iteration, we can not call
> page_offset(), as non-head pages of a large folio do not have their
> page::index initialized properly.
> 
> Fix that by going a helper using page_pgoff() to calculate the file
> offset, which handles both head and non-head pages of a large folio.
> 
> Qu Wenruo (2):
>    btrfs: fix the ASSERT() inside GET_SUBPAGE_BITMAP()
>    btrfs: fix the file offset calculation inside
>      btrfs_decompress_buf2page()
> 
>   fs/btrfs/compression.c | 18 +++++++++++++++++-
>   fs/btrfs/subpage.c     |  2 +-
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>


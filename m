Return-Path: <linux-btrfs+bounces-12711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0965A77491
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CF57A1453
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314A1E25F8;
	Tue,  1 Apr 2025 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="ei6kEPCr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54D1DB55C
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489201; cv=none; b=KRRhc4h0/HDN2wRqYTOOCEvY5x7A3gnA0AMfO/sunUS40p2opGKYfLt7JkBn71v7ztkYtGFdgun2Am7bsNQAe9FOgQdjb3WSGPEDbwTX81LQBUqOaKKSQeZ0v5Wt+ajvK/Zi4jDnt3jUOb7pIMs5j8cM+GtLz1DBRyc7xbGX/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489201; c=relaxed/simple;
	bh=QODW2bcZjOnuiLO7lGCr/yoaKQrkSBXp52m7I8abS5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WAi6CXMSlXNjJLYb0jg2pzrUzqo6bIDA2sXdCxqFue6HOtPqDHVE+9lMWzxCTRZHSEPPfdyKE4PEllrrEWLQDG2ADvmLfa583SNDOqCUYJgzzryjC+enCYrwAq83fH8I1TiRrB8XTW2qhADLA+lf/uXdjqoBlDvUDNUAh8A95Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=ei6kEPCr; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id C01BE82688;
	Tue,  1 Apr 2025 02:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1743489198; bh=QODW2bcZjOnuiLO7lGCr/yoaKQrkSBXp52m7I8abS5c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ei6kEPCrDTAYKu/lCYl3j7KsD9ASVmVBQkCxXNF+ykPwRpOT+wTLPTU9mX8zNmTzf
	 N8mAGTGRX0BoO508HNGUP5qK+g/5aBWX3iW38FA5wY3nVWBT+DBmz4bN9sKPUy32dT
	 vd8cDMc25LMeldMnPajw9pNVRqXoRpvlspEP/CbMT25+Z9MG7HvXGf6sBQuNArR8uk
	 YI6c/+2G7XD7dHAstAWpKZPIxdlSZOXLyXUBiIKNskKlunv8jawERIdl/VWSQDvmwF
	 rMbONfXHOWZeXxcuFeed8RBj0L+VX00yB6DmJIwGXIwn4vIcQKbA3apOpNW9hTsOLg
	 lb1TwOYJ6Fsfg==
Message-ID: <beff4178-200b-40cf-a7cf-afceaa1b413a@dorminy.me>
Date: Tue, 1 Apr 2025 02:33:18 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] btrfs: fix the file offset calculation inside
 btrfs_decompress_buf2page()
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1743487685.git.wqu@suse.com>
 <8fb7820d18bef8f661f807b3d96be2591aee6494.1743487686.git.wqu@suse.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <8fb7820d18bef8f661f807b3d96be2591aee6494.1743487686.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/25 2:12 AM, Qu Wenruo wrote:
> +static u64 file_offset_from_bvec(const struct bio_vec *bvec)
> +{
> +	const struct page *page = bvec->bv_page;
> +	const struct folio *folio = page_folio(page);
> +
> +	return page_pgoff(folio, page) + bvec->bv_offset;
> +}

I think this needs to be page_pgoff() << PAGE_SHIFT + bvec->bv_offset: 
page_pgoff() returns in units of PAGE_SIZE, while bv_offset is in bytes?


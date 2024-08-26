Return-Path: <linux-btrfs+bounces-7528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE5495FCD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E41F23730
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835919D094;
	Mon, 26 Aug 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRjthn8b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAAB677;
	Mon, 26 Aug 2024 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711667; cv=none; b=CI5OBupq6Cd/vHoAhTHACQYCc+PyTrSLY3D/V4R99FeMLkfzPcm3Ie8EiLHGQyXtutnJ1JGcEtNrwpz7zjN5JEQQZkuuZdsqT3RTGeiXWRNfFp73574esfn8PHBw+wW+hM261Vx1Vqj397pQrO4w2Df8Q4kSpO3487J1nBI5zgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711667; c=relaxed/simple;
	bh=KI/Ef2+QSwmbPw9UDRf0rD6MsmoGsxFmsxtsENqYfuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVB05eDZK6VCTumRAhphOTM/01Ne4FvjLcaohUsc5I9rncgQSsMFNtGV1ZDwh0EtVVKoHWNPzADphwy+b8NH/hQnjaZXFoXaKvTTGHxg1vfAb72Y1+WJkx/g9JCPoqOMWUVpDE44YvMzn+Um4vzZXKJMorB9JCgNvzu3/KGwjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRjthn8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E706C8B7D9;
	Mon, 26 Aug 2024 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711665;
	bh=KI/Ef2+QSwmbPw9UDRf0rD6MsmoGsxFmsxtsENqYfuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uRjthn8bv6HO8IgVj18t1dCTTNMhiBcsipcBUJe5GygsoIGDC92Gqw1BPqIxaJrvI
	 CtMB+j9YEoGNzs7qAwl1BEfiIqjx0mEJBoTJ9YkZvCuEEzuBSa9EhSblZzrcpZJnMw
	 8DmGySbb9Pv4D9bIDVt/AisGYPg6HfVzhEfVcIbR4D/S9x8onYG/q1gKhfmaaYCR3Y
	 jJDdPZhKjbWA4kjZqn52T2Qa83qX2Jrhx/12qYxWuMGM78neXBv6/kAaU5KFLiD1AF
	 f9Z2ul/XWgtr4DC5WmZYnQPsxVCcGlDdlRpZQQEuOoE7WSMjmw2IRi9AhdsfLqtQsz
	 RQdZtBAwh00Pw==
Message-ID: <aa7d8692-ee40-42da-b78a-6a0f3818cf61@kernel.org>
Date: Tue, 27 Aug 2024 07:34:23 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: don't use bio_split_rw on misc operations
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826173820.1690925-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 02:37, Christoph Hellwig wrote:
> bio_split_rw is designed to split read and write bios with a payload.
> Currently it is called by __bio_split_to_limits for all operations not
> explicitly list, which works because bio_may_need_split explicitly checks
> for bi_vcnt == 1 and thus skips the bypass if there is no payload and
> bio_for_each_bvec loop will never execute it's body if bi_size is 0.
> 
> But all this is hard to understand, fragile and wasted pointless cycles.
> Switch __bio_split_to_limits to only call bio_split_rw for READ and
> WRITE command and don't attempt any kind split for operation that do not
> require splitting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



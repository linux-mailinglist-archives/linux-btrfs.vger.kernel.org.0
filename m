Return-Path: <linux-btrfs+bounces-15639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A3B0E841
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 03:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8867A5D8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C31991DD;
	Wed, 23 Jul 2025 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofyKsrDS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32B82C60
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235098; cv=none; b=chofo1H0qaywDNxYEFuR6nJQVbMbZ6ydlagx7czfBh5ZtxHIjBOuBl7yL4b9L4LCM/t8K6KAcJ7eL35g9ak/LWAkFVsX6nBDVWp94CBL2XSGCGG16wL0RDvncSQb+LQr/8zH+jqvjzqiWNgNd+w0ozfCkkInAX7Rb02Duo09Jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235098; c=relaxed/simple;
	bh=S/yXsu1PO6ofCcMnGaIWpYy3HsQ+nPAOV4ewjPhKU+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7aZjmww2iQr7n69g0LInuAFVmPJEPuM7z28mIMKtq425xefJc10F2LkUKrTzZqeFSU0HpeuwydAUSzAyAuK4rzQbw3yc1W4PxG/5UZu9CbbHTeG1erfbG5hijhDvfAMwCjzAZce1h6jBKVujF45P4oUSdKhZRL0TaA0xZlWws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofyKsrDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B41C4CEEB;
	Wed, 23 Jul 2025 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235098;
	bh=S/yXsu1PO6ofCcMnGaIWpYy3HsQ+nPAOV4ewjPhKU+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ofyKsrDSvVBBbHPYGuOxL15STCzai/mRt0iTcnoNYL18P4yNqYSfnrpFcl9mX88/p
	 tR7mF4gjitNGtCbC6NOZkGh4YA54mbn7TOx4GwIwrOYjpGMB2E8D6mFcLPFQg+0PQ9
	 R50/68bb7Oe2ns7T4nnTucgO2ufQG7aJZdQOY7q/F1HHiFsXdR6oN0O1XdmYo3GEK6
	 VCnNo/pAeXRdBduIw5tpE2OtbvlUHHQc0aa/FOP/vwQiVIFdeAbsfvIx3dui0cxyD5
	 WGWtG4zKduLn8URz30qrQp7APaEmp5g4NiU3KXYIRkH50Nq3nqDc8uWG/deDIEUBUm
	 sX1LN2U9y8Xyw==
Message-ID: <9d39486f-62f5-4a72-9996-02ef6a3f1ae8@kernel.org>
Date: Wed, 23 Jul 2025 10:42:29 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: zoned: return error from
 btrfs_zone_finish_endio()
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250722113912.16484-1-jth@kernel.org>
 <20250722113912.16484-3-jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722113912.16484-3-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 8:39 PM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Now that btrfs_zone_finish_endio_workfn() is directly calling
> do_zone_finish() the only caller of btrfs_zone_finish_endio() is
> btrfs_finish_one_ordered().
> 
> btrfs_finish_one_ordered() already has error handling in-place so
> btrfs_zone_finish_endio() can return an error if the block group lookup
> fails.
> 
> Also as btrfs_zone_finish_endio() already checks for zoned filesystems and
> returns early, there's no need to do this in the caller.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


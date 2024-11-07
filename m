Return-Path: <linux-btrfs+bounces-9383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB39C0532
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 13:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE84FB21811
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00120FA8A;
	Thu,  7 Nov 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNZVP1Y0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DF20F5B8;
	Thu,  7 Nov 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981047; cv=none; b=g7aQ0nON+F/bXVsNRcMBQXMgdKOx/fQhUkoPJ1BqIqy03dADKJJNaY4fVXC4tSgkwKBDb6zhdX/sdndd+Mo9xi/tmyGWFosbg1tApQI4pfJ9kQjgZcRK8jiiJ1gQrN6rZ1+xtk+Zm7710Tume88/CZ/x1GbH/ZjAGj/n1YdxxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981047; c=relaxed/simple;
	bh=I/u95mbKCvFvs2EBtEwyUYQAjGPOpjIkP6O9sT9lstk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XI2VzmSOYhL+HgyLsw14yWgodTjkCnKee749RENpuFTJ/0F6TLjVy1XGONs1rPQIGttPDHuhyavaxeSmiiWy1jNgAdValXEVM2JublefJ7qq0YoH87ITfv9zwLlPIdZB/UNDNj6CIF/TYacNC/y2046y59usiWidnPZLX9byrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNZVP1Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E109C4CECE;
	Thu,  7 Nov 2024 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981046;
	bh=I/u95mbKCvFvs2EBtEwyUYQAjGPOpjIkP6O9sT9lstk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sNZVP1Y0bf2NXpBwhe0nFoeW+zDE1haoDrjdG4mqCyh59M06hjp+6aKiixfSX1LHd
	 tWUTE1IwhqTpmc+G5ueeXhM+pa3re3XRhk0BNZ0qoujuuD9GZjfftuWaAM/g0sXHmn
	 BTcW3irQiQ/lg5FZ5gQSwnF+V2bs+Xv/juMPw3K9ra/FJI1MyenjSsvdK/SRs3m80C
	 4qe99ytGwQV91z48oom5/y8N5NFqfq1OombtSr0rSyFHNm5+HFFFxAdX8yLlv76UL8
	 2bSqvmY49rVtCmskate0Vjap8Pc5Jz+GzE1e9GbDXNnkFWdVmWhAuxz0kRQC9GhfMG
	 L6/b0YfZ3zJ4Q==
Message-ID: <b0da3642-b3d7-4bd1-8609-50b138e758d9@kernel.org>
Date: Thu, 7 Nov 2024 21:04:03 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] block: take chunk_sectors into account in
 bio_split_write_zeroes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241104062647.91160-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 15:26, Christoph Hellwig wrote:
> For zoned devices, write zeroes must be split at the zone boundary
> which is represented as chunk_sectors.  For other uses like the
> internally RAIDed NVMe devices it is probably at least useful.
> 
> Enhance get_max_io_size to know about write zeroes and use it in
> bio_split_write_zeroes.  Also add a comment about the seemingly
> nonsensical zero max_write_zeroes limit.
> 
> Fixes: 885fa13f6559 ("block: implement splitting of REQ_OP_WRITE_ZEROES bios")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-btrfs+bounces-9384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90C9C053E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4CD1C21BA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF720F5C8;
	Thu,  7 Nov 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjZYpFMY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5420B1FF;
	Thu,  7 Nov 2024 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981123; cv=none; b=r7FooHQYwH8zFdNdGGyptV+1cgdt/reux1nBWraw5RhXX6akV6/Gzu0+J3eLxkhXf/u69SoUpfg+eMQSDp1Sp1tHNMGlBME6HG466zxCtBtW5aSMt5DA/ORXEIopaGn9do2WCOHrcAv4z0xMOReJfpNGvMzrkTyCl11FcNpmgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981123; c=relaxed/simple;
	bh=D+Mq0vueGbC+wrkRmahPIUkwTuOnv4qSU8n+g5Oz0kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9i+wQ1dheUXbP94UiHx2bVoRSLz5EkfnstoAxqj+HTY5lPx0EhvKpQ1tB3TdK2TsRWhVCR7RaBo0RTpWelWfrL4XGKwJ4agjlBO9yFddy/Zz9x2kr5bdgAzaJWLpknbv3etBgNtZgBNA6At7S66mGkd8UfW3AzN4JoZ3PbDAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjZYpFMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2F7C4CECC;
	Thu,  7 Nov 2024 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981122;
	bh=D+Mq0vueGbC+wrkRmahPIUkwTuOnv4qSU8n+g5Oz0kU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RjZYpFMY3I3vkK+I1JbBj19hHE+1kbVwN+dR+JdjEap9oBQspwWjso2pndS8jLJIq
	 lmkYEl/3ZTFm0QNCuCCNRVnB0vP2mXTVf6W7tHYHtIkHdr2JpHA9i/Oe9foxVV+X+7
	 pY3Yo0jmteUZ4YXd6YZBm+pl0mp9KieciLEjB6NEdBhO6JSGZMK3Sp8d6ifPNSftG2
	 RziOfECWHFEiDq9r44Fm4duxa4nv7WRZrx0gKKydv2vxwTC/qIcdv/Ly8D/qyHniIj
	 Rwj1Rp7l5gZmhHW0jkH43ZINECpFIO7LrVZwSrA6LgYQAru8dqclpEvp5IR6AWU58r
	 q/yda5zeTpQiQ==
Message-ID: <d0873473-1220-4492-8f81-8d10e337f251@kernel.org>
Date: Thu, 7 Nov 2024 21:05:20 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: fix bio_split_rw_at to take
 zone_write_granularity into account
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241104062647.91160-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 15:26, Christoph Hellwig wrote:
> Otherwise it can create unaligned writes on zoned devices.
> 
> Fixes: a805a4fa4fa3 ("block: introduce zone_write_granularity limit")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


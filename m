Return-Path: <linux-btrfs+bounces-1019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D09816A31
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FD1F257CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB912B6F;
	Mon, 18 Dec 2023 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjXofiJh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF05125A3;
	Mon, 18 Dec 2023 09:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2461FC433C8;
	Mon, 18 Dec 2023 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702893010;
	bh=kliH95p4M6Xr4U/JBggiZ+H3u6I+liKEwWc2N1aGs18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FjXofiJhW9jL1rJtTbtwM+I1TO2JOPuwQLWysbLSk8VmfoJOporitqoAdo9zgM4tg
	 KebfTmvh2aktzrLEqFs/N0kl0uX4DvMaJgNWC5QM13PqxOrnSgLHN1nqp1uAZO8aBo
	 7JeNjhm1+aVR3evMPZK7qGpZIohwlWocUFheFK/AptmYfRw8IxPGb+DpyXqm17UJf9
	 wnuJBeilC1v2AgUTB+kvoBQeW3XHlcSMvr9hL2xfyetrXq63JhRlMZaNt6WyUy3gVx
	 cvhYq19/9JgtCumFTXIsxg1N+G7htDR9zvV6CTBfugqodVINZSHaYzg9bz+6On7/xx
	 yTtMD2cAMlOqQ==
Message-ID: <816f252c-191f-4517-931a-3d7b14dac654@kernel.org>
Date: Mon, 18 Dec 2023 18:50:07 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: simplify disk_set_zoned
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/18 1:53, Christoph Hellwig wrote:
> Only use disk_set_zoned to actually enable zoned device support.
> For clearing it, call disk_clear_zoned, which is renamed from
> disk_clear_zone_settings and now directly clears the zoned flag as
> well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



Return-Path: <linux-btrfs+bounces-1017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAB8169F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC61F23341
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13607125B8;
	Mon, 18 Dec 2023 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQzvQS+K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C46FA8;
	Mon, 18 Dec 2023 09:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD6FC433C7;
	Mon, 18 Dec 2023 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702892225;
	bh=Z4ThilXJPF52KkpFFtkk2UUa9/0Ai3GpLVjPXlR17A8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pQzvQS+KVHfkHlgbEBnhnpy0T/9Bx/Bzsk4DHPZNtT8gZuB8FzsYEzMa4y/M8HFTh
	 a/79UdFFQ4wb8X6ArgNHaCrumfzFl4c4nvRTtEs7R84rgH0ukIlh69/Oq7/aCEJ/xJ
	 Bp3oSPIeQEpmphihrSKDpgMu/OjpJ1ELUAiLMeRS079UF3wuSSNtgAUWYTP27D0N4e
	 IJvEkMcvnJbegCaHWkoh9e0ZLdb2D9VCH4mabPM+NXvDIRMbuCqMZ425d5qEpsLhcC
	 lQUcyoWmALOQNLsuwJ3tUeuhPUkPompc6LZj0O/RZdmA9kA/XaLDAtGiq6fcQDpfEM
	 DUFigcnPsQiWQ==
Message-ID: <bad7e62c-f4c6-4db9-a1ae-c14d56378072@kernel.org>
Date: Mon, 18 Dec 2023 18:37:03 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] virtio_blk: remove the broken zone revalidation
 support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/18 1:53, Christoph Hellwig wrote:
> virtblk_revalidate_zones is called unconditionally from
> virtblk_config_changed_work from the virtio config_changed callback.
> 
> virtblk_revalidate_zones is a bit odd in that it re-clears the zoned
> state for host aware or non-zoned devices, which isn't needed unless the
> zoned mode changed - but a zone mode change to a host managed model isn't
> handled at all, and virtio_blk also doesn't handle any other config
> change except for a capacity change is handled (and even if it was
> the upper layers above virtio_blk wouldn't handle it very well).
> 
> But even the useful case of a size change that would add or remove
> zones isn't handled properly as blk_revalidate_disk_zones expects the
> device capacity to cover all zones, but the capacity is only updated
> after virtblk_revalidate_zones.
> 
> As this code appears to be entirely untested and is getting in the way
> remove it for now, but it can be readded in a fixed version with
> proper test coverage if needed.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Not ideal... But I think this is OK for now given that as you say, the upper
layer will not be able to handle zone changes anyway.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/virtio_blk.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index aeead732a24dc9..a28f1687066bb4 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -722,27 +722,6 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>  	return ret;
>  }
>  
> -static void virtblk_revalidate_zones(struct virtio_blk *vblk)
> -{
> -	u8 model;
> -
> -	virtio_cread(vblk->vdev, struct virtio_blk_config,
> -		     zoned.model, &model);
> -	switch (model) {
> -	default:
> -		dev_err(&vblk->vdev->dev, "unknown zone model %d\n", model);
> -		fallthrough;
> -	case VIRTIO_BLK_Z_NONE:
> -	case VIRTIO_BLK_Z_HA:
> -		disk_set_zoned(vblk->disk, BLK_ZONED_NONE);
> -		return;
> -	case VIRTIO_BLK_Z_HM:
> -		WARN_ON_ONCE(!vblk->zone_sectors);
> -		if (!blk_revalidate_disk_zones(vblk->disk, NULL))
> -			set_capacity_and_notify(vblk->disk, 0);
> -	}
> -}
> -
>  static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  				       struct virtio_blk *vblk,
>  				       struct request_queue *q)
> @@ -823,10 +802,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>   */
>  #define virtblk_report_zones       NULL
>  
> -static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
> -{
> -}
> -
>  static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  			struct virtio_blk *vblk, struct request_queue *q)
>  {
> @@ -982,7 +957,6 @@ static void virtblk_config_changed_work(struct work_struct *work)
>  	struct virtio_blk *vblk =
>  		container_of(work, struct virtio_blk, config_work);
>  
> -	virtblk_revalidate_zones(vblk);
>  	virtblk_update_capacity(vblk, true);
>  }
>  

-- 
Damien Le Moal
Western Digital Research



Return-Path: <linux-btrfs+bounces-1016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425C08169ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 10:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B001B1F232D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28121125B6;
	Mon, 18 Dec 2023 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixzIFM8A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148C11C91;
	Mon, 18 Dec 2023 09:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3ACC433C7;
	Mon, 18 Dec 2023 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702892133;
	bh=PdHvoka0eRTRzrIhBD8Y+azqZmjNt6H86o7Q4PS3jto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ixzIFM8AXAn2cja/sTESRTfJoPsg4QgxKJKyvmiQM1CWZvFLAr5MOkpcMN5Ys5906
	 T8lUM+06OuvSGYR1vOezMXxxqsQquG8879ZlIu4jDA+oxOiue63P+nt0QAXJLhWxjj
	 3bwrmS3JwSRWLln1vScF91Vne6aa858bo9b3C3EZBPaGmRIS91eu5THp6C1F1xCrAa
	 kClzMKYkkxYj2vY6CDTStAonyBqcFheLWMSCSp+Zwqk7HBKDH0ghgzyyugA2cOtdny
	 xgjGGTAbU9lsmnyRKUvlHqbIU27gfNYWiNkdsKdroDVxWtstQUzQM1ztQt6soO5+pJ
	 4u5RYHjamVwZw==
Message-ID: <7d3c7ab1-490a-498c-9e15-a33a36788b61@kernel.org>
Date: Mon, 18 Dec 2023 18:35:30 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] virtio_blk: cleanup zoned device probing
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/18 1:53, Christoph Hellwig wrote:
> Move reading and checking the zoned model from virtblk_probe_zoned_device
> into the caller, leaving only the code to perform the actual setup for
> host managed zoned devices in virtblk_probe_zoned_device.
> 
> This allows to share the model reading and sharing between builds with
> and without CONFIG_BLK_DEV_ZONED, and improve it for the
> !CONFIG_BLK_DEV_ZONED case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/virtio_blk.c | 50 +++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index d53d6aa8ee69a4..aeead732a24dc9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -748,22 +748,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  				       struct request_queue *q)
>  {
>  	u32 v, wg;
> -	u8 model;
> -
> -	virtio_cread(vdev, struct virtio_blk_config,
> -		     zoned.model, &model);
> -
> -	switch (model) {
> -	case VIRTIO_BLK_Z_NONE:
> -	case VIRTIO_BLK_Z_HA:
> -		/* Present the host-aware device as non-zoned */
> -		return 0;
> -	case VIRTIO_BLK_Z_HM:
> -		break;
> -	default:
> -		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
> -		return -EINVAL;
> -	}
>  
>  	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
>  
> @@ -846,16 +830,9 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
>  static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  			struct virtio_blk *vblk, struct request_queue *q)
>  {
> -	u8 model;
> -
> -	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
> -	if (model == VIRTIO_BLK_Z_HM) {
> -		dev_err(&vdev->dev,
> -			"virtio_blk: zoned devices are not supported");
> -		return -EOPNOTSUPP;
> -	}
> -
> -	return 0;
> +	dev_err(&vdev->dev,
> +		"virtio_blk: zoned devices are not supported");
> +	return -EOPNOTSUPP;
>  }
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
> @@ -1570,9 +1547,26 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	 * placed after the virtio_device_ready() call above.
>  	 */
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> -		err = virtblk_probe_zoned_device(vdev, vblk, q);
> -		if (err)
> +		u8 model;
> +
> +		virtio_cread(vdev, struct virtio_blk_config, zoned.model,
> +				&model);
> +		switch (model) {
> +		case VIRTIO_BLK_Z_NONE:
> +		case VIRTIO_BLK_Z_HA:
> +			/* Present the host-aware device as non-zoned */
> +			break;
> +		case VIRTIO_BLK_Z_HM:
> +			err = virtblk_probe_zoned_device(vdev, vblk, q);
> +			if (err)
> +				goto out_cleanup_disk;
> +			break;
> +		default:
> +			dev_err(&vdev->dev, "unsupported zone model %d\n",
> +				model);
> +			err = -EINVAL;
>  			goto out_cleanup_disk;
> +		}
>  	}
>  
>  	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);

-- 
Damien Le Moal
Western Digital Research



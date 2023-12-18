Return-Path: <linux-btrfs+bounces-1018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724EC816A29
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 10:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC0281514
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977AC12B6C;
	Mon, 18 Dec 2023 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as+YGjvF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAB11CBD;
	Mon, 18 Dec 2023 09:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877CBC433C8;
	Mon, 18 Dec 2023 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702892926;
	bh=w3Wuzja30oOGu0utwKgnSd8xLtm5mDiuTxMgEorAXbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=as+YGjvFQQHCp0vG4DpCpN+b/lQQcLdoRqqACk87PvDIKzXnIuGjJy4Y0UnVEkzvg
	 W27e3J1lmjujffQ0WLuvrrYYi29etk3JdlJ1yjGO+LAN/oWe5WrMGjTe44kFDWraEU
	 /WceoHYRnuBBo/kqBMPLs1FpitywHmoBgwrEvPH0JTmvwxB754j20bS453Pj0x6WeD
	 1ozC6QlkLCKH+mwqBTISxTymRT9hnit6pAFPWpQ+GGturAnfoh1wxKbf6GWE4zrlYT
	 aJbSfp34v/UjaYcB1vVc9jlpS1qqLFUQIqu0mTHZ+5RwSqmJFeqwd9URZqp/WViOzl
	 9FjPCS9lb0JgQ==
Message-ID: <09f1adfe-90b5-445c-b7f6-ae4fc7a9666a@kernel.org>
Date: Mon, 18 Dec 2023 18:48:43 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/18 1:53, Christoph Hellwig wrote:
> When zones were first added the SCSI and ATA specs, two different
> models were supported (in addition to the drive managed one that
> is invisible to the host):
> 
>  - host managed where non-conventional zones there is strict requirement
>    to write at the write pointer, or else an error is returned
>  - host aware where a write point is maintained if writes always happen
>    at it, otherwise it is left in an under-defined state and the
>    sequential write preferred zones behave like conventional zones
>    (probably very badly performing ones, though)
> 
> Not surprisingly this lukewarm model didn't prove to be very useful and
> was finally removed from the ZBC and SBC specs (NVMe never implemented
> it).  Due to to the easily disappearing write pointer host software
> could never rely on the write pointer to actually be useful for say
> recovery.
> 
> Fortunately only a few HDD prototypes shipped using this model which
> never made it to mass production.  Drop the support before it is too
> late.  Note that any such host aware prototype HDD can still be used
> with Linux as we'll now treat it as a conventional HDD.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

[...]

> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 6d8218a4412264..d03d66f1149301 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -339,7 +339,7 @@ struct sdebug_dev_info {
>  	bool used;
>  
>  	/* For ZBC devices */
> -	enum blk_zoned_model zmodel;
> +	bool zoned;
>  	unsigned int zcap;
>  	unsigned int zsize;
>  	unsigned int zsize_shift;
> @@ -844,8 +844,11 @@ static bool write_since_sync;
>  static bool sdebug_statistics = DEF_STATISTICS;
>  static bool sdebug_wp;
>  static bool sdebug_allow_restart;
> -/* Following enum: 0: no zbc, def; 1: host aware; 2: host managed */
> -static enum blk_zoned_model sdeb_zbc_model = BLK_ZONED_NONE;
> +static enum {
> +	BLK_ZONED_NONE	= 0,
> +	BLK_ZONED_HA	= 1,
> +	BLK_ZONED_HM	= 2,
> +} sdeb_zbc_model = BLK_ZONED_NONE;
>  static char *sdeb_zbc_model_s;
>  
>  enum sam_lun_addr_method {SAM_LUN_AM_PERIPHERAL = 0x0,
> @@ -1815,8 +1818,6 @@ static int inquiry_vpd_b1(struct sdebug_dev_info *devip, unsigned char *arr)
>  	arr[1] = 1;	/* non rotating medium (e.g. solid state) */
>  	arr[2] = 0;
>  	arr[3] = 5;	/* less than 1.8" */
> -	if (devip->zmodel == BLK_ZONED_HA)
> -		arr[4] = 1 << 4;	/* zoned field = 01b */

I think we should keep everything related to HA in scsi debug as that is an easy
way to test the block layer and scsi. no ?

Other than this, very nice cleanup !

-- 
Damien Le Moal
Western Digital Research



Return-Path: <linux-btrfs+bounces-143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01017ED9C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 03:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99E9B20C56
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC963CF;
	Thu, 16 Nov 2023 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBxNbZRu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8E199
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 18:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700103095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL4zxiN7u9NkwZgBjtZRADD+ybgJzZTVWcuKU9mDEZo=;
	b=CBxNbZRuUI6Ub7yHcByEtmxBz9AIKM4dIxbe6G4EmfwgFYoaP/VUCy0HS/CxD2ASIOJjxb
	P4WjtIqQzbdXs/PqFuM8AnsItyOB0xJVBUKbAdgdk7QYjOujH1c901fChnHb3BqCW5/XhD
	DGpFhF0gkY+EfHnrCwRg7TsWoIXaxNQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-LXZTFelKMGiSbsg9n4uegw-1; Wed, 15 Nov 2023 21:51:33 -0500
X-MC-Unique: LXZTFelKMGiSbsg9n4uegw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28032fd5866so306165a91.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 18:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700103092; x=1700707892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL4zxiN7u9NkwZgBjtZRADD+ybgJzZTVWcuKU9mDEZo=;
        b=nMo6R4W9rcQHJW6ApbrbiGS5BC8WBej8oVGYAimDD0/R1x3+JmNRzowNQB5LLJDd+W
         4+mRJPMYIANKJt5Dk883RHVgAmI+lc56fGts0LR4uLaxruSChIM/VVP06T1pfrobRxpz
         BaOj6T+k1ql0YxgcxIz+3gqH6OCEdjNavj6n2Q/ml2lnkOTcqJbYGBQG7qdmuyUu1MhK
         01CHA3/Goqh8DERaU8W8r7OH6jMlQ+CX6bs8MxqhkM4IoBY7ppFSBBZLffPf1Pn8739c
         +/iKFy5MxpAH4ObxtnVCUbUCcaBz+o4wE5pDKe90TeEEPMUfmvCcOxLBXWU5deJUeL9E
         dt5g==
X-Gm-Message-State: AOJu0YwYA0LgEnTYDF4wsdh+HhgQHAJvl45QVdf7m3wL59XzjB/Cve4z
	L3uPx9PLkwIMwOf7BivZ9MdUANKv5vdGHkGxDXvBNHm4fFIhWL2m7pussr3gOvSN04cLQLesN7d
	Ub81rlIT07kxBV9Iox5slhmM=
X-Received: by 2002:a17:90b:3b47:b0:27c:f8f4:fedb with SMTP id ot7-20020a17090b3b4700b0027cf8f4fedbmr16957714pjb.21.1700103092412;
        Wed, 15 Nov 2023 18:51:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGms3NCGbnZe4BJTxXjIBHSBKzJhwlVFfrZGxEm9fAyWwc5ptdzCfEOOxGKl933OFzN4PAkZA==
X-Received: by 2002:a17:90b:3b47:b0:27c:f8f4:fedb with SMTP id ot7-20020a17090b3b4700b0027cf8f4fedbmr16957705pjb.21.1700103092123;
        Wed, 15 Nov 2023 18:51:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090ab89100b00280469602bcsm517179pjr.2.2023.11.15.18.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:51:31 -0800 (PST)
Date: Thu, 16 Nov 2023 10:51:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] common/btrfs: add _btrfs_get_fsid() helper
Message-ID: <20231116025125.cdrwnopq33srdcb4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <887706aa6c981aff219b0b2faca614e8ee2323b3.1699417639.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887706aa6c981aff219b0b2faca614e8ee2323b3.1699417639.git.anand.jain@oracle.com>

On Wed, Nov 08, 2023 at 12:28:57PM +0800, Anand Jain wrote:
> We have two instances of reading the btrfs fsid by using the command
> 'btrfs filesystem show <mnt>' turn this into an easy-to-use helper
> function and also use it.
> 
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

It looks good to me, will merge it with:
  [PATCH v4 0/5] btrfs/219 cloned-device mount capability update

Reviewed-by: Zorro Lang <zlang@redhat.com>


>  common/btrfs | 14 ++++++++++++--
>  common/rc    |  5 +----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index fbc26181f7bc..f91f8dd869a1 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -457,13 +457,23 @@ _scratch_btrfs_is_zoned()
>  	return 1
>  }
>  
> -_require_btrfs_sysfs_fsid()
> +_btrfs_get_fsid()
>  {
>  	local fsid
> +	local mnt=$1
>  
> -	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
> +	fsid=$($BTRFS_UTIL_PROG filesystem show $mnt |grep uuid: |\
>  	       $AWK_PROG '{print $NF}')
>  
> +	echo $fsid
> +}
> +
> +_require_btrfs_sysfs_fsid()
> +{
> +	local fsid
> +
> +	fsid=$(_btrfs_get_fsid $TEST_DIR)
> +
>  	# Check if the kernel has sysfs fsid support.
>  	# Following kernel patch adds it:
>  	#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> diff --git a/common/rc b/common/rc
> index 7f14c19ca89e..b2e06b127321 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4721,7 +4721,6 @@ _require_statx()
>  _fs_sysfs_dname()
>  {
>  	local dev=$1
> -	local fsid
>  
>  	if [ ! -b "$dev" ]; then
>  		_fail "Usage: _fs_sysfs_dname <mounted_device>"
> @@ -4729,9 +4728,7 @@ _fs_sysfs_dname()
>  
>  	case "$FSTYP" in
>  	btrfs)
> -		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
> -							$AWK_PROG '{print $NF}')
> -		echo $fsid ;;
> +		_btrfs_get_fsid $dev ;;
>  	*)
>  		_short_dev $dev ;;
>  	esac
> -- 
> 2.39.3
> 
> 



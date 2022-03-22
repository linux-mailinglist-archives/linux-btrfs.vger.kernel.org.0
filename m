Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001CC4E4691
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiCVTUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiCVTUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 15:20:54 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72F66C85
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:19:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k125so14805164qkf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m8/RIVJJDn/Dh+DtqyofHaD0AkX1UTG7IOEUpYsWR8k=;
        b=vFIzk0gG+m4/TrMYzbavfNTRmv6bJT9dnEqcIp0bCp7wduJfc/7Mg1CsjEXIK9TMeN
         NrHSRikARBRcYSxb3u1+9Dm0iDKwy1kOrC8lvZwst+veY5QVfVDhoB9IWP2qSZ/U0NFK
         MyetUUb2Zi7YewJVhoErCPtkHoLIrrctG4Y4qVhvemPZ7MO659SMiDPhSwQR62DsE7u2
         5nSro+rgzYZA4wVE17pXA+/illDfvohK87scnd16DkN51w2b+SVjDCVK5qIudz7f/S9B
         iwZ0MrydFKAwhgnC5NtIlObi4FuvvfF9pDuSlg2ym8HPNZ5WYkm95YiLwWqTCUacTdGq
         nNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m8/RIVJJDn/Dh+DtqyofHaD0AkX1UTG7IOEUpYsWR8k=;
        b=iNcpVkE3+Tkj4iJVR0Gy5i19O4yWyl12DHue4Nnl+5FPxtoZzAEY32VMW5Ebz/2NQj
         AdwT9drOe/h3h7Kz5/YE9s+T2WUIZ8/Y0jCU/dM6tWoUUv4a4jSa9OwRDGHkcx5rMA46
         vpn89WP/r70i7WahjVlqg84Sute/bhDpgD5gwmBqrFwA4/2F21gOd6jKQpByXE6Z3iB8
         vsbmmo4+j1uxruAg2rVDZ9pojp1vWd6/jYewfcil9LA0g33gGx4WNFkHZvtm+d85WZ7K
         EHhyi328Q3UI4FLNXPvSEq1nLm02PzKTY2m5GDbvGNTxP2cNXaDhw4IrBHHzr/QdzOtM
         RkMg==
X-Gm-Message-State: AOAM530OvSiYW8K7ut0zHS8QFv+cW3wIQK0nt4Zf5uEozThDawlxAFno
        xSPDaAsg9Ax7+yl6LM7x3z/Q4g==
X-Google-Smtp-Source: ABdhPJydpoV6wmie3KBD7iHqYtpaHHMKynVEYGamyHR84SX9ihplA9etSGZuhREUgKoW1hb0RfA/1A==
X-Received: by 2002:a05:620a:c55:b0:67e:125b:38ea with SMTP id u21-20020a05620a0c5500b0067e125b38eamr16194346qki.396.1647976765234;
        Tue, 22 Mar 2022 12:19:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n143-20020a37a495000000b0067b12bc1d7bsm9609691qke.13.2022.03.22.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:19:24 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:19:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 3/5] btrfs: change the device allocation_hint property
 via sysfs
Message-ID: <YjohO4/ShmN9CVXd@localhost.localdomain>
References: <cover.1646589622.git.kreijack@inwind.it>
 <7c56077a080b9ab77d1a722cb3bdde50e83895c4.1646589622.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c56077a080b9ab77d1a722cb3bdde50e83895c4.1646589622.git.kreijack@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 07:14:41PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> This patch allow to change the allocation_hint property writing
> a numerical value in the file.
> 
> /sysfs/fs/btrfs/<UUID>/devinfo/<devid>/allocation_hint
> 
> To update this field it is added the property "allocation_hint" in
> btrfs-prog too.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/sysfs.c   | 76 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.c |  2 +-
>  fs/btrfs/volumes.h |  2 ++
>  3 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 59d92a385a96..c6723456c0e1 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1606,7 +1606,81 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
>  	}
>  	return scnprintf(buf, PAGE_SIZE, "<UNKNOWN>\n");
>  }
> -BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
> +
> +static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
> +				 struct kobj_attribute *a,
> +				 const char *buf, size_t len)

If you're using vim, use

set cindent
set cino=(0

This will give you the proper formatting we expect, this should be something
like

statice ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
						    struct kobj_attribute *a,
						    const char *buf, size_t len)


> +{
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_root *root;
> +	struct btrfs_device *device;
> +	int ret;
> +	struct btrfs_trans_handle *trans;
> +	int i, l;
> +	u64 type, prev_type;
> +
> +	if (len < 1)
> +		return -EINVAL;
> +
> +	/* remove trailing newline */
> +	l = len;
> +	if (buf[len-1] == '\n')
> +		l--;
> +

This is unnecessary, because lower you can do...

> +	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
> +		if (l != strlen(allocation_hint_name[i].name))
> +			continue;
> +
> +		if (strncasecmp(allocation_hint_name[i].name, buf, l))
> +			continue;
> +

strmatch(buf, allocation_hint_name[i].name)

I would make a separate patch to change strmatch to do strncasecmp instead, but
then you can just use that helper.

> +		type = allocation_hint_name[i].value;
> +		break;
> +	}
> +
> +	if (i >= ARRAY_SIZE(allocation_hint_name))
> +		return -EINVAL;
> +
> +	device = container_of(kobj, struct btrfs_device, devid_kobj);
> +	fs_info = device->fs_info;
> +	if (!fs_info)
> +		return -EPERM;
> +
> +	root = fs_info->chunk_root;
> +	if (sb_rdonly(fs_info->sb))
> +		return -EROFS;
> +
> +	/* check if a change is really needed */
> +	if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) == type)
> +		return len;
> +
> +	trans = btrfs_start_transaction(root, 1);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	prev_type = device->type;
> +	device->type = (device->type & ~BTRFS_DEV_ALLOCATION_HINT_MASK) | type;
> +
> +	ret = btrfs_update_device(trans, device);
> +
> +	if (ret < 0) {
> +		btrfs_abort_transaction(trans, ret);
> +		btrfs_end_transaction(trans);
> +		goto abort;
> +	}
> +
> +	ret = btrfs_commit_transaction(trans);
> +	if (ret < 0)
> +		goto abort;
> +
> +	return len;
> +abort:
> +	device->type = prev_type;
> +	return  ret;

Extra whitespace here.

> +}
> +BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
> +				      btrfs_devinfo_allocation_hint_store);
> +
>  
>  /*
>   * Information about one device.
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5e3e13d4940b..d4ac90f5c949 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2846,7 +2846,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  }
>  
> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
> +noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
>  					struct btrfs_device *device)
>  {
>  	int ret;

You can drop the noinline thing here as well, and make sure to fix the
indentation.

> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index bd297f23d19e..93ac27d8097c 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -636,5 +636,7 @@ int btrfs_bg_type_to_factor(u64 flags);
>  const char *btrfs_bg_type_to_raid_name(u64 flags);
>  int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>  bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
> +			struct btrfs_device *device);

Make the indentation correct.  Thanks,

Josef

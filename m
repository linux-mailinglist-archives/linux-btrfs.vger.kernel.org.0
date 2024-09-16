Return-Path: <linux-btrfs+bounces-8054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCD979F93
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2131C23224
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A61534EC;
	Mon, 16 Sep 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DEgA0Jy7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55408145336
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483304; cv=none; b=hrDoL8bstSG58tQKmX3zDwFLGk8Of0X2mZGEnY8Ep2cISFjk2ycWPHl3ss8LbFWP+dtXH237+TquFxG2IjCrDG/sSsyKtbBMoE1R0a3Ell3OLGp+kPM314Dlhwtosjh4x4k6G93NO43BpjTUsTs4fyyOknmzDsaYHXorF/rlrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483304; c=relaxed/simple;
	bh=M6qt0MqEg21tDFsnU0kxYsYOzFeuxCiE9c4uNlwuuyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvOZjsG5w4GOVMrel8RAcdhAOWMRV7zTMETmJ65rQYwh1PeJM/kAD2KIBKxi9ZOHCR3aIDuK6cqLpzfuKXykL2kGIsr6iSIMBr9fKbeMsAbPIKDLQbr3mF3OMXozXIPnuVLRdLBwo8PF6/ihdAjpZTQHldnEsJMrcYo5TEBB5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DEgA0Jy7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374d29ad870so1981820f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726483301; x=1727088101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ra8/pqRfP7A8W4Sg1b45pf3BbARdFe/KatE6of4jnNM=;
        b=DEgA0Jy7YJ4CFPxbHsucK8pBU2PDOnGdbv3aRhNbIZ+g/2fTRU23gm494BbL+2WlPg
         mvLBqeJ8zf30v5ybDHo8w3tg23Nilq73g60lSGxx68JdGrdwPCXZl4LmFqwLYmEx5Yw+
         +PNY82hxrbGrIO371SVh8JFlpnoGt6o5pDuIM+EbDI2XwiWn4/rWH25i3KEZfnDnobW3
         R1I3oytSQ9z92jXgicjpud2EvckpHyOyINttrC8EmfBLI/ZxwGnSy4KppipC03mhlqp2
         fv3NQNN5ncSLlLFC4EfBxpDFVBcqayiGFVQiXw+AqIPUz7bbianVUag5oEYBLgBkzyCD
         6YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483301; x=1727088101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra8/pqRfP7A8W4Sg1b45pf3BbARdFe/KatE6of4jnNM=;
        b=vfPKeGfm+tfLbHX9d7iVK+VqrDmSfdjawTu/no2tw9objBdWskM3GhM85ZrBk5mzcw
         CQVqY+W8tinlwKwzXJGdKekJUoeC+AclVb0uKAohnKki43sNex9IEjugKFIHUw0AOegr
         XJpAPIZhZwaTw7OXUBwWUQottcAsgUtWHH3NX+jxOWUtcU8YozTZS/pGNh0tVWa5BIbL
         M3nUpUaTRMjinzyubY+iG+CD+J/F+q2M59XBMVvdx+pO7rrShm6dGfTAeFAv5jV3FMjv
         ADi8mFY8e0G5LjkzslfW9WIf+k5R7CRJkVyHgw6jMVlbg11QpU1i4ZY/LGByjEWi18lD
         MvQw==
X-Forwarded-Encrypted: i=1; AJvYcCWmOUE1pY7MW6i0LzleD4dvKMkUeJyE69KNRIPhjcy1/JAiLlbsDzSNbx/FsGjhz6vH3OYOH9ddgxWI6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4o834F9OKWW1HmvmRPM02/9J2ne5f0BTUrDBRTRbejvMG+IG8
	Mj/HYJX3xGczFXiPCwyWJz3E02UlrWytXBQ2f4eaQ0Ll5A1vxpqa0VAIzK42p64=
X-Google-Smtp-Source: AGHT+IEmR93xh2og4ZQJtp1ucu8ZW4W/zfBvMfoRdORmexaCQuJzT7M8tUl3c1DLK5WZSD+CB9sFJA==
X-Received: by 2002:a05:6000:c89:b0:374:b9a0:ddee with SMTP id ffacd0b85a97d-378d625a9d0mr5502398f8f.56.1726483299927;
        Mon, 16 Sep 2024 03:41:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2933sm33627785ad.155.2024.09.16.03.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:41:39 -0700 (PDT)
Message-ID: <44534dea-0baf-420b-a2c2-0ee15db7298a@suse.com>
Date: Mon, 16 Sep 2024 20:11:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] btrfs: Don't block system suspend during fstrim
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
 <20240916101615.116164-4-luca.stefani.ge1@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240916101615.116164-4-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/16 19:46, Luca Stefani 写道:
> Sometimes the system isn't able to suspend because the task
> responsible for trimming the device isn't able to finish in
> time, especially since we have a free extent discarding phase,
> which can trim a lot of unallocated space, and there is no
> limits on the trim size (unlike the block group part).
> 
> Since discard isn't a critical call it can be interrupted
> at any time, in such cases we stop the trim, report the amount
> of discarded bytes and return failure.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>   fs/btrfs/extent-tree.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index cbe66d0acff8..ab2e5d366a3a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -16,6 +16,7 @@
>   #include <linux/percpu_counter.h>
>   #include <linux/lockdep.h>
>   #include <linux/crc32c.h>
> +#include <linux/freezer.h>
>   #include "ctree.h"
>   #include "extent-tree.h"
>   #include "transaction.h"
> @@ -1235,6 +1236,11 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> +static bool btrfs_trim_interrupted(void)
> +{
> +	return fatal_signal_pending(current) || freezing(current);
> +}
> +
>   static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   			       u64 *discarded_bytes)
>   {
> @@ -1319,6 +1325,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   		start += bytes_to_discard;
>   		bytes_left -= bytes_to_discard;
>   		*discarded_bytes += bytes_to_discard;
> +
> +		if (btrfs_trim_interrupted()) {
> +			ret = -ERESTARTSYS;
> +			break;
> +		}
>   	}
>   
>   	return ret;
> @@ -6473,7 +6484,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>   		start += len;
>   		*trimmed += bytes;
>   
> -		if (fatal_signal_pending(current)) {
> +		if (btrfs_trim_interrupted()) {
>   			ret = -ERESTARTSYS;
>   			break;
>   		}
> @@ -6522,6 +6533,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	cache = btrfs_lookup_first_block_group(fs_info, range->start);
>   	for (; cache; cache = btrfs_next_block_group(cache)) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +

Please update @bg_ret return value.

>   		if (cache->start >= range_end) {
>   			btrfs_put_block_group(cache);
>   			break;
> @@ -6561,6 +6575,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +

The same here, please update @dev_ret.

Thanks,
Qu
>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>   			continue;
>   


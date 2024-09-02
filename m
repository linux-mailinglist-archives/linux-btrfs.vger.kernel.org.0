Return-Path: <linux-btrfs+bounces-7753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5563968FD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A891F25B00
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA113BC2F;
	Mon,  2 Sep 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J16BW/DJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94213D50A
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316589; cv=none; b=LB53AjnQ7jL/C7TFaeers42TgVN9Ig27uiIYlIn/682w/3ZQEYFKPhAI9wLNH382Kl36vMWjcT3A1zK+uBxCH1Q+lASMHUpqFNLCtwY3a6ttJ5qJ+jySkkGhoxYWZhuGi30oTJhV3LQPa0thc0HU8RbBEIAGIMAqvvL6OB7zkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316589; c=relaxed/simple;
	bh=JeKAIV8Qs1+w6IaBQoCKZtopNY1wXWgBLUY+Nn5mHLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eoe7E9rGaUXfdcdBt8W3gEa1lOiDI40I2q7tRQonh97XCNUU2fV9q94ir55lFXgOmnSqgKVm0KRPF8UjNNn0UWMsBfVjfX4poFFxyqIxZgz4qgQs29X+WUBUk53lTi9HQwpAJXtXbFvvyOODVgUns0Fwxskd+1KOD0BAziqSoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J16BW/DJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so24435945e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725316585; x=1725921385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aiGY7FrMUgB/JFXLqO9FHvLDXWOoOx/leerdKf01sPA=;
        b=J16BW/DJosK8QO9CpFtGctl8Gautj+AB2jfpNL2HdLL+kz0cANzZr2c4oHl02+Mruq
         XSuM5hv+99sG8SgTMkRnzPr47uRO7qdcyNqTyURA906GIBbIIg8gd2MIjZkIzTmMid/b
         HYDwn+DuergE5CFtJRcJX8hZ6sDR0/TAM+dMZVLZNv98ojWUDefYhcyuQ/2J1Yb5aXU+
         b3bhROCnO0l3SD7vntkd9VlWItddlkJvdtMhHm+lNmlWvehrsQC3j+Fy5F89CddVuiiA
         StbLoiZTnONbh/Y8jFnn4SeDIcqUuS4jtmoMKjwRq8FE+bLxNJMGRYJ96NyAAjJlTO3s
         HahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725316585; x=1725921385;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiGY7FrMUgB/JFXLqO9FHvLDXWOoOx/leerdKf01sPA=;
        b=QRqBN8mNg46M8E1aZRxYS4di6YFwOtBOJVJYThra9aDaMjLG6t1UVA2QjMotixJ0OH
         Ni+8aD0Eog/NTIvNg2hu15sMNP5cS1PkIUCsKEkli92PkdqA38wQEdOx9rxd3wyuDnVg
         g0sG38r6XXPOYla+DoaX288PJfAmx4bZzMc2GkUaGQvnMYh93EvCH6Z0Qz4QbGvoB5nQ
         dAtHydr7QE5UY9n8K/X4el9u9YnrQlalBVirOWcDCqt64wDXQqUTePrFS3t5wkoAUK0I
         lzIaVQGCwM5YG2jArzFyYfCDxcAr2dh9JmCCe56VQVgkx66Az0b4P7qOW+tAFuu+euJR
         6L9A==
X-Forwarded-Encrypted: i=1; AJvYcCU+JiTOhcxeNvjBQxDxfTT5kQM548cjQCnx5RbP/9nf/aIjC3bWpri3xeh8UP/ob+132dWsm2Ptz5yprw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uwrQIwTEf4/nsgYIu4Ht42v6WrqfZMjn698M3OMdD0AJ56SX
	qPfdhgL4RTHuNvbLh5Z6cau4EunaikCh3HIE9A8v16esr87tcEQceWUyszZrUT4=
X-Google-Smtp-Source: AGHT+IHtb2QavBah0ufS5XufJQhqFWTnBfXdA4IaAMKaRk0IUL3FulKXfBZZtdpGDA0qi5EHUlB1lA==
X-Received: by 2002:adf:f1cb:0:b0:374:bde8:66af with SMTP id ffacd0b85a97d-374bde866f9mr6352144f8f.57.1725316584451;
        Mon, 02 Sep 2024 15:36:24 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8e79bb5d7sm2271408a91.55.2024.09.02.15.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 15:36:23 -0700 (PDT)
Message-ID: <6416ac73-0a2a-4568-b407-62fbeb6d5540@suse.com>
Date: Tue, 3 Sep 2024 08:06:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: Don't block system suspend during fstrim
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
 <20240902205828.943155-4-luca.stefani.ge1@gmail.com>
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
In-Reply-To: <20240902205828.943155-4-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/3 06:26, Luca Stefani 写道:
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
>   fs/btrfs/extent-tree.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 894684f4f497..7c78ed4044db 100644
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
> @@ -1302,6 +1308,9 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   	}
>   
>   	while (bytes_left) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +

Although with this change, the check should be more than enough to cover 
everything, better than the existing per-block-group check and the 
possibly large discard for the free extents.

Thus just this check would be enough.

The other thing is the old return value, I guess you can just add "ret = 
-EERESTARTSYS;" before the break.

Thanks,
Qu
>   		sector = start >> SECTOR_SHIFT;
>   		nr_sects = bytes_left >> SECTOR_SHIFT;
>   		bio_sects = min(nr_sects, bio_discard_limit(bdev, sector));
> @@ -6470,7 +6479,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>   		start += len;
>   		*trimmed += bytes;
>   
> -		if (fatal_signal_pending(current)) {
> +		if (btrfs_trim_interrupted()) {
>   			ret = -ERESTARTSYS;
>   			break;
>   		}
> @@ -6519,6 +6528,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	cache = btrfs_lookup_first_block_group(fs_info, range->start);
>   	for (; cache; cache = btrfs_next_block_group(cache)) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +
>   		if (cache->start >= range_end) {
>   			btrfs_put_block_group(cache);
>   			break;
> @@ -6558,6 +6570,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
>   	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (btrfs_trim_interrupted())
> +			break;
> +
>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>   			continue;
>   


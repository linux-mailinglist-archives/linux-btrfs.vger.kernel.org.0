Return-Path: <linux-btrfs+bounces-14513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DAACF99F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 00:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E0C3AFD1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DB20F070;
	Thu,  5 Jun 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="goBV7sUe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BE20C03E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161883; cv=none; b=aKZZL3DmHLcUdCw/Kwya1PawFu/DZK0nSb3VeXrQ+T8ue3zgk1DQQbIK/HSk2Wuf3oikoB27yVJscy5aiGhprxpVLKh6P8dUMMebmWhfc835XXn8MyfBvLdbf1+1IZ49j3NKtRdg1QB5UvJ/Z2/7wwmkMVnya9vDmXyUebK2oEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161883; c=relaxed/simple;
	bh=u9tBU+De7wm89jT1APNGgfPY6T009mrCcDdVx78ngt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZgipDAzuBISrJjZYlSCnYD+HUrA0JPoMre1TSC3WzIcz9ib2jC9DOBoCFZ/nqU1tD/0K5ab59KuSHVCyZX/2wIiWW6jAO6kpf5Lwtl2KOO0y6S6W4YHm8cnTCcqscw1xflg0A12UjNv2fwLkmpOtkqyqYHixwlXlLzvSGSfqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=goBV7sUe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a3758b122cso947576f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749161879; x=1749766679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+VndC8KneoaP4hJuMNdT4kNO1Kq4QAe+v+8ucfYLaUk=;
        b=goBV7sUez0DT4fHKzmrE+fnAgA2Ekebv2IP0jJTQMvmAxt1dJHOnfyrPIhOKKXJFoV
         bB4dR6/uT8rhRO5whPcxVPdGy6orDHF/odc3mpgKgBu6RbPfI+4DHYR6d3tmG0PO6Rp0
         XNgIHTJOspbeF8nfmD5T3oz5comAqc0OprH8K6DQ/nZHP/1CwwQLllexQ3GgAvVZrHkl
         rqvlvxFpVi5TDGKSB735Wwq/yENnn6IgjKz4c2qKEB7POpR67qb0lk9qkovUCc+P8H6a
         Mt14fH1XhjCEj5EXBB58kN3KKpGyQ7Ymcn7blbBReWi00CbDrNFCoiIJi4/5U/2J2wF9
         BTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161879; x=1749766679;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VndC8KneoaP4hJuMNdT4kNO1Kq4QAe+v+8ucfYLaUk=;
        b=Coq/45M1EiYMgfYw74M+KQ7aOy9QJzcyGVfhBlRKKB17NCG/BXpj7fwyT1UMdu0rru
         tA5yXt19qmSCNI25MtN2/kLCLfn1FhSlTLBTxiO+oiwXet5Ja1fbl9Y+Jp7HjKGTaQfz
         87A32QUA8CiFz4ZcaZ5xyeKYTyg9syJ1ha+I2IYKChUgLKNiCM6++i2lSOJeYK0ufK0f
         3QxW+wKj25FyxVS2Uk9Z/oOiPv9B2wwQXlFmrBuwhZUJZNh+Kfu624jdoewpaWgkit02
         8ocEev6Ec5waljG/SmwOWe26U4UjqE+u4HwoSm7gZcyK7nRmxd13+PUie0hf1/Exi1sc
         EKAg==
X-Gm-Message-State: AOJu0Yw+cNsP29ep44Caq/tqPHYxtG3owQC0EoHPOzokC9sC8u3/vl2x
	DaSvsuoUf0iMr8MwYQn01zabqi8LIiX1iedgvSROOaoW0QXSAe6hfzqToLiHikYuhuUKP1N+/Ip
	P/JtJ
X-Gm-Gg: ASbGnctutYueru+pV1cPh/LjfRnG37XHowWKkRGV7kBr9nf/cHVxLPujZIeJKEpn16/
	q7irYi4vWyP+rx+w6xCO21eVQ6W3rQZI2+JyG4VcGylG5/3BHcgklQ62Wfy8Ssq/maB722wMYid
	b9grlswPN37xg4FTIkJDzymWZrMhjnMzcYso1G/OMVq3QRIOesDROH3sl0E+gfDENR2xHG6UNmF
	0eXQNync7M1E4Bq4Q5tI2KxTULeHruWfAdO8Y1QOnkhjlY/NZpHPZSMYN6Mzb59hM44einqVE4x
	A14ujbkDxHPqvwLTZDqTWLAYvDjLcQlnM6fR2Vu5viTHgpJMrLQq2CinnNhauydGCS4i2Yz2BkV
	q31E=
X-Google-Smtp-Source: AGHT+IGVuOhzy6FaBsMP8f0K6ZEpTVp2MjPXGuuyJwB16yEranLtakiX3OfHOwartzbhUyLhZSb0Hw==
X-Received: by 2002:a05:6000:240e:b0:3a4:d8f8:fba6 with SMTP id ffacd0b85a97d-3a5319b4b5fmr766365f8f.6.1749161878577;
        Thu, 05 Jun 2025 15:17:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077ffasm1004015ad.30.2025.06.05.15.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 15:17:58 -0700 (PDT)
Message-ID: <095c58d4-41d7-49e3-bd0b-affe4f2eb2a3@suse.com>
Date: Fri, 6 Jun 2025 07:47:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use fs_info as the block device holder
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <8c2f064770e5bf7a78d768b3e0a2cad9643169d7.1749116730.git.wqu@suse.com>
 <20250605170431.GA3475402@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250605170431.GA3475402@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/6 02:35, Boris Burkov 写道:
> On Thu, Jun 05, 2025 at 07:15:48PM +0930, Qu Wenruo wrote:
>> Currently btrfs uses "btrfs_fs_type" as the bdev holder for all opened
>> device, which means all btrfses shares the same holder value.
>>
>> That's only fine when there is no blk_holder_ops provided, but we're
>> going to implement blk_holder_ops soon, so replace the "btrfs_fs_type"
>> holder usage, and replace it with a proper fs_info instead.
>>
>> This means we can remove the btrfs_fs_info::bdev_holder completely.
> 
> I definitely support this, I always found it quite weird that we had a
> single generic holder and relied on our own checking to ensure we only
> mount each device once. I think this should help insulate us from
> bizarre fsid bugs like we've seen with seed+sprout in the past.
> 
> However, I'm a little confused, as I thought Johannes and Christoph made
> the change to using the super block as the holder a while ago:
> https://lore.kernel.org/linux-btrfs/20231218044933.706042-1-hch@lst.de/
> 
> Did that end up failing to get in? Or it got reverted? I don't see it in
> the git history.

I guess that series didn't get in as no review?

> 
> Those patches have a lot more going on, so I'm also wondering if any of
> that is necessary for making this change? Haven't fully refreshed myself
> on that old series, though, so it's a fairly naive question. Also, it
> does seem like other fs-es uses sb, but I don't have a strong opinion on
> that and don't see why fs_info can't work.

The holder change itself is independent, and the main reason I'm pushing 
is, I'm on the way implementing the blk_holder_ops (mostly for the 
mark_dead() callback), thus need a way to grab the fs info from a bdev.

If we can passing fs_info directly around, without a sb wrapper, I think 
it should be fine.
(Bcachefs passes a structure holding its fs_info too)

Thanks,
Qu

> 
> Thanks,
> Boris
> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/dev-replace.c | 2 +-
>>   fs/btrfs/fs.h          | 2 --
>>   fs/btrfs/super.c       | 3 +--
>>   fs/btrfs/volumes.c     | 4 ++--
>>   4 files changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>> index 2decb9fff445..cf63f4b29327 100644
>> --- a/fs/btrfs/dev-replace.c
>> +++ b/fs/btrfs/dev-replace.c
>> @@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>>   	}
>>   
>>   	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
>> -					fs_info->bdev_holder, NULL);
>> +					   fs_info, NULL);
>>   	if (IS_ERR(bdev_file)) {
>>   		btrfs_err(fs_info, "target device %s is invalid!", device_path);
>>   		return PTR_ERR(bdev_file);
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index b239e4b8421c..d90304d4e32c 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -715,8 +715,6 @@ struct btrfs_fs_info {
>>   	u32 data_chunk_allocations;
>>   	u32 metadata_ratio;
>>   
>> -	void *bdev_holder;
>> -
>>   	/* Private scrub information */
>>   	struct mutex scrub_lock;
>>   	atomic_t scrubs_running;
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 2d0d8c6e77b4..c1efd20166cc 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1865,7 +1865,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>>   	fs_devices = device->fs_devices;
>>   	fs_info->fs_devices = fs_devices;
>>   
>> -	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
>> +	ret = btrfs_open_devices(fs_devices, mode, fs_info);
>>   	mutex_unlock(&uuid_mutex);
>>   	if (ret)
>>   		return ret;
>> @@ -1905,7 +1905,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>>   	} else {
>>   		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
>>   		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
>> -		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
>>   		ret = btrfs_fill_super(sb, fs_devices);
>>   		if (ret) {
>>   			deactivate_locked_super(sb);
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d3e749328e0f..606ddf42ddc3 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2705,7 +2705,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   		return -EROFS;
>>   
>>   	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
>> -					fs_info->bdev_holder, NULL);
>> +					   fs_info, NULL);
>>   	if (IS_ERR(bdev_file))
>>   		return PTR_ERR(bdev_file);
>>   
>> @@ -7168,7 +7168,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>>   	if (IS_ERR(fs_devices))
>>   		return fs_devices;
>>   
>> -	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
>> +	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info);
>>   	if (ret) {
>>   		free_fs_devices(fs_devices);
>>   		return ERR_PTR(ret);
>> -- 
>> 2.49.0
>>



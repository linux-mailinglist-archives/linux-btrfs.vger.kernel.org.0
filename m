Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0143C350
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 08:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhJ0GyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 02:54:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3663 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhJ0GyG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 02:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635317501; x=1666853501;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MXSqx/0jch4dYjptnM5jtWGjmxXzkko1qCkPlA0k3k4=;
  b=TFTy4uHmWfeNSSGSCsV7e3XNHMzjQhETMOEoLIiblt9ZqM6dhdDmOa/c
   WERqulX4ULcTPflK89iMC2K16bJWp+CLE/9NWhaWyXy+JK7RqN7Ej1IGH
   h86OKIfpjD6pAJ+UF0FC6AgujHJ1VHdg4kOkfdI8H1mxG4c81YmaRnSK5
   Kwd5kupTcGd3Y3s+6b43dKFEzfklYm4AIHf5xhRhXMyEFzFKjRVRKbk6g
   8CtTlFlCuXj/unqUZ+YWHNG97CqTWrxOBmH/HVQWi224eeqmWF70cQdGg
   8NkOG4Cmibjh9It5ipU9qsGKBoRnmUfzpcmfFb5Jycpi3hBpfJA5xDE6o
   A==;
X-IronPort-AV: E=Sophos;i="5.87,186,1631548800"; 
   d="scan'208";a="188720270"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 14:51:40 +0800
IronPort-SDR: 9yI7TNhgTbglh5EfTjWHEO2GoheWTKaPNF9lThHi2qO+1XilWXFNxTLx3l+8BjDIDsqWv/JLNw
 Gfrq4l/ISn0urNjB1rCPw56K3RMizIZ6+F0XwvqHxrSRJOIfVzuNhNgjzUkNV0+GQow5bePIss
 Hg8qwXkhptKe4sdxMn9jHkvEpetUqBMVR1kiCgfqmym8R4gQXph62gms42NEBVBJn3NS3uVgW+
 0VTx01gYR6070+z4Q0nqSwiqeUyJf46rC3xvxOAAo9LvtUWfiWPvXH968VbP1LiOKTrm95LgHK
 sQrTzpxtyxhPWxnBdNj4eolO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 23:25:37 -0700
IronPort-SDR: mvHVi2z442JriuftahbHuwbFcx0QbanogkjdJ6KRA2NELZVfNXzqty5Y1adHQXsJQY/trJQBYr
 Mn2pVh7Jf3UENUMS0OBTgsQAXjl1CAV2ZcZ3uNmWQ8JNrNd/ZpIJ5FQHb92rAGiTUcnqk3ahSN
 2yrlawQoSEEGIouXvvaJdv3/MDAmoG5PM+ofnD9apKfy2tpqVSZo+Ys7P8C1F+/YeNxp8SZBOQ
 hoy76YWybw6KcJrwnjKfgp8oPlda3kNf2dpY+TTukiGeDidZpot/LHYmc4XNGw/z73EJa2nTVd
 6ak=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 23:51:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HfK9T1kqXz1RtVn
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 23:51:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635317500; x=1637909501; bh=MXSqx/0jch4dYjptnM5jtWGjmxXzkko1qCk
        PlA0k3k4=; b=khwp0joTB2fcnGU3c8JMpR7x6YhpZoaYRIDd/NjlqW+s1tzluc+
        SC0XYvMvJoI4nDXMD0EnKXVd28wcaTRdPqH/eojOnW6NoRddFCBMb/5nGjONDJ+k
        +2n98T9Vs/iHDOHVBh3m8Q37dHn5OiAcMEh7WcdYrJocDB9D5tGhLbQO4I4nBkog
        bURhWGv6JUuYZkMZ6QvOqdZsiOaBUaKYLP67X8sNx0mcDCUeQjMZZ3WsjuomvWZh
        Jy+BURLJy5JVG/JfvfrDf+guVBtU27t/QjMXAiY83YjuMLiYBGQBvbOmR/n9yY64
        9tcMbGorOKN6/oZIbk5epOdzMiK8CKkfvHA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qe2QyNxbS5oe for <linux-btrfs@vger.kernel.org>;
        Tue, 26 Oct 2021 23:51:40 -0700 (PDT)
Received: from [10.89.86.157] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.86.157])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HfK9S01jqz1RtVl;
        Tue, 26 Oct 2021 23:51:39 -0700 (PDT)
Message-ID: <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
Date:   Wed, 27 Oct 2021 15:51:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Stefan Roesch <shr@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20211026165915.553834-1-shr@fb.com>
 <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/10/27 15:28, Johannes Thumshirn wrote:
> On 26/10/2021 18:59, Stefan Roesch wrote:
> 
> [...]
> 
>> +/*
>> + * Compute stripe size depending on block type.
>> + */
>> +static u64 compute_stripe_size(struct btrfs_fs_info *info, u64 flags)
>> +{
>> +	if (flags & BTRFS_BLOCK_GROUP_DATA) {
>> +		return SZ_1G;
>> +	} else if (flags & BTRFS_BLOCK_GROUP_METADATA) {
>> +		/* For larger filesystems, use larger metadata chunks */
>> +		return info->fs_devices->total_rw_bytes > 50ULL * SZ_1G
>> +			? 5ULL * SZ_1G
>> +			: SZ_256M;
>> +	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>> +		return SZ_32M;
>> +	}
>> +
>> +	BUG();
>> +}
>> +
>> +/*
>> + * Compute chunk size depending on block type and stripe size.
>> + */
>> +static u64 compute_chunk_size(u64 flags, u64 max_stripe_size)
>> +{
>> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
>> +		return BTRFS_MAX_DATA_CHUNK_SIZE;
>> +	else if (flags & BTRFS_BLOCK_GROUP_METADATA)
>> +		return max_stripe_size;
>> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>> +		return 2 * max_stripe_size;
>> +
>> +	BUG();
>> +}
>> +
>> +/*
>> + * Update maximum stripe size and chunk size.
>> + *
>> + */
>> +void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *space_info,
>> +					     u64 flags, u64 max_stripe_size)
>> +{
>> +	spin_lock(&space_info->lock);
>> +	space_info->max_stripe_size = max_stripe_size;
>> +	space_info->max_chunk_size = compute_chunk_size(flags,
>> +						space_info->max_stripe_size);
>> +	spin_unlock(&space_info->lock);
>> +}
>> +
>>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>  {
>>  
>> @@ -203,6 +251,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>>  	space_info->clamp = 1;
>>  
>> +	space_info->max_stripe_size = compute_stripe_size(info, flags);
>> +	space_info->max_chunk_size = compute_chunk_size(flags,
>> +						space_info->max_stripe_size);
>> +
>>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>>  	if (ret)
>>  		return ret;
> 
> [...]
> 
>   
>> +/*
>> + * Return space info stripe size.
>> + */
>> +static ssize_t btrfs_stripe_size_show(struct kobject *kobj,
>> +				      struct kobj_attribute *a, char *buf)
>> +{
>> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
>> +
>> +	return btrfs_show_u64(&sinfo->max_stripe_size, &sinfo->lock, buf);
>> +}
> 
> 
> This will return the wrong values for a fs on a zoned device.
> What you could do is:
> 
> static ssize_t btrfs_stripe_size_show(struct kobject *kobj,
> 				struct kobj_attribute *a, char *buf)
> 
> {
> 	struct btrfs_space_info *sinfo = to_space_info(kobj);
> 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> 	u64 max_stripe_size;
> 
> 	spin_lock(&sinfo->lock);
> 	if (btrfs_is_zoned(fs_info))
> 		max_stripe_size = fs_info->zone_size;
> 	else
> 		max_stripe_size = sinfo->max_stripe_size;
> 	spin_unlock(&sinfo->lock);

This will not work once we have stripped zoned volume though, won't it ?
Why is not max_stripe_size set to zone size for a simple zoned btrfs volume ?

> 
> 	return btrfs_show_u64(&max_stripe_size, NULL, buf);
> }
> 
> [...]
> 
>> +	if (fs_info->fs_devices->chunk_alloc_policy == BTRFS_CHUNK_ALLOC_ZONED)
>> +		return -EINVAL;
> 
> Nit: As we can't mix zoned and non-zoned devices 'if (btrfs_is_zoned(fs_info))'
> should do the trick here as well and is way more readable. 
> 
> 


-- 
Damien Le Moal
Western Digital Research

Return-Path: <linux-btrfs+bounces-4321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887538A7B2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 06:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABABA1C21824
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA843ADC;
	Wed, 17 Apr 2024 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GtxRzbOZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69041C73
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326393; cv=none; b=jZo/SPP7JcBlmJSWv5ytcCZQ3c52iQ/BfXGbOqbg9lyGKeQtRQZr/ei/DG6ETkEbqVjjmfy3B5D7Mk++yL/AEzz3Dpz3dzWBp/0WJh2JcBwW7kuOyXnIcpBHfgbFVEXOc7/mPFBNtRFELERRnTMPIORb8v8efcv38r7Xl6bbNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326393; c=relaxed/simple;
	bh=aBu/w30isdtyKjUlyjHxx+mSUsopJq8SX+3T+OiivB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WCulko6i/o21rMrtXnw+zDUZtwfUU6FhrSx1wpqFKOY/nzj/exihDY3MehYD2xZ0At6ReBFeNcMMCAeW+NRT+ml+xi26rPFhIBn/VM8/Py0gDOq8dCMu4G0hFgzSwmVETllg9ui/vv0fxGociVX4IJIfNRTVMETkJ7KH56p28QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GtxRzbOZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so63279041fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713326387; x=1713931187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8nTM9FBy3f+i+DZEbjCoMz9vzHPfmP6SbxzrbWSs9i8=;
        b=GtxRzbOZ+GF5pK9C2kGwYx899Xi/SwKrmxzCxVpDs/Dm6dR+qhNcWP0GVo0PmjEwnD
         Poc+Od2X0hFwdhwrxA3lxdYl372qoXbus8yQbShj9Q/AXnSSGTzJC3apqUlcJklFPore
         vrOXRCqahIGiwypFFh9Dty9Q1BLunths6iA2PMys1bAC6ywh8xntL+JoVTBUEdVK3QhS
         1LUJ+jOS1b4yDAwFUuiJb1t0muV4MhLEhXbXVQqI0BKRbtmdHNSKzyLxEjMFPw2UZubD
         r6EQiiLEsnZV1nGIcZIOc8ohwsLchEobgd64fp+Ne7TNsEts+24RrePGb9GMv2JdGlFY
         G+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326387; x=1713931187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nTM9FBy3f+i+DZEbjCoMz9vzHPfmP6SbxzrbWSs9i8=;
        b=dOick5aivOQLe2XcbQ7OB/ObwGuhpOvZ1az4NDQMN6roMnrhe8llYRkrxLLlC216+Q
         yuRg3zzPNKMPczt0LBhmNoWAujb8WmmC/CoslEhqtGFvcEluIOSHmm2SyXb0lfsc7cFq
         p4iUsNFop4b9fcnZwvBTHAX3iPocAiD9oBC8oIPnbTq1bP1l9zu4WA4ZloYxH1id+azK
         YRkyx3RLc9v7Lq4zbA9xFFvze3AI9ixyRL9mV94gmiGNNr4avrEWdiCepHB+va89sHPu
         L+RJ5ynDlgkjJB9wTxqM7WdPLsnOJ/Cjj+u9A6OBiSDBQ0puSHe8UkM7rntxH+ET8Bil
         FtXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6H+WexNkLArJs39yE8cbIeiOgr7Kp36wF5Cm0LBKl2qkEvzi/+fu42XMuhnXSGjusTmb5xdADvDgI7JZ6s6F18YI/XAHD+3MW0nA=
X-Gm-Message-State: AOJu0Yx+GQEjUxRhmumhdZ9eDgDAYGTvVN8O5WgzvbIowkehmP8x1Ma4
	+S5idyDVbe/Vr8OX5eVuijNXwJSX5h6imtrrxOFKd1ViXHT6Mvd64amyah3QzuQ=
X-Google-Smtp-Source: AGHT+IH88TzP3ahVP7KkXqK8TryilWR3p0LHahJt4eWUPPf21ynMNBYtAngmnXRFISjYSBNRJ4L4JA==
X-Received: by 2002:a2e:3209:0:b0:2d8:d8b5:73c7 with SMTP id y9-20020a2e3209000000b002d8d8b573c7mr8931353ljy.23.1713326387267;
        Tue, 16 Apr 2024 20:59:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902e35300b001e44578dccasm10621882plc.254.2024.04.16.20.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 20:59:46 -0700 (PDT)
Message-ID: <f1bb92f4-461f-49a7-a108-657900e249c7@suse.com>
Date: Wed, 17 Apr 2024 13:29:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] btrfs: btrfs_cleanup_fs_roots rename ret to ret2
 and err to ret
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
 <c1e5cfaf-111d-49b4-b927-ee140e83e5ca@gmx.com>
 <a0daa2a7-b8ac-428f-bd46-b42e44c6a1eb@oracle.com>
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
In-Reply-To: <a0daa2a7-b8ac-428f-bd46-b42e44c6a1eb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/17 12:54, Anand Jain 写道:
> On 3/20/24 04:43, Qu Wenruo wrote:
>>
>>
>> 在 2024/3/20 01:25, Anand Jain 写道:
>>> Since err represents the function return value, rename it as ret,
>>> and rename the original ret, which serves as a helper return value,
>>> to ret2.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/disk-io.c | 22 +++++++++++-----------
>>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 3df5477d48a8..d28de2cfb7b4 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -2918,21 +2918,21 @@ static int btrfs_cleanup_fs_roots(struct 
>>> btrfs_fs_info *fs_info)
>>>       u64 root_objectid = 0;
>>>       struct btrfs_root *gang[8];
>>>       int i = 0;
>>> -    int err = 0;
>>> -    unsigned int ret = 0;
>>> +    int ret = 0;
>>> +    unsigned int ret2 = 0;
>>
>> I really hate the same @ret2.
>>
>> Since it's mostly the found number of radix tree gang lookup, can we
>> change it to something like @found?
>>
>>>
>>>       while (1) {
>>
>> Another thing is, the @ret2 is only utilized inside the loop except the
>> final cleanup.
>>
>> Can't we only declare @ret2 (or the new name) inside the loop and make
>> the cleanup also happen inside the loop (or a dedicated helper?)
>>
> 
> Cleanup inside the loop is possible, but it would be something like
> below, what do you think?

One less @ret, one less goto tag.

Only the btrfs_orphan_cleanup() call part needs some extra check, but 
still looks good to me.

Thanks,
Qu

> 
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c2dc88f909b0..d1d23736de3c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2926,22 +2926,23 @@ static int btrfs_cleanup_fs_roots(struct 
> btrfs_fs_info *fs_info)
>   {
>          u64 root_objectid = 0;
>          struct btrfs_root *gang[8];
> -       int i = 0;
> -       int err = 0;
> -       unsigned int ret = 0;
> +       int ret = 0;
> 
>          while (1) {
> +               unsigned int i;
> +               unsigned int found;
> +
>                  spin_lock(&fs_info->fs_roots_radix_lock);
> -               ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +               found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>                                               (void **)gang, root_objectid,
>                                               ARRAY_SIZE(gang));
> -               if (!ret) {
> +               if (!found) {
>                          spin_unlock(&fs_info->fs_roots_radix_lock);
>                          break;
>                  }
> -               root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
> +               root_objectid = btrfs_root_id(gang[found - 1]) + 1;
> 
> -               for (i = 0; i < ret; i++) {
> +               for (i = 0; i < found; i++) {
>                          /* Avoid to grab roots in dead_roots. */
>                          if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>                                  gang[i] = NULL;
> 
> @@ -2952,24 +2953,20 @@ static int btrfs_cleanup_fs_roots(struct 
> btrfs_fs_info *fs_info)
>                  }
>                  spin_unlock(&fs_info->fs_roots_radix_lock);
> 
> -               for (i = 0; i < ret; i++) {
> +               for (i = 0; i < found; i++) {
>                          if (!gang[i])
>                                  continue;
>                          root_objectid = btrfs_root_id(gang[i]);
> -                       err = btrfs_orphan_cleanup(gang[i]);
> -                       if (err)
> -                               goto out;
> +                       if (!ret)
> +                               ret = btrfs_orphan_cleanup(gang[i]);
>                          btrfs_put_root(gang[i]);
>                  }
> +               if (ret)
> +                       break;
> +
>                  root_objectid++;
>          }
> -out:
> -       /* Release the uncleaned roots due to error. */
> -       for (; i < ret; i++) {
> -               if (gang[i])
> -                       btrfs_put_root(gang[i]);
> -       }
> -       return err;
> +       return ret;
>   }
> 
> Thanks,
> 
> Anand
> 
> 
> 
>> Thanks,
>> Qu
>>>           spin_lock(&fs_info->fs_roots_radix_lock);
>>> -        ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>>> +        ret2 = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>>>                            (void **)gang, root_objectid,
>>>                            ARRAY_SIZE(gang));
>>> -        if (!ret) {
>>> +        if (!ret2) {
>>>               spin_unlock(&fs_info->fs_roots_radix_lock);
>>>               break;
>>>           }
>>> -        root_objectid = gang[ret - 1]->root_key.objectid + 1;
>>> +        root_objectid = gang[ret2 - 1]->root_key.objectid + 1;
>>>
>>> -        for (i = 0; i < ret; i++) {
>>> +        for (i = 0; i < ret2; i++) {
>>>               /* Avoid to grab roots in dead_roots. */
>>>               if (btrfs_root_refs(&gang[i]->root_item) == 0) {
>>>                   gang[i] = NULL;
>>> @@ -2943,12 +2943,12 @@ static int btrfs_cleanup_fs_roots(struct 
>>> btrfs_fs_info *fs_info)
>>>           }
>>>           spin_unlock(&fs_info->fs_roots_radix_lock);
>>>
>>> -        for (i = 0; i < ret; i++) {
>>> +        for (i = 0; i < ret2; i++) {
>>>               if (!gang[i])
>>>                   continue;
>>>               root_objectid = gang[i]->root_key.objectid;
>>> -            err = btrfs_orphan_cleanup(gang[i]);
>>> -            if (err)
>>> +            ret = btrfs_orphan_cleanup(gang[i]);
>>> +            if (ret)
>>>                   goto out;
>>>               btrfs_put_root(gang[i]);
>>>           }
>>> @@ -2956,11 +2956,11 @@ static int btrfs_cleanup_fs_roots(struct 
>>> btrfs_fs_info *fs_info)
>>>       }
>>>   out:
>>>       /* Release the uncleaned roots due to error. */
>>> -    for (; i < ret; i++) {
>>> +    for (; i < ret2; i++) {
>>>           if (gang[i])
>>>               btrfs_put_root(gang[i]);
>>>       }
>>> -    return err;
>>> +    return ret;
>>>   }
>>>
>>>   /*
> 
> 


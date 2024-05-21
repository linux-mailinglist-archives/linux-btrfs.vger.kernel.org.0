Return-Path: <linux-btrfs+bounces-5135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6A8CA598
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 03:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC1E1C21031
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 01:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608CC8836;
	Tue, 21 May 2024 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R90zP4o/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82E256A
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253529; cv=none; b=Apti1Gms35dbg11hVma+JUqT8zMUWygOYa0EBDBXZWyUW57dzfWe3boct+fx9wf6t/UM9Ij5koF8t3M/4gZYEnBhRIG7euwXCDIPEJtknCFUz9Fv3O38hNNlDDALlCGFrFvznokOvzmmkZrGwDitXsddzXON9rs8BrcgFqzzJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253529; c=relaxed/simple;
	bh=9Rv8hp/VIIkRvpXPdSfg0ooMH2iqG8GcOXUxVoC/x9Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o3E2utfNqKkkMk3rPknTixZOGTNrYj56GNnkbNIepHpgNWyoQUuVZ8DCOwtpSV8vD2aoXQnNqucwx5UO6EHqPAQa20wu+2qU1sz6JbZc6Wmy/82c4WayQm15+ZxdUtCOzf57cFmZQZrUH4eqvQ17LTwTIqhQaZIVzRTP13Q+27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R90zP4o/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e716e302bdso27743271fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716253525; x=1716858325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UbE7ERuU3D8c6iFXx+XtX8nZ6Od5JdUBInBO9TQ/lA0=;
        b=R90zP4o/uC654+kv1zR8GTpHxg7Ez2jldHeI8qfeOIiMTAK6p7sqUVLhKAQ87He0df
         F9uH9//9aI2ydoE9uRy6kif2esRC+VFQ/x/vlocDqqSASGwqfXtnTh1A5wpuCZDwm9t2
         AaaAU8gmxd7PNSBZi/3TrEMbDuGiMPmkxJcC5dlisxvvDWhXpN+IMc3khMRhHj8Eaj2U
         rsY+AuynyUtzfviDN769U1Oq8BSYJixhliHCH1a35Hr806DIUBTidqCuuatPZDt0vgLG
         NTEJsHtMHNSMXuS5rkPgDFZksiH4Y2du+pIhNli676rrqrIwT3RDQ7Y080aDB8RpZ6jk
         DjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253525; x=1716858325;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbE7ERuU3D8c6iFXx+XtX8nZ6Od5JdUBInBO9TQ/lA0=;
        b=ibKtGm2P7f0yxcKagK1WLyK/kBWjDVkIk/K5d1C8RK37b3W/W4jn3LuykvJuuXqskC
         tUw6G6vhYxmwdtrF8AlCUmXy3K5PwZNss3lUpPjnSOwfGzGRLY/dBjwEuG1gUlLMPVUt
         D7H9oxAgIe5mk285akDambfrJdlg3+204sTPSDRK3rGYRYvgsCpHXm7+sbbHciQRHedl
         56JS+nI+VGphix6ydOLg9OU/WMG3hgrmJUPahQfKSDuSiX11n0i4k5jZeXEKujZYCE76
         DPEndN+ilUeiks2S7FrT/C9Kcihnt/rBA6I7TVr7anFjiRJkYSkoejgvG4w+qMD9smhk
         M4LQ==
X-Gm-Message-State: AOJu0Yz7iSaJqZzmmLiSOs7z+/ahLjC1waE6Xuvz9fYy5Aq8gn3a/dFD
	yrKE58LQqHBTWpyeo36ep1ZzaXI0trIZMkcfca2CdkFn9CfITgi0xHNu+bzNlBI=
X-Google-Smtp-Source: AGHT+IEPYqiDZwxdyl4IwPBvDpo9ljdTRsEGMzMQZufi6Yep9Yvp5+70UemQH3q0Vo4QjBb2gvc5Vw==
X-Received: by 2002:a2e:5159:0:b0:2e5:8685:8b13 with SMTP id 38308e7fff4ca-2e5868590f8mr150546501fa.25.1716253525161;
        Mon, 20 May 2024 18:05:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3061c329dsm18793885ad.138.2024.05.20.18.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 18:05:24 -0700 (PDT)
Message-ID: <23aa71da-b9a1-414d-aa16-a46512455641@suse.com>
Date: Tue, 21 May 2024 10:35:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: automatically remove the subvolume qgroup
From: Qu Wenruo <wqu@suse.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715064550.git.wqu@suse.com>
 <90a4ae6ae4be63ef4df3d020707fb7b1ae004634.1715064550.git.wqu@suse.com>
 <20240520225051.GB1820897@zen.localdomain>
 <298e832e-349a-4914-81c3-f276b6cbc290@suse.com>
Content-Language: en-US
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
In-Reply-To: <298e832e-349a-4914-81c3-f276b6cbc290@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/21 08:33, Qu Wenruo 写道:
> 
> 
> 在 2024/5/21 08:20, Boris Burkov 写道:
> [...]
>>> +    /*
>>> +     * It's squota and the subvolume still has numbers needed
>>> +     * for future accounting, in this case we can not delete.
>>> +     * Just skip it.
>>> +     */
>>
>> Maybe throw in an ASSERT or WARN or whatever you think is best checking
>> for squota mode, if we are sure this shouldn't happen for normal qgroup?
> 
> Sounds good.
> 
> Would add an ASSERT() for making sure it's squota mode.

After more thought, I believe ASSERT() can lead to false alerts.

The problem here is, we do not have any extra race prevention here, 
really rely on one time call on btrfs_remove_qgroup() to do the proper 
locking.

But after btrfs_remove_qgroup() returned -EBUSY, we can race with qgroup 
disabling, thus doing an ASSERT() without the proper lock context can 
lead to false alert, e.g. the qgroup is disabled after 
btrfs_remove_qgroup() call.

So I'm afraid we can not do extra checks here.

Thanks,
Qu
> 
> Thanks,
> Qu
> 
>>
>>> +    if (ret == -EBUSY)
>>> +        ret = 0;
>>> +    return ret;
>>> +}
>>> +
>>>   int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>>>                  struct btrfs_qgroup_limit *limit)
>>>   {
>>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
>>> index 706640be0ec2..3f93856a02e1 100644
>>> --- a/fs/btrfs/qgroup.h
>>> +++ b/fs/btrfs/qgroup.h
>>> @@ -327,6 +327,8 @@ int btrfs_del_qgroup_relation(struct 
>>> btrfs_trans_handle *trans, u64 src,
>>>                     u64 dst);
>>>   int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 
>>> qgroupid);
>>>   int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 
>>> qgroupid);
>>> +int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info 
>>> *fs_info,
>>> +                       u64 subvolid);
>>>   int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
>>>                  struct btrfs_qgroup_limit *limit);
>>>   int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info);
>>> -- 
>>> 2.45.0
>>>
> 


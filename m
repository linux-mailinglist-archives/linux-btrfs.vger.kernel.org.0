Return-Path: <linux-btrfs+bounces-12439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB4A69BED
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789EC8A3F98
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25B21C9E0;
	Wed, 19 Mar 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eb+CkRl5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058321A43C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422755; cv=none; b=ilJhS7HObRn2voDxqGb7BDMuywN8e8G6rK4w8CGfw3DmyDLAmNKLhgi5kXD897DEf0oHyfVz6c8YYqhGpFfbPfMRvF5N3XycbwqOn48z+h6inb6YtMI52uWcRe7aHXHzwaHGwdATrmycbb5Bqz8e0ot6GdeiX7dlJQKGZaoFX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422755; c=relaxed/simple;
	bh=Tp4RSO9XwTzOMezRHxxix2lh4jPzVZD4Ktuma839LwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spRdgDeU4eL/BGrzVzqkQkh6BvwMY0Yr3xunXGVFdD5vwlNXkLRA8DfM5k/dCOkgu/MxAFMhrIgsPSykQ55V9OnHn2dThHFaFZ4cu0qBAgUArKsb8Bcz0l1RwqSbbMxdxhkMCbwIoaCMQzu0yvRmr9GICUQ7gIonIT61qIDXYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eb+CkRl5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3995ff6b066so53816f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742422751; x=1743027551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MHdCepOkPm0tf7IZtMySyozU9UXe5uR7jsyE++XAyhg=;
        b=eb+CkRl5TRhd3xnzXFPc4tJyBQjshY6ESt7IqbYT5QSzmB8FnRwcQIcW4XObEggTCL
         1a/zQm1p8gK6YF92XT53+eO75ZIFhZabFQ4ncbG2W4m/9MND9a5QEZ2js2TvgYw5vAmX
         EOWAuF3driw2blVVWpg5Cr3BZ8mpFclSpl73YAzBIvc7WsKDeQvxtMofjzAzjHgirq/v
         1v1R2n7svk7ebYY0jx0I8w6MyHhyW8FSV/ki1YSVdtbHRbScQbhhnw6vKJx4Cwl3KLLr
         QZOfkfvDhgaueVd44QRIVHgidegyV008w0QSrII6MLSmmdE+oCSF7oJj27Qbumli1hUD
         sNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422751; x=1743027551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHdCepOkPm0tf7IZtMySyozU9UXe5uR7jsyE++XAyhg=;
        b=Eg2M0ZAIuE7pRv0hfh1EMOM8DB6ckVX0czt3Mp/hW1SJilBREzq3xSqjzlc+DqMXCJ
         OGqx1x9Gfm/Xt7FQGXjnwHcMJZfgtJOErH2xjbfRk3Le8AEB71CGU08sbcaspODE6mfq
         SvySYgLGdKYQn1dT1HjXy6v1RV9xn3eKTuj9bXzfB4Es/2Er17eFL+IWkgbbLoW9W9mo
         2u0xhdtGlu/tStk/UsjDO6sm7+qIv1K93iEkWQBlaMXMIoxC77GsqMjcCai/3+lMedo9
         EpzGzPXHEMGVJQEg9A2mBqj5Yl2FUEKi9EAAoa954GZUYmYXXrGB4gFRUhx0sviB55Xw
         Bcwg==
X-Gm-Message-State: AOJu0YwPRLGqrsSzM7KCwqCl9TnCs/QV3PznOQp3KKBTPx1PH367pNh4
	7wzmTAKCh7RLngP+RlSHZxhhssLAjllzbJilZYvu4cJlUfVxWlQIZdeQTzOoFr8+8IgppMUVZU+
	9
X-Gm-Gg: ASbGncuUyLduQXFQZbndM4MxL0o0/Ljt4FFoV8CnFoHeYV4xOvoRi/TxKiLnQsB0QE7
	Tb+YV+/owbdnWZ15j46jEKW4kj7d1Djno0ydMt+ZSfE72GWtX/QmLcO9NXjcgxw5ESPG+IduPSq
	y81ScuKzuM99CpQV7r1v29uXXqIho9njB6i9QdHTD5fNdeOz8Y8aE97BI2HyeLIC8kYVPxiQdEN
	Xy5z+nlIbMSI44j4AgrVDJENfrwJ3k9hyzvKeoamSGflRT6BnHBIN8zJHEpEG7cS7XAqIajCiy8
	FSO9fy20c/VOTjGXeAIIb/Y8PewSyT3LhiCUL8GaHV3d5LaScOGoRSGefvevWmJSsp3cNZOh
X-Google-Smtp-Source: AGHT+IHaBD+O88me7pSj8Dxdedz+hZdLcCA0TjQEQaiQfAdJWQrNBLxIFYBd5Twe+KPXLkQd5b9YNA==
X-Received: by 2002:a5d:64c3:0:b0:391:3028:c779 with SMTP id ffacd0b85a97d-39973b03ebemr3458343f8f.45.1742422750983;
        Wed, 19 Mar 2025 15:19:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e08dsm12623471b3a.102.2025.03.19.15.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 15:19:10 -0700 (PDT)
Message-ID: <57216433-0829-48bf-af23-d9959611974c@suse.com>
Date: Thu, 20 Mar 2025 08:49:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs-progs: allowing 2K block size for experimental
 builds
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740542229.git.wqu@suse.com>
 <20250319214912.GM32661@twin.jikos.cz>
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
In-Reply-To: <20250319214912.GM32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/20 08:19, David Sterba 写道:
> On Wed, Feb 26, 2025 at 02:29:13PM +1030, Qu Wenruo wrote:
>> Btrfs always has its minimal block size as 4K, but that means on the
>> most common architecture, x86_64, we can not utilize the subpage block
>> size routine at all.
>>
>> Although the future larger folios support will allow us to utilize
>> subpage routines, the support is still not yet there.
>>
>> On the other hand, lowering the block size for experimental/debug builds is
>> much easier, there is only one major bug (fixed by the first patch) in
>> btrfs-progs at least.
>>
>> Kernel sides enablement is not huge either, but it has dependency on
>> the subpage related backlog patches to pass most fstests, which is not small.
>>
>> However since we're not pushing this 2K block size for end users, we can
>> accept some limitations on the 2K block size support:
>>
>> - No 2K node size mkfs support
>>    This is mostly caused by how we create the initial temporaray fs.
>>    The initial temporaray fs contains at least 6 root items.
>>    But one root item is 439 bytes, we need a level 1 root tree for the
>>    initial temporaray fs.
>>
>>    But we do not support multi-level trees for the initial fs, thus no
>>    such support for now.
>>
>> - No mixed block groups mkfs support
>>    Caused by the missing 2K node size support
>>
>> Qu Wenruo (3):
>>    btrfs-progs: fix the incorrect buffer size for super block
>>    btrfs-progs: support 2k block size
>>    btrfs-progs: convert: check the sectorsize against BTRFS_MIN_BLOCKSIZE
> 
> Thanks, added to devel. I've enabled the 2k case for convert but it
> fails, I haven't analyzed it as it does not seem to be important right
> now.

2K convert needs the ext4 to use 2K block size too, which is only 
lightly tested here.

E.g. at least it works here:

./btrfs-convert ~/test.img
btrfs-convert from btrfs-progs v6.12

WARNING: blocksize 2048 is not equal to the page size 4096, converted 
filesystem won't mount on this system
Source filesystem:
   Type:           ext2
   Label:
   Blocksize:      2048
   UUID:           e004c54c-7a86-4c71-be87-a8ff707c3948
Target filesystem:
   Label:
   Blocksize:      2048
   Nodesize:       16384
   UUID:           b54b8947-7f7a-4e3b-a658-d344a1d47766
   Checksum:       crc32c
   Features:       extref, skinny-metadata, no-holes, free-space-tree 
(default)
     Data csum:    yes
     Inline data:  yes
     Copy xattr:   yes
Reported stats:
   Total space:      5368709120
   Free space:       4693164032 (87.42%)
   Inode count:          327680
   Free inodes:          327668
   Block count:         2621440
Create initial btrfs filesystem
Create ext2 image file
Create btrfs metadata
Copy inodes [o] [         0/        12]
Free space cache cleared
Conversion complete

But it should not be considered a feature for end users.

Thanks,
Qu


Return-Path: <linux-btrfs+bounces-15679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8786B125F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D767A2FD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34825BEE1;
	Fri, 25 Jul 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FtgW4g2d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E50246BA5
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477562; cv=none; b=ffkrK959ns/4AuxhF0ohV/PYgo3wRpGkJ3+C1IDClkI0SK4NjkviRPluZjeK/uLGVnLNNyi2ZcSVBtXVdpGBOwHsZp7UKyFAxwK4IY31qBSPw/Hr8zHI0l0h2fmDpc13/zyXppuWs8yCUhswBmlVi+TEYAmpBkDUELXMLW2en5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477562; c=relaxed/simple;
	bh=MAAN0/d2LrPW4Fdwy/P5ce6nA/sGtAS6+UtDUZlGmq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTi9Mx2pDHWErkJ9LNcfJWDH9SJvSz/gP9Ygn0fG8u60BXFnOv5YEFTbaMN46b7ITSqlWLIEXdkhAMUdCIJdlmQKufR+9EemvoPo6seiWaL7LJ2MQqORKOj7RKNYqePPCVxjddgVL7FocgLtoiBQHp6bUOvuPAX33h6jpB/oDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FtgW4g2d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a528243636so1656702f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753477558; x=1754082358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=shK4ZD78vrZj0Z/TzdwfzTcn+jf2AWVJfc39Es0MRtg=;
        b=FtgW4g2dYbLuRQ60yclTfFGxtoNFlYCaMuJ66Tmmu9ASVuBHR88qz7p4Ia+AsONwAw
         xSVARWlvasjUMqmOzMMZAckbarBk40nX1zVm3wGCSIRs9gdMRKdW6q5bzKA4XYCifmJb
         6JMVYhQceCgV2/0XAcc32qt1WvsXxWJ2XGyH91g9HkXT9VmxZ9THPijCGEiBmzq8OudZ
         Vtebno7wkHVTkUW+JOcqY0hDb6ltAnBZt0U2Y/mejgmlKUOkrL+qLqvNOtlfim35J9dw
         h4L288C2Aj8w6kXENelPaQGHxgvmL7B3CeS72ozKH4pK4TiyFU8FIM9LZL9TbOyVvTU/
         6egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753477558; x=1754082358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shK4ZD78vrZj0Z/TzdwfzTcn+jf2AWVJfc39Es0MRtg=;
        b=m+nNJU+xJjPZuyql5Sm+bCi4O7fdikO7Lw5L/ikRX9dKXF/O4tsob+u3zJGwnTrpvM
         rtPYhz68tMruT5YOXkiLmULRB3PseLPrGwPFGnsQESQtZOLMBuj1q0Ymuu6tCmw6Q+bF
         DMr9T7kg8hEvyAIUxoNDRLmCPYZvKhD+7vyhxR4hrTTG2vBO26gyZFrEXDB6XujZK6nd
         CT/ardXcw4cQ/jJZj+4p0lBu+lxWIEjR0QO2eTevViHTF8mZah2yJdlTm2yBoalrWyIJ
         0X4jcmyGArmAtY0rUeWjNvMpsfjIzoAZpp6ZZsVukfy/ff2x8es/G4OzIZV4NMuQ4UoC
         ysnQ==
X-Gm-Message-State: AOJu0YzPIcRc0d/5FmsDmxjXabqXfK68DMKj8EYn4uAXskRdzC8hl310
	L3Ha2BYi8jwhNsgcWu4paDFdnu2SXHl/R4t0s3TiRtDeqcQF/bkt2mLcAZrL8KoOOVs=
X-Gm-Gg: ASbGncvCT3zz/jF//AOBJDoN4lMN26kahdDUh+BLmh4NVcDed1uaVmRb1O4uJwvgnzZ
	PRODdAvTUf3l2kMsBRiDOseuI1QjiH+X31VIUjyIlGa20yyR8ynWC1BtxT4MGZVoZdWi6hmXiYg
	CC4qFKDr1qAkTgsOZE1r/fPhkXb2fLqDIaYL7GCCErr3Jc6zm6wlOAu/cU58D4k1Cf8Rjfe90Uv
	dihMxZBTBao4RJpflXQAEsZ9EA16YfLZE+R/CnZjDYX54MU9VlroFW+P55CkSV8NudQ7Ovmx+1e
	1wOKUobmCNsKYguMcfn+7lVbj2C7GzvXo9BUlyuwob8WlADRSqrkJuc3InBtkFbXdrBF3rqaLiZ
	GFaH35APOz3oV7Y6Ga2gJ1K/N1Etoi4lwe7Tp1djafBE1VTw28w==
X-Google-Smtp-Source: AGHT+IHHYzXS15kDJjLMn/MF6l4+WnX6HQ3NBJKhb9sywoOB+BC/AYdS+/xglI/OQAUeFGgNpLXopw==
X-Received: by 2002:a05:6000:40c8:b0:3a5:2848:2e78 with SMTP id ffacd0b85a97d-3b77664208amr3059889f8f.28.1753477558124;
        Fri, 25 Jul 2025 14:05:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8872568esm59895a91.34.2025.07.25.14.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:05:57 -0700 (PDT)
Message-ID: <a765c0a9-f223-4a10-8ddb-80bb0ebff42e@suse.com>
Date: Sat, 26 Jul 2025 06:35:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not allow relocation of partially dropped
 subvolumes
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <bbc7c6af95f7628d4d0a517358e7e9c2e421ccc5.1753441296.git.wqu@suse.com>
 <CAL3q7H5yk9PWo3JD-fLM5UZ=2E8CNrW6hJ+8OB4bFiYfKjBMVA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5yk9PWo3JD-fLM5UZ=2E8CNrW6hJ+8OB4bFiYfKjBMVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/25 20:39, Filipe Manana 写道:
> On Fri, Jul 25, 2025 at 12:05 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There is an internal report that balance triggered transaction abort,
>> with the following call trace:
>>
>>    item 85 key (594509824 169 0) itemoff 12599 itemsize 33
>>            extent refs 1 gen 197740 flags 2
>>            ref#0: tree block backref root 7
>>    item 86 key (594558976 169 0) itemoff 12566 itemsize 33
>>            extent refs 1 gen 197522 flags 2
>>            ref#0: tree block backref root 7
>>   ...
>>   BTRFS error (device loop0): extent item not found for insert, bytenr 594526208 num_bytes 16384 parent 449921024 root_objectid 934 owner 1 offset 0
>>   BTRFS error (device loop0): failed to run delayed ref for logical 594526208 num_bytes 16384 type 182 action 1 ref_mod 1: -117
>>   ------------[ cut here ]------------
>>   BTRFS: Transaction aborted (error -117)
>>   WARNING: CPU: 1 PID: 6963 at ../fs/btrfs/extent-tree.c:2168 btrfs_run_delayed_refs+0xfa/0x110 [btrfs]
>>
>> And btrfs check doesn't report anything wrong related to the extent
>> tree.
>>
>> [CAUSE]
>> The cause is a little complex, firstly the extent tree indeed doesn't
>> have the backref for 594526208.
>>
>> The extent tree only have the following two backrefs around that bytenr
>> on-disk:
>>
>>          item 65 key (594509824 METADATA_ITEM 0) itemoff 13880 itemsize 33
>>                  refs 1 gen 197740 flags TREE_BLOCK
>>                  tree block skinny level 0
>>                  (176 0x7) tree block backref root CSUM_TREE
>>          item 66 key (594558976 METADATA_ITEM 0) itemoff 13847 itemsize 33
>>                  refs 1 gen 197522 flags TREE_BLOCK
>>                  tree block skinny level 0
>>                  (176 0x7) tree block backref root CSUM_TREE
>>
>> But the such missing backref item is not an corruption on disk, as the
>> offending delayed ref belongs to subvolume 934, and that subvolume is
>> being dropped:
>>
>>          item 0 key (934 ROOT_ITEM 198229) itemoff 15844 itemsize 439
>>                  generation 198229 root_dirid 256 bytenr 10741039104 byte_limit 0 bytes_used 345571328
>>                  last_snapshot 198229 flags 0x1000000000001(RDONLY) refs 0
>>                  drop_progress key (206324 EXTENT_DATA 2711650304) drop_level 2
>>                  level 2 generation_v2 198229
>>
>> And that offending tree block 594526208 is inside the dropped range of
>> that subvolume.
>> That explains why there is no backref item for that bytenr and why btrfs
>> check is not reporting anything wrong.
>>
>> But this also shows another problem, as btrfs will do all the orphan
>> subvolume cleanup at a read-write mount.
>>
>> So half-dropped subvolume should not exist after an RW mount, and
>> balance itself is also exclusive to subvolume cleanup, meaning we
>> shouldn't hit a subvolume half-dropped during relocation.
>>
>> The root cause is, there is no orphan item for this subvolume.
>> In fact there are 5 subvolumes around 2021 that have the same problem.
>>
>> It looks like the original report has some older kernels running, and
>> caused those zombie subvolumes.
>>
>> Thankfully upstream commit 8d488a8c7ba2 ("btrfs: fix subvolume/snapshot
>> deletion not triggered on mount") has long fixed the bug.
>>
>> [ENHANCEMENT]
>> For repairing such old fs, btrfs-progs will be enhanced.
>>
>> Considering how delayed the problem will show up (at run delayed ref
>> time) and at that time we have to abort transaction already, it is too
>> late.
>>
>> Instead here we reject any half-dropped subvolume for reloc tree at the
>> earliest time, preventing confusion and extra time wasted on debugging
>> similar bugs.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Update the subject to reflect the change better
>> - Fix a memory leak when the check is triggered
>> - Make the error message less confusing
>>    All thanks to Filipe.
>> ---
>>   fs/btrfs/relocation.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 60dd3971c3ae..c33c591b23f2 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -602,6 +602,25 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
>>          if (btrfs_root_id(root) == objectid) {
>>                  u64 commit_root_gen;
>>
>> +               /*
>> +                * Relocation will wait for cleaner thread, and any half-dropped
>> +                * subvolume will be fully cleaned up at mount time.
>> +                * So here we shouldn't hit a subvolume with non-zero drop_progress.
>> +                *
>> +                * If this isn't the case, error out since it can make us attempt to
>> +                * drop references for extents that were already dropped before.
>> +                */
>> +               if (unlikely(btrfs_disk_key_objectid(&root->root_item.drop_progress))) {
>> +                       struct btrfs_key cpu_key;
>> +
>> +                       btrfs_disk_key_to_cpu(&cpu_key, &root->root_item.drop_progress);
>> +                       btrfs_err(fs_info,
>> +       "can not relocate partially dropped subvolume %llu, drop progress key (%llu %u %llu)",
>> +                                 objectid, cpu_key.objectid, cpu_key.type, cpu_key.offset);
>> +                       ret = -EUCLEAN;
>> +                       goto fail;
>> +               }
> 
> Sorry I forgot to point this out before, but why isn't this placed
> outside the if statement?
> I.e., before the "if (btrfs_root_id(root) == objectid)"

For the root_id != objectid case, it's btrfs_reloc_post_snapshot() for a 
reloc tree.

In that case won't the reloc tree being merged thus got a non-zero drop 
progress and trigger a false alert here?

Thanks,
Qu

> and even
> before allocating the root_item?
> 
> I don't see a reason why not.

> 
> Thanks.
> 
>> +
>>                  /* called by btrfs_init_reloc_root */
>>                  ret = btrfs_copy_root(trans, root, root->commit_root, &eb,
>>                                        BTRFS_TREE_RELOC_OBJECTID);
>> --
>> 2.50.1
>>
>>



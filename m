Return-Path: <linux-btrfs+bounces-17876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C4BE2118
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB2F14ED4FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D09284B2E;
	Thu, 16 Oct 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U4V0FwOj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC72D4B5F
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601635; cv=none; b=aH/GchddqBZyQQTaaIqeghy1EMNdUE3bjedcCJjaj8of2YzAxCuVPUAq7+JxYkdLsn5A+Vv+rOZaOs0RQlpPOnl7VftjbKcDfRjqV76DF/jKCuhKcrY5x5oaLIF76qRAtqGv5dvi1o7kO4r186mS5LSW+kQoJ7ZNi48DgH8Z7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601635; c=relaxed/simple;
	bh=BeCHLzxRRYxw4ZwcUMAuz/xstDGGrVEyfzhffINtlyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/eQiMCWGoVNez5+c6OiVcrTTcJ4P/B1MhV8ouzXkWSxs8RXqXzZHPQXIMuKKSkbnRdQCp/VkVA32NQ3KpkotjaE3JFsFqjb71DCjOw2uiA0Ki1kDEjAuA6rQdw6V4On92n1k0fA92B9n4O464LsD6bgWcyrHDNzWkFNqMs4jgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U4V0FwOj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso356779f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760601632; x=1761206432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+yk9MzXBPZOigsS6mC9hazugTQH8CmIQ1FXFMx0VHmo=;
        b=U4V0FwOjoqCIjNhN3UNXzfpi8w/bxmGiLwotvq3RBNU7mPU+jHDSVE394fqafhaMAR
         YkZGnhfJJpNDYFoXz+7jcTn/TksKr0ZNO+XyF4w9G+GWK8bFQGr61+vAnI5VCW63GguX
         rEiqoTWN5WkJsWC8+xYl51g1OaNljwKUk0yuRvDafV+wRA1bJ8RBnP6Up4ulu2dpzyO+
         yWyCvsTSpr3x8u3BKbBHYj5tCkhIKIPsRoc8+GDLx3tShtr178ckpaTt6Jb0JpHZLW1f
         o+pNW7AFUu5nPZqsHufRzT7558Aooroi24N0JaC0NeCVdTV2Iidbwqp+CysDAX3D6NAn
         JgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601632; x=1761206432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yk9MzXBPZOigsS6mC9hazugTQH8CmIQ1FXFMx0VHmo=;
        b=J9Ut61nnfVOLd7i3RIGpSN2GKMWHzN9TkybyNE1b3r0ytjuE7f7haGPbiAuBHB4LMW
         d9XOmMuyvQ/RD20gyjwE2YgLTjPqdahoTZiroOqEKrKcjpqX18nGhhYYpLwiqlxuccZg
         zMeuCRoT+lJXZ8qN0qUBDAPeh4NKHxol+iboDwG3lLJrDQoaWqfmOKsfM31CIbWudV/e
         X8vk0yafrsztl19Nn0LRGRWsxqMrHbtK2HgbDg6dC3mWkv/y1pBKAqKrar3ukuuE0aKh
         WNo1p/PPFO1aDa3Bz12oNBmCVyt8az2ppJbEBitt7Eu91r+QvJY8OpVzNqJq37JzBeGx
         Y3jA==
X-Gm-Message-State: AOJu0YyQFCjvUPjjjp8EaSa3AFk5vz6CJODKhEHjhaZ5uTg6fs3YP3Jv
	YW0gLJjRojo/6HrO4CtdE7ayZ3GLw6iS1wt9WCzYAqTDsEZ4ykuhkNZxc4EYGnaeOuQ=
X-Gm-Gg: ASbGncvm+yEF0nvYabuzp4fBjR3ruNkmjsvM1/N27addF4xoPm6BxsheYwFFcTjpnFG
	2YUAEP9fI6g+SEp0wmynn3uSWfzjrEEzLb4dDJxWb8VqpkXhBpuGRSvgC/5qCEkO8PLT3vuQTP7
	ofC3UYui3kdWO4mpYi6r7MM4VbXdsmQ/oAns/VCbDGn3+TXVjt8vleIFGXj/QTfc4hY8oJcwX1p
	5d1f/8YBxOkhAolCzdaE3Qj+fuXoysVGjn6xH8fNu93BC09ZbazU5xfI/KyexXan4Kkh1keE070
	K5PW/R8x31CUwbbK4vP/wsDVs3uwtltFQ4CyMe+cpSGnZgEkA4axPGSip6Bd7jQNzGlYoBWGyXK
	Pp3BAUnhLAN0bGblwLOJyQxzD9Ke51Et2OH1VX9WMZo1/zCpROzNxOHSEdJAeXzcDJi1blvvW8i
	eoVDRiqD9LJnS7Hi6arI+CV2NIfJZD5+AVwutHPgg=
X-Google-Smtp-Source: AGHT+IHv75yXM4Ud4X5WsAqNpTIGwI7bUoVJU7i68RyrnibaeR76vKqTt+glrLlTUHC2yo2nTs132g==
X-Received: by 2002:a05:6000:1887:b0:3ec:e226:c580 with SMTP id ffacd0b85a97d-4267b339754mr21575415f8f.60.1760601631510;
        Thu, 16 Oct 2025 01:00:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b7bbc7sm1933261a12.22.2025.10.16.01.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:00:30 -0700 (PDT)
Message-ID: <82dd77e3-67c9-4ca6-a1ed-728e9925fd4b@suse.com>
Date: Thu, 16 Oct 2025 18:30:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1760588662.git.wqu@suse.com>
 <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
 <CAL3q7H7q9=Fk=2EjC44dB8HnnsUv7EBZPLt=kot7quWD8=Jvaw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7q9=Fk=2EjC44dB8HnnsUv7EBZPLt=kot7quWD8=Jvaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/16 18:21, Filipe Manana 写道:
> On Thu, Oct 16, 2025 at 5:33 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> It's a known bug that btrfs scrub/dev-replace can prevent the system
>> from suspending.
>>
>> There are at least two factors involved:
>>
>> - Holding super_block::s_writers for the whole scrub/dev-replace
>>    duration
>>    We hold that mutex through mnt_want_write_file() for the whole
> 
> It's not a mutex, it's a percpu rw semaphore.
> 
>>    scrub/dev-replace duration.
>>
>>    That will prevent the fs being frozen.
>>    It's tunable for the kernel to suspend all fses before suspending, if
>>    that's the case, a running scrub will refuse to be frozen and prevent
>>    suspension.
>>
>> - Stuck in kernel space for a long time
>>    During suspension all user processes (and some kernel threads) will
>>    be frozen.
>>    But if a user space progress has fallen into kernel (scrub ioctl) and
>>    do not return for a long time, it will make suspension time out.
>>
>>    Unfortunately scrub/dev-replace is a long running ioctl, and it will
>>    prevent the btrfs process from returning to user space.
>>
>> Address them in one go:
>>
>> - Introduce a new helper should_cancel_scrub()
>>    Which checks both fs and process freezing.
>>
>> - Cancel the run if should_cancel_scrub() is true
>>    The check is done at scrub_simple_mirror() and
>>    scrub_raid56_parity_stripe().
>>
>>    Unfortunately canceling is the only feasible solution here, pausing is
>>    not possible as we will still stay in the kernel state thus will still
>>    prevent the process from being frozen.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index facbaf3cc231..728d4e666054 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -2069,6 +2069,20 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
>>          return 0;
>>   }
>>
>> +static bool should_cancel_scrub(struct btrfs_fs_info *fs_info)
>> +{
>> +       /*
>> +        * For fs and process freezing case, it can be preparation
>> +        * for a incoming pm suspension.
>> +        * In that case we have to return to the user space, thus
>> +        * canceling is the only feasible solution.
>> +        */
>> +       if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
>> +           freezing(current))
> 
> Why the check for sb->s_writers.frozen > SB_UNFROZEN?
> I don't see why freezing() is not enough and would prefer to not
> access such low level details of the vfs directly.

It's possible to configure suspension to freeze fses first, before 
freezing processes.
Although not yet the default behavior, it's going to be the new default.

So we have to check both fs and process freezing.

> 
>> +               return true;
>> +       return false;
>> +}
>> +
>>   static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>>                                        struct btrfs_device *scrub_dev,
>>                                        struct btrfs_block_group *bg,
>> @@ -2093,7 +2107,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>>
>>          /* Canceled? */
>>          if (atomic_read(&fs_info->scrub_cancel_req) ||
>> -           atomic_read(&sctx->cancel_req))
>> +           atomic_read(&sctx->cancel_req) ||
>> +           should_cancel_scrub(fs_info))
> 
> If we now have a should_cancel_scrub(), the checks for the cancel
> atomics should be moved there, otherwise it's confusing why some
> cancel checks are in the helper and others are not.

That sounds good.

Thanks,
Qu
> 
>>                  return -ECANCELED;
>>
>>          /* Paused? */
>> @@ -2281,7 +2296,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>>
>>                  /* Canceled? */
>>                  if (atomic_read(&fs_info->scrub_cancel_req) ||
>> -                   atomic_read(&sctx->cancel_req)) {
>> +                   atomic_read(&sctx->cancel_req) ||
>> +                   should_cancel_scrub(fs_info)) {
> 
> And it would avoid duplicating the atomic checks by having them in the
> new helper.
> 
> Thanks.
>>                          ret = -ECANCELED;
>>                          break;
>>                  }
>> --
>> 2.51.0
>>
>>



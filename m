Return-Path: <linux-btrfs+bounces-12698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E321A77003
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 23:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D45B7A3A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B49421B9D9;
	Mon, 31 Mar 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/1tk59n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235814601C
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455974; cv=none; b=h3vq1SdOIdx6d+HNXNirgw3Oh/G30bVKBGqx7kUwKccTzlBp7laOVs+5wIYVIQjNfaOxnu+zCtPOCuXjdEYkDWqc6x+NnQFWIg8qSflpG+AyrgqFG0dCZaq3D8tjXJBs9YNkPm5bHstacVohW1VW4WlLpLDjM0FJGgxwiGwBBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455974; c=relaxed/simple;
	bh=uCzPfHV945w5wgKvM2alz4yzy0Rd6SV/lzgFMg8mXAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAbNyzjcmOSe+YT+paLJId6pZulEkbnjestWS67DGeUnhAzmHtcqgWJv5Q9bgVrfbaRpO/DEI46C+mIi+a2Pu/DPqTiEjkwvEv52Z7cgLjJA6Mc7Lc8v2kX3ztU03gPF7k5eM6Qz3UP4LUDEgDgeZAUco289Ddw/4ibBlQYWrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/1tk59n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so4141548f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743455970; x=1744060770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wLzzTOktZ7+jQHgERa7L/99ZsiAhnsVHc4kNDhJ4m0M=;
        b=e/1tk59n4rY+qVbZevAKi0h5XAiY1hDyHwlYz6CKNGIf2zByopbs/5aqva4AFolhZX
         N0rs8FLGazAMp06RE2Cw3SnShTAyAGwgl+amXCNzbsbfFegyy4N6EDeqmIQkJISeyN/C
         86kLgcAWu9L7Twzz21XCgbMdrWISpkxgcoF9ViVXlvXEtUJGdgUfRqNW6PCVzUwt+1Sb
         Bu1Nl5nUUgIdWa5f1xx509TgwOoveqLbj3Qm7ADP7yHNIAGFnWf9cidDCjBYSlurzHOn
         65Q92xqTBoUpr9rKFxeHxMW6U0ZU9A0Dvg291AaDaxjvlmCq6pg0SP3GoRBoCs/RId4M
         wNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743455970; x=1744060770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLzzTOktZ7+jQHgERa7L/99ZsiAhnsVHc4kNDhJ4m0M=;
        b=dy1xoe87qxqXSa2CQL/RoUex1pdlbDXQ3TrGZItctXjtgHRzYc8QcLBgfajcFnelJt
         Lec1+1JbyukbHZyAuIP93tXcK1vmAJTcOhQnse9vmBGcfO/dAoRn/m7Oe4PFWMQnJ144
         jL29ne1GNYLRnjv+CcJ5NVfHNtnUV0s/InHzBNjtr8+zIoJgHG1wgldanwGyctM8thdn
         VhwjjEqwBTc30syiNT+63WUxRoDTQLPOo+6Z5IK6VB+6cm/VZNNJLbhMiBj1E2JLyWVE
         sMi3+exbpzX3UePvsG3ZeHLEYKUGo6g2oE9DUbXUvYmq9vsYkhjzB43Q98GaoZBfEmRy
         rJsQ==
X-Gm-Message-State: AOJu0YypNiwyQJQKHWNbievOdu7l13/jRMuiHVCzbe4UWtZWZzGLFidH
	0Pzg/NmAixOUCXMj3Mj9Tf3qSRZoYvPTjkdj95OzhWwzzzEeR1/YOgpHjclxL6U=
X-Gm-Gg: ASbGnct95nGyXxUCmNuLgqHYmF6Kt6KFRLFDqWRruDXYUirx5ECGFduamaPA92TzJkT
	YeqpYLaTtlx6e/OIy0urf6ezWIQviaGL6TQXokdZVLgXu1E9JqGC72dBzbZfz5gqmWyNQE3JMcU
	UGooSQymquuVy6KU8Q6YpwaEsNBuQenTMwwcnHCWv4b3pXwFhUTDxDpdJqaa/JCNa6Si/8pIRtR
	kmz27bVd2O4z5jYToOs1eZUDiw4WoMjYs8/zpUzeX7s/qfKsj02FwQTZB/+wa748zch2tUAuYBQ
	IFwwcp3i0wIB8UiUoSU+f6PJaw+2RuzILHqn3XmYYpHZToIyLdln9OX6s5LdRE0xZxCa5OdJ
X-Google-Smtp-Source: AGHT+IGpVYft464rU5mqHAk7j9sjZW61n7EXYRCGX2pA2JuoJW9l8qxVO9lQSN1MvSpdYN7gQPkuCw==
X-Received: by 2002:a05:6000:2c6:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-39c12114dfbmr8439723f8f.43.1743455970184;
        Mon, 31 Mar 2025 14:19:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df006sm73925215ad.166.2025.03.31.14.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 14:19:28 -0700 (PDT)
Message-ID: <92f90d65-3b9e-4078-8ee6-2b6a71d50aa0@suse.com>
Date: Tue, 1 Apr 2025 07:49:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] btrfs: prepare btrfs_punch_hole_lock_range() for
 large data folios
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743239672.git.wqu@suse.com>
 <86cc5b6bd21e489ea6838b01bb0948c0a19b2cb5.1743239672.git.wqu@suse.com>
 <CAL3q7H5oaA67Ube5jekmstXh=80RY3UMWs9gkbA8BwK6-bWN_Q@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5oaA67Ube5jekmstXh=80RY3UMWs9gkbA8BwK6-bWN_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/31 22:20, Filipe Manana 写道:
> On Sat, Mar 29, 2025 at 9:20 AM Qu Wenruo <wqu@suse.com> wrote:
[...]
>> +       found_folios = filemap_get_folios(inode->i_mapping, &tmp, end_index,
>> +                                         &fbatch);
>> +       for (int i = 0; i < found_folios; i++) {
>> +               struct folio *folio = fbatch.folios[i];
>> +
>> +               /* A large folio begins before the start. Not a target. */
>> +               if (folio->index < start_index)
>> +                       continue;
> 
> We passed start_index (via tmp) to filemap_get_folios(). Isn't the
> function supposed to return folios only at an index >= start_index?
> It's what the documentation says and the implementation seems to
> behave that way too.

Not exactly, comments of filemap_get_folios_tag() shows exactly this:

  * The first folio may start before @start; if it does, it will contain
  * @start.  The final folio may extend beyond @end; if it does, it will
  * contain @end.

This is exactly what we need to support large folios.

> 
> Removing that we could also use start_index to pass to
> filemap_get_folios(), making it non-const, and remove the tmp
> variable.

The reason I use @tmp is, filemap_get_folios() can update the @tmp to 
the next folio's start index, which makes us unable to use the original 
start_index to compare.

Thanks,
Qu

> 
> Either way it looks good and that's a minor thing:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>> +               /* A large folio extends beyond the end. Not a target. */
>> +               if (folio->index + folio_nr_pages(folio) > end_index)
>> +                       continue;
>> +               /* A folio doesn't cover the head/tail index. Found a target. */
>> +               ret = true;
>> +               break;
>> +       }
>> +       folio_batch_release(&fbatch);
>> +       return ret;
>> +}
>> +
>> +static void btrfs_punch_hole_lock_range(struct inode *inode,
>> +                                       const u64 lockstart,
>> +                                       const u64 lockend,
>> +                                       struct extent_state **cached_state)
>> +{
>>          while (1) {
>>                  truncate_pagecache_range(inode, lockstart, lockend);
>>
>>                  lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
>>                              cached_state);
>> -               /* The same page or adjacent pages. */
>> -               if (page_lockend <= page_lockstart)
>> -                       break;
>>                  /*
>>                   * We can't have ordered extents in the range, nor dirty/writeback
>>                   * pages, because we have locked the inode's VFS lock in exclusive
>> @@ -2195,8 +2243,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
>>                   * locking the range check if we have pages in the range, and if
>>                   * we do, unlock the range and retry.
>>                   */
>> -               if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
>> -                                           page_lockend - 1))
>> +               if (!check_range_has_page(inode, lockstart, lockend))
>>                          break;
>>
>>                  unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
>> --
>> 2.49.0
>>
>>\


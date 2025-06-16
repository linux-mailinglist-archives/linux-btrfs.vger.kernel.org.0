Return-Path: <linux-btrfs+bounces-14694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED59ADBDC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 01:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126B03A3D75
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6222F14D;
	Mon, 16 Jun 2025 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Za/e8+UV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734E2163B2
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117008; cv=none; b=RM6/cBKUh8EUo2uJ/GsYNyyAVK3StAfqXldz2k6zAPCwIUW6ZL6Mk41wjm9njrpw32dkNRXnQaL+zGVjcpP9R9mEwbqHkKLs7N/odYCOgUcz9rpqxUMTH7QCmy1fFDAUb8k5ZuuQ0DWyeeMc2KNszv2gZPAT6BenqpVweYTTULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117008; c=relaxed/simple;
	bh=qGiPlJ0FX14GxzFkuIvryJaNqI+pxEPl8AnGML/O7SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLgpL/u2qp1CXprB7TEmUV4kMebxxtyPLRtDGBbP13akJt6X0sMs2OfSCKcncEtm7/JvfQyY0LrVfQaAAkna08S7IWY3iO/3hXGYPby6HrZBv5hgt5kPk7Iy7Rx6cBH5P/1UVyRJlBV/xOa2DEPxDsktKSlnNUS13wneQ6+gcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Za/e8+UV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4533bf4d817so14901175e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750117003; x=1750721803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VdMOSQ7+rYSv4pl1ZvpppkmNXp5y/+B098uCzMh0aQ8=;
        b=Za/e8+UVYx05H9SA5zW66ihbdw9ytR7ImknEvWZeqwJf0AT6cW+tcOARWaTN+bgzgE
         fgnUrtkmokuTASg6ASLI3bdBlJs+KW9hPYKJU/7Uszs/IPIOdBLvf2HytRXpKmaPDAXz
         eJvK46UJFAzyB+aGLK55Rs0pE2J12npDKx9R6kMug0RulhVJQRA9+SB7xIJmuXcjyXm6
         FhygJ1owHChXeXid2A7pY12+kL9+R9mvJdUywtg3r8fgyO6v31b25POpSugZoWoa4ki0
         B23OR7WlVR7R6qAi+RGl15+IQ5usfKqJqkr9Mu9yDiVkoROxWVtNFP/k/FcFLmrEGNnU
         ASKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750117003; x=1750721803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdMOSQ7+rYSv4pl1ZvpppkmNXp5y/+B098uCzMh0aQ8=;
        b=fMrVnVld1cmTkHCex2JKePL0bpMG9fc2Z0lR8akPjw/xrk+/nsFEwhdUWCxKircwuC
         4Hde5s8QmnAbg94k+9j8H2kUjPPyoUnxEaAfKbozYyHhcZ33MUHDV1GowHk6QiMAflow
         6YhEzMh7fIsoglcN3jxtX27fJeCzgFmCDf39+7rGKejRb+rpOyYkddKkYx7HO8xEOjVF
         ig9cLLh+YWA+KZpe/yUs+pVmo+lWKC1JaNrICG7cEMwLA/qMcY1hLZZTTUDKQ5CknFCZ
         xgSXBLrRHSqdnpdFj4g6ugFNlLBIMeWn0PXuPW219dM8xGdSpFpxhN1LOZX++tVPrxGe
         PUjA==
X-Gm-Message-State: AOJu0YwcT0qkDQoxEEtSBmW3Tdb2ZLS3NPyYzNWvrY3C+QVtz64tCXKx
	pCgB1qk0pbW9O83gTYH7PUsWv+z6U706vnDXjBUZ47JJlYbg2pUKEi8tB+vZkNi0Wrs=
X-Gm-Gg: ASbGncsod1nmovwHn6sy8vLvVE46eYkVomotaIjQWTyuNVaCauuTBOeVoOC7R/BEaHu
	JQmV7QcEkGKAw5x9Fq0vxE2ilZXT6nZsrQuKm2BKfmMn7hf0NbUH3uioUabCSIRtJkLLzQLdDHL
	48pPS0lJuYU33y5nrp+N7Oc97T8L7Rbe4u6fIDsnpU+7fo2TmFwUH9MyNaHj5UkQBQSVvdc1jfD
	r6Zk0sf4AjCc0fAoCcv7DlafPG2yG6WoRCSs+AXGo2+C5FbuwbCENVMxvHYmgyOEnwPA2BT9ucC
	yv6TJhHCrPG0zJd9DA/FGwGY3W3ozSZ6su7KDm89ysoD5YT9xFuvD8Ojxf2k5DSlo1HIHwzca6H
	4zRPDlWoYjAL2E1knfW9YYsvv
X-Google-Smtp-Source: AGHT+IGkd1rEiMA+8E4Bj3TAojI1hanfLl8nLyIvwOa/dujmyn4Cw8DUfohGjRY5bQJOc4tLapz1VA==
X-Received: by 2002:a05:6000:144f:b0:3a5:2599:4163 with SMTP id ffacd0b85a97d-3a572e8e56cmr8793253f8f.47.1750117003031;
        Mon, 16 Jun 2025 16:36:43 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890006f96sm7733579b3a.65.2025.06.16.16.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 16:36:42 -0700 (PDT)
Message-ID: <10d53ef3-eaa2-47ea-9895-6677f5c555ee@suse.com>
Date: Tue, 17 Jun 2025 09:06:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use readahead_expand on compressed extents
To: Filipe Manana <fdmanana@kernel.org>, Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <24414ba3107560a48f2e6a70e102de63b6bca4ca.1750112614.git.boris@bur.io>
 <CAL3q7H6t2qrKQ7qudfUp68=LLOHHy5QqTz8C1FLWcu2v2FX-Dw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6t2qrKQ7qudfUp68=LLOHHy5QqTz8C1FLWcu2v2FX-Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/17 08:23, Filipe Manana 写道:
> On Mon, Jun 16, 2025 at 11:22 PM Boris Burkov <boris@bur.io> wrote:
>>
>> We recently received a report of poor performance doing sequential
>> buffered reads of a file with compressed extents. With bs=128k, a naive
>> sequential dd ran as fast on a compressed file as on an uncompressed
>> (1.2GB/s on my reproducing system) while with bs<32k, this performance
>> tanked down to ~300MB/s.
>>
>> i.e.,
>> slow:
>> dd if=some-compressed-file of=/dev/null bs=4k count=X
>> vs
>> fast:
>> dd if=some-compressed-file of=/dev/null bs=128k count=Y
>>
>> The cause of this slowness is overhead to do with looking up extent_maps
>> to enable readahead pre-caching on compressed extents
>> (add_ra_bio_pages()), as well as some overhead in the generic VFS
>> readahead code we hit more in the slow case. Notably, the main
>> difference between the two read sizes is that in the large sized request
>> case, we call btrfs_readahead() relatively rarely while in the smaller
>> request we call it for every compressed extent. So the fast case stays
>> in the btrfs readahead loop:
>>
>> while ((folio = readahead_folio(rac)) != NULL)
>>          btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
>>
>> where the slower one breaks out of that loop every time. This results in
>> calling add_ra_bio_pages a lot, doing lots of extent_map lookups,
>> extent_map locking, etc.
>>
>> This happens because although add_ra_bio_pages() does add the
>> appropriate un-compressed file pages to the cache, it does not
>> communicate back to the ractl in any way. To solve this, we should be
>> using readahead_expand() to signal to readahead to expand the readahead
>> window.
>>
>> This change passes the readahead_control into the btrfs_bio_ctrl and in
>> the case of compressed reads sets the expansion to the size of the
>> extent_map we already looked up anyway. It skips the subpage case as
>> that one already doesn't do add_ra_bio_pages().
> 
> Maybe add a comment in the code about why the subpage case is skipped?
> And can't this be done for non-compressed extents too, why do we have
> to skip them?

The subpage skip is introduced by commit ca62e85ded2c ("btrfs: disable 
compressed readahead for subpage").

This is definitely something I need to take a look again.

Thanks,
Qu



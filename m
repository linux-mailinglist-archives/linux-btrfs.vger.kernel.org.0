Return-Path: <linux-btrfs+bounces-8923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C299DB46
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 03:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831E61C21286
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 01:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9314B959;
	Tue, 15 Oct 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NRkKluVq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D30184F
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955607; cv=none; b=ZUDe3S71eRydfBXIjasUKvyNobc+sxcKxiYri8Za7DOB5y4/+tgMR4lymyQstHHLdRMmD0qYgVdHfuKjfbXO0OLqK4LqpirA7ftAnlX1XfNNGb4n9yqj16gGflMMmCKmwXc55FTAEV3RosPswvgFq4RJ/oAWEJeNSyat5JQNjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955607; c=relaxed/simple;
	bh=oWWc48IEepZcz4U74eQ/gE/p06rqMG9MXfj7xo8d81U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzOoSvt8ax1oFOdCoA86rILfGc1N1SlmrK0Y/VOCUQDTFZbDpgbK0r9UwR10YlSp1+1t0Af2RsokdB9FYgdb0T+nibeo3/3nWS5+Li5mivxd9+csVzM9pZNXmID3Q0tMXJLq21YxNd64Ps/7nAaH4jIOxcAxef7ulOS+dhZjM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NRkKluVq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb443746b8so13666261fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728955602; x=1729560402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhdLtvCHRpRCgGmVfpOpPi8dywyXU/wFQD/Fn20fU2k=;
        b=NRkKluVqbVDxeAJqhtwNSqUb3ZRHwbZRdA7U6RnkLdFj7+lQO+2vYYx4c3rknOX5Ds
         B1NWSe7qS51Mzg2k+5cFv+t9QvuC9w0i59mzobOivx3typnO8+iEooiw0nq5k9W5cJM0
         gw/zqU3yYwEnLxv6mP68E5UgVLBIC/RI3zplzEmEBCPY/iBJAWSc/kDux4LCu5r/TjyL
         lwyShE+6GGkzn+ZWcOspwJ1nPGcewCUIlammiMwjaFgbSPRHCPGTqTSHb1zgcdm0rSU6
         V5mbSyzrh53qr4bIpt3H7160SOVI3Tr2yIb6aT4ZHj7AVyG02ZFZD7ru6TmgnVx6sEjP
         v+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728955602; x=1729560402;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhdLtvCHRpRCgGmVfpOpPi8dywyXU/wFQD/Fn20fU2k=;
        b=OmwxlL0Gh1CZE/HQe2XZGcQsGyxy7UUOFfxbcTquY4ySX5JrZEFjJrXKAQYm3MCS2X
         V4slVCQW28nU0e/Nrg1jAxfWo3y3Nrfs+dWgqJz1z/O/ALe0No7f4atgNfWhtqRSa2X2
         OGZBr7mA2gYZCm1/xTE9s8b4efRC/0lOoLNehjZ+GFmjvzE7LTDWPHWSaE9dCAqyLnE6
         6lAnSfI/w6GmtBBe5GEQIhujUcwZjQKca85BTzeAKHhDHvMDEAudkQUEOaPUXPtXXXBT
         HijkLoqeT5NjEptXh03Tr+GfOrHtvTGGH9wU/Fm58sdGADIF5ByyuahvLfZcn6LJGJKo
         5b8g==
X-Gm-Message-State: AOJu0Yw8p9YPoid3Y6WaZbVFKu97zGtPf0HBE+JNiWa1IQpSZdQzeeb+
	ZHESL1xSNBtk/WavhpWgxIrDSzHgvpmAHzf/mtOzWqwwnKUbb5EFhYcB2tUsFVs=
X-Google-Smtp-Source: AGHT+IG5vV+MZ8NusdcQq4Yj+z7X8Cmm+Q6ZXaNQ+nr8uH7ip62UyiKBoDhwkZcVn6GS8D+Tuwlbtg==
X-Received: by 2002:a2e:e19:0:b0:2f5:2e2:eadf with SMTP id 38308e7fff4ca-2fb3270ab14mr48452021fa.10.1728955601224;
        Mon, 14 Oct 2024 18:26:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773a2fc7sm192132b3a.54.2024.10.14.18.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 18:26:40 -0700 (PDT)
Message-ID: <3c6ce709-472a-4fbc-ad54-b7257c18c62d@suse.com>
Date: Tue, 15 Oct 2024 11:56:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
 <20241014141622.GB1609@twin.jikos.cz>
 <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
 <20241015003148.GG1609@suse.cz>
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
In-Reply-To: <20241015003148.GG1609@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/15 11:01, David Sterba 写道:
> On Tue, Oct 15, 2024 at 07:25:20AM +1030, Qu Wenruo wrote:
>> 在 2024/10/15 00:46, David Sterba 写道:
>>> On Mon, Oct 14, 2024 at 03:06:31PM +1030, Qu Wenruo wrote:
>>>> __filemap_get_folio() provides the flag FGP_STABLE to wait for
>>>> writeback.
>>>>
>>>> There are two call sites doing __filemap_get_folio() then
>>>> folio_wait_writeback():
>>>>
>>>> - btrfs_truncate_block()
>>>> - defrag_prepare_one_folio()
>>>>
>>>> We can directly utilize that flag instead of manually calling
>>>> folio_wait_writeback().
>>>
>>> We can do that but I'm missing a justification for that. The explicit
>>> writeback calls are done at a different points than what FGP_STABLE
>>> does. So what's the difference?
>>>
>>
>> TL;DR, it's not safe to read folio before waiting for writeback in theory.
>>
>> There is a possible race, mostly related to my previous attempt of
>> subpage partial uptodate support:
>>
>>                Thread A          |           Thread B
>> -------------------------------+-----------------------------
>> extent_writepage_io()          |
>> |- submit_one_sector()         |
>>     |- folio_set_writeback()     |
>>        The folio is partial dirty|
>>        and uninvolved sectors are|
>>        not uptodate              |
>>                                  | btrfs_truncate_block()
>>                                  | |- btrfs_do_readpage()
>>                                  |   |- submit_one_folio
>>                                  |      This will read all sectors
>>                                  |      from disk, but that writeback
>>                                  |      sector is not yet finished
>>
>> In this case, we can read out garbage from disk, since the write is not
>> yet finished.
>>
>> This is not yet possible, because we always read out the whole page so
>> in that case thread B won't trigger a read.
>>
>> But this already shows the way we wait for writeback is not safe.
>> And that's why no other filesystems manually wait for writeback after
>> reading the folio.
>>
>> Thus I think doing FGP_STABLE is way more safer, and that's why all
>> other fses are doing this way instead.
> 
> I'm not disputing we need it and I may be missing something, what I
> noticed in the patch is maybe a generic pattern, structure read at some
> time and then synced/written, but there could be some change in
> bettween.  One example is one you show (theoretically or not).
> 
> The writeback is a kind of synchronization point, but also in parallel
> with the data/metadata in page cache. If the state, regarding writeback,
> is not safe and we can either get old data or could get partially synced
> data (ie. ok in page cache but not regarding writeback) it is a
> problematic pattern.

The writeback is a sync point, but it's more like an optimization to 
reduce page lock contention.

E.g. when a page contains several blocks, and some blocks are dirty and 
being written back, but also some sectors needs to be read.
If implemented properly, the not uptodate blocks can be properly read 
meanwhile without waiting for the writeback to finish.

But from the safety point of view, I strongly prefer to wait for the 
folio writeback in such case.

Especially considering all the existing get folio + read + wait for 
writeback is from the time where we only consider sectorsize == page size.

We have enabled sectorsize < page size since 5.15, and we should have 
dropped the wrong assumption for years.

> 
> You found two cases, truncate and defrag. Both are different I think,
> truncate comes from normal MM operations, while defrag is triggered by
> an ioctl (still trying to be in sync with MM).
> 
> I'm not sure we can copy what other filesystems do, even if it's just on
> the basic principle of COW vs update in place + journaling.

I do not think COW is making any difference. All the COW handling is at 
delalloc time, meanwhile the folio get/lock/read/wait sequence is more 
common for page dirtying (regular buffered write, defrag, truncate are 
all in a similar situation).

Page cache is here just to provide file content cache, it doesn't care 
about if it's COW or NOT.

Furthermore, COW is no longer our exclusive feature, XFS has supported 
it for quite some time, and there is no special handling just for the 
page cache.
(Meanwhile XFS and ext4 has much better blocksize < page size handling 
than us for years)


And I have already explained in that case, waiting for the writeback at 
folio get time is much safer (although reduces concurrency).

Just for the data safety, I believe you need to provide a much stronger 
argument than COW vs overwrite (which is completely unrelated).

> We copy the
> and do the next update and don't have to care about previous state, so
> even a split between read and writeback does no harm.

Although I love the csum/datacow, I do not see any strong reason not to 
follow the more common (and IMHO safer) way to wait for the writeback.

I have explained the possible race, and I do not think I need to repeat 
that example again.

If you didn't fully understand why my example, please let me know where 
it's unclear that I can explain it better.

Thanks,
Qu


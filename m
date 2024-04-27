Return-Path: <linux-btrfs+bounces-4563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF858B4300
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 02:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EBC1F266B4
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 00:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C8A945;
	Sat, 27 Apr 2024 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gz+eV4Qj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F088F59
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Apr 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176281; cv=none; b=XVqN975OGa3VsPKIKlfkArBIpUJ7c74hXdiiQGlncxoMINWpnYVwiL4Pbt2WYSGRWgLbx1ybuS7BgTDqeOPqsafjYP0YUtBkkuFbv9jUzTkjhjmFw3Bify7TA8QhRc1OJiIkePMI4lfAsvwKlwsBRL4Dxcyb3SWPt62mHv86i2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176281; c=relaxed/simple;
	bh=Z+ZL9Z2H4BNVhMSaOCmrcxzkPqxY2sKsp/cCnNOf02Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WRWrtKQ76tz9dFvtRu68V64S/6JLdi8X+lxSwao2ybGCcY+amPVhPAEUB0OdRpSk+kq2rTAIM5ukuzf2xDyJH7Y+DqMIYZdIeTaZ45Y8lMmMszuKYI7/9ojgAvWzbbOvx1tPw9HguyJa1zFat/tVFTQh76jUKmyag5cZiFRCpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gz+eV4Qj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so33529831fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714176277; x=1714781077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m1Uk36+r4RAlAOGcg6AqpsWQfDW3MOKGbEB6wYdmGd8=;
        b=Gz+eV4QjTlijGekCuNf7hISt3OJWf4BuQK2h4O3RTnd25w2yz2gK8Iygmo2pJw6Eic
         it5rz5Ui+X9aE53LASvUYmsULFo7OPNEgEUh9lkkszQgNQ4vM0ZFoyandK4j8wIuLL9j
         2mpX6PgEs3fQ0IL6y+Sso8WZFRkndehJ5zgOx4yj6CoJ8VbCvUhsR72H8pA+ls2PTKEc
         J58ynUbQa/39hn/piu/tcMBFlE9CrqHDFsmuSe6RHATGGr1QES/nAWGTtlBYlN5Qlv/H
         ggZLuyvbTYrad4Ez81nKSUzjCLl8dsx+VxCY/rlVbjMTj57AEC1u9MKmcpcpKAeCt7hC
         TV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176277; x=1714781077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1Uk36+r4RAlAOGcg6AqpsWQfDW3MOKGbEB6wYdmGd8=;
        b=m9jTc5mogLM0WYJ6wjGiXA5AofIyApI6NKHt5obopGsP9C+y60j7zD4shed7G+zV/P
         SCuL/oPeP2L3RaHlPZs7TGZ9EEplN/bdn+Lee3ADeZHRmCXhxbO/wGZu2aJuxgiaDlyb
         1wkd8FOv7F78qLPCkHcKVfGhMKmoVBgqQoMcA9dPHsl0NRJD8RsFAUXpAuWv5pL2n9BA
         40VsHkkwHoIS9ZBUEDMgnZijL6LfGz4Ibe1B6bzr79UOtwBaNky+IYXhIWKSiEV4iY8h
         oVpzEjKOkMG4a6ogVjUyE/4/SbQdDSYmCdpLqCkownYsgQfh1STSSxFs865l1b216qsI
         +Waw==
X-Forwarded-Encrypted: i=1; AJvYcCXZTYcRgP9i2q2ggm6HDXgewrgQqevQ8r329W/k+b5o98YLjS33nHiVvFAa6LGR3VEY0WKuVfffi3qy1bGrKDfbZncDnvG1F5OVazM=
X-Gm-Message-State: AOJu0Yxw4p0AbIN8BY8ZjWxJzBe8PEgh1YB7YIRGKzWVyESl59F2iiFE
	wuaL8v4z6GuvG9vO+Ggiw5TXCSbkKsGemzQF8dDWSZHP9LMROJWk+0c5sPWDSf3CqcrwCPcRyfB
	9
X-Google-Smtp-Source: AGHT+IEIlavobzu5wItpSFZFjdOe8ECVL5vwiErx54xQK9NmUAjSt6Hxv3GagsfylQfL2a61e82UDQ==
X-Received: by 2002:a2e:8ecd:0:b0:2df:a177:58e3 with SMTP id e13-20020a2e8ecd000000b002dfa17758e3mr733182ljl.13.1714176276593;
        Fri, 26 Apr 2024 17:04:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm15361769pfk.215.2024.04.26.17.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 17:04:36 -0700 (PDT)
Message-ID: <e9a07ed8-facc-462f-9fe2-ede4d1e4a8bb@suse.com>
Date: Sat, 27 Apr 2024 09:34:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's the difference between `btrfs sub del -c` and `btrfs fi
 sync`?
To: intelfx@intelfx.name, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
 <71f2d380-9b11-4ed5-949c-0edc1ed56c60@gmx.com>
 <c8bac058c40b15a242d4598172d6a89c2f97608b.camel@intelfx.name>
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
In-Reply-To: <c8bac058c40b15a242d4598172d6a89c2f97608b.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/27 08:44, intelfx@intelfx.name 写道:
> On 2024-04-27 at 08:36 +0930, Qu Wenruo wrote:
>>
>> 在 2024/4/27 08:22, intelfx@intelfx.name 写道:
>>> Hi,
>>>
>>> I've been trying to read btrfs-progs code to understand btrfs ioctls
>>> and one thing evades my understanding.
>>>
>>> A `btrfs subvolume delete --commit-{after,each}` operation involves
>>> issuing two ioctls at the commit time: BTRFS_IOC_START_SYNC immediately
>>> followed by BTRFS_IOC_WAIT_SYNC. Notably, the relevant comment says
>>> "<...> issue SYNC ioctl <...>" and the function that encapsulates the
>>> two ioctls is called `wait_for_commit()`.
>>>
>>> On the other hand, a `btrfs filesystem sync` operation involves issuing
>>> just one ioctl, BTRFS_IOC_SYNC (encapsulated in a function called
>>> `btrfs_util_sync_fd()`).
>>>
>>> I tried to look at the kernel code for the three ioctls but to my
>>> untrained eye, they look like they are doing different things with
>>> different side effects.
>>>
>>> What is the difference, and why is it needed (i.e. why are there two
>>> sets of sync-related ioctls)?
>>
>> IIRC --commit-after/each only commit the current transaction, and it's
>> just doing the same `btrfs fi sync` after all/each subvolume deletion.
>>
>> The reason is to ensure the unlinking (not fully deleting) of the target
>> subvolume fully committed to disk, so a sudden powerloss after the
>> deletion won't lead to the re-appearing of the target subvolume(s)
>>
>>
>> However there is a another behavior involved, `btrfs subvolume sync`,
>> which is to wait for a deleted subvolume to be fully dropped.
>> In the case of btrfs subvolume deletion, it can be a heavy load, thus
>> btrfs only unlink the to-be-deleted subvolume, and mark it for
>> background deletion.
>> `btrfs subvolume sync` would wait for any such orphan subvolume to be
>> deleted.
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Cheers,
> 
> Thanks for the fast reply!
> 
> Yes, I'm aware about `btrfs sub sync`. I understand that's a totally
> different operation.
> 
> What I was asking about was specifically the difference between
> `btrfs _filesystem_ sync` and the operation that happens at the end of
> a `btrfs subvolume delete --commit-after`.
> 
> Or, in kernel terms: what exactly is the difference between issuing a
> BTRFS_IOC_SYNC and issuing a BTRFS_IOC_START_SYNC immediately followed
> by a BTRFS_IOC_WAIT_SYNC?

If you go really deep, there is some small difference, but overall you 
can consider them the same, despite the START/WAIT_SYNC is an async 
operation, while IOC_SYNC would wait for it.

> 
> It is not immediately obvious that the kernel code for the three ioctls
> is equivalent (even if it is). For instance, BTRFS_IOC_SYNC begins with
> a call to btrfs_start_delalloc_roots() whereas BTRFS_IOC_START_SYNC
> begins with a call to btrfs_orphan_cleanup(), and the subsequent
> transaction handling code seems subtly different.
>
There is a small difference, but not really effect end users.

The IOC_SYNC would start and wait for the writeback of all dirty files.
(AKA, the same behavior as `sync` command).
Meanwhile IOC_START_SYNC would not trigger the writeback, just commit 
the metadata which is already dirty.

For the --commit-after/each, IOC_START_SYNC is faster, since 
IOC_SNAP_DESTORY has already dirtied the necessary metadata, we only 
need to commit the dirtied metadata in current transaction, no need to 
wait for other data writeback.

Thanks,
Qu


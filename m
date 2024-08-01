Return-Path: <linux-btrfs+bounces-6940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40CB9439E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797C5284E97
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 00:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4CEC2;
	Thu,  1 Aug 2024 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bvjWVaeP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB0632
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470804; cv=none; b=Wpog35uYM3dTIuXncfUE8ujkh9F313rWT3Uby3OYuW8kx7EuBm41tyiaJYdKzxgT2ZsaY/ejq1RCGax/3Uj7rgZ81WMDexmxCwuEBGj15ST+3Xq9aOAer/fCLNjWYWth/v8bLBDynANqTPd/pzwH9j6DlRZtXPZJMmJ4ndOZwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470804; c=relaxed/simple;
	bh=rTyXPpJy/mIMMBP1GAySXRH0twExNlJXiMc74Z7k72Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+A9CPqviUivGsWbCnXmLN879VJuw4yf3dRHPLRKLlIdLb55bmd8f3iVx9TVevFIADDsHIqD3qZnBmMOtUMgyhyTJ1dsWot/OkI8vpwDyaw1Qv8NXome67dagivukSpH4xgmlTx504UiEtu/xLcnYXnAgJatDllN5N9uqlzVYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bvjWVaeP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso74304291fa.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722470798; x=1723075598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v5gNh9nRd8kd/uZ7sJYY+Ln5oS2sY5MGQaOBpJZtsr0=;
        b=bvjWVaePug6Gspj60BezxHd0hXG6arR5ELPcKUTGUFw5QlEKhmSMxVPh1OOuqEV4Cp
         Anj/5B1AzsonGyFxmxoTu0KdqaPOg4Tt1QVD2tZOUu/mpEGYy1Oz8teE2Di3mRDD+NHf
         qaGNyvhZA2XCZR0JZmujV3V7uG0cwmVWt77EHItC4Hj2/kCuSQybWfFzdSI/3quOZPSv
         Ult+E5919B4oEIEE/d28Rcj76glyR6xuDpEA/9Bs4NmK2Zxc+1AxAE8qEy58KCx6c2oR
         lVyRnjuqZQOgh1EtHvxBbiwgyacXF2IX0oSd4DtwD46rT2c88D5DSdQhDLtRcuMgqnMd
         NayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722470798; x=1723075598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5gNh9nRd8kd/uZ7sJYY+Ln5oS2sY5MGQaOBpJZtsr0=;
        b=PnEPf9NiqKqMO/SsdNYkj/keJNceTDawrQYFowK3oz1wWwiEo24wXG2vY+wCXteeyz
         vkTKaE8jgm3lxUKmZ7lfY4uMa5skvpRHjPB/JWWyiUssssNEjXI45e2WsznD8NMbz/YJ
         uidwfuGu15jvoxcsd6eQu9xVZzn26K0ALZCtTpFgifZVJ7R6+MGdjYTeism8NE68V3W+
         mXEPqaxw+KMSbgZCV+WkQR8TPY5OKluUS2NMN6TNC3oijVpXtAQTRQQmhrteZ/XAU88m
         RfjSh3TD9X/QyaYpN3tJSH0Lt5TXpIZlx+ZAWgIRuYVCow9Qsyl3D6bYm+tYThQj+159
         X1yA==
X-Gm-Message-State: AOJu0YwHVOo3wCvKS8GybiryvmJjR4CoiZXKEDpTyYA2R7i+n3ePtTx3
	IK94Owqga6X6BMjLSBs07YWuYETOawIBP80jnaR+IM/ZvSi5dpUltdTzFL+Tul+AvLS/+W8bsES
	/
X-Google-Smtp-Source: AGHT+IGQrl5QzSJ7U949SXWAE27Coj7/F+lBUY7HysO4ycZEDOHzc4xy6Zydu53KtzI8IMi9IF2xrQ==
X-Received: by 2002:ac2:5586:0:b0:52e:f367:709b with SMTP id 2adb3069b0e04-530b61f8971mr259687e87.42.1722470797509;
        Wed, 31 Jul 2024 17:06:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d2261esm126518095ad.103.2024.07.31.17.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 17:06:36 -0700 (PDT)
Message-ID: <558f5dc5-ad7a-4aed-b7ee-b0f78eec85f0@suse.com>
Date: Thu, 1 Aug 2024 09:36:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs-progs: mkfs: rework how we traverse rootdir
To: Boris Burkov <boris@bur.io>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1722418505.git.wqu@suse.com>
 <667ee4f02fdc2cb6f186eb8b06dd089f3ce53141.1722418505.git.wqu@suse.com>
 <20240731225935.GB3808023@zen.localdomain>
 <dd3444f9-c8be-46e7-97b1-8f95a161c709@gmx.com>
 <20240731234231.GA3809836@zen.localdomain>
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
In-Reply-To: <20240731234231.GA3809836@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/1 09:12, Boris Burkov 写道:
> On Thu, Aug 01, 2024 at 08:49:39AM +0930, Qu Wenruo wrote:
[...]
>> # mkfs.btrfs -f --rootdir rootdir test.img
>> ERROR: item file1 already exists but has wrong st_nlink 1 <= 1
>> ERROR: unable to traverse directory rootdir/: 1
>> ERROR: error while filling filesystem: 1
>>
>> And it failed as expeceted.
>>
> 
> Perfect example, it did seem to be vulnerable to this with just
> "original st_ino + 256"... Thanks for the new test.
> 
>>>
>>> In that case, if this is a bugfix, I think it makes sense to write a
>>> regression test that highlights it. It would be nice to pull the fix
>>> out of the refactor, too, but I suppose that with such a deep refactor,
>>> that might not be possible/worth it.
>>
>> Unfortunately I didn't even notice how serious these problems are, until
>> I tried...
> 
> That's kind of my concern with the higher level testing question, that
> we don't have much coverage for such a big refactor. OTOH, if we already
> had such serious bugs, how bad could the refactor really be :)

David is also pushing for the coverage tests:
https://github.com/kdave/btrfs-progs/actions/runs/10167512547

And indeed the coverage for mkfs/rootdir.c is not that good (71.2 %)

Another thing is, even if we go fsstress (already included 
btrfs-progs/tests) there are still limits what we can test.

E.g. the cross-mount point bug, and the out of rootdir hard link, as 
even fsstress can not create new mount point (unless using btrfs 
snapshot/subvolume)

To be honest, all the exotic new bugs are only exposed if we find some 
behavior unreliable, then reserve engineering to create test cases.

So in short, we need both fsstress based functionality tests, but we 
also need all those weird and seemingly impossible hand-crafted corner 
cases.

I just hope the new cases can improve the coverage.

[...]
>> A quick grep shows:
>>
>> 004-rootdir-keeps-size
>> 009-special-files-for-rootdir
>> 011-rootdir-create-file
>> 012-rootdir-no-shrink
>> 014-rootdir-inline-extent
>> 016-rootdir-bad-symbolic-link
>> 021-rfeatures-quota-rootdir
>> 022-rootdir-size
>> 027-rootdir-inode
> 
> Thanks for collecting those. By scanning those, it's hard to tell if
> there is, for example, a test of an "interesting" directory structure
> like the one I drew above, to test the traversal, for example.
> 
> Out of curiousity, I applied your patches, ran the tests (pass) then
> put a bug in the traversal code (only pop on cur_lvl > ftw_level, not
> ftw_level - 1) and 004-rootdir-keeps-size did fail, as it ran on the
> Documentation/ dir, which does seem like a sufficiently interesting
> directory.
> 
> I feel a bit better now :)
> 
> Maybe something that ran after fsstress (or however we test send/recv?)
> in the long run would be a good test, as we nail down some of the bugs
> you have hit here.
> 
> This comment is not directed at you, but is more general for btrfs
> development: I think explicitly stating the testing conducted on a
> complex patch is really helpful for reviewers.

In that case, the coverage rate would be something to improve next.

> 
>>
>>
>>> Is it
>>> in fstests? Knowing that all of the new code has at least run correctly
>>> would go a long way to feeling confident in the details of the
>>> transformation.
>>
>> We have btrfs-progs github CI, runs the all the selftests on each PR.
>> And it's all green (except a typo caught by code spell).
>>
>> [...]
>>>> -	parent_inum = highest_inum + BTRFS_FIRST_FREE_OBJECTID;
>>>> -	dir_entry->inum = parent_inum;
>>>> -	list_add_tail(&dir_entry->list, &dir_head->list);
>>>> +	/*
>>>> +	 * If our path level is higher than this level - 1, this means
>>>> +	 * we have changed directory.
>>>> +	 * Poping out the unrelated inodes.
>>>
>>> Popping
>>
>> Exposed by the CI, and fixed immediately in github.
>>
> 
> Cool!
> 
>>>
>>> Also, this took me like 15 minutes of working examples to figure out why
>>> it worked. I think it could definitely do with some deeper explanation
>>> of the invariant, like:
>>>
>>> ftwbuf->level - 1 is the level of the parent of the current traversed
>>> inode. ftw will traverse all inodes in a directory before leaving it,
>>> and will never traverse an inode without first traversing its dir,
>>> so if we see a level less than or equal to the last directory we saw,
>>> we are finished with that directory and can pop it.
>>>
>>> Perhaps with an annotated drawing like:
>>>
>>> 0: /
>>> 1:         /foo/
>>> 2:                 /foo/bar/
>>> 3:                         /foo/bar/f
>>> 2:                 /foo/baz/            POP! 2 > (2 - 1); done with /foo/bar/
>>> 3:                         /foo/baz/g
>>> 1:         /h                           POP! 2 > (1 - 1); done with /foo/baz/
>>>
>>> To help make it clearer. I honestly even think just changing to >= makes
>>> it clearer? Not sure about that.
>>
>> I'll add comments with an example to explain the workflow.
>>
>> BTW, David and I are working with Github review system a lot recently:
>> https://github.com/kdave/btrfs-progs/pull/855
>>
>> We do not force anyone to use specific system to do anything, but you
>> may find it a little easier to comment, and feel free to fall back to
>> the mail based review workflow at any time.
> 
> Happy to do code review in PRs! It's a bit annoying that the history
> gets blown up when the author re-pushes the branch after incorporating
> feeback (never understood that design, Phabricator tracks the *branch*
> history too and it seems very helpful to me.)

In fact that auto `outdated` marking is pretty useful for guys with a 
short memory, just like me.

Sometimes I forgot to address some comments, then the review part still 
shows the previous comment without `outdated`, reminding me something is 
missing.

Thanks,
Qu

> 
> BTW, if this review style is going well, we should discuss more and get
> the workflow more documented/supported in the workflow docs.
> 
> Also, while we are still here in email-land, you can add
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
> Thanks,
> Boris
> 
>>
>> Thanks a lot for the detailed review!
>> Qu


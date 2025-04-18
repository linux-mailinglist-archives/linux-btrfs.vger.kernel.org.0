Return-Path: <linux-btrfs+bounces-13166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD551A93B23
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B66E189EB22
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D09221558;
	Fri, 18 Apr 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="uPi2By4j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313B224231
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994333; cv=none; b=PYzW8D5zMlpgWPsipER96qI1NE1LITm9C5U8BD2Ln7hiGlnrs9F1Ngp86R1V+HgWF8y2MumnbTqJd0pAFoPI0rshfdC1RG/KhdhlNrfDY/3Q+W6WjWymhVbLETDUlR9X0FD36lDA74T824+hRbKYIDLHjq1Kdv5Oh0QTpE3Mvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994333; c=relaxed/simple;
	bh=270JPJGGjY7IPgmfewe28hrxl/Ritzcxa5nGiJd0c20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaBGjkBUmwOugfvWxjp/lpJhEfl/+3tjMOfrF7SPqe8KUcdM6lB+ACjzQjZTGfZvJyYqLONX6CwR7c1eWrw4fBVv830+eizWSYZX0mkvT4JZLhLVYrEKYSUcq5YJX9x+QxPkvodMQjnNI3Ef5Bm9pNeJZ2WmMAkKdsEEWdtrQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=uPi2By4j; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id 5ojhumumhrFho5ojiu1mFk; Fri, 18 Apr 2025 18:38:42 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1744994322; bh=U8LXjbi8hjg2a133vJ10rfnK/xhkjqUqm2yf3dBVSbk=;
	h=From;
	b=uPi2By4jH5X8u4yuOnFu+CRhg2dcbL2HQtkucO6Y1mB7L8ttBB9LTXNGf7qM0P9b/
	 dsTmuOyYs5z+QPLgWBZszJewHevODv4h6dYNgaDUi+8um5MpKZVXO5UWgyvLvjdpYG
	 qf59DTEQ+5K12PxV0OhaTTCC3iFn5nml/TlS8tfBZyKb6x5FHqbHW/NXZie8UJuGVF
	 a7hLDyW7HzzrL8bmfa7XoSO/Mf750GmMRUgFp2vjhwEkC4aLjOeBAXAeWuIxsIgBPi
	 UXbixyuyl4vmz29Zz0ATeHRzjKnv/ccfJef00JDhu27jd8UritKBaUnHz5IRgd78Wb
	 YAXcFOPrkwEOg==
X-CNFS-Analysis: v=2.4 cv=UPIWHzfy c=1 sm=1 tr=0 ts=68028012 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=zykuF6jACpLkSlqT_k0A:9 a=QEXdDO2ut3YA:10
Message-ID: <e76520ca-a9e6-4bd4-bb25-30849f946e20@inwind.it>
Date: Fri, 18 Apr 2025 18:38:41 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: P.S. Re: Odd snapshot subvolume
To: Nicholas D Steeves <sten@debian.org>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
 <87friais1a.fsf@navis.mail-host-address-is-not-set>
 <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
 <72d7150b-4e0b-4e15-bd3f-ab410be4a767@libero.it>
 <87tt6q1tn3.fsf@navis.mail-host-address-is-not-set>
 <93a7fd2e-d667-4b9c-b2b9-dc4f05e7055d@inwind.it>
 <87y0vy32lh.fsf@navis.mail-host-address-is-not-set>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <87y0vy32lh.fsf@navis.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLOdggbK+zOBrT6OzwRrOoZ3igE0eix/l6X0P4kDQJGZlPGXsl3zkuCAMpenPziJKoBhkdb8CjzZQFtXZjxC+B1IjgnbfC9ey5POTTTFXc3weYiwHXqS
 dpYe7hOedVVGcnShPJkf+PINVLajNMVYAv9hMwOC7h3bORBNxfMyK/d+ywy8yj6nxtxvW0kun3ZeBGvEl0ixk+HPHvahXJ0+fGVxfIisBufCifOkheePEkRz
 o5i4bLNOKVSIfdUJikwHQA==

On 17/04/2025 23.22, Nicholas D Steeves wrote:
> Hi Goffredo,
> 
> Goffredo Baroncelli <kreijack@inwind.it> writes:
> 
>> On 14/04/2025 20.32, Nicholas D Steeves wrote:
>>> To encourage btrfs adoption I think we need to do better.  After
>>> considering alternatives, I wonder if there is anything simpler/better
>>> than
>>>
>>>     # findmnt -n -o SOURCE /foo | cut -d[ -f1
>>>
>>> to get the device suitable for mounting -o subvolid=5 | subvol=/ ?  Ie:
>>> "Just let me see everything with as little fuss as possible. Make it
>>> simple!", without relying on fstab.
>>
>> Below a bit simpler command options set
>>
>>       # findmnt -n -v -o SOURCE /foo
> 
> Oh, nice!  I guess it's been a while since I've read the fine manual.
> Findmnt has a very, hmm...unique...definition of the "-v" option.
> 
>> However I have to point out that this is not a specific BTRFS problem. See below
>>
> [snip reproducer (see previous email)]
>> 	ghigo@venice:/tmp/test$ sudo mount -o X-mount.subdir=b /dev/loop0 t2
>>
>> 	ghigo@venice:/tmp/test$ ls t2/
>> 	c
>>
>> 	ghigo@venice:/tmp/test$ findmnt t2/
>> 	TARGET       SOURCE         FSTYPE OPTIONS
>> 	/tmp/test/t2 /dev/loop0[/b] ext4   rw,relatime
>>
>> 	ghigo@venice:/tmp/test$ findmnt -n -o FSTYPE,SOURCE t2/
>> 	ext4 /dev/loop0[/b]
>>
>> For *any* filesystem, it is possible to mount a subdir of a filesystem as root.
>> BTRFS subvolume has some special properties (e.g. it is a "barrier" for the snapshot).
>> However the possibility to be mounted is not one of these BTRFS special properties.
> 
> Ouf, so the complexity has now become a generalised feature?
> 
>> If you want to know which subvolume is mounted, you have to look to the "subvol"
>> option in the mount command. However even a sub directory of a subvole can be mounted
>>
>>
>> 	ghigo@venice:/tmp/test$ sudo mount -o X-mount.subdir=b,subvol=/subb /dev/loop1 t5
>> 	ghigo@venice:/tmp/test$ findmnt t5
>> 	TARGET       SOURCE              FSTYPE OPTIONS
>> 	/tmp/test/t5 /dev/loop1[/subb/b] btrfs  rw,relatime,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/subb
>>
>> This to say that event for the common case "findmnt -n -v -o SOURCE <path>" may be
>> overkilling, there are some corner case where it is needed. To understand the situation I suggest to use
>>
>> 	ghigo@venice:/tmp/test$ findmnt -o FSTYPE,FSROOT,SOURCE -v t5
>> 	FSTYPE FSROOT  SOURCE
>> 	btrfs  /subb/b /dev/loop
> 
> Why would someone do this, and what are the circumstances where it would
> be required to spend resources engaging such complexity? 

It allows to have multiple root. E.g. you can install different distro
on the same filesystem in different sub-directories. And you can mount
a directory as root easily passing X-mount.subdir.

Of course this flexibility, means that you now have to track not only:
- source device
- mount point

but also:

- source directory as root

If you think to this model, you can ignore the btrfs subvolume concept
entirely if you don't need the snapshots.

I have to point out that the root of this complexity/flexibility is in the possibility
to mount a path to another mount point. In fact if you do:

	# mount /dev/sda1 /path1
	# mount --bind /path1/subdir /mnt/other

you have

	# findmnt -o FSTYPE,FSROOT,SOURCE -v /mnt/other
	FSTYPE FSROOT  SOURCE
	ext4  /subdir  /dev/sda1

	(the example above was from my memory, so expect few typo)

And this is *not* filesystem dependent.

> I honestly
> feel like I'd be triggered into "nope, nope, nope, it's not a good use
> of time to deal with this" if a team member did this!  That's one of the
> reasons I want to document the simplest, overkilling, corner-case
> mitigating workaround ;)

If you don't use {mount --bind,mount -o X-mount.subdir, mount -o subvol=},
you can live as this complexity doesn't exist. If you want to mount a
"btrfs subvolume", you have to track this somewhere, and thus the
complexity.

> 
> Thank you,
> Nicholas

Ciao
Goffredo


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


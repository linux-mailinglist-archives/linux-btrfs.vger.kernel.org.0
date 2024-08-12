Return-Path: <linux-btrfs+bounces-7120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5294EC06
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B51F2267C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B416CD16;
	Mon, 12 Aug 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="r/0imVPG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914116DC20
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463111; cv=none; b=Z8Y2cmNsxO+80rnaCQT4P6fCOeit2iuLnajLhnXsFxcxGF65QAs2ZarMaRtr0ej/k3N9qQJkflN5dIGjFSKvpARwh89QKAj25A/Yp7zJtvocnv8CXA901r8ga7ycXyPXJ8jihksly5HMbLUHBfX5htErAU99H4Ogx14bUG6/RUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463111; c=relaxed/simple;
	bh=lYkJtXhbwBxlo7/27QE4bhzYl7fyFG6ZQVz1lylGJn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eyx/yk9AW1gAmE20fdDcldrkQR2KfGTFn7D/n5+7/6D6YVUYwpeqexBL6p/R7WpzayMnHTb4STwGu10zhN9Jka4/z3EB0Nf7aXwOkbIsef39hh8kdYkpU41cElzC2jnRUiQ1hqScuWOkw81TmMkAxZlaBdcTkpX3U59mJn4WeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=r/0imVPG; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id dTRTsJlrM201ldTRTs5f2E; Mon, 12 Aug 2024 13:42:28 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1723462948; bh=7YNeYxqOkwxCNLGgsNUgKZwWBbg8xU3j12nT+F+ZZhk=;
	h=From;
	b=r/0imVPGybM7yGvzNKgC7zYySBabBd2PL71Pg1TpxJB2cLUXpOT2pSToanF++uRuc
	 mfmMinEV5XQa1XXl5Gn8OQZ7uGI0ShsDyOuVPxhG2hksiV8pALi9dziG0CMWL9w/b1
	 CvcT/DjYap/+tjMQ567AEYAs+6BHwI0HZI3LzmtQF8CqYFg8OSGfC97okAM/2TYyPX
	 YTU49Gdmq9Xn4WvF3ZV4jWWiu13WgT6AMmiLXgLlJpXbRoSFvVC8/EzlGTGpXiDH9V
	 /SgyZJ1BmQ384RfGy+DCOGfQaYTklLdanMnW24BYu4kMaxybw8S3BByF8cAKhpr/A0
	 zpNfoVABGxbpQ==
X-CNFS-Analysis: v=2.4 cv=f7aDB/yM c=1 sm=1 tr=0 ts=66b9f524 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=NpvV3WJMCwzl7tNDu6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
Date: Mon, 12 Aug 2024 13:42:27 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
 Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
 <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPavLSedTLJAg3FQ+mWqZd67Ul8zsq0209K77TGRb0Y73ACZzN6kXjTqxtUj+oHaKO6XNvnZcoTJTnMwKxJ7m8JCAAlmF8zxanHtRy689V8XOyw52jKU
 YLbvsnVkhjhRoszjOLuVVJPgnJuD6N4CoiPyXun9MN3Bs9R1md8MYW3ChNu9ndlAHMNakZJCwYqbEDudbkTk9rcDqtUfhUIc0yjMoZgnooaH1xkK1jSTDWgU
 3RUiJ2bYeQaEWf5v7hvjLStkKMTiI50vVuDp8FK4webtCAIXXOMnEp9UnipcYTb8

On 11/08/2024 00.40, Qu Wenruo wrote:
> 
> 
> 在 2024/8/10 19:23, Goffredo Baroncelli 写道:
>> On 09/08/2024 21.31, David Sterba wrote:
>>> On Thu, Aug 08, 2024 at 06:17:16PM +0100, Mark Harmstone wrote:
>>>> This patch adds a --subvol option, which tells mkfs.btrfs to create the
>>>> specified directories as subvolumes.
>>>>
>>>> Given a populated directory img, the command
>>>>
>>>> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home
>>>> --subvol img/home/username /dev/loop0
>>>>
>>>> will create subvolumes usr and home within the FS root, and subvolume
>>>> username within the home subvolume. It will fail if any of the
>>>> directories do not yet exist.
>>>
>>> Can this be fixed so the intermediate directories are created if they
>>> don't exist? So for example
>>>
>>> mkfs.btrfs --rootdir dir --subvolume /var/lib/images
>>>
>>> where dir contains only /var. I don't think it's that common but we
>>> should not make users type something can be done programmaticaly.
>>
>> Can we go a bit further ? I mean get rid of --rootdir completely, so
>> a filesystem with "a default" subvolume can be created without
>> passing --rootdir.
> 
> Personally speaking, I would prefer the current scheme way more than the
> out of tree subvolumes.
> 
> It's super easy to have something like this:
> 
> rootdir
> |- dir1
> |- dir2
> 
> Then you specify "--rootdir rootdir and --subvolume /somewhereelse/dir1"
> 
> This is going to lead filename conflicts and mostly an EEXIST to end the
> operation.

I am not sure to fully understand to what you means as "filename conflicts";
anyhow, now you have the ENOEXIST problem :-)

> 
> 
>  From my understand, the "--rootdir" along with "--subvol" is mostly
> used to populate a fs image for distro building.
> 
> If you really want just a single subvolume, why won't "--rootdir rootdir
> --subvol dir1" work for you?
> 
> If your only goal is to reduce parameters, then your next question is
> already answering why the idea is a bad one.


The use case that I have in my mind is to create a filesystem with a default
non root sub-volume, and nothing more. This would prevent the typical problem
that you face when you populate the root-subvolume, then snapshot it and then
revert to an old snapshot, swapping the subvolumes.
It is not easy to swap the root subvolume, because it is a special in the sense
that it cannot be deleted and it is the root of all subvolumes.

Being so I think that it is better to avoid to have the root subvolume as
default sub-volume.

For my goal (having a filesystem with a non root default sub-volume) creating a
template filesystem is waste of effort.

Now these two use cases (my one, and the one related to this patch) have a lot
in common. So I trying to find a way so the two can be joined.

> 
>>
>> However, this would lead to the queston: which user and permission has
>> to be set to those subvolumes ?
>> So I think that we need a further parameter like "--subvol-perm" and
>> "--subvol-owner"...
> 
> Nope, the current code is already handling that way better.
> The user/owner and modes are from the rootdir.
> 
> Meanwhile your idea is just asking for extra problems.
> 
> Thanks,
> Qu
> 
>>
>> BR
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


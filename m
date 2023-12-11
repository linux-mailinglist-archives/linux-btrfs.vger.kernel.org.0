Return-Path: <linux-btrfs+bounces-824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B980DF62
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 00:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1862826DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F65674B;
	Mon, 11 Dec 2023 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZpCnifev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C07CD
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702336863; x=1702941663; i=quwenruo.btrfs@gmx.com;
	bh=z/nfvxaG7RGQXn5KM5tDg31TrEf6ryNRQxcVzPHS6N0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ZpCnifevfza7Dv+RZbLq+LxZCuDbw/gDtnZl2K/n9gqAtefX+5oq3gZTbz37yggp
	 BnnkmDCrogDErgt9P3WA7KBQRBKDWkrXbf8rc0kAOr67Y7Fj7uziLr07ZrWFyiY9a
	 Kbjunney8cXLlZ33kfUMEwD0Q9CunDlwSSH0lmz8uyeb0ZUEEcmIxr/nGq08FULi/
	 8f7cMKivl4Ze8C/Znr8vLyfluyRTOKu4Ko8k3O6BXtXdZ0EmuuC9HSvaNOduZIhuR
	 TN0y8t5lh+XNMd5KNVTWinIMzrrcQcoA6rbjlvCKQspD1f9aJaBZsuRmYCvD+bSdo
	 wC8AoHk1BZdbYUBjZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1rhTV02iC8-00dlEb; Tue, 12
 Dec 2023 00:21:03 +0100
Message-ID: <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
Date: Tue, 12 Dec 2023 09:50:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YN4v4unVatUG0d2nLZJo+d4DGYWzAw9jhKZbujTJVZQWdY09Lks
 pXy8TDvPFsvmrhxwlGbQ+ZuAuJzBl2zYUNMUC9yZIu9rVWFreVHuURe7rx929D149X4kal7
 g6USNs4xetgOZapUri7L08d2ZTVNzKGn6sdtpWNfN2fFOhjZIr9oxFp8CRstLGkn6MspwEI
 rwmaWBUOxvR9psT0gK9Iw==
UI-OutboundReport: notjunk:1;M01:P0:KmBQxYZW+ys=;Nd+35EJl5b3RFlPaM5r2hyWZSpg
 fMFcOxKJLEpNmm7DOErHJPK0aP5gKEu1Mn1B36lWNgjSSPwku5tJlWdYwxinL+Aqr0yI732xk
 /If4ZgyB8D9fBSnU1kaStEsCKriAeB+31UpJ3TKnDcfUARn9U4+o+LYBdTPNXfr2wVPezzzc1
 dXHmv8mgrZsg4iD0GY4a+hGgbewqgPHofQeWJk5atAN19DnxXs5Zkhnc9rjr7JgRXrhajrLk1
 U9ogHDnhHeM8+8VreX6nuZB7yUnyfsm6Nc4FsLJI7S3gjSKotI/4vGwKAIYmLQG138iLzC1NG
 WGqItxLJvxQqPFoe6tbVqkOWcba7gFCxZeTDuOd89Yh7kWED3BvXKvkamI6tOD3YmNMPXqgc0
 gS8gKEnESK3N8wuw/9wxYUviRplcExQwinR7i9C6+7j6dUP2XNZXHyosEXRc83Iz1f1Q5ahtK
 4jd+473cwfApoln6GjA9h0UNsArBnGxHmKXAqJT6dmhuBHDh40h6BJMM+Z4jj1gcq7vLt4Igd
 +jShSinmKZ5yYR5voCyjKEwA1N6SFH5qyfierdkU/JmvRpRZp3xiWw+3CyLYhDuCyFG8qtTFv
 I/MHTo8z0sRKQpJto5EuEM+ulr/tpiLBYd06Iz4YCpb8B+PXwXuHy0sgKMChgm51MZ+PPsbQs
 U+8CAU0w3197DmWhizZh2ONfPgHPFLW+3rcY8ekvrYYWbhjsPrajIRjwRXFBuxYVK7CJLO23w
 9IeNPGuKR/AJxnQfm4WaXBNGp+B983CbbbRyYNAZKDO4KZ2fbi8wMoHMVvKJLXvV3krNzBHWS
 Td0rUJ39b6EWKxs11jd9Xd1lHYM5MjsagKDBiSESnzGkj0w6matk9qwDpQUL9vaX72QU3lx+T
 7yNIijoZjwz7Gre7k5Osdkl8OiWCJJp0DYWnpyx1lW+d1ou3kk/vM3vc+RpcGL5EAjQJ8PkZB
 PANGpcI6e8KbH3f+hdc6uR69kvU=



On 2023/12/12 08:53, Christoph Anton Mitterer wrote:
> Hey Qu
>
> On Tue, 2023-12-12 at 07:27 +1030, Qu Wenruo wrote:
>> Is your current mounted subvolume the fs tree? Or already the data
>> subvolume?
>
> Well actually both, I always have a "service" mountpoint of the root
> volume as well, and just unmounted that to no confuse with "double"
> mount entries.
>
> In reality it looks like:
> # mount | grep vdb
> /dev/vdb on /data/main type btrfs (rw,noatime,space_cache=3Dv2,subvolid=
=3D257,subvol=3D/data)
> /dev/vdb on /data/btrfs-top-level-subvolumes/data-main type btrfs (rw,no=
atime,space_cache=3Dv2,subvolid=3D5,subvol=3D/)
>
> But all data (except for 2 empty dirs, where on other systems I would
> place btrbk snapshots) is in the data subvolume:
>
> data/btrfs-top-level-subvolumes/data-main# ls -al
> total 16
> drwxr-xr-x 1 root root 26 Feb 21  2023 .
> drwxr-xr-x 1 root root 30 Nov  9 23:49 ..
> drwxr-xr-x 1 root root 20 Feb 21  2023 data
> drwx------ 1 root root 10 Feb 21  2023 snapshots
> /data/btrfs-top-level-subvolumes/data-main# du --apparent-size --total -=
s --si *
> 29G	data
> 10	snapshots
> 29G	total
>
>
>> If the latter case, there are some files you can not access from your
>> current mount point.
>
> No it's not that (that would have been quite embarrassing ^^).
> /data/btrfs-top-level-subvolumes/data-main# tree -a snapshots/
> snapshots/
> =E2=94=94=E2=94=80=E2=94=80 btrbk
>
> 2 directories, 0 files
>
>
>> Thus it's recommended to use qgroup to show a correct full view of
>> the
>> used space by each subvolume.
>
> Uhm... qgroups? How would they help me here?

Shows exactly which subvolumes uses how many bytes, including orphan
ones which is pending for deletion.

Thanks,
Qu
>
> Cheers,
> Chris.
>


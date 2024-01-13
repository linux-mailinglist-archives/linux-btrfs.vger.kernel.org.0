Return-Path: <linux-btrfs+bounces-1422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09A82C937
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 04:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1809F286265
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 03:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF285CA78;
	Sat, 13 Jan 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wsur/u8R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625068F5A
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705115849; x=1705720649; i=quwenruo.btrfs@gmx.com;
	bh=D3e/yjMu615CKY+FdkJblsmDrgTVkfBNLGtwzcQMHA4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Wsur/u8Rh0VXvQ6/SAcqQA2T7B7aLhBrO4nk04Fo+X4RtjKKNFX7P9yYCc7lj8VW
	 0qZaX0P2gG5+v+nrHEzHTGA0MNg8+wTKxmcrJqie/n7T51P9L3uod58A+NB/OJqvj
	 zZOoJj7MP3gpkJYJ7JlTfvE/4rCE2/SQG3ZY+U7jaGSfZYDUoSxlxli3/UB2sIsyT
	 xlp28NM7BuKH7O1NIFj6vPOdaT6Akc63Gupj/6iAp+4gTD+a9HDtpRtCogvQun21+
	 44njHcB0DWmQc5TCznk438a1QXFHiKnmbCqk7UU+BSM9dYsKZDI/umm9tufxOt6uI
	 eq5P+JtbdTSTcjhmIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1rQyYr2qLp-002bfq; Sat, 13
 Jan 2024 04:17:29 +0100
Message-ID: <7bef3393-a1b4-4a18-98cb-508cfb1ca6ee@gmx.com>
Date: Sat, 13 Jan 2024 13:47:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <20240110170941.GA31555@twin.jikos.cz>
 <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
 <20240112155806.GS31555@twin.jikos.cz>
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
In-Reply-To: <20240112155806.GS31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vhn8vM/8xFZI8p5bacChAX46OayDDyY/Bx/NRK5QYyZoBn+rqnz
 jtPjNUAVi5avHGWtjCKO+PLQAdrAdzgmMnYkzYWGJffEc7C50sCYMwJ8dZ9KX0Le8EbN88C
 tsq7tUCbA+H2D3QhEpjIYuif6LzOOTjAmphkwbzCx7jUUzVoQY5YzR0RoG6OoVu71rMHa9P
 cMl2uz17bYK21BDNl7cXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/FiA4Iauo2E=;kwPWkuIls+KJ1wmyhD9CK8FjCvb
 fvTFX1sH3dWUG0g9LZT0L29U0l1gKLiwjSBKGv8KobucFW4dlglYKoNbuxRm7jTtKiSXPROnc
 ujbjTKAooZ1JEEUvT7Nj9P2QLjo9NfIMbGEp0ssHZNSlogDEiS4WRJv7V6TS3s+TheKqouYK5
 1KmIzn8o+9QFYiS6fqIJKUaUiaGCeB7xjYY8Dz3fegdrV/sP2IHQXbCAZPUDZFYg8thP+1Z7a
 98XLpcOsm2ERChC0eBIgS5Msn4tIc6IZCg4v+tXJUHUxjrXvwCTTEK8rBf8vV7zf5C0ku+JHx
 4bG2sJxc4MuUE+wnkvEr7r5OAOGlEMj4zJlgllso82GE8gdhRD+4SzuZpIVrGQE76vVkQr26k
 xd+pu+A3KhrQa4sORI5QbBSEqKXBdXuHo63onVp3glXD+NNSp41aaQAJGcFkElQrFzXQni49B
 P2/fjKBVKVpdISyTCJuQTL1YwgBTyOGbHsbOxsqrHS5V5dFYg1ZDDi+AWyNQjx1LOsPINkaH5
 4Xpd9BR+Bg1QzonHGYS932GJGUUwhUNjCyqnVwZYxMS0BTlsSFPdHSloL+Ih9q8kW4e6wwb+N
 SynEnF6an7QWRrn5LG2T+tC44EWyoy8J5GMUUi/gpoTX7V36V7Ii2SbG0cnmI2aEhWQLwsXGA
 eijbfnEwbpU1/Lzj41SoH8USloWzTQP+wPmsRacyW/Q+21R/Gdvhx7aEhzUvRq3B7mdmJ/JeK
 1iXc1uBdAe0Qt1pFa7RSOV1zySCrfIrprj0Y0cR1YgdpDMv6AlKDf2hq7ywAaQ9k9Wv79AJxP
 NG7TZueo7MGls5Y9IP6sbM64hbjjcG/9iIKIpvr3V5KWiCV7MUc5eWHxJq6OMKuVCviO+kAMs
 EiyGHPEw4VznFUaR6voxyYs6x4qj4mOlLEkhq9L/bm9tW8JyWjoj244DGpS28KC03oKHuzsR6
 07bIj9plcDU3gljGLQsH4Y++cz8=



On 2024/1/13 02:28, David Sterba wrote:
> On Thu, Jan 11, 2024 at 04:54:47PM +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/1/11 03:39, David Sterba wrote:
>>> On Fri, Jan 05, 2024 at 06:03:40PM +1030, Qu Wenruo wrote:
>>>> [BUG]
>>>> The following script can lead to a very under utilized extent and we
>>>> have no way to use defrag to properly reclaim its wasted space:
>>>>
>>>>     # mkfs.btrfs -f $dev
>>>>     # mount $dev $mnt
>>>>     # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
>>>>     # sync
>>>>     # btrfs filesystem defrag $mnt/foobar
>>>>     # sync
>>>
>>> I don't see what's wrong with this example, as Filipe noted there's a
>>> truncate missing, but still this should be explained better.
>>
>> Sorry, the full explanation looks like this:
>>
>> After above truncation, we will got the following file extent layout:
>>
>> 	item 6 key (257 EXTENT_DATA 0) itemoff 15813 itemsize 53
>> 		generation 7 type 1 (regular)
>> 		extent data disk byte 298844160 nr 134217728
>> 		extent data offset 0 nr 4096 ram 134217728
>> 		extent compression 0 (none)
>>
>> That would be the last 4K referring that 128M extent, aka, wasted
>> (128M-4K) bytes, or 99.695% of the extent.
>
> Ok, so it's the known issue.
>
>> Normally we expect defrag to properly re-dirty the extent so that we ca=
n
>> free that 128M extent.
>> But defrag won't touch it at all, mostly due to there is no next extent
>> to merge.
>>
>>> Is this the problem when an overwritten and shared extent is partially
>>> overwritten but still occupying the whole range, aka. bookend extent?
>>> If yes, defrag was never meant to deal with that, though we could use
>>> the interface for that.
>>
>> If we don't go defrag, there is really no good way to do it safely.
>>
>> Sure you can copy the file to another non-btrfs location or dd it.
>> But that's not safe if there is still some process accessing it etc.
>>
>>> As Andrei pointed out, this is more like a garbage collection, get rid
>>> of extent that is partially unreachable. Detecting such extent require=
s
>>> looking for the unreferenced part of the extent while defragmentation
>>> deals with live data. This could be a new ioctl entirely too. But firs=
t
>>> I'd like to know if we're talking about the same thing.
>>
>> Yes, we're talking about the bookend problem.
>> As I would expect defrag to free most, if not all, such bookend extents=
.
>> (And that's exactly what I recommend to the initial report)
>
> Here the defrag can mean two things, the interface (ioctl and command)
> and the implementation. As defrag tries to merge adjacent extents or
> coalesce small extents and move it to a new location, this may not be
> always necessary just to get rid of the unreachable extent parts.

To me, defrag just means re-dirty the file range.
Whether it would result contig extent or lead to more fragments is not
ensured.
(E.g. defrag a fragmented file, but the fs itself is also super
fragmented, or due to very high memory pressure we have to do writeback
very often).

>
>  From the interface side, we can add a mode that does only the garbage
> collection, effectively just looking up the unreachable parts, trimming
> the extents but leaving the live data intact.

Another thing is, the same bookend problem would lead to very different
behavior, based on whether the file extent has an adjacent extent.

To me, the very basic defrag is just re-dirty all extents, no matter
what (and I believe some older fs is doing exactly that?).

It's us doing extra checks to avoid wasting IO on already very good extent=
s.

>
> The modes of operation:
>
> - current defrag, move if filters and conditons allow that
> - defrag + garbage collect extents
> - just garbage collect extents

Thus I don't really think there is any different between garbage
collection or "defrag".

They are the same thing, just re-dirty the file extents.
(And as stated above, if the result would be better is never ensured).

What we really want to do is, just add extra filters to allow end users
to re-dirty the last file extent.

Thanks,
Qu
>
> The third mode is for use case to let it run on the whole filesystem but
> not try to rewrite everything.
>
> I'm not sure how would it affect send/receive, read-only subvolumes
> should not be touched.
>


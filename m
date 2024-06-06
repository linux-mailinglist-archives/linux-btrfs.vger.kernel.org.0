Return-Path: <linux-btrfs+bounces-5517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DF8FF832
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 01:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41944B24C0B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069413DB8A;
	Thu,  6 Jun 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="V+7OkWx5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1E71B5B
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716651; cv=none; b=BU/Ha7I2HGR4FPzwHvohbkQ7LSkrekBSyJsYwG0eaupcxptVjPpzhMTgIu1hCT1OwAb/ZeDjxKjEufdjBiNM/6G2St2k5x06wW5lpNxR/o2UlKsPhesNbN2h9arhCG4jDSpWcBr7usKRT6vckGL+edrqNoGj6H4LVa6qYBq3UXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716651; c=relaxed/simple;
	bh=CLVwy1KjHjmstuHZxxHVoK20Xpy1oONRQrtio48NmPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PtmS+LBba2ZM962VaPuacJkMfZgY3zgDlOyJUQpueOW2/7UGwj56OgZlvCtBHks1drP6Bmfax7SuBMKh04GSzaz6kJxFXnCRYRHiQIN6xOYM6nOL21MUre02Mu2mOpq85q2/y6e3kb9J7sSaCFaxNshjbWCIxsHswVp/PYaGjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=V+7OkWx5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717716646; x=1718321446; i=quwenruo.btrfs@gmx.com;
	bh=CLVwy1KjHjmstuHZxxHVoK20Xpy1oONRQrtio48NmPQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V+7OkWx5Mx1WB3LSyE+LxMSHKBETR1LPEXtEmChWO44OZFD6iiX5y3kYkOKMKYr9
	 axeSmhhVHC2VuwuomVW8/YJxsm5ZaLsfAzk9m2tqk7ySpndRSVzhcOMbnctLSHcks
	 YMRd1mmxnaRPJMDSIDuCdbQRP6YbvjT7uouR5z16ql4+GmcBqkNUwXolXDiu2YSck
	 yRN7ot/kq5BBD6I5xq0IiwQUvZ2cg90sREAmtWle83fYo0oulgm2UhHhaEORZ4DgQ
	 mjXwWnolQ5WHqUmrgE6a63ZM2DtARqFRXf7q4Ki9THWIBUFeFLzCU9jQBdzkS1Km5
	 rHOygMv2G0as+4JQ0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1sAB5s0oUX-005Oo8; Fri, 07
 Jun 2024 01:30:45 +0200
Message-ID: <80456d11-9859-402c-a77c-5c3b98b755a5@gmx.com>
Date: Fri, 7 Jun 2024 09:00:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
To: Lionel Bouton <lionel-subscription@bouton.name>,
 linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
 <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
Content-Language: en-US
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
In-Reply-To: <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s+bEP+lpd4tHvmlmLJ0g03tsZ3e8+Af+DqBMPTDZcPRdeYuQLJZ
 pMs4nu0fxo2LUFQNGASb+8Z04PzF/Yqgi5UJNV0MqAtYrnWBxeFJm1+PuFRkpiWtEhUjG9w
 5SERrYCvPSR8tbz/QoqGHEoo6WZbnO+oWuanNRG0bxIKnTDGhdMu7tEvSHpusJVtq1IGJmI
 1DfhjPcSgfsoYq0xBXWqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OOfpXh7bhUM=;6YJnGr/XFvexIa8OEqoLEXVnGlh
 VZdhqCwAvH95iSMp2lMPQLTHVH1BTwz4HizFk1nVvCY6ixU2JWAZEW2SZq0Ep65EC1JGXx6D+
 +ShyTmIQWi/oABJTEGdUsG3o03giDKfS5lE3PcrEtcXQS0uR2MBcPeNa3Pdx2YVruz7CbFEE8
 PsejtWhEvAfrc+tqSq4mEu8VxOKltGUNK/8NzgvWtJxhbZQBzd/E9rwhJQQDNBhi8yjmAhhYh
 osT4o/b2SAJngtaRCbIzVhTpM9ucT56pKhS6qvvuLyk2J7zxHn26wxv5JNPKfHuQrmUW2uQS0
 HG55Dv6GCDH4dAadpCwi1WyEK24fJFZV7Zd57BLbBPfblwx+7lbN89aNZX++quK4bR2D4FSXe
 eoClyiu0af2KgPVsxyoft6BDgd8GjboCK6WCpCFPpW59AgoWq5/u9tdIwb19aPFNhT+qDs820
 f0GaamcsJFCa7RwkWhOmD2QVSZ74xMET+19E4+tdT0obs8hUDIdd8J9T5tY+dMC0FOUu3eS3C
 E7q3f2ezOBoXg3OuGrxOQ0nzA6iKiEMT6k3xOynaKQIe9Lpftc2EpQxJOwQJuaLT/1pTl1181
 OWftEe3rOYBwZEdNQd7A4WoBPoTJgmZlf0URMQYpJqKxQnJd9c25DZgt/Tc1XhG5VwBPSO4Ic
 AkCgeSBxUY7JIxi3ia4jSvKlEPVnBjKfBY6btCdWiRhFdFQHDGFdjhEwLS7cg+Ghs7iNYYIfi
 K5m9tsOk0oOVFwnIfh/chrPisa0CoSQCK5bF58qtMHBr3c9wSpGKE6g3HHvjILFxosyrYS7/K
 S/YDPK7aDz2eS8kq8vwwZroPC+42MkbLDlRkoKknvScG8=



=E5=9C=A8 2024/6/7 08:51, Lionel Bouton =E5=86=99=E9=81=93:
> Hi,
>
> Le 07/06/2024 =C3=A0 01:05, Qu Wenruo a =C3=A9crit=C2=A0:
>>
>>
>> =E5=9C=A8 2024/6/4 23:42, Lionel Bouton =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> It seems one of our system hit an (harmless ?) bug while scrubbing.
>>>
>>> Kernel: 6.6.30 with Gentoo patches (sys-kernel/gentoo-sources-6.6.30
>>> ebuild).
>>> btrfs-progs: 6.8.1
>>> The system is a VM using QEMU/KVM.
>>> The affected filesystem is directly on top of a single virtio-scsi blo=
ck
>>> device (no partition, no LVM, ...) with a Ceph RBD backend.
>>> Profiles for metadata: dup, data: single.
>>>
>>> The scrub process is ongoing but it logged uncorrectable errors :
>>>
>>> # btrfs scrub status /mnt/store
>>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <our_uuid>
>>> Scrub started:=C2=A0=C2=A0=C2=A0 Mon Jun=C2=A0 3 09:35:28 2024
>>> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ru=
nning
>>> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26:12:07
>>> Time left:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 114:45:38
>>> ETA:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Sun Jun=C2=A0 9 06:33:13 2024
>>> Total to scrub:=C2=A0=C2=A0 18.84TiB
>>> Bytes scrubbed:=C2=A0=C2=A0 3.50TiB=C2=A0 (18.59%)
>>> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 38.92MiB/s
>>> Error summary:=C2=A0=C2=A0=C2=A0 csum=3D61
>>> =C2=A0=C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>> =C2=A0=C2=A0 Uncorrectable:=C2=A0 61
>>> =C2=A0=C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>
>>> According to the logs all errors are linked to a single file (renamed =
to
>>> <file> in the attached log) and happened within a couple of seconds.
>>> Most errors are duplicates as there are many snapshots of the subvolum=
e
>>> it is in. This system is mainly used as a backup server, storing copie=
s
>>> of data for other servers and creating snapshots of them.
>>>
>>> I was about to overwrite the file to correct the problem by fetching i=
t
>>> from its source but I didn't get an error trying to read it (cat <file=
>
>>> =C2=A0> /dev/null)). I used diff and md5sum to double check: the file =
is
>>> fine.
>>>
>>> Result of stat <file> on the subvolume used as base for the snapshots:
>>> =C2=A0=C2=A0 File: <file>
>>> =C2=A0=C2=A0 Size: 1799195=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Blocks: 3520=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO Block: 4096 reg=
ular file
>>> Device: 0,36=C2=A0=C2=A0=C2=A0 Inode: 6676106=C2=A0=C2=A0=C2=A0=C2=A0 =
Links: 1
>>> Access: (0644/-rw-r--r--)=C2=A0 Uid: ( 1000/<uid>)=C2=A0=C2=A0 Gid: ( =
1000/<gid>)
>>> Access: 2018-02-15 05:22:38.506204046 +0100
>>> Modify: 2018-02-15 05:21:35.612914799 +0100
>>> Change: 2018-02-15 05:22:38.506204046 +0100
>>> =C2=A0=C2=A0Birth: 2018-02-15 05:22:38.486203934 +0100
>>>
>>> AFAIK the kernel logged a warning for nearly each snapshot of the same
>>> subvolume (they were all created after the file), the subvolume from
>>> which snapshots are created is root 257 in the logs. What seems
>>> interesting to me and might help diagnose this is the pattern for
>>> offsets in the warnings.
>>> - There are 3 offsets appearing: 20480, 86016, 151552 (exactly 64k
>>> between them).
>>> - Most snapshots seem to report a warning for each of them.
>>
>> This is how btrfs reports a corrupted data sector, it would go through
>> all inodes (including ones in different subvolumes) and report the erro=
r.
>>
>> So it really means if you want to delete the file, you need to remove
>> all the inodes from all different snapshots.
>>
>> So if you got a correct copy matching the csum, you can do a more
>> dangerous but more straight forward way to fix, by directly overwriting
>> the contents on disk.
>
> I briefly considered doing just that... but then I found out that the
> scrub errors were themselves in error and the on disk data was matching
> the checksums. When I tried to read the file not only didn't the
> filesystem report an IO error (if I'm not mistaken it should if the csum
> doesn't match) but the file content matched the original file fetched
> from its source.

Got it, this is really weird now.

What scrub doing is read the data from disk (without bothering page
cache), and verify against checksums.

Would it be possible to run "btrfs check --check-data-csum" on the
unmounted/RO mounted fs?

That would output the error for each corrupted sector (without
ratelimit), so that you can record them all.
And try to do logical-resolve to find each corrupted location?

If btrfs check reports no error, it's 100% sure scrub is to blamce.

If btrfs check reports error, and logical-resolve failed to locate the
file and its position, it means the corruption is in bookend exntets.

If btrfs check reports error and logical-resolve can locate the file and
position, it's a different problem then.

Thanks,
Qu

>
> The stats output show that this file was not modified since its creation
> more than 6 years ago. This is what led me to report a bug in scrub.
>
>
>>
>>> - Some including the original subvolume have only logged 2 warnings an=
d
>>> one (root 151335) logged only one warning.
>>> - All of the snapshots reported a warning for offset 20480.
>>> - When several offsets are logged their order seems random.
>>
>> One problem of scrub is, it may ratelimit the output, thus we can not
>> just rely on dmesg to know the damage.
>
> I wondered about this: I've read other threads where ratelimiting is
> mentioned but I was not sure if it could apply here. Thanks for clarifyi=
ng.
>
>>
>>>
>>> I'm attaching kernel logs beginning with the scrub start and ending wi=
th
>>> the last error. As of now there are no new errors/warnings even though
>>> the scrub is still ongoing, 15 hours after the last error. I didn't
>>> clean the log frombalance logs linked to the same filesystem.
>>>
>>> Side-note for the curious or in the unlikely case it could be linked t=
o
>>> the problem:
>>> Historically this filesystem was mounted with ssd_spread without any
>>> issue (I guess several years ago it made sense to me reading the
>>> documentation and given the IO latencies I saw on the Ceph cluster). A
>>> recent kernel filled the whole available space with nearly empty block
>>> groups which seemed to re-appear each time we mounted with ssd_spread.
>>> We switched to "ssd" since then and there is a mostly daily 90mn balan=
ce
>>> to reach back the previous stateprogressively (this is the reason behi=
nd
>>> the balance related logs). Having some space available for new block
>>> groups seems to be a good idea but additionally as we use Ceph RBD, we
>>> want it to be able to deallocate unused space: having many nearly empt=
y
>>> block groups could waste resources (especially if the used space in
>>> these groups is in <4MB continuous chunks which is the default RBD
>>> object size).
>>>
>>>
>>> More information :
>>> The scrub is run monthly. This is the first time an error was ever
>>> reported. The previous scrub was run successfully at the beginning of
>>> May with a 6.6.13 kernel.
>>>
>>> There is a continuous defragmentation process running (it processes th=
e
>>> whole filesystem slowly ignoring snapshots and defragments file by fil=
e
>>> based on a fragmentation estimation using filefrag -v). All
>>> defragmentations are logged and I can confirm the file for which this
>>> error was reported was not defragmented for at least a year (I checked
>>> because I wanted to rule out a possible race condition between
>>> defragmentation and scrub).
>>
>> I'm wondering if there is any direct IO conflicting with
>> buffered/defrag IO.
>>
>> It's known that conflicting buffered/direct IO can lead to contents
>> change halfway, and lead to btrfs csum mismatch.
>> So far that's the only thing leading to known btrfs csum mismatch I can
>> think of.
>
> But here it seems there isn't an actual mismatch as reading the file is
> possible and gives the data which was written in it 6 years ago. Tthis
> seems an error in scrub (or a neutrino flipping a bit somewhere during
> the scrub). The VM runs on a server with ECC RAM so it is unlikely to be
> a simple bitflip but when everything likely has been ruled out...
>
> Thanks for your feedback,
> Lionel
>
>>
>> But 6.x kernel should all log a warning message for it.
>>
>> Thanks,
>> Qu
>>>
>>> In addition to the above, among the notable IO are :
>>> - a moderately IO intensive PostgreSQL replication subscriber,
>>> - ponctual large synchronisations using Syncthing,
>>> - snapshot creations/removals occur approximately every 80 minutes. Th=
e
>>> last snapshot operation was logged 31 minutes before the errors (remov=
al
>>> occur asynchronously but where was no unusual load at this time that
>>> could point to a particularly long snapshot cleanup process).
>>>
>>> To sum up, there are many processes accessing the filesystem but
>>> historically it saw far higher IO load during scrubs than what was
>>> occurring here.
>>>
>>>
>>> Reproducing this might be difficult: the whole scrub can take a week
>>> depending on load. That said I can easily prepare a kernel and/or new
>>> btrfs-progs binaries to launch scrubs or other non-destructive tasks t=
he
>>> week-end or at the end of the day (UTC+2 timezone).
>>>
>>> Best regards,
>>>
>>> Lionel Bouton
>>
>


Return-Path: <linux-btrfs+bounces-1280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA6825E4D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 06:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774C81C23456
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B733FB;
	Sat,  6 Jan 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N3Wd74Yl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F311FAB
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Jan 2024 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704519626; x=1705124426; i=quwenruo.btrfs@gmx.com;
	bh=Zw+MZJeEfmIg3lDq5Cd7YvUamNPEVv3KRmz6yJKUmgs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=N3Wd74YlbAHQUh2qThd3jZfiplU2SE7GHI5slgletEvvtAuYix3spvn5vlpy/18D
	 +Xf4s2noRFdxJ7KEBwHULIJLo4JyEflz6eUoULHrz5yuYrlmfiSLVuwM9UU5xU7hn
	 dKfl+mgxZ0KAy5Eq+g6MSN/p78wlXwYh+qGAT8ci0ULziZk9odTcYLUf9Uoe7Wme9
	 UdGay7m5B+ds/e/qZkgSMAAHPJIAFoF5xyrU5+NxFz6Kb3+eZgYSPXvv9Bv7mBOw+
	 PJ9IfE59yTurqw+rPS9/jA4MLXnxPiby0N8DE6PYoywS6fIUgH+ACY5JZ/kjuyAOp
	 liXXJ7Jx55muK/iuyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4s4r-1rNuIQ2Sdr-0020OY; Sat, 06
 Jan 2024 06:40:26 +0100
Message-ID: <b849c107-c3d5-4dae-a03f-c7575eee157b@gmx.com>
Date: Sat, 6 Jan 2024 16:10:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
 <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
 <494daef3-c180-4529-befb-325a46a3eeeb@gmx.com>
 <156b27d5ea42ed4afa6d73dec8e2f479d346786d.camel@scientia.org>
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
In-Reply-To: <156b27d5ea42ed4afa6d73dec8e2f479d346786d.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SCbKcDc/mM7NtvnAW6QVQDBmxv3ezRw660pewjVyrts1LCdv4xX
 +8A+guVdymnfEDyPhcKknrLQe/hP0ERU9MTc6tsNQRXxTlPkOg9gKxtkSmj5wkbKXIYalrE
 kYarCXhs2BCs0LvWOqM6Gop1RLpTrS8LX2tOs4JqYdO+SsIAg49p3nS69qU89cKxPcciQV1
 Na3HCUiOx4hcoMjg34C9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MiRznYyHQ9o=;WVTUcG7yITBCkQHo/Y0DAV2b1ig
 pSZCBaTy7ePJzghk//xOw7Gzu8YvM3EZWpjLJFDPMka8LTk/jhBSrRnO3dQqZGLVrEz9sD7YS
 nA/dDFKfijYC3h4hOe0J6Yr4FY9xURDV6XTeWqYeS3aM8rWvXlQ+v8ktvsRJekZAeM8B9K6ZE
 JLNkH4UaZZscqiHp8L0jb0pT5HlU85HlGLgrsGbiLBm3hL18JJyiMCp8yc5Ck4A+Z/6VK4hCY
 X4mo/oSPfjLw/wsyB802gTYpEtYhE2ps+GDwplW3Wz3kcK5Dw+7P9HxLzMKn84oepvqaaXfNG
 qLn95T2wgI9/lVxNuZjXg18o5o6x5qAtJ0oimkodKJnqJBnDQgkiio6aGesmTByX1BU51shvZ
 zMxjxTh+XP1gZvqHI7m7EsUPqle0Mm15KicsSah2ET2wYs54/9fZwDoV8HG1/9NRRaUGH289G
 IcoCRXFfnR+G6kPRU18ED+xGDxH4WNtYuxGc+tyOzUwHFLTqLn5iU9zDV0tmJz6+rJzIu2ND0
 EqLAdx2n+z+CaaDJX5U1tlO2U1xq3B/UeTsawvJH9NvjNpDi5w4wLB+XlbwLw2GsrJHHfdpgJ
 qaV0cSxICc19F595Njphp210d8WM54Soddc4k+YhKCvmOtTc4jWFp3YnqKc8vPDIY6+06ilBD
 AZPg5MvSX608nLHLgMMVOwRyjP9gz+pVwyfwkT7PGPaoQNg2udK1fyZtmIruidP7q6uLkLRI5
 5bCk12BPoo1HuIw13OqApRo0zsOGZn0yDYkoo2cO+5h73Ub3ezNIQzF6Z/F6rr6RQH5jBbtPF
 91q5yLlpvhta70Wk14tW9caARFekKpW/yUngwP7jkiNrEb8/w8v0uODQe7uMEBMsrYKyD6XKO
 9ZbxQmC+2ufEm1OiJVid+aaXKBhL4hBYEAb9cBzYT8X4X7u/8SoTDlYRcq0B/qFqnsM5aBz0v
 6+SClimk3IzDTNV8T56GL6nD2Yo=



On 2024/1/6 11:12, Christoph Anton Mitterer wrote:
> On Fri, 2024-01-05 at 17:37 +1030, Qu Wenruo wrote:
>> but pretty hard to find a
>> good way to improve:
>
> I guess it would not be an alternative to do the work on truncate (i.e.
> check whether a lot is wasted and if so, create a new extent with just
> the right size), because that would need a full re-write of the
> extent... or would it?

I'm not sure if it's a valid idea to do all these on truncation.
It would involve doing all the backref walk to determine if it's needed
to do the COW.

>
> Also, a while ago in one of my mails I saw that:
> $ cat affected-file > new-file
> would also cause new-file to be affected... which I found pretty
> strange.
>
> Any idea why that happens?

Initially I thought that's impossible, until I tired it:

mkfs.btrfs -f $dev1
mount $dev1 $mnt
xfs_io -f -c "pwrite 0 128m" $mnt/file
sync
truncate -s 4k $mnt/file
sync
cat $mnt/file > $mnt/new
sync

Then dump tree indeed show the new file is sharing the same large extent:


         item 6 key (257 INODE_ITEM 0) itemoff 15817 itemsize 160
                 generation 7 transid 8 size 4096 nbytes 4096
                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                 sequence 32770 flags 0x0(none)
         item 7 key (257 INODE_REF 256) itemoff 15803 itemsize 14
                 index 2 namelen 4 name: file
         item 8 key (257 EXTENT_DATA 0) itemoff 15750 itemsize 53
                 generation 7 type 1 (regular)
                 extent data disk byte 298844160 nr 134217728 <<<
                 extent data offset 0 nr 4096 ram 134217728
                 extent compression 0 (none)
         item 9 key (258 INODE_ITEM 0) itemoff 15590 itemsize 160
                 generation 9 transid 9 size 4096 nbytes 4096
                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
                 sequence 1 flags 0x0(none)
         item 10 key (258 INODE_REF 256) itemoff 15577 itemsize 13
                 index 3 namelen 3 name: new
         item 11 key (258 EXTENT_DATA 0) itemoff 15524 itemsize 53
                 generation 7 type 1 (regular)
                 extent data disk byte 298844160 nr 134217728 <<<
                 extent data offset 0 nr 4096 ram 134217728
                 extent compression 0 (none)

My guess is bash is doing something weird thus making the whole cat +
redirection into reflink.

But at least dd works as expected by creating a new extent.

>
>
>
>> My previous guess is totally wrong, it has nothing to do with
>> NODATACOW/PREALLOC flags at all.
>>
>> It's a defrag only problem.
>
> Sure, but I meant, if a file is NODATACOW and would be prealloced to a
> large size and then truncated - would it also loose the extra space?

That would be the same.

>
>
> And do you think that other CoW fs would be affected, too? IIRC XFS is
> also about to get CoW features... so may it's simply an IO pattern that
> developers need to avoid with modern filesystems.

Not sure, maybe XFS would do extra extent split to solve the problem.

Thanks,
Qu

>
>
> Cheers,
> Chris-
>


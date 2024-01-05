Return-Path: <linux-btrfs+bounces-1261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC377824D69
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 04:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5688C286B92
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6746B8;
	Fri,  5 Jan 2024 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="T6/+f2k9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24EB4403
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704425126; x=1705029926; i=quwenruo.btrfs@gmx.com;
	bh=HGanREAfgHaSmI3yJG1MGIoL1AeP8ED4VEe7LFmMgqY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=T6/+f2k9HAHNG/HVIW5CmDei4dkOP1IqbzYHzPB9f8cRiu12HaTnUopqgNJK08t0
	 WhyoBSQjQI3kOjnbF4kNr/4UOpf+b0aqoaSNgGb3J9q576zgEixFA9eamSBX+Ezeh
	 zUVJzPSDdSDRlrSkGkQXBVgwoU2GAtwWNCnQON8VYy5tZOpXi9tBnvdAIDoPDD/Pg
	 rEz35vJ6tOPgh4qXrJKKNpVsHWvlAzfJOGTnVqY18U6tBIPfL5t3pfwJ1QaMPFZVD
	 IeyUQm8Lgb1/VGGD6bkIz7taSXPY8q8jl4ReM2P/n+1LUd2g64nLZxbkd7FhfXt8r
	 VhKkxNbQTjUsbPkv7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9G2-1qpDxD0xuw-00oBRg; Fri, 05
 Jan 2024 04:25:26 +0100
Message-ID: <42f58177-01b0-4553-9c45-24c1be019c7f@gmx.com>
Date: Fri, 5 Jan 2024 13:55:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS Broken, Help
Content-Language: en-US
To: Isaac Chang <isaacchang673@gmail.com>, MatthewWarren101010@gmail.com
Cc: linux-btrfs@vger.kernel.org
References: <CAO0vF5EHAiLsVvi=tvERS4gS+AeGSDWHmZxcf-mBQtDaQ+UDBg@mail.gmail.com>
 <008c8c46-3940-4635-9a6a-155ad4c5370d@gmx.com>
 <CAO0vF5FMbZt8tXrFB3KLVhpCnPjkV4_v6Ro7=N5Tj1fNYybeNQ@mail.gmail.com>
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
In-Reply-To: <CAO0vF5FMbZt8tXrFB3KLVhpCnPjkV4_v6Ro7=N5Tj1fNYybeNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XvYPItCrmUGzvqF4CKafST+i1ZCUWPppCRqdzgd+YPfzsLMFsf+
 olwJyzuSNJz3RG++kLmSCdPd8o9zxRE87AmduzlvjoHT4HnuF7HMzLHXI+pK2eOIOHF5vNC
 lKXl90gWil/vqp7GFDQarFBaEw+RIX3OtL6tum828ZBCb56n9yjc6OTH5ETN146xd5nZRwM
 o7uGMxg61ik+lV6XZ7OhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:foILNxcniUI=;X41jbaJO098mAX0FIbgycmBnSWJ
 wMzr8cgkX1M2fLJTLfAAzT7BHoQJIyoo5JH7VnkcPbA6lvUt77lgaOMw5DcsHXe2eakKSsgPX
 wcax9tO/emCFE39UGX0tcNlAs36UiS1ZTR6hSIHrjBVfeyZFs4DhW6Ctpbyi01rGNQbyXf3OH
 Iz3VA/MC/9gl4zWKJxWyxhJmvKYa1+maGxxmby/eVHFKXhrRC5vODnh7513lIu3ywfyb6bTku
 OBMxO3qmNY5fBeu2U/ZPguk0ErinRe9uKlIADoK6N69ygVvqnDaXQhzaWGGvhp+zcGXEQS6YS
 3N2IgX1sfFPCvl90dPQulz00MoFUG3hY8GkDSVadOiEpIQIuC7mbnUNNreSrIH8/s3DkhBpmd
 OszYZAwReIf3xiwGkLtBa7yh4h86YKiiXJ1i65NFQCW0gqwrtWFITtTzW3idukTvlAhXFO90x
 Uw0s3jA1yAp1OUFocgfEWY7wuZhWDuJxkBKNCOpVIpys6RzQM3fMbrvGMrKLBDAqORYrm+Nq0
 QHp5cdG57z7i8Xawtb7eXT8D8DwroKD92KoRVKoeCrkERC3lZ+UpY2BBjBhMXUhKZd+swco8Y
 f4vgmIWIh9aVvS+UV57hyDtIw48q21XRzGPiSUomR6iFvBVJUqQsIAKw1MUr8ORQ7QsVJap0a
 oh7mN04cu+7us85anFM8RWAQvDv8zP2ah4vZTmgagiMRg/zL0arFMnyeSyLF1YCOWg0/80+x3
 0IB65eZ+/h8q/xDdUWEw7cmmNSnHKZvpzK9sBOAxjPkRhXMWYgmusxIgdMaRKwKtBBNebx3QB
 Gc3eaG3CFzeyJ8TGfIKcsBU73NyFDJ8lY8uGkrRMaXGchFC/ZIuNO+GjQ0HQIPxc/ULp2EiDz
 cDqi0Lc9Qv9p7/fqyEnk67b6F2wGHD3/nPZrTUsUiII197NQTHThzlE7notYWBBhg9zg2Q2lQ
 rHqhBXXxxbwj/SRiN5rZW3/SRiw=



On 2024/1/5 13:07, Isaac Chang wrote:
> Thanks for your reply and help. Very appreciated.
>
> I ended up running some BTRFS rescue commands on the missing drive which
> brought it up and fixed the I/O issue. I was then able to mount both
> drives as a single pool.
>
> Still was unable to copy the full integrity of the files.
> So I gave up on trying and went nuclear with the BTRFS check=C2=A0 -repa=
ir
> command.=C2=A0 This ended up fixing the fs in a matter of seconds. Data
> integrity seems good.

Strongly not recommended.

At least you may want a "btrfs check --readonly" after the repair, to
make sure every metadata is fine.

Then mount it, and run a full scrub to check/repair whatever is affected.

Thanks,
Qu
>
> So far I'm back and running.
>
> Thanks=C2=A0again for your help,
> Happy New=C2=A0Year!
>
>
> On Thu, Jan 4, 2024, 9:32=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     On 2024/1/5 02:14, Isaac Chang wrote:
>      > My Server blipped and upon reboot, the=C2=A0Cache Drives (pool of=
 2
>     devices
>      > RAID 0) are now unmountable. I can mount the lead disk in CLI and
>     peruse
>      > the files but if I use MV or CP or rsync, I get Input/Output erro=
rs.
>      > BTRFS restore also yields Input/Output errors.
>      > Using the instructions here as this is an UNRAID server:
>      >
>     https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/#comm=
ent-543490 <https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2=
/#comment-543490> <https://forums.unraid.net/topic/46802-faq-for-unraid-v6=
/page/2/#comment-543490 <https://forums.unraid.net/topic/46802-faq-for-unr=
aid-v6/page/2/#comment-543490>>
>      >
>      >=C2=A0 =C2=A0root@Tower:/# uname -a
>      > Linux Tower 6.1.64-Unraid #1 SMP PREEMPT_DYNAMIC Wed Nov 29
>     12:48:16 PST
>      > 2023 x86_64 Intel(R) Xeon(R) CPU =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 L5638 =C2=A0@ 2.00GHz
>     GenuineIntel
>      > GNU/Linux
>      > root@Tower:/# btrfs --version
>      > btrfs-progs v6.3.3
>      > root@Tower:/# btrfs fi df /temp
>      > Data, RAID0: total=3D887.40GiB, used=3D606.95GiB
>      > System, RAID1: total=3D32.00MiB, used=3D96.00KiB
>      > Metadata, RAID1: total=3D3.00GiB, used=3D1.05GiB
>      > GlobalReserve, single: total=3D117.83MiB, used=3D0.00B
>      > root@Tower:/# btrfs fi show
>      > Label: none =C2=A0uuid: 15b03357-29bc-43b0-bfbb-b306a3611d8f
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 4=
08.00KiB
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 1.00G=
iB used 126.38MiB path /dev/loop2
>      >
>      > Label: none =C2=A0uuid: b53ef962-5a9b-4c35-98a3-33ff77ebaac5
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 2 FS bytes used 6=
08.00GiB
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 465.7=
6GiB used 446.73GiB path /dev/sdg1
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A02 size 0 use=
d 0 path =C2=A0MISSING
>
>     One of your disk is missing.
>
>     In fact that disk (ata5) is dead:
>
>     [ 7517.440956] ata5.00: exception Emask 0x0 SAct 0x40000fff SErr 0x0
>     action 0x0
>     [ 7517.440967] ata5.00: irq_stat 0x40000001
>     [ 7517.440972] ata5.00: failed command: READ FPDMA QUEUED
>     [ 7517.440975] ata5.00: cmd 60/08:00:50:3f:61/04:00:38:00:00/40 tag =
0
>     ncq dma 528384 in
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0res 41/04:b8:f9:3d:61/00:01:38:00:00/00 Emask
>     0x1 (device error)
>     [ 7517.440985] ata5.00: status: { DRDY ERR }
>     [ 7517.440988] ata5.00: error: { ABRT }
>
>     Which failed to do a basic read.
>
>     You can try mount with "ro,rescue=3Dall,degraded" to salvage whateve=
r you
>     still have.
>
>     Thanks,
>     Qu
>      >
>      > ERROR: superblock checksum mismatch
>      > ERROR: cannot scan /dev/sdf1: Input/output error
>      >
>      >
>      > Attached is the dmesg output.
>      > Please let me know what I can do.
>      >
>      > Thank you!
>      >
>      > Isaac Chang
>


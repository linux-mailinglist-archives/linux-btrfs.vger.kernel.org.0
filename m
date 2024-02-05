Return-Path: <linux-btrfs+bounces-2096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42284934C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 06:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000781C22570
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 05:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B0B664;
	Mon,  5 Feb 2024 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gMb8if9Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3525B653
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110574; cv=none; b=JO5O1hpgO0Qa6gs+wK+McYBoDioO2YRGaav0Us9P7FZqc7/lP7QIBlkVYpGfkGhSupvJSrmWvCUod5dJE68b6+E/Vh9rbtkpJu+tH68huvr9sLpIVxD0cDjWKx+rkyHtLji1zggckCTSwOVdW0mJU7qiK6CWGAeNvKhA+xRja5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110574; c=relaxed/simple;
	bh=nfpjI4roXgB/ZF05wugRv0966xUfjQoiqzMeGj0HhAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTBLnxI+XEX6KXJiUXAxPmTyN1PcnQRQc/BEHdelq67I4JC/IewT/0RdcIyuR1/ZtSzUvAc8c1nKH4DB0j90H/skz7oxtDniKkG2ApsO+LaURNpZWabZ2G5iebDyCrEvriK5KuZ7t0/bsy+aJp6k9XzEpSlNEOiCQ1PqLpOkEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gMb8if9Q; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707110565; x=1707715365; i=quwenruo.btrfs@gmx.com;
	bh=nfpjI4roXgB/ZF05wugRv0966xUfjQoiqzMeGj0HhAM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=gMb8if9QUvc5zKzJceSjVh0xx9kg87SEuWz157VVOs8xY5Tt8UEnqrmxdU98Gy/7
	 /ea87wzGM9E6/qXdTxGYumrjeTk6fR9td0Jdj4GxPp2vRTzV6cwjn1MHaBR88/rlW
	 aZuIK3BfMp064d0FM7mFaOjPwKKEDyfYtPtrHKiYDd8ucJ5vK/IpDHEfwRqrroi5R
	 s816LJSI51jP+d5KRfMmRyK8Xi8l7MlwjWj7GfWOkGc5813Aiu4tMKBypLhKzpCMA
	 1QHhHGMI6REKG9fSNBF6ibTFXrMfiuMHPOPPRLRsU7vuu4j4GghXsWqthu1jO3v4i
	 sLdNfGvvWqLi8DdN9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoN2-1rlfHO3BLC-00Evxo; Mon, 05
 Feb 2024 06:22:45 +0100
Message-ID: <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
Date: Mon, 5 Feb 2024 15:52:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Language: en-US
To: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
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
In-Reply-To: <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TWa5nXu6WXkYWrQ9HJSnA49/OMCQk6ClaUAHnX8dyruoF8w0QeV
 kwiS0UBJI5hz4LAzSsrf3B4HgxWu1GkHawTTHrvbqcn45dL7KoofaWh9xej75CsQXQb7NLc
 0/vLe63d0MOa4KDIKuAe6+3Kf6n+uETxlF6Z14vLatDvcDxzyuCbJeWdsfakCqfOJrARUEi
 2YVayVWRKFkrRIVk7Hdmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MUA5Pwcpwc0=;UVMmh9kIkH1wPM8lPJjIASAE/RX
 h3r4Y6E/ydqUopkVFg9gmALiQdNVWHsZ4p3dYVTOveU2WBTWhHxAskHNHMGzKhUo1sKJTytgX
 8diuPO/okuuaDF8VzqEnCfBqlxKLv4duroxUj3iV0NAHdo+hWuSFhAbL7GFRX9vwj2Sk3579q
 Neu5vElZPL3ljtgGoBhdGsuX2ZY5GAzMbRZOnRSTY8HRHBhFV9C+Z1B3cYcpUV5KiULalYDJ1
 CQpshrSfxzhZyWt16/9X4+0WJdQNAeniZTM4c9b+BPoHzpSR8Hiau3DTI9aearUgQ5mddDvoU
 JSdRnT6IZ9HQF9o/jt6EnIKv0Evvppi21TqHstpPaMhDCythG2lcgHFJ/Irj7XIYwYIZBQP79
 BUjnqm/DV37hLRl1qmPHlDNk+dhb1jdl3Il8Nl0+yYpZD4+j9uWV7cYpiUc5H8A/UOaN6ojhQ
 TcSIMszycnVuQwNZxBTcE3Ej/G9fv+vQyQE2SfKSgmi3GeEK9Hlrq/ubLQhvG5c2tQ1QMegwe
 vq8XmCMVMTSaJcemcfnkxbwoxdBXf7vboRAUrzRGe/QfOPWmH0G0tVKvWuhD3YVRrmf1sFxS3
 KSs9K1otOdg+On/Fge8GmVGEYGOnMpe5OkzddkOfZCNFyCCM5DLm9i76iOGZLwlG1MXe3Hljo
 0H26m3RfoaWXbh40Hj+JRu4GGb5pBq+XuyYLh+JyIzTQoYXAn43E9jCBN7NHFTXX+MZzOM2lZ
 oGOrfVmmU7knFPKvrQSusJ4MRcgxkKQj5O0LPO5/mH+x5VaM9likhtwkO7KCExz7sR7B6hq0A
 SsWgF7gzsMH7+PCMV0eTq4GxzfmUDmr6FAbNI2N99RvO4=



On 2024/2/4 20:04, =E9=9F=A9=E4=BA=8E=E6=83=9F wrote:
>  > ie. mkfs.btrfs --sectorsize 16k. it works! I can sync without any
> problem now. I will continue to monitor if any issues occurred. seems
> like I can only use these disks on my loongson machine for a while.

Any clue how can I purchase such disks?
And what's the interface? (NVME? SATA? U2?)

I can go try qemu zoned nvme on my aarch64 host, but so far the SoC is
offline (won't be online until this weekend).

And have you tried emulated zoned device (no matter if it's qemu zoned
emulation or nbd or whatever) with 4K sectorsize?


So far we don't have good enough coverage with zoned on subpage, I have
the physical hardware of aarch64 (and VMs with different page size), but
I don't have any zoned devices.

If you can provide some help, it would super great.

>
> Is there any progress or proposed patch for subpage layer fix?
>
> =E5=9C=A8 2024/2/4 6:15, David Sterba =E5=86=99=E9=81=93:
>> On Sat, Feb 03, 2024 at 06:18:09PM +0800, =E9=9F=A9=E4=BA=8E=E6=83=9F w=
rote:
>>> When mkfs, I intentionally used "-s 4k" for better compatibility.
>>> And /sys/fs/btrfs/features/supported_sectorsizes is 4096 16384, which
>>> should be ok.
>>>
>>> btrfs-progs is 6.6.2-1, is this related?
>> No, this is something in kernel. You could test if same page and sector
>> size works, ie. mkfs.btrfs --sectorsize 16k. This avoids using the
>> subpage layer that transalates the 4k sectors <-> 16k pages. This has
>> the known interoperability issues with different page and sector sizes
>> but if it does not affect you, you can use it.
>>

Another thing is, I don't know how the loongson kernel dump works, but
can you provide the faddr2line output for
"btrfs_finish_ordered_extent+0x24"?

It looks like ordered->inode is not properly initialized but I'm not
100% sure.

Thanks,
Qu


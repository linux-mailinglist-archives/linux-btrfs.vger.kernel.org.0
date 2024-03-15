Return-Path: <linux-btrfs+bounces-3328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA487D4A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 20:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BD2284E29
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F952F99;
	Fri, 15 Mar 2024 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZTyM8rho"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E691436B15
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532332; cv=none; b=s1eZG5zuQZKcwCowVx+E4M+HlLwZR+MOwRYOQ6zbeD9lWkpTyeNnZhBinq9mvAlFGlKQn51oJYxrTawRWAQDefMqDeYw02sX9ElhJV4cEgcm0ffkrtMhVccGNkEiMGrTIQQwPUtLDX9ZzdRlj5sVa9w+fYp14ax/WLdzX3QO3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532332; c=relaxed/simple;
	bh=2j/lTgt6Gep5fD2dk1SUtA9mFhfPQ62Y3Wk8gQNIjZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5To6a6rJLvXMszPf2tReO32be9cZOwErTCxVfRAf7w8GWv9kyNMgW8Ts03pO5ruveciowKru9ZI4i8vz65KrAkjb+l5olnbcPASMaotbxkzCvHM8qSIYHpoe5lG5BecSacrmA3GBEGS6tkBoKEaNPtszDFEJ7aisVBQPAu0Row=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZTyM8rho; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710532321; x=1711137121; i=quwenruo.btrfs@gmx.com;
	bh=/NGDhoWcp/WV50RaRZZ1h4/QKWv8pQcr6tg+UZ826Gk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ZTyM8rhocSGoc9LRNh0PZqmXjwCfaTgZXrtOSeW1gLPeICx6HUb97RpY9SfZzitP
	 ot7n0LgehLvUb/KwU8KrgDhIjFE74dy5H2+AdBCpkpHLjqhpytO5mq46QE/fukB4G
	 Fkz+liE+mGoumFPzeunBPaBmboBz2zIxcgPqaOvqmaENqaOQmaLoz5HEoqAG93G2M
	 2jZbUF2uP8dO/dQYDQVvaDyqwRKIPcT742KP659UcvqvzbcyDUVUSR9WcH2DT1j2B
	 uVElnHVGVS2QSZtkxTWXaoZPVgaiZ57iXt24aYj5B0O7thUknOOTgx2oWGgER13q6
	 3tQaTHGLHfjNX5J6Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmKX-1rWAki0zov-00K7zB; Fri, 15
 Mar 2024 20:52:01 +0100
Message-ID: <49c7a4c8-852c-4b9c-ba57-938a097aaa6a@gmx.com>
Date: Sat, 16 Mar 2024 06:21:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About the weird tree block corruption
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com>
 <CABg4E-nKSZR4kvAGfxKLwAoH1_fJXwQb91spFAMsU9L1vqEpiA@mail.gmail.com>
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
In-Reply-To: <CABg4E-nKSZR4kvAGfxKLwAoH1_fJXwQb91spFAMsU9L1vqEpiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QdkgIfmwOn/Q3oLkOQaEha/7ZnrH1b1aQpdux66Gxa2wvS008p5
 /B6PmEcTDBYPRqrsWZpw9blhfDeJbznlwEzRtAiDpT3Zuzu1PTWTiPOCZb5hvuXDcjQLtd6
 hoGWfSi+1tForuBFtExeemnyjqdca4H5daq3DQb+dJwuBPcu73THDX78Lhxc2+L7TEil68N
 Z1u/Q+kLritChilAzRt+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iidbhNrW0Uo=;OwIz1/QvlsymZSjB2obRewxRQMB
 1NLXr06IN2j8lWpeIDeuNeetwIyRqZemfFxug0Z7/kUlzQBr6KhoIVmTYiW/N9QCyY/LdWUkD
 Y2thmZjDlw6bR6rtGLa3ETqwFqqwdeSNu4rR3OPRPj9fn/sVeIqCR+pQ4Hl0F6TXZry/5YJM8
 +wrECuLTyVeiOMv/DvOZmVa5gNZnoqOu706DqBej6hQUBLA4PPI2LCQRd1nB4LwxFQqRoaaur
 WDyt6wXRFALumUhGBQL3AW14mdNp2PCYzFZmzWwfTtaBZB+jEIZABvOPwmlPFqT3XZcmWuTbC
 IFn18Rt5MalGfaHm1putxlBVdWJ22ufC+nLDLzM8vSzwffixmVQd7AuRhNTQu65+n2awRbzZw
 yQ2csH2EiqAOZCqnxRS5igEf3Fg/BImG+geMsGQfC2IN3uTEIIUNriTrUflAcC1O9iAoh76+3
 U99xPFP8A1Pvlz7M/ufVHdsiJZhCUbuejgl5e4SzWrh8+OxzAGlHLWzvq1M4V0eKVw31x9/TO
 3jtiwFEZ1vvj4J+Qpd0a5H0vRSbp2TnXsG/JmD6cqzcy7DvEZLufjOYoHXT9b3PXDykaWJlqP
 rM31vdNSWH12gwW83gaFFACPKxnpoPnvEF7VCQ2j+vII6yu/I/UPyoA44+9X+BKGxYoGLBgtu
 XCoWHUJ7MWfnC2bwmTNuPr8Ng1R6TvZK/jB6UZHEL7/53DQgmDA6EmW41Ej7cSzYMaiF/F5LU
 3pRMHmyK9cfcpyWZSYT4waa6Yv6H4gd2FgZ+5mnRBwcghvo5Vqmr33c1bx9Op0FEhSxXuqVhL
 odIXqZutzd6Larrkkhe9D8GeBPgNPp/4xG1xo6wgpkO0c=



=E5=9C=A8 2024/3/16 01:53, Tavian Barnes =E5=86=99=E9=81=93:
> On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>> [SNIP]
>>
>> The second patch is to making tree-checker to BUG_ON() when something
>> went wrong.
>> This patch should only be applied if you can reliably reproduce it
>> inside a VM.
>
> Okay, I have finally reproduced this in a VM.  I had to add this hunk
> to your patch 0002 in order to trigger the BUG_ON:
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index c8fbcae4e88e..4ee7a717642a 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -2047,6 +2051,7 @@ int btrfs_check_eb_owner(const struct
> extent_buffer *eb, u64 root_owner)
>                                  btrfs_header_level(eb) =3D=3D 0 ? "leaf=
" : "node",
>                                  root_owner, btrfs_header_bytenr(eb), eb=
_owner,
>                                  root_owner);
> +                       BUG_ON(1);
>                          return -EUCLEAN;
>                  }
>                  return 0;
> @@ -2062,6 +2067,7 @@ int btrfs_check_eb_owner(const struct
> extent_buffer *eb, u64 root_owner)
>                          btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "nod=
e",
>                          root_owner, btrfs_header_bytenr(eb), eb_owner,
>                          BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJE=
CTID);
> +               BUG_ON(1);
>                  return -EUCLEAN;
>          }
>          return 0;
>
>> When using the 2nd patch, it's strongly recommended to enable the
>> following sysctl:
>>
>>    kernel.ftrace_dump_on_oops =3D 1
>>    kernel.panic =3D 5
>>    kernel.panic_on_oops =3D 1
>
> I also set kernel.oops_all_cpu_backtrace =3D 1, and ran with nowatchdog,
> otherwise I got watchdog backtraces (due to slow console) interspersed
> with the traces which was hard to read.

oops_all_cpu_backtrace looks a little overkilled, and it seems to flood
the output.

>
>> And you need a way to reliably access the VM (either netconsole or a
>> serial console setup).
>> In that case, you would got all the ftrace buffer to be dumped into the
>> netconsole/serial console.
>>
>> This has the extra benefit of reducing the noise. But really needs a
>> reliable VM setup and can be a little tricky to setup.
>
> I got this to work, the console logs are attached.  I added
>
>      echo 1 > $tracefs/buffer_size_kb
>
> otherwise it tried to dump 48MiB over the serial console which I
> didn't have the patience for.  Hopefully that's a big enough buffer, I
> can re-run it if you need more logs.

That's totally fine, and that's exactly what I do during debugging.

>
>> Feel free to ask for any extra help to setup the environment, as you're
>> our last hope to properly pin down the bug.
>
> Hopefully this trace helps you debug this.  Let me know whenever you
> have something else for me to test.

The btrfs_crit() line is using btrfs_header_bytenr(), which can be
corrupted.

So it's much better to add extra trace_printk() to print eb->start so
that we can match the output.

But there is some interesting output, the trace_printk() in
btrfs_release_extent_buffer_pages() are already showing the page refs is
already 0, and its contents is already incorrect.

It may be a clue, but without the proper matching trace, it's still hard
to say.

I'm afraid you will need to add the extra trace_printk() lines, much
like this to all the return -EUCLEAN locations:

	trace_printk("eb=3D%llu\n", eb->start);

>
> I can also try to send you the VM, but I'm not sure how to package it
> up exactly.  It has two (emulated) NVMEs with LUKS and BTRFS raid0 on
> top.
>

Just send me the rootfs qcow2 would be more than enough.
I can setup LUKS and btrfs all by myself here.

Thanks,
Qu


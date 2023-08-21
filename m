Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1B7820FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 02:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjHUAq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Aug 2023 20:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHUAq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Aug 2023 20:46:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A2A3
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692578781; x=1693183581; i=quwenruo.btrfs@gmx.com;
 bh=DdUg8h2rMWDtKk9sUN6EBk0sX9Cnp3QXb4qRhGMMp4s=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=rbSdwRcQC/ymxhTfIObA6l+ZWGBmEIMG1B1FhZBWEmudoLcxtiLLmmP96tGjvK9bjPSxei9
 Z1h+1Zkgm1L5s9bbIGYEUr+bEzUbxhQuBe32LwyT+TqQPfyqtb1bzYC3MyWvN09dp8eidCUcI
 r137KNGfHqRiyqso2FA22a6bEbTXPWA9Uw0Qeq0vpL6LYT5EYPoDzbpwAC/M8dYV4dmhg/95E
 WNWsLIb1YH6mTbPzx4z4g6XIh2M2Z/5B1HZLeMXvcBPAwCcShMTSXli1ahV9qjn2euCp4PTTL
 ox2OHKcBP5NSOjan78bwpRLAWzxxAFDGPl+57O7u8C+iPE9ad1nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1pYjtq2L2c-011VEj; Mon, 21
 Aug 2023 02:46:21 +0200
Message-ID: <b3fce2d5-c589-4356-80a5-4d973b63ae28@gmx.com>
Date:   Mon, 21 Aug 2023 08:46:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check Causes File Corruption
Content-Language: en-US
To:     "Longhao.Chen" <Longhao.Chen@outlook.com>,
        linux-btrfs@vger.kernel.org
References: <OSZP286MB1533FD75E8CD5AE3D1CBEF1C9E19A@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <OSZP286MB1533FD75E8CD5AE3D1CBEF1C9E19A@OSZP286MB1533.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1laHnu37EukHmECIRi40O4JCc0tfYkH5p93ZaZd/IaCXzqqh9PE
 nwZp/HNZsftCl41EPYKIohFfMKZRWxwpryDeEMh2z9HzNBqk7Bz+fdlEhGNqE6T5mLpKU9u
 57KiMa9y/vhvKwBrw1DpGmUsPAQTzXAiZPtWGBcj6GcFYD6cmATa3M6YM58iiBXn2JihZy2
 YBVGooMmJYlw/H7he9i7g==
UI-OutboundReport: notjunk:1;M01:P0:16sgfPQweuc=;Lj5i62BpH8AKG2vSXZSQli4pdxo
 Yk83VfFLQzMUusBuMqvWivhV7h9jWYqp0LpY/X+WpOkTMmSzGvSZqX2zDB54jsPZBipkBfERW
 vgYrnIhGctQ/s2sm9ZXZ/uAYFPnlMjtMiKnrzukg29EGsv8OJtgYWIC9yyJbj3Bg0Pxga4nKM
 3vOiq1HVhd4hOW+19zja+cuvCB4TRRxja0Nr0W502paZ4z8K9aR6migVfYrvWkABRHBdlT8UH
 gpzeEJjEm/oFj1HDg/qvJf1Qpz6b1hkqR2fwjx4mb9EIoYA1BgY6rIqsuMA8lXFO4sfWwS8g2
 FS9NnmQXEmpp4sEcctrLvTjm7h3ygRGwe7AwGZBorl+/7+Jkl/7IlEvJG8FqCDVla3GnXCaM7
 W0rfXdgzovQUwFCqsgUhXjlNfb28z+SGjkbBQX1cDrUb6KnC46zZM58TRlUw0B3amyQY5cdja
 6bZqZf7Xe7tTly/1nFhy/bNUcgRUFUmLSsD8uBaL4hGIeFlCwf3+f+Bp0bNinusoKuoTQT0ql
 Yerp5OUuJwJWZ+luaf9nPrxqMARbb9S6Eja867590CwWizDYvlfOSFfBKraBb4LMYknfkXsmD
 swI1b8OdXSQZ4RGCUxQkdCFokRepQ37q2qGtRyMP7emn5WpR0pMMLZKcEQs5Y00kVprR1cZO7
 cA6khZv8GnNAOzPQuXcb4MG5jgwAFusm6l2xPHnc13k+4aoKGI4BdsvMApOv2MCWcTcaCWu5i
 j4JlJmzZPb2NwboRnj4XfuoSN8NqhVntNgyNqGkrguYEB00y4m8smeMHLJ2blNFFx0k4d6uuO
 ydITIvY/Uly7gpn4WmLwfwhdyOvdwqRaQqwCSrH8lRtfLQIl5IGDnT2UA7EPwpiHPmVN+IWYm
 uquqbAtEwJ6UrRA5/4FMmbZIwW0C8sh0oTMwMMQaDrsX1OwVskGWVI59lerTVX58pc26YYl8q
 OEDWqh7bIzwJVH1WhhZMqYYCd7I=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/20 22:44, Longhao.Chen wrote:
> Hello everyone, I use Btrfs as the file system on my laptop. Yesterday, =
I was preparing to backup a snapshot to an external hard drive using btrfs=
 send, and the following error occurred:
>
> ERROR: send ioctl failed with -5: Input/Output error
>
> I used btrfs scrub to scan the disk, and the result was:
>
> Error summary:    csum=3D1

Csum error itself can be caused by incorrectly utilized direct IO.
E.g. modifying the direct io buffer while it's still under writeback, in
that case btrfs just properly detects such situation.

>
> Corrected:      0
>
> Uncorrectable:  1
>
> Unverified:     0
>
> The disk is a 1TB Samsung SSD with less than 4TiB written, the SMART is =
completely normal with no errors. I suspect that this error may have been =
caused by random bit flipping in the memory (DDR4 non-ECC memory).
>
> Afterwards, I booted a LiveCD and ran:
>
> btrfs check --init-csum-tree

Why you go --init-csum-tree as your first step?
Why don't you run "btrfs check --readonly" first?

Especially that operation has a HUGE warning right at your face.

>
> During the running process, many outputs similar to this appeared:
>
> root 1380 inode 5006723 errors 2001, no inode item, link count wrong unr=
esolved ref dir 1164151 index 1566 namelen 28 name <filename> filetype 1 e=
rrors 4, no inode ref

This already looks like the fs is corrupted in the first place.
As csum tree rebuilt itself won't really touch subvolume trees, thus
your subvolume tree itself already has something wrong in the first place.

Without your initial btrfs check --readonly result, it's really hard to
tell what's going wrong.

Thanks,
Qu
>
> Then I found that the file in the above <filename> had disappeared. At t=
his point, I immediately backed up all the existing files and then used:
>
> btrfs check --repair
>
> btrfs rescue
>
> in an attempt to recover the lost files, but was unsuccessful.
>
> The current issues are:
>
> How do I recover the lost files?
>
> Why does btrfs check --init-csum-tree cause file loss? Is this a bug?
>
> LiveCD information:
>
> Linux ubuntu 6.2.0-26-generic #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu=
 Jul 13 16:27:29 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>
> Thank you for your help.

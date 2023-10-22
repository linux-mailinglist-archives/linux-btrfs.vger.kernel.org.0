Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050F17D261C
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 23:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjJVVdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Oct 2023 17:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVVdU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Oct 2023 17:33:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FA93
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698010394; x=1698615194; i=quwenruo.btrfs@gmx.com;
        bh=5iv8AYq88lZF4PaM6Mh2ay8Xo6EN9/86YuOjPJ4rgoE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FOaTE5y+9WyORt7D+XKco/bkPIm7zkYlr8DbUL/fM+D/zZRGRfmGiHWQEjrnPb9T
         ARmW3zd52Bz/+kaW1yVcAOPz1dSBiTdVTZ+IfbJ/EfhAVCDTaLvEgtZHniG3yhwdj
         z+rpuMLKfrE0hXV6mbMovTBCmg9tQt0TXbK57WundYK4f8piKCKQ/7dSW1bFysBYX
         Iin0trlyE1taTdfGhTyIbei7PbMGSIjAuD7iXs8j5bSNuLiMghPWKwrSuZL31O0Mw
         72EnRwWigv2/ZI818bwE3yfHSodhRaH2LAaLXG1EpsCYIWq78TsTIEfORgN/IXuYp
         lhqG+gNCHmnssKoYsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowKi-1rIDFn3kXW-00qRFN; Sun, 22
 Oct 2023 23:33:14 +0200
Message-ID: <9760a471-6473-4c11-a807-ded4bb2833e2@gmx.com>
Date:   Mon, 23 Oct 2023 08:03:11 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRF: no free space
Content-Language: en-US
To:     Reindl Harald <h.reindl@thelounge.net>, linux-btrfs@vger.kernel.org
References: <2856c6f2-8d3c-412b-a012-a8151a4b1392@thelounge.net>
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
In-Reply-To: <2856c6f2-8d3c-412b-a012-a8151a4b1392@thelounge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pBSJMAY5dzrBViPgENQV+vksv+O2jSvaF/YMGXt3EJiBZYM9obD
 BuxgRHp+251DHunL87pKwSnl+O+0hZniFBWVZec2LE/JNP4q+wlvHHTtPqoY/twkI4zfhuq
 N3yVe5/79xk1vGV2uadVNkLhriaeMhKJlZjYIXy1b7pOtOOmXDkONJn4MfT9QNpqcLmlQgB
 zP2QeHfozkhWWjvq5lmjA==
UI-OutboundReport: notjunk:1;M01:P0:oCqDzczoIvo=;aHFah/wTnINhytwyGG6cDLTfQ81
 RhJORPEgEItY91T41ZRWMv13HN2DnVoLJBTRVXH+ukBeMXtwgTubX66nd6TzNGhMeLCpl1QnJ
 rRzCwstR7b2LKxN8ZMisa7NPtJAxMQQuVha01GfnpKCsPMsrDLmo0nr2iCxmz7c+riSUZvXgR
 mig2Z/MyzaRy9lcPocT7Ww8h7jlSbAymczkRf26F1T6JgWLoLVatVpCdkr0s4/zl34gC5DfpO
 EXJs+xySKpt2fLNNd+td5wQM6L5bqIY6uK6l0ipZZDwDH8tIEmKhHybTu5mo8yP5Oay5aYGd4
 6g9vjofCPD14wtvlIguJJf6ax8E7VnX/b3t2I142RkAjFkkzQj9PXRIA7T38ydJCFdBY91YRi
 YvkgVtlmzkdCSGRV8z7TzRxkp90tVSbW2XvtDA78IEllGyq7Jqj0cVkDOjb1xMaughSrSlCRi
 VxPHWiyoTFM8TyxSbH1MiN9cVnt2HWJvIrDWkuglocT00+RZky2OPLq5xW+m3SEKF+UPJddU1
 Hp1iOuGEbnjgi3T7nrkwjnl0VRfYfNBY/A6gVZh83lrHeJjGTJKdyX5QxvYcBp1lVFjpPqw++
 rNWRkZdAT1YxBC8IzVNzLQ+9Wn9/oSLWO+Xh8yuFiq42RjssB21LMduLdbQ18ul9qPBiQzeTf
 WtqbS2Hv8S35ZrhYpS5Xna1Hcjp+SoZ03Pixvas40XYlWZBwwul6urQHlWdZkZM2VvjB6GK5E
 C0lPqx/b5E9ngYaP9sGSa9EqHp2U75LcZLLaINLvAynGbyL15VcLUWJuUrNv4COK7K6DVXJdD
 sHw35TShwAXEXo+Xt4XUkWmSWlKOQUFio8zB0M03ycm3CQpuQhY8zbNf9fWO5+f3UZSuwPYbL
 Mk0CSB6AozNPyTOCuYTOui4F8UTW6Ky9w+dKvt1B+Ew3wWC09t88cnKyicObpxhOiBYFQ0plh
 62N4XDHx43Up7zv3OQ1TQ67R5RI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/22 21:13, Reindl Harald wrote:
> this is a *new* filesystem and somewhere in the middle of the night at
> 10% usage a large rsync stopped because BTRF thinks the filesystem is
> full - how is this possible in 2023?
>
> Metadata, DUP: total=3D1.00GiB, used=3D945.61MiB

Metadata is already exhausted.

Thus no way to start balance.

>
> -----------------
>
> defaults,noatime,compress-force=3Dzstd:15,ssd,ssd_spread,nodiscard,nobar=
rier,noexec,nosuid,nodev,commit=3D60
>
> adding "clear_cache" which solved such issues in the past eve refuses to
> mount it
>
> [root@arrakisvm:~]$ mount /mnt/fileserver-backup/
> mount: /mnt/fileserver-backup: mount(2) system call failed: No space
> left on device.
>
> -----------------
>
> [root@arrakisvm:~]$ df
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0 Type=C2=A0=C2=A0 Size=C2=A0 Used Avai=
l Use% Mounted on
> /dev/sdd1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs=C2=A0 2.0T=C2=A0 209G=C2=
=A0=C2=A0=C2=A0=C2=A0 0 100% /mnt/fileserver-backup
>
> [root@arrakisvm:~]$ btrfs fi df /mnt/fileserver-backup
> Data, single: total=3D1.95TiB, used=3D207.05GiB

Is this after you deleted some files? Or exactly where the situation is
when the ENOSPC happens?

If it's the latter case, it looks like a kernel bug that we're
over-allocating data chunks, and we need to investigate.
But please provide the initial 'btrfs fi df' output for that case.

If it's the former case and you're trying to make up enough space, I'm
afraid you have to delete more data until one continous 1G chunk is
freed up, then you can do balance to free up most of the space.

Thanks,
Qu

> System, DUP: total=3D8.00MiB, used=3D224.00KiB
> Metadata, DUP: total=3D1.00GiB, used=3D945.61MiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> [root@arrakisvm:~]$ btrfs balance start -dusage=3D5 /mnt/fileserver-back=
up
> ERROR: error during balancing '/mnt/fileserver-backup': No space left on
> device
>
> [root@arrakisvm:~]$ dmesg
> [Sun Oct 22 12:31:52 2023] BTRFS info (device sdd1): balance: start
> -dusage=3D5
> [Sun Oct 22 12:31:54 2023] BTRFS info (device sdd1): 496 enospc errors
> during balance
> [Sun Oct 22 12:31:54 2023] BTRFS info (device sdd1): balance: ended with
> status: -28
>
>

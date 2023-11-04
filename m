Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4A7E113D
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Nov 2023 22:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjKDVWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Nov 2023 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKDVWE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Nov 2023 17:22:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D7CA
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Nov 2023 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1699132916; x=1699737716; i=quwenruo.btrfs@gmx.com;
        bh=mCiF8Fb5a9T56ZoYUcsGkMgoRYEhno04eUTTIMa2lO8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=OQI5qZED6HYqCu73hs33sm3UuKFvfpjECczBIcYP2z6IdWQoFS8VdTC3PmKkT/HR
         pqkxJlMsjEqicZD+ewq3y2HUW0LoXdNHwdDm4Ay23WEAOJiG/9O0bv1NhCT5eVz54
         rONxBKDyC0p77C+A0L3+t0wCK7LY3exuIwrPuceOiRrTv8KuIBmqcmbQKIxyBS4Sx
         zD7v7flI5NbKpmyvdUon0xeSTebgMbUqz8vCF0hoqD05KiMuYfcodOWD8Z26bAQz5
         103gLbaP4U1qLTsoP6HULvYoL/XhQrv0tEhS2jdJv3tHFnMjg2H+UzC4NiQXjcFzZ
         KDWYOj/bi7R0L5Kn/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQe5u-1qkaUX3vdO-00Nllz; Sat, 04
 Nov 2023 22:21:56 +0100
Message-ID: <7a48da35-991b-473e-a6d9-7efb08f6a6bb@gmx.com>
Date:   Sun, 5 Nov 2023 07:51:52 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 55 /etc/resolv.conf's. Clearly, something's wrong.
To:     Ken D'Ambrosio <ken@jots.org>, linux-btrfs@vger.kernel.org
References: <80a02ff5c8e2cc16b72247caa9ccca55@jots.org>
Content-Language: en-US
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
In-Reply-To: <80a02ff5c8e2cc16b72247caa9ccca55@jots.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X5+ZXpu26NNdSuujgww/jsNPMN/9KXG+gJqkyx2+u3js479M6q3
 kYzs96UddlDaYmxo1zdPNJO6A6tulG3Ut8MfkfVsgf3X6BlGQ+jFDi8XMqIdJSnkrffS43n
 Y5ZWLUG5pzfMLY6nZEJjOzjXYUooR6hyuRajEIWQalWv5l8G6prAiQNg1eaAG0oCiHwSpTP
 sUCAR1bCSwR37r8Tl+imA==
UI-OutboundReport: notjunk:1;M01:P0:NYceHvLYjRo=;Cm28p2LoJqjYAjn3hlP217YoE1q
 YckaVugygFldexYfLY1JR4X1h6nftlFtCihYp88sQiO5xQoBGcqeT8izE3/gqgO+uP4yR63dP
 rjOXrZlzwZP/fI47MfuJfSwt4V0xqDWlMCVAXJi6hq0kVEJstG/0d3CTYcZRFCD+aNdAWehe7
 XMA/rmklnpeG1Tn/iQLqcOBG1xWkRYPyQQPIKxNVrrpfu9+5WvbjdPLjq+FcrmL2+fvkW/fK5
 Qrw3s+jfxjcAU+GKy6BSdIfN/r3IpeAuUKES2WerqDiXj6tQpWaLkNnTKUn9haLIJPQN7GW6L
 kriImxIxuRSXMbKPN2G7ZDjvEctKN8iOhpnEYPOloa+yi/GVEsXyohxg99r/KKNukkp3XH30U
 v1pDTZ1s6W3tZtXAHWD8KMO20KXkNsoY7Ktf6dKrVjP9YuaF8343OSfJQ4mSMu9LK/rhPz93V
 BZ/cC3NoU/hV16pZhlvfUmOamrPhAhqK98xU9BWaKVtVJ4FcgfNF3GA3EDhwnzq/artvo6DjZ
 llG3bm8ZHqdCl1ZJCKPQ67YD66CCcfdYrPaWAuX62qjJw0xgqK1IWrWjDLi3QSstjWTOuEGiN
 UWG5lubgsopG72dD5EwXPxY3MsOjYrr1pjKwhCJJqCchcSWrbZh8Mf6VzL3TjnOAdAXR6jFbL
 Ceq6DAXoz1M/i4/0XdjufvF9Z9DD+aaSVc9XJcnHW80L0WtkaFaT0AxLKbrraPgookNIGG0yZ
 S6gsPVhk6a5BLllSk1kqBL2+tGP4s9xe1PDJh+vQzjjULdAtzhRJKIUcJc4K3K3drTGZ9Zw/q
 QCYgZCO9s2sT8X0fc2RQWwMgrWjjHhU6FdbwYQ9wNve6VL0KDT4mOG+31dZvMsTOsn6NrCRRi
 e906vFyCaoU8Pd90AxLCG4IpAU+wsHt/x4GSMfy7fohBhsD3U30dkHviHpP4cYLVXY6Sldk2+
 6ttH98Nvbk1hiEoZMfLSzrjJ0xI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/5 07:04, Ken D'Ambrosio wrote:
> Hey, all.=C2=A0 I've got 55 /etc/resolv.conf files.=C2=A0 All except the=
 "real"
> one show like this to an "ls -al":
> root@prairie:~#=C2=A0 ls -al /etc | grep resolv.conf | head
> ls: cannot access '/etc/resolv.conf': No such file or directory
> ls: cannot access '/etc/resolv.conf': No such file or directory
> ls: cannot access '/etc/resolv.conf': No such file or directory
> ls: cannot access '/etc/resolv.conf': No such file or directory
> ls: cannot access '/etc/resolv.conf': No such file or directory
> ls: cannot access '/etc/resolv.conf': No such file or directory
> [snip]
> -????????? ? ?=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ? resolv.conf
> -????????? ? ?=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ? resolv.conf
> -????????? ? ?=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ? resolv.conf
> -????????? ? ?=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ? resolv.conf
> -????????? ? ?=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ? resolv.conf

"btrfs check --readonly" please, and please use the latest btrfs-progs
just in case.

> [snip]
>
> As per
> https://github.com/kdave/btrfs-wiki/blob/master/btrfs.wiki/Btrfs%20maili=
ng%20list, here's stuff about my system:
>
> root@prairie:~# uname -a
> Linux prairie 5.10.0-19-amd64 #1 SMP Debian 5.10.149-2 (2022-10-21)
> x86_64 GNU/Linux

This is a little old, especially it may lack some newer tree-checker
patches thus it doesn't detect wrong on-disk data immediately.

If possible, please try a v6.x kernel and see if there is any new dmesg.

My current assumption is, some bad DIR_INDEX items, which would be
caught by btrfs-check.

Thanks
Qu
>
> root@prairie:~# btrfs --version
> btrfs-progs v5.10.1
>
> root@prairie:~# btrfs fi show
> Label: none=C2=A0 uuid: dcc7ffb4-4fbd-447a-8f10-e9d3c02a7cd3
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 1 FS bytes used 156.95GiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 838.19GiB used 4=
51.19GiB path /dev/sdc2
>
> Label: none=C2=A0 uuid: e371ae40-a198-4045-ac4a-52780d8e62f1
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 1 FS bytes used 49.64GiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 1.63TiB used 51.=
02GiB path /dev/sdd6
>
> Label: none=C2=A0 uuid: 7a82f874-9df6-44d9-9c1c-2cc927f97f24
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 1 FS bytes used 26.05GiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 7.28TiB used 27.=
02GiB path /dev/md127
>
> Label: none=C2=A0 uuid: 62cd7a65-93cb-491d-a3f0-89709066bb0f
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 1 FS bytes used 4.25TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 10.92TiB used 4.=
95TiB path /dev/md0p1
>
> root@prairie:~# btrfs fi df /
> Data, single: total=3D439.01GiB, used=3D151.83GiB
> System, single: total=3D4.00MiB, used=3D80.00KiB
> Metadata, single: total=3D12.18GiB, used=3D5.12GiB
> GlobalReserve, single: total=3D310.30MiB, used=3D0.00B
>
> ... and dmesg output is attached.
>
> Suggestions on my next step?
>
> Thanks!
>
> -Ken

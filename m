Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2C7880A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjHYHKN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbjHYHJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 03:09:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C021B2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692947393; x=1693552193; i=quwenruo.btrfs@gmx.com;
 bh=c6a8jAfT4HbRCllklgchCE6B/J8H1/Aafb19B+A7NAE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ikVDmyBgyTjNU1FMMsSP5D3UqYjHuv5LjQXiKHzisbx4nQIPEmwp4oqCDIIaTD7iTuHawkS
 tQekbMQ4WNFCRdTXn2IR42ZE2X790B3J0TlBsZaJ+RrU/zhf3cyklf6Owc/PAmtM5hMfosT0a
 3FJqW3SYD2nYWRfNH0ftFbspGDt2Qn3mqaxIq4QeH4dHMwg/1zrToHtko9PE0P9WK97doUh0F
 jN7avONImAeyfXm6wToLIzlaqiVww9E+lwiaw3L98KU9OkArzfu94GbCUvn81LIR5UE9UrTOi
 eEV+d5aEFkKsMuzoMTHaRLVkURjt/7jNeQl8d4K0marNP/zk4xCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1pZ81J0iY1-013KSL; Fri, 25
 Aug 2023 09:04:36 +0200
Message-ID: <a21684a4-ee7e-4404-85a2-2ab1f4a1623a@gmx.com>
Date:   Fri, 25 Aug 2023 15:04:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel bug when performing heavy IO operations
Content-Language: en-US
To:     dianlujitao <dianlujitao@gmail.com>, linux-btrfs@vger.kernel.org
References: <db36520a-e3c6-4dac-ae5f-1826b8e6d753@gmail.com>
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
In-Reply-To: <db36520a-e3c6-4dac-ae5f-1826b8e6d753@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VNiRIXZTrVgpNIk/SpEq0if8MD5AXCM2rRQj7db2G74hyDV/tmT
 SacE58vvWWqBNAbm5mmYQNd7ezQ5/Zfjztq7qyclRDwtoIPUGaUob804X+jzoh4bG2fKN1f
 uTOwK3bAq3XlpyKzQqoga0A+kV1rWgzyOJRe/Wda68YiopfoOC3xNayxH2pRkbqgOCUObUx
 GpzC6+h2LnNFpbOy0ifig==
UI-OutboundReport: notjunk:1;M01:P0:qUESEhCkI7I=;5taO9QnsAKgEUt6z7zEeo3Jgd+n
 fpRdCySPigUwlG+hyI2aTGmmPpfZroBEuHGJG6fJG2DwzUwSfGFwF8pfBScrbFjRiUXH3JC3A
 mVeeLLysnzbDU0Q4AM34+MC6IozoBnIDa54i91PHLYP+rI0UN2DYQOWxCabyD8ahwSgV/ZEnr
 5/h5GqBlHfDB7UceTlAAQuKoQ55saa1iTulOdWOrEEtyZ+11pD/YeSVoeoxYN85qW9dfDMteg
 JWCpRtzbQvTiWVo83WrAi0gmpTBbMIwoMs7lyIrIkhvvCxnc6fzB31UzOMM0dADW8lYiwraGF
 hNYqAGV3QDvVSr5h7e8NWOD6dxDNS5Dj8/HueccT1aSZYpxDa41fyC4Y8oQTZ8itAihQgkQu0
 RhxTCnY7vyhHDLWEYASXcO4Hqf1gaQFiN3FVBCWfRbtSEh/hS/44/U3wIooEZGv9rBj7sduSZ
 fQOaDcKvqvn6fe0t/J9CbsY2MloB131yYCAMlecPoKArRpMdXb9tn+BNGCFX+IP/yNR7kI7tc
 wSPX6sXxl25urE+k/xSTx3D/3wGHhbXnoF7XYiTeiYVhJ2w91cBeVFaIPAknqa4sEcnkCD7LA
 hS4vVFuEqErOmpqx5YVrGZmI0OskZEmhjLX4A6fvEhPXFyL17rtcsXgkss2U9P1cjQ1GWH/7r
 luciXoMBpID+rwLfya8aM65y7RKRCrixTA9Z+rVQ4LFX32+bDHO8JIKcm2k9z1nf04pkA9wdF
 CtL0HI5Q29pMhp+TcHqdbAqOk00Bgr6tJSJVlV8OuamLSyV9SjFN+w7TIe16UvvxIFyf73/ra
 UkeDbGltb70zwhRZSNMgTQfR+UsidvhjtHXJKZT7SDe8xITQoWpIBbtIkpBBoxGjKVYIG+9to
 edjVjSiG2y8fFEJkjT/WmriFS02GRQZCrXAf5ZFqjyEFGniUifTEu1P6jQY0a46tDKWKhOmeL
 ZewRor04nhhsqTm8oIkrOZ0877k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/25 14:27, dianlujitao wrote:
> Dear developers,
>
>
> When the IO load is heavy (compiling AOSP in my case), there's a chance
> to crash the kernel, the only way to recover is to perform a hard reset.
> Logs look like follows:
>
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: BUG: Bad page map in process tmux=
:
> client=C2=A0 pte:8000000462500025 pmd:b99c98067
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: page:00000000460fa108 refcount:4
> mapcount:-256 mapping:00000000612a1864 index:0x16 pfn:0x462500
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: memcg:ffff8a1056ed0000
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: aops:btrfs_aops [btrfs] ino:9c463=
5
> dentry name:"locale-archive"
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: flags:
> 0x2ffff5800002056(referenced|uptodate|lru|workingset|private|node=3D0|zo=
ne=3D2|lastcpupid=3D0xffff)
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: page_type: 0xfffffeff(offline)
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: raw: 02ffff5800002056 ffffe6e210c=
05248
> ffffe6e20e714dc8 ffff8a10472a8c70
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: raw: 0000000000000016 00000000000=
00001
> 00000003fffffeff ffff8a1056ed0000
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: page dumped because: bad pte
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: addr:00007f5fc9816000 vm_flags:08=
000071
> anon_vma:0000000000000000 mapping:ffff8a10472a8c70 index:16
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: file:locale-archive fault:filemap=
_fault
> mmap:btrfs_file_mmap [btrfs] read_folio:btrfs_read_folio [btrfs]
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: CPU: 40 PID: 2033787 Comm: tmux: =
client
> Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=
E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.4.11-zen2-1-zen #1
> a571467d6effd6120b1e64d2f88f90c58106da17
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: Hardware name: JGINYUE X99-8D3/2.=
5G
> Server/X99-8D3/2.5G Server, BIOS 5.11 06/30/2022
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: Call Trace:
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 <TASK>
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 dump_stack_lvl+0x47/0x60
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 print_bad_pte+0x194/0x250
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 ? page_remove_rmap+0x8d/0x2=
60
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 unmap_page_range+0xbb1/0x20=
f0
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 unmap_vmas+0x142/0x220
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 exit_mmap+0xe4/0x350
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 mmput+0x5f/0x140
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 do_exit+0x31f/0xbc0
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 do_group_exit+0x31/0x80
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 __x64_sys_exit_group+0x18/0=
x20
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 do_syscall_64+0x60/0x90
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: entry_SYSCALL_64_after_hwframe+0x=
77/0xe1
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: RIP: 0033:0x7f5fca0da14d
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: Code: Unable to access opcode byt=
es at
> 0x7f5fca0da123.
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: RSP: 002b:00007fff54a44358 EFLAGS=
:
> 00000206 ORIG_RAX: 00000000000000e7
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: RAX: ffffffffffffffda RBX:
> 00007f5fca23ffa8 RCX: 00007f5fca0da14d
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: RDX: 00000000000000e7 RSI:
> fffffffffffffeb8 RDI: 0000000000000000
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: RBP: 0000000000000002 R08:
> 00007fff54a442f8 R09: 00007fff54a4421f
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: R10: 00007fff54a44130 R11:
> 0000000000000206 R12: 0000000000000000
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: R13: 0000000000000000 R14:
> 00007f5fca23e680 R15: 00007f5fca23ffc0
> 8=E6=9C=88 25 13:52:23 arch-pc kernel:=C2=A0 </TASK>
> 8=E6=9C=88 25 13:52:23 arch-pc kernel: Disabling lock debugging due to k=
ernel
> taint
>
> Full log is available at https://fars.ee/HJw3

Any log before the carsh?

Unfortunately the backtrace itself doesn't show a strong relationship to
btrfs.
The only btrfs related part is the call back of btrfs_read_folio(),
considering the BUG itself is about bad page mapping, which may or may
not be btrfs' fault.

Another point is, it looks like you're using zen kernel (from Archlinux
repo?), zen kernels have quite some out-of-tree patches, which can be
another cause of problems.

Have you tried upstream kernels? (Arch official `linux` package is more
than good enough for this case).

> Notice that the issue is introduced by linux kernel released in recent
> months.
>
>
> I also reported the issue at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217823
>
For zen kernels, I strongly doubt if kernel bugzilla is the correct
location to report bugs, as kernel bugzilla/btrfs mailing list are only
for upstream kernels.

Thanks,
Qu

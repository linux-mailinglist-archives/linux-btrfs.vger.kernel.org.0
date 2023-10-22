Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F117D2617
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 23:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjJVV3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Oct 2023 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVV3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Oct 2023 17:29:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FEDD
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698010182; x=1698614982; i=quwenruo.btrfs@gmx.com;
        bh=oATrbZOkYimtTM8cyjp1pq+HconionTI9h5Imw7pSyc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=l1gevCmhKpFVTh86aY9uiJqWoZj42Md50KAukby9ahWaWuAkN9w1kRFYfpckDEuC
         imEEdzhk6nQem06nepp3aHdtLsuCJywY5SK8iZz6GHP6dzC1q4LClVGjbb6l5FZ5I
         Hv/jlIMZvpHAZErrjz9eUdR3wJg6Q15ZlNr3s38vcmL9vYx3hnDIgn70HIFMlFMNK
         wBWh0x+VYKUfTHA5mq2/zbAJRDx6Reh46duVO7pdYjEoVlS70q0NoCP35Wzg3G9d8
         4K0A4oos9FY0ieGOfXHc8/b2mR7q4yp141LvRO4jyvqeOloP0WkLBNr5qFR1HsxnW
         UyHmRVAwAmux9gDz9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1rHeyf3ePc-00pr7c; Sun, 22
 Oct 2023 23:29:42 +0200
Message-ID: <c6c6a985-9817-46ef-85c6-e9fd6baa9478@gmx.com>
Date:   Mon, 23 Oct 2023 07:59:38 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs readonly after few minutes
Content-Language: en-US
To:     nzb_tuxxx <nzb_tuxxx@proton.me>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <o9XJJu0qMzbW4Iiu4eBNXZZscccGRCC0lpf_tUMBA7Mlxmlba4yfx27_7W29DfGvZAByVGSyul3dxcPwpLrPBWiUx0B-AJU-L-vyKKMyjO8=@proton.me>
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
In-Reply-To: <o9XJJu0qMzbW4Iiu4eBNXZZscccGRCC0lpf_tUMBA7Mlxmlba4yfx27_7W29DfGvZAByVGSyul3dxcPwpLrPBWiUx0B-AJU-L-vyKKMyjO8=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LSzV1Edc99RwkRoFTjv6i5aGfx8488XwiGhnCMNwB0xY4D86kn5
 iRk1xiglxZ7GV/ewhCtcxzW0vkuXGmJV7VnG3eyQgQIfWRCpKHfICdD2CIZ74mchmNOn/4M
 9Zv6AdB16vke8aYJeUipAUVLQs5smzehX1SrdHU53h9k5erwpozVGKywfOvn55vH6Ax5ZDZ
 NH4ZGEXL2mA4CDgcpZvig==
UI-OutboundReport: notjunk:1;M01:P0:NJZFuNS0UDQ=;vSial9WdFUiVo9VBAcV3WZnHE7w
 XKRUe8Cxe9+60rgQQWJjaC9acLcSSetm7QMDY5JP08JuttlSA8haDrt8f6dwYdqYPupnsWdDz
 eY3aNsWy9b3NIGy9eKLddILLnHyWHy0+qXQnGS2WDYBWDDe+0N1aBa3t0Mclh2TEZ7xGRMHrI
 po1gZrWCypqGHfMXcbUz2Ud5Bxf8R+8t3/qSwVhn5MbhgJ+gUG8HE2B/QpVsxINxgVnDfSlk0
 x4L5ZR0OnKYBe50JQ5fpRNjcXCA7W5hOSMz+sijrXVL1PGvX7R//pWu5VpsFsw4JvZc+9HVC9
 Z/1PRg0HkZrRv1XvVzGEwgDONBEPfU6BAtSlthBKyvb0QclPyE72gWomBqnnq8a2uWa7GunbM
 i++S6/tpLc/Pf1wnsYjOf2749X7rnmJFKcsnFSXEAlYSkwQ8ohvwwjLxyHbU+ZCvVTnoSFwkS
 Ulpg4G/kjW+5n2RHSGoI3AFCLWXYVYenEsXqqPHFnitEU1j9Lo4iafSLyn3crAzECOosJjMFK
 GowDalnUiwQ1rlGVw+jwBTeNmHqcl06sfX9+bS6hVCGNAInklOyCAAfzkZPBsavhTIPtaf/7x
 iEVFKqGik24Z9MvDK8+pqNWI2cU8oZAP+2e9qLEYAD8na7fE5CFZwRuRwKudoj+1ItY4nApzP
 VNzN/C/waEgmHYSdlp1dHxTRQojTFF4l9NoxwcmvOQpEOVQQSPbu+KCtzX5+IgzNUyr7f+OrU
 iPsxHnDQmTJGlCWa31uSavH25GMwh7bNwXUKJIAmereylTneojsVbn8Q3TtVFg9dpfzY//YZN
 yyoxWdWorlmcfZ9/9nGDMGfl+DhJqAt5/6+012JQc+BGqXhRJqkg+5TiR0HsYB40vaL2QmTKO
 u2TPNJLpN0loTlY6BTm4qfWfrggWS2k1rtE99sfaVWwoHjMWWaV1lRp09mi+68iAIcfoswlQg
 X+gKw+uejqZvVUkakCgBcwe/Rc4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/23 03:47, nzb_tuxxx wrote:
> hello,
>
> my root btrfs fs mounts to readonly after a few minutes uptime. any idea=
s? thanks.
>
> Linux T14s 6.1.55-1-MANJARO #1 SMP PREEMPT_DYNAMIC Sat Sep 23 12:13:56 U=
TC 2023 x86_64 GNU/Linux
>
> btrfs-progs v6.5.2
>
> Label: none =C2=A0uuid: a9754b40-2b24-4756-84de-9286a3eee35a=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 571.27GiB
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 1.82TiB used 591.=
02GiB path /dev/nvme0n1p2
>
> Data, single: total=3D585.01GiB, used=3D568.73GiB
> System, DUP: total=3D8.00MiB, used=3D80.00KiB
> Metadata, DUP: total=3D3.00GiB, used=3D2.55GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> [ 6029.069758] Hardware name: LENOVO 20UH001QGE/20UH001QGE, BIOS R1CET76=
W(1.45 ) 07/31/2023
> [ 6029.069758] RIP: 0010:__btrfs_free_extent.cold+0x91e/0xa24 [btrfs]
> [ 6029.069798] Code: 50 e8 ad dd ff ff e9 20 ff ff ff bf fe ff ff ff e8 =
1c ed ff ff 84 c0 74 67 be fe ff ff ff 48 c7
> c7 60 62 76 c0 e8 5d 62 36 ed <0f> 0b c6 44 24 14 01 44 8b 44 24 14 48 8=
b 7c 24 08 b9 fe ff ff ff
> [ 6029.069799] RSP: 0018:ffffa53f02f67c40 EFLAGS: 00010282
> [ 6029.069800] RAX: 0000000000000000 RBX: 0000004315d84000 RCX: 00000000=
00000027
> [ 6029.069801] RDX: ffff8e456fa21668 RSI: 0000000000000001 RDI: ffff8e45=
6fa21660
> [ 6029.069802] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa53f=
02f67ab8
> [ 6029.069802] R10: 0000000000000003 R11: ffffffffaf8cc7c8 R12: 00000000=
00000001
> [ 6029.069803] R13: 0000000000000000 R14: 00000000000001b5 R15: ffff8e40=
174201c0
> [ 6029.069804] FS: =C2=A00000000000000000(0000) GS:ffff8e456fa00000(0000=
) knlGS:0000000000000000
> [ 6029.069805] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6029.069806] CR2: 0000557e4481c000 CR3: 00000001f5010000 CR4: 00000000=
00350ee0
> [ 6029.069807] Call Trace:
> [ 6029.069808] =C2=A0<TASK>
> [ 6029.069808] =C2=A0? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b=
4e7eeb39a12924341f62dfed6044ab567f0]
> [ 6029.069847] =C2=A0? __warn+0x7d/0xd0
> [ 6029.069848] =C2=A0? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b=
4e7eeb39a12924341f62dfed6044ab567f0]
> [ 6029.069887] =C2=A0? report_bug+0xe6/0x150
> [ 6029.069888] =C2=A0? handle_bug+0x3c/0x80
> [ 6029.069890] =C2=A0? exc_invalid_op+0x17/0x70
> [ 6029.069892] =C2=A0? asm_exc_invalid_op+0x1a/0x20
> [ 6029.069894] =C2=A0? __btrfs_free_extent.cold+0x91e/0xa24 [btrfs 6809b=
4e7eeb39a12924341f62dfed6044ab567f0]
> [ 6029.069934] =C2=A0__btrfs_run_delayed_refs+0x2be/0x1080 [btrfs 6809b4=
e7eeb39a12924341f62dfed6044ab567f0]
> [ 6029.069972] =C2=A0? psi_task_switch+0xd6/0x230
> [ 6029.069974] =C2=A0? __switch_to_asm+0x3e/0x60
> [ 6029.069976] =C2=A0? finish_task_switch.isra.0+0x94/0x2f0
> [ 6029.069978] =C2=A0btrfs_run_delayed_refs+0x62/0x1b0 [btrfs 6809b4e7ee=
b39a12924341f62dfed6044ab567f0]
> [ 6029.070015] =C2=A0btrfs_commit_transaction+0x66/0xc60 [btrfs 6809b4e7=
eeb39a12924341f62dfed6044ab567f0]
> [ 6029.070052] =C2=A0? start_transaction+0xc3/0x5f0 [btrfs 6809b4e7eeb39=
a12924341f62dfed6044ab567f0]
> [ 6029.070089] =C2=A0transaction_kthread+0x141/0x1b0 [btrfs 6809b4e7eeb3=
9a12924341f62dfed6044ab567f0]
> [ 6029.070125] =C2=A0? btrfs_cleanup_transaction.isra.0+0x5e0/0x5e0 [btr=
fs 6809b4e7eeb39a12924341f62dfed6044ab567f0]
> [ 6029.070161] =C2=A0kthread+0xde/0x110
> [ 6029.070163] =C2=A0? kthread_complete_and_exit+0x20/0x20
> [ 6029.070164] =C2=A0ret_from_fork+0x22/0x30
> [ 6029.070168] =C2=A0</TASK>
> [ 6029.070168] ---[ end trace 0000000000000000 ]---
> [ 6029.070169] BTRFS: error (device nvme0n1p2: state A) in __btrfs_free_=
extent:3072: errno=3D-2 No such entry
> [ 6029.070172] BTRFS info (device nvme0n1p2: state EA): forced readonly
> [ 6029.070173] BTRFS error (device nvme0n1p2: state EA): failed to run d=
elayed ref for logical 288129302528 num_byte
> s 16384 type 182 action 2 ref_mod 1: -2
> [ 6029.070175] BTRFS: error (device nvme0n1p2: state EA) in btrfs_run_de=
layed_refs:2149: errno=3D-2 No such entry
>
>
> btrfs check --readonly /dev/nvme0n1p2
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: a9754b40-2b24-4756-84de-9286a3eee35a
> [1/7] checking root items
> [2/7] checking extents
> tree extent[288129302528, 16384] parent 626657099776 has no backref item=
 in extent tree
> tree extent[288129302528, 16384] parent 557937623040 has no tree block f=
ound

This is the cause of that RO flip.

Tree block has incorrect backref, thus above btrfs_run_delayed_refs()
can not update the backref and results transaction abort.

Furthermore, this looks like a bitflip of your hardware memory:

626657099776 =3D 0x91e7ac8000
557937623040 =3D 0x81e7ac8000

Exactly one bit flipped.

Please verify your hardware memory by memtest, and repair the offending
stick if possible.

Only after the physical memory is fully verified, then you can run
"btrfs check --repair" on the unmounted fs.

This problem is repairable by btrfs-check.

> incorrect global backref count on 288129302528 found 9 wanted 8
> backpointer mismatch on [288129302528 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> [4/7] checking fs roots
> root 257 inode 2898321 errors 1, no inode item
> unresolved ref dir 8303 index 334 namelen 36 name 7c03a3d8-ad08-4634-9a1=
4-09a3d6bc5866 filetype 2 errors 5, no dir item, no inode ref
> unresolved ref dir 8303 index 334 namelen 36 name 9e2e9865-2cd5-44b9-971=
e-e5912c0c3357 filetype 2 errors 2, no dir index

This is another minor problem, but should not cause any transaction abort.

And it's also fixable.

Thanks,
Qu
> ERROR: errors found in fs roots
> found 613545406464 bytes used, error(s) found
> total csum bytes: 589807276
> total tree bytes: 2773516288
> total fs tree bytes: 1971666944
> total extent tree bytes: 100712448
> btree space waste bytes: 478904078
> file data blocks allocated: 1129657352192 referenced 722378301440

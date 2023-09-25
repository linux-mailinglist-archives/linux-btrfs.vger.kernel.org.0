Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F517AE238
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 01:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjIYXZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 19:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjIYXZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 19:25:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F711C
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695684343; x=1696289143; i=quwenruo.btrfs@gmx.com;
 bh=BmzK8Q/p7wvSEnNd9jPF4JXB4RkdPextNWVaTj+on/A=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=H5xWoduUaHnLxZZ73d+U+cF789U3MkkrJ6OdLpy77y3SvHchMkZqYk47JwOojybuln82KtTMXjv
 6EKbL9Enwb+U+ImnfzvaQ2/im6YjSjHdZihc47cumqc9ta7Jwk01jF6iuylydhjBS/3D4Fx6nm+/0
 B7LDJCoJY4QkbjkvhfBcI4xm7eI3A+tJkVykZHtPZEItnXTIpDJrKm2kGXcQxSr4uH2IFWrHHxFpu
 vopirp5bKXwTOXNXLoWhsB/RhzzRv81deG3A0Qd8mTJLZ3vp3faARwrB9yN+MxcV5HIzS1A/xU1p4
 palnWg55mPBHeKTgZpyOQ6Jkz1HQIkUJS/gQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.17.112.24] ([173.244.62.19]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSKyI-1rDcwo3VX6-00SjYL; Tue, 26
 Sep 2023 01:25:43 +0200
Message-ID: <61403da7-b355-4edc-91af-e5966dd80411@gmx.com>
Date:   Tue, 26 Sep 2023 08:55:40 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RAID1 parent transid failed
Content-Language: en-US
To:     Shaun Hills <shaunhills@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHvAn9gAP1rnQrL=ibwjWGS7fORCg3R=YEwZM9mHzPFQjEE_uA@mail.gmail.com>
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
In-Reply-To: <CAHvAn9gAP1rnQrL=ibwjWGS7fORCg3R=YEwZM9mHzPFQjEE_uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tQ1mogGNFp2R15aOOJO4aio7yJgtC5CflqYBx1g/FGDLOizNhic
 7WQLs6ndu79xuxxva1fPCDb7OMplVHiGGcPkEjsDhQnrv1IdjVNpq9funcVkXQtOvTdIAGi
 g9oVYs6lQa1eo5A9LzkjOT4YwWr0mKzEHgF2lZBvdUGWtCDsZ2ZkJrPx4OCRX8h2HNa2j5j
 yncTOtliIypI0XLop+0IQ==
UI-OutboundReport: notjunk:1;M01:P0:J9wVU8Xzt0U=;QIWHI9FKaJR7o+vz+lU00ibSc4A
 aq53t6tOQqab36o930+/Z3I0Qz8QoLEh4D8sGv8rDj71Yg0WA3L5wGSsfJOUFteYg0eeo/XGz
 cJo6p4KaxR8tXyAbezi2qr+Df+p63NbnYuYUO8VxjYcHmsmu1kTxVTx7ncZCBF+lnq/j74lgW
 ORnDm8c76/WnbX0spmU8wJUgTGY/OamfSbc+hoxi9IfJklhAstJXOh8GhkPrnaMCe+aLwSCDB
 aL+6c4wS7GljipeNVnBfTF48cqJR6X3cG50+sfAArFNFG3Xotg+P4EQvUVZsu2MUd/mzd5AoZ
 L+4brbz9eSM1uGMiLdkdswn4BKaYyfvPRyOWd2k3/ByR2lDOGwUdYhoYA6M8/EGu+5KkSzNS6
 T1+gHPVH4peZwNykiweghN115v4L3UM/4GKw/OALBicUxQC0M6XAHWHUbBBIIqyRYzg+35JiW
 qfinpAkae0n0dCn3A8YKcOu8dXh13oYcQ0TsSP8r4RoSFaXQRXfWPv7Zgrw9szSmPN/50Y/0G
 Aa9DKbdaZxHsM1Gb0f4mAGWPowc/JMX2h8Hl4uFvwV86Xr00MeenJ9nRrt9aqRITxGbulYu4T
 3D2Kx2c9ANK2x+3q3jL+ilnw7oPJjwOH+c07EIDPr5CNUqs1wHBuoG12fxsp+1dJ7bpjHyZ5d
 XlWsS+MZqTSY4bqM5+j6mLE6KJjUJXubj95Y7+vzkdtBfnm/F0KVCWCsX/8sunvtqfXyaRr1j
 3p6vXkXof1xeBgV6vzCtAOp1vHGJGRamIqvD8PVfAdrlvOaVn41W7w67u9qnopEFM7uJ1jsZM
 3Zctbfj4Tzt9l9sxwF2Ld0DjHAMQgzh1esJof/FjI7KJrPlOtWiTbZYqORtXhOKhn/FfcLQrW
 3o0jpTOPZFCmGUHLMSUg3w+m1bDzkvyV0yjMdHwhQ9KPSDlZfozSYoTxiSv8J+Mb1osrXl8cb
 wXQBop0qUDclYBsJudPl9vzcmDQ=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/26 08:47, Shaun Hills wrote:
> Hello,
>
> I have a RAID1 BTRFS volume on my Ubuntu home NAS with 3x4TB SATA
> disks. It has been running successfully for some years. But I run an
> hourly script to check its health that just started reporting errors
> last night. Script does this:
>
> /usr/bin/btrfs device stats --check /mnt/btrfs | grep -vE ' 0$'
>
> # if grep returns 0 i.e. success i.e. a match
> if [ $? =3D 0 ]; then
>      echo "Subject: Alert - BTRFS degradation reported on $(hostname)"
> | sendmail <address redacted>
> fi
>
> What it started getting back:
>
> [/dev/sdd].write_io_errs    93877
> [/dev/sdd].read_io_errs     556
> [/dev/sdd].corruption_errs  569
>
> Looks like /dev/sdd might be failing. Though I haven't 100% ruled out
> a SATA controller problem because an ext4 disk on the box was also
> showing some odd behaviour.
>
> I rebooted and ended up in Ubuntu "emergency mode". journalctl -xb
> showed some problems with mounting the BTRFS and ext4 disks; don't
> remember exact messages.
>
> A further reboot brought everything back seeimgly OK, ext4 fsck is OK,
> but when digging deeper I have worrying BTRFS errors:
>
> sudo btrfs check --force --readonly /dev/sdb1

=2D-force is only recommended if your fs is mounted RO.

Or any transid mismatch can happen due to the race between btrfs check
and kernel.

> Opening filesystem to check...
> WARNING: filesystem mounted, continuing because of --force
> parent transid verify failed on 15182296121344 wanted 2311287 found 2310=
777
> parent transid verify failed on 15182153809920 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182088847360 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182164918272 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182318321664 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182164983808 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182319714304 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182319845376 wanted 2311286 found 2311=
267
> parent transid verify failed on 15182396751872 wanted 2311328 found 2310=
808
> ^C
> (truncated for brevity)
>
> Luckily I can still mount the volume, and am currently running btrfs
> scrub (hasn't completed yet).

For mounted fs, scrub is more recommended, but for a full, more
comprehensive result, it's strongly recommended to go "btrfs check
=2D-readonly" on an unmounted fs.

>
> I *did* have backups, but in a case of bad timing I got rid of them a
> few weeks ago :( - offsite company I lost confidence in. New backups
> by shipping snapshots to an offsite server are being worked on but not
> done yet.
>
> I'm going to buy an external USB disk and try copying all the data
> off. After getting the data off I will probably also try replacing
> /dev/sdd.
>
> At this stage I have two questions:
>
> 1) Is there a command I should use to maximise chances of
> success/minimise problems/check for errors when copying data, or is
> something like rsync -av OK?

No special requirement. If you hit an EIO, and you're using btrfs RAID1,
it really means a problem.
Otherwise btrfs would try to fix the problem all by itself.

>
> 2) Is there anything else I should be trying to correct the transid
> verify error? Quite a lot of info on the Internet is a few years old,
> and this seems like the sort of error where it pays to be careful.

I'd say it's more like a false alert due to the forced check on a RW
mounted fs.

But still, your sdd doesn't look good at all.

Thanks,
Qu

>
> thanks
>
> =3D=3D=3D
> Info asked for by the mailing list:
>
> uname -a
> Linux storage 5.15.0-84-generic #93-Ubuntu SMP Tue Sep 5 17:16:10 UTC
> 2023 x86_64 x86_64 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.16.2
>
> btrfs fi show
> Label: none  uuid: ab1359a8-98ae-4f6d-a581-fbfa40ef633f
>          Total devices 3 FS bytes used 4.79TiB
>          devid    1 size 3.64TiB used 3.34TiB path /dev/sdd
>          devid    2 size 3.64TiB used 3.34TiB path /dev/sdb1
>          devid    3 size 3.64TiB used 3.34TiB path /dev/sda
>
> btrfs fi df /mnt/btrfs
> Data, RAID1: total=3D5.00TiB, used=3D4.78TiB
> System, RAID1: total=3D32.00MiB, used=3D768.00KiB
> Metadata, RAID1: total=3D6.00GiB, used=3D5.84GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> dmesg > dmesg.log (attached)

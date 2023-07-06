Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0274957A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 08:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjGFGTw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjGFGTv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 02:19:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86989D
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688624383; x=1689229183; i=quwenruo.btrfs@gmx.com;
 bh=4AScRI0mkFYIHqi87O05FbGaiFCo1+/LcrZsgxMrSHw=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=DFRnvKdsFzz5uSiJC3IojMMRTD/VIQl6wzlSrpwJCRVntNDc1oK/6NLrbbPm3rT/n40FNgO
 t2RP6nY1ZsDtZ5ESpU2N2kadYUPalhRlIFP7d0oFR/EmCNjfqoAVP7ARPNMNsTkpCUeo4ahrj
 w7ETbXfHoNeJvoLKD08bp0z3fZGDPa/8z9dpzbEoERGi1gmmF1BKs4Ii9w52IEjYXIKGY40CS
 2PO/YZ/0N2f7jErjM5dtmhiRAG4tcSwsiBhV6Gfo43wcX5iKodHr/qWjAU37qo9/FwCg4oqBF
 kmNUjJudAbuXROEoCj0DOTIH6C4J0GTaAS6J98I8m/xdAloUI6Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1qARu91qtH-00BuJq; Thu, 06
 Jul 2023 08:19:43 +0200
Message-ID: <11a9ec6a-7469-fdba-4375-c24e8ea5f7fb@gmx.com>
Date:   Thu, 6 Jul 2023 14:19:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: question to btrfs scrub
In-Reply-To: <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6s0KKjcuTeTh7NXSPyKCRbjYqw1cBAhYLvm5AiWr4LoUrwBGejo
 GiIMBxZv+Y7UVdRieVMYVR5hWjvl0AhVXxfgGk+484TYoegLh/7v7gOebT2AAYlTacRTVX1
 82zz9M8ChUX7ZkdisWuZ3RVdfThaqbAYgWU22kbtp7OF+35If+QDBpRCoZYZMdHIqUrmCU8
 1iYYo1hMzM2pbN47NyeVA==
UI-OutboundReport: notjunk:1;M01:P0:XM+2gUALQsw=;Zj/Jd3KCb5AbJ2evjJUlYzvBtLu
 DWsIa0rW5gL7QEz4IwM6quS+Hqgaw64d4tW09OkWdZYEYw/NGY48mPm46yS7gyiqI2XYd7XSN
 fO4Tphy1NCoeU8FhAei9OMRiu+iG9/HsSAEEEDo+iqDoqd1iiHgIYT4EHJ9nseNkynGajrfZu
 mFaQNpKwMvn1vvKR+T9HYgoIGJNQZiaZ9kBVGQnIxWxDQc7NE0wpevRCQkIcBrtC7CbJg5F7w
 mNgm72j0GyZAnmw0UPiQpuBzvJrCOgrTGuU8u4dk/slUaMrtVaak5bXCWBLNAjdBlMHvmfaVK
 69D5yz7uvJzEZGTLPoPUW0x0l8YDSVXHcwb3Wl2jnxRCccDoFCzADTcNlftX1ZEzuruCfquLm
 CMES4HA0R0kAJ0c1UX/5qLJXH9jce2iqb3IPrrkUTEWXCsT2MTgtoHVwOjL7T1gVXgicGankC
 yD9aVAHGH6e05cDt1CQZJkB7njY/Wq5ys6IhRO/4eu+i8RLaHVSPSAej2Vj+4Y9cR4wTIUmLa
 3dQDrElj8g8+TBpGPTV4rnsWESr/Ub+ghw84R9ozBdwc1SF8tCtehmCU/1LXJKXL2TOrnY0/3
 0gOxGfx+iPijJrA5TUJHujD3euGrHKlPKj2CmuRz5Z09mi8uVzIY4KB8usqMIK5IZOOgcJs6e
 dckL4utG6sBfkOS3VoA4G6zT9LTGaDx+NLDrFzRXqTcnP7c49jkhhiy28U6sFozv3/OyWnfoS
 PUfZeSDokbeo73QX2erYzkuxKQMKgSGu01wa5cFvpE9AtpPZ7bOI2E7VahxMsfCPhVz6aEmVM
 CuraZ36CG14MAuPzF+X9EbD9UcXSCclcYFL29NHmElfkHR8tosbOSXoTSSDNdD1nRwQnSE+5h
 ayRBkSaGK9IvAsgA9MgPdUpCRf5Q7jUbg7sgdEhF9cjafJh3tivPI0F+9/LBAHskM7szGaIMv
 +QtvnHvV+WD8l/JjzrbKWAqTcMw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/5 23:01, Bernd Lentes wrote:
>> -----Original Message-----
>> From: Qu Wenruo <wqu@suse.com>
>> Sent: Wednesday, July 5, 2023 10:46 AM
>> To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>; Qu Wenruo
>> <quwenruo.btrfs@gmx.com>; linux-btrfs <linux-btrfs@vger.kernel.org>
>> Subject: Re: question to btrfs scrub
>> That's why it doesn't report the csum error, and we need "--check-data-
>> csum"
>> to verify data csum.
>>>
>>> OK. I started it. But isn't that the same as "btrfs scrub" ?
>>> The man page gives a hint:
>>> --check-data-csum
>>> verify checksums of data blocks
>>> This expects that the filesystem is otherwise OK, and is basically an =
offline
>>> scrub that does not repair data from spare copies.
>
>> Btrfs check has way more comprehensive checks on metadata, but it by
>> default not check data csums.
>
>> Which is quite the opposite of btrfs scrub, which only checks data csum=
, and
>> metadata checks are very lightweight.
>
>> The main thing here is, nodatacow implies nodatacsum, thus it would not
>> generate any csum nor verify it.
>
> But aren't checksums important in case of errors ?

Checksum have two functions:

- Detect errors
   As long as it's not a false alert, then it makes sense.
   But please keep in mind that, a csum mismatch will prevent anyone
   from reading that corrupted data, whether this is the expected
   behavior really depends on your workload.

   E.g. if some archive with built-in error detect and recovery (like RAR
   files), it's definitely not a good idea to return -EIO for the whole
   block, other than reading out the corrupted data and let the software
   to handle them.

- Recover the good data from the extra mirrors
   This only works if you're using profiles with duplication (DUP,
   RAID1*, RAID10, RAID5, RAID6).
   Otherwise btrfs won't be able to recover anything.

In your case, since you're already using LVM, thus I believe the fs is
using default profiles (DUP for meta, SINGLE for data), thus there would
be no extra copy to recover from.

So there is really error detection functionality lost if go nodatasum.

> OK. I know which VM images produced checksum errors. I delete them and r=
estore them from the backup.

You mentioned snapshots are utilized for those images, thus you have to
delete all the involved files, including ones in the snapshots.

> Then I set the attribute for the directory.
>
> OK ?
>
> Here my output from the btrfs check:
> ha-idg-1:~ # btrfs check -p --check-data-csum /dev/vg_san/lv_domains
> Opening filesystem to check...
> Checking filesystem on /dev/vg_san/lv_domains
> UUID: bbcfa007-fb2b-432a-b513-207d5df35a2a
> [1/7] checking root items                      (0:00:35 elapsed, 6900134=
 items checked)
> [2/7] checking extents                         (0:01:58 elapsed, 484995 =
items checked)
> [3/7] checking free space cache                (0:00:14 elapsed, 5184 it=
ems checked)
> [4/7] checking fs roots                        (0:02:38 elapsed, 65549 i=
tems checked)
> mirror 1 bytenr 1489997918208 csum 0x0e45a39c expected csum 0xaa326ac93 =
items checked)
> mirror 1 bytenr 2036881817600 csum 0x714ca3eb expected csum 0x2cf56c3f9 =
items checked)
> mirror 1 bytenr 2708733394944 csum 0xa5bc757d expected csum 0x7055fdf48 =
items checked)
> mirror 1 bytenr 2743035994112 csum 0x743f7516 expected csum 0x2f21def46 =
items checked)
> mirror 1 bytenr 2855677394944 csum 0x50cbb065 expected csum 0xfb923a738 =
items checked)
> mirror 1 bytenr 4354053398528 csum 0x62eba801 expected csum 0x879bde4a0 =
items checked)
> mirror 1 bytenr 4355127242752 csum 0x71594d4c expected csum 0x879bde4a1 =
items checked)
> mirror 1 bytenr 4359422152704 csum 0x71594d4c expected csum 0x879bde4a6 =
items checked)
>   ...
> mirror 1 bytenr 5227759489024 csum 0x92051821 expected csum 0xa61efb7f89=
 items checked)
> mirror 1 bytenr 5229552353280 csum 0x26981ed8 expected csum 0xad21497c44=
 items checked)
> mirror 1 bytenr 5229990215680 csum 0x27f66fb8 expected csum 0x746827b001=
 items checked)
> mirror 1 bytenr 5231527952384 csum 0x9cfa691f expected csum 0x2847c53493=
 items checked)
> mirror 1 bytenr 5233822765056 csum 0xe8072b89 expected csum 0xaf60264806=
 items checked)
> mirror 1 bytenr 5234632364032 csum 0xfd83365b expected csum 0x26dc10d424=
 items checked)
> [5/7] checking csums against data              (3:54:58 elapsed, 3236328=
 items checked)
> ERROR: errors found in csum tree
> [6/7] checking root refs                       (0:00:00 elapsed, 13 item=
s checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 5396770611200 bytes used, error(s) found
> total csum bytes: 5263001424
> total tree bytes: 7945863168
> total fs tree bytes: 1077493760
> total extent tree bytes: 828391424
> btree space waste bytes: 1124143787
> file data blocks allocated: 127704684556288
>   referenced 8084906622976
>
> So it finds errors in the data csum, correct ?

Yes, either there are some files not deleted, or the file is snapshoted.

You'll need to resolve the file, either through scrub (and check dmesg
of the file names), or go with "btrfs inspect logical -o <bytenr like
2743035994112> <mount point>" to find the files.

Otherwise your fs is completely fine.

Thanks,
Qu

> Thanks.
>
> Bernd
>
>
>
> Helmholtz Zentrum M=C3=BCnchen =E2=80=93 Deutsches Forschungszentrum f=
=C3=BCr Gesundheit und Umwelt (GmbH)
> Ingolst=C3=A4dter Landstra=C3=9Fe 1, D-85764 Neuherberg, https://www.hel=
mholtz-munich.de
> Gesch=C3=A4ftsf=C3=BChrung: Prof. Dr. med. Dr. h.c. Matthias Tsch=C3=B6p=
, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir=E2=80=99in Pro=
f. Dr. Veronika von Messling
> Registergericht: Amtsgericht M=C3=BCnchen HRB 6466 | USt-IdNr. DE 129521=
671

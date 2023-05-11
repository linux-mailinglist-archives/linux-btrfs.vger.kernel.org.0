Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C609D6FEE94
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjEKJU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbjEKJTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 05:19:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73B93F8
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683796767; i=quwenruo.btrfs@gmx.com;
        bh=eedaMKwwGmU7A7i36abeWTCQwgbBinJBOfj9dEfFD8w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CQDvIz4nIj+GAn9MNdYafiSEKb7IGqRhX0Ly761fVw5TIutv0kzRLm+V3EI8I9OdV
         xEKkVsl3aENZErUSLReT+zxqYPHogUY38HIYM60Yr5Clu1W5YW0V+FZQDdcZ+/Q5ei
         Q3Cg0gXqJvDuOU4sxyCY3+inpAv1TdOX4ghdjh/iAfHeF3SbgNIGYvPye13talIZBw
         xpzz2kP32ZWaco+TCzwfK47aeRoCm2Y4P7LrjopXz1dyUjcDkGFJhU1tA7ldXpusL2
         4jvURYR8bYvGqiXur8tTIVwq4EB6CArFBOCedQGn10GJ4of27nJcJllR7rtfKCj1D9
         SwHf8YohZdSeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1qeJhZ05Ac-00jnwu; Thu, 11
 May 2023 11:19:27 +0200
Message-ID: <5a36af11-2325-6725-ccfe-779babe7fd21@gmx.com>
Date:   Thu, 11 May 2023 17:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Scrub errors unable to fixup (regular) error
Content-Language: en-US
To:     hendrik@friedels.name
Cc:     Qu Wenruo <wqu@suse.com>, Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
 <f941dacc-89f0-a9bc-a81a-aaf18d4fad47@gmail.com>
 <em3a7de55d-2b2b-45f6-9ecd-0725bd9bbace@59307873.com>
 <760e7198-4360-d68f-83fd-5ff27be57db5@gmx.com>
 <20230508205117.Horde.RK1QaW1dK8JHObLzII7D9cs@webmail.friedels.name>
 <6528e2b3-cc84-2faa-29e5-9a26fe1685a7@gmx.com>
 <20230509192639.Horde.QxWaLhyEPB3pLQHuBQtufoy@webmail.friedels.name>
 <6a175825-67a5-89f5-8456-6ffcf492ee9f@suse.com>
 <20230510171413.Horde.Hni1DVgjm4BqVg4XdHnLRsT@webmail.friedels.name>
 <9bf450c9-0efd-f1d0-4af6-d20d77929d33@gmx.com>
 <20230511100430.Horde.Q4rsEEoGJiD70MPHAHrw-Ir@webmail.friedels.name>
 <04805c00-ab15-f121-fd71-7d2ca4ffca9d@gmx.com>
 <20230511102616.Horde.PQt3Ahvb38yOP4F7xIyeaf5@webmail.friedels.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230511102616.Horde.PQt3Ahvb38yOP4F7xIyeaf5@webmail.friedels.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EJGR2VsDVIkWB/mKge6ewOKd50pJYX6WyGBteSwOJxkjF92psDw
 0b4LwRTUBOVkp9yRq2Msz5X2X7VsU0nD4Gho0MkvSbIhWFy2s8uhpFkYAbLFp2mwDzoujxl
 Pd2DwIQLQtnO3gl5mn9rtqgM8rQIENJz1lDNYokcNRE93dqalOFQZGN8bH5eckDNQhqIHzQ
 ZgSfeYdCIIfHDf71DrhIg==
UI-OutboundReport: notjunk:1;M01:P0:Z+No4NQ64Nw=;if3sfunsyYg36NHXtRq/bqUF8CH
 7xsFoAbd33A8o8G7dVHha37+5gR13gN9njHbY/l0lGnb4cjYsK7spC9vH/XQP0CHgRAiuiN7X
 hVJh/sSIUDlCEkHAniaUHVm1r/lXEyRt6cOcnwOkuhCELkMfLxTN//k6v9+vJVk4GT5RwU5r0
 ri+Q0tqPl5LAAvns15+RqvnkBBsX7EHZXqK3GtdKK8EGpETiQtgbkWzX9pg+9li6uWoEap8j3
 O3BpXILZZsOA0g0S1iUxLgSd5rod9hzshZrbQGb5lT1E1ivBafOA5rI1D3Tqz/MA5vOI9QKaU
 GNdZ8l9UbIu2eS9Ga4jtWmHLr7VsQfdbwYouWvNoNAGpjpnwPxClhGw666u6kk3U+5zJBWYv4
 zA3v0H1bZP0O5IjqFYHqAD5JKE0ZKP5ZuhQO/dWoaNF3yfeaLuBdsUXuFmUmzJmoY1rtI/mbb
 NsArYo5itC8OiMA0H5RSw1FUl+jruOF1fWm6tPZgu8BDknxT6D4sucn3RKhO5xv6iKorvuqmS
 wJRFWZsaU/qFmqfgkNhenlmO4q0tDWEmGkrN01rw7s12OHe5HDXzsM0/Jwvra+zNCpcRnetQO
 z6Wb8lzFZQMs5+yxhrfzEufnVqDJw7qsIAu4kH0VtPrWZkG54nU5Yx+NKYx8Yd151acUHwA/R
 YUgzyVTIR+wvdGOyHJc52jnJkZcAgPqgRWQLqpwQwbNpnDYLjflrnLrrb8hqeM4CoGcKbjlTm
 Q/fYt3BRbDoeEu9qLw2rTqERktdRcevmnEoGKq1hnnvAkccLnuE27fWeXbPNyhCPZxXY+EE2J
 8cJnMSRzBWu6KoW3wbgNUORBWOHOjkGJ9i6q/DvSExfeiqGgmiPKKRdlFK1Ib/mC6ST/b136/
 lp1DVDPoWWqECBalG/PpKCyECXzQXek190vTK7y2T1s3L1Y1hGtpcUi0zQ0eV99ncRiKtRGi/
 ztFawnn/ISeICpfoT+Qeq2Cd7Ms=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/11 16:26, hendrik@friedels.name wrote:
> Hello Qu,
>
>> I believe that extent is already being marked orphan but by somehow the
>> cleaner is not working on cleaning it up.
>
>> Mind to use the following command to dump needed info?
>>
>> # btrfs ins logical-resolve -P 256655540224 <mnt>
>
> No output.
>
> I now ran both commands on all 557 extents that scrub found up to now
> and reported in dmesg.
>
> Original command (w/o -P)
> /mnt/temp/VMs/haos_ova-9.4.qcow2
>
> New command (-P)
> inode 20516966 offset 6654013440 root 5

And then

# btrfs ins dump-tree -t 5 <mnt> | grep -A5 20516966

This may contain filenames, if you want to hide it, "--hide-names"
option can be appended to "btrfs ins dump-tree".

Thanks,
Qu

>
> That means, for 556 extents, I get no result.
> What does this mean?
>
> Greetings,
> Hendrik
>
>> With output, I still need to dump the offending inode of the subvolume
>> later.
>>
>> Thanks,
>> Qu
>>>
>>> Best regards,
>>> Hendrik
>>>
>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>> On 2023/5/10 23:14, hendrik@friedels.name wrote:
>>>>> Thanks Qu,
>>>>>
>>>>> compiling (and make install) worked.
>>>>> However, I still get no list of the affected files:
>>>>> root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve
>>>>> 256655245312 /mnt/temp/
>>>>> /dev/sda3 on /mnt/temp type btrfs
>>>>> (rw,relatime,ssd,space_cache,subvolid=3D5,subvol=3D/)
>>>>
>>>> It's possible the bytenr is for deleted files, in that case
>>>> logical-resolve won't find the filename.
>>>>
>>>>>
>>>>> Are the NNNNNNN (here 256655245312) changing after reboot?
>>>>> I did in the meantime reboot, so currently the dmesg does not have a=
ny
>>>>> errors...
>>>>> Do I need to run scrub again?
>>>>
>>>> It's better to scrub again to make sure if the affected extent is gon=
e.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Greetings,
>>>>> Hendrik
>>>>>
>>>>>
>>>>> Quoting Qu Wenruo <wqu@suse.com>:
>>>>>
>>>>>> On 2023/5/10 01:26, hendrik@friedels.name wrote:
>>>>>>> Hi Qu,
>>>>>>>
>>>>>>> thanks for your reply.
>>>>>>>
>>>>>>> I feel a bit helpless:
>>>>>>> wget
>>>>>>> https://github.com/kdave/btrfs-progs/archive/16f9a8f43a4ed6984349b=
502151049212838e6a0.zip
>>>>>>> unpack, change into dir
>>>>>>> patch --dry-run -ruN --strip 1 < ../patch
>>>>>>>
>>>>>>> checking file Documentation/btrfs-inspect-internal.rst
>>>>>>> checking file cmds/inspect.c
>>>>>>> Hunk #1 FAILED at 167.
>>>>>>> Hunk #2 FAILED at 216.
>>>>>>> Hunk #3 FAILED at 258.
>>>>>>> 3 out of 3 hunks FAILED
>>>>>>> checking file common/utils.c
>>>>>>> Hunk #1 FAILED at 424.
>>>>>>> Hunk #2 succeeded at 528 with fuzz 1.
>>>>>>> 1 out of 2 hunks FAILED
>>>>>>> checking file
>>>>>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>>>>>> Hunk #1 FAILED at 51.
>>>>>>> 1 out of 1 hunk FAILED
>>>>>>>
>>>>>>> What am I doing wrong?
>>>>>>
>>>>>> Please grab this branch directly:
>>>>>>
>>>>>> https://github.com/adam900710/btrfs-progs/tree/logic_resolve
>>>>>>
>>>>>> You can go git command to fetch that branch or through the webUI to
>>>>>> download the zip.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Hendrik
>>>>>>>
>>>>>>>
>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>
>>>>>>>> On 2023/5/9 02:51, hendrik@friedels.name wrote:
>>>>>>>>> Dear Qu,
>>>>>>>>>
>>>>>>>>> great, thank you!
>>>>>>>>> Can you tell me, where to find the basis for this patch?
>>>>>>>>>
>>>>>>>>> I tried to patch against master of
>>>>>>>>> https://github.com/kdave/btrfs-progs, but that seems wrong:
>>>>>>>>>
>>>>>>>>> checking file Documentation/btrfs-inspect-internal.rst
>>>>>>>>> checking file cmds/inspect.c
>>>>>>>>> Hunk #1 FAILED at 167.
>>>>>>>>> Hunk #2 FAILED at 216.
>>>>>>>>> Hunk #3 FAILED at 258.
>>>>>>>>> 3 out of 3 hunks FAILED
>>>>>>>>> checking file common/utils.c
>>>>>>>>> Hunk #1 FAILED at 424.
>>>>>>>>> Hunk #2 succeeded at 528 with fuzz 1.
>>>>>>>>> 1 out of 2 hunks FAILED
>>>>>>>>> checking file
>>>>>>>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>>>>>>>> Hunk #1 FAILED at 51.
>>>>>>>>> 1 out of 1 hunk FAILED
>>>>>>>>>
>>>>>>>>> I have also tried to patch against v6.3 also with failed Hunks.
>>>>>>>>
>>>>>>>> It needs to be applied to David's devel branch.
>>>>>>>>
>>>>>>>> I applied against 16f9a8f43a4ed6984349b502151049212838e6a0
>>>>>>>> btrfs-progs: build: enable -Wmissing-prototypes, and it works as
>>>>>>>> expected.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Hendrik
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>>>
>>>>>>>>>> On 2023/4/5 16:41, Hendrik Friedel wrote:
>>>>>>>>>>> Hello Andrei,
>>>>>>>>>>>
>>>>>>>>>>> this partially works:
>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>> logical-resolve 254530580480
>>>>>>>>>>
>>>>>>>>>> The user interface of logical-resolve is a total mess, it
>>>>>>>>>> requires
>>>>>>>>>> every subvolume to be mounted.
>>>>>>>>>>
>>>>>>>>>> You can apply this patch, and mount the subvolid 5, then
>>>>>>>>>> logical-resolve would properly handle all the path lookup:
>>>>>>>>>>
>>>>>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/7ccf52d3=
5fdcdf743a254f3c93065f9334d878f8.1681971385.git.wqu@suse.com/
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E=
-part3/
>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/582/snapshot cou=
ld
>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/586/snapshot cou=
ld
>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/583/snapshot cou=
ld
>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/584/snapshot cou=
ld
>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/581/snapshot cou=
ld
>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/585/snapshot cou=
ld
>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>> logical-resolve 224457719808
>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E=
-part3/
>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>> logical-resolve 196921389056
>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E=
-part3/
>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>> logical-resolve 254530899968
>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E=
-part3/
>>>>>>>>>>>
>>>>>>>>>>> I do not quite understand, why it complains of the subvol not
>>>>>>>>>>> being mounted, as I have mounted the root-volume...
>>>>>>>>>>>
>>>>>>>>>>> However, it already shows that some of the files (all that I
>>>>>>>>>>> found) are in snapshots, which are read only...
>>>>>>>>>>>
>>>>>>>>>>> I am not sure, what the best way would be to get rid of the
>>>>>>>>>>> errors. Do you have any suggestion?
>>>>>>>>>>>
>>>>>>>>>>> Best regards,
>>>>>>>>>>> Hendrik
>>>>>>>>>>>
>>>>>>>>>>> ------ Originalnachricht ------
>>>>>>>>>>> Von "Andrei Borzenkov" <arvidjaar@gmail.com>
>>>>>>>>>>> An "Hendrik Friedel" <hendrik@friedels.name>
>>>>>>>>>>> Cc linux-btrfs@vger.kernel.org
>>>>>>>>>>> Datum 04.04.2023 21:07:42
>>>>>>>>>>> Betreff Re: Scrub errors unable to fixup (regular) error
>>>>>>>>>>>
>>>>>>>>>>>> On 03.04.2023 09:44, Hendrik Friedel wrote:
>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>
>>>>>>>>>>>>> thanks.
>>>>>>>>>>>>> Can you Tell ne, how I identify the affected files?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> You could try
>>>>>>>>>>>>
>>>>>>>>>>>> btrfs inspect-internal logical-resolve NNNNN /btrfs/mount/poi=
nt
>>>>>>>>>>>>
>>>>>>>>>>>> where NNNNN is logical address from kernel message
>>>>>>>>>>>>
>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>>
>>>>>>>>>>>>> Am 03.04.2023 08:41 schrieb Andrei Borzenkov
>>>>>>>>>>>>> <arvidjaar@gmail.com>:
>>>>>>>>>>>>>
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 On Sun, Apr 2, 2023 at 10:26=E2=80=
=AFPM Hendrik Friedel
>>>>>>>>>>>>> <hendrik@friedels.name> wrote:
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Hello,
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > after a scrub, I had these =
errors:
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:28 20=
23] BTRFS info (device sda3):
>>>>>>>>>>>>> scrub: started on
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > devid 1
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, =
corrupt 63, gen 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical =
2244718592 on dev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, =
corrupt 64, gen 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical =
2260582400 on dev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, =
corrupt 65, gen 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, =
corrupt 66, gen 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical =
2260054016 on dev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical =
2259877888 on dev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, =
corrupt 67, gen 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical =
2259935232 on dev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, =
corrupt 68, gen 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 20=
23] BTRFS error (device sda3):
>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical =
2264600576 on dev /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > root@homeserver:~# btrfs sc=
rub status /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > UUID:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c1534c07-d669-4f55-ae5=
0-b87669ecb259
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Scrub started:=C2=A0=C2=A0=
=C2=A0 Sat Apr=C2=A0 1 23:24:01 2023
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Status:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Duration:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:09:03
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Total to scrub:=C2=A0=C2=A0=
 146.79GiB
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Rate:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 241.40MiB/s
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Error summary:=C2=A0=C2=A0=
=C2=A0 csum=3D239
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 Corrected=
:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 Uncorrect=
able:=C2=A0 239
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 Unverifie=
d:=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > root@homeserver:~# btrfs fi=
 show /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Label: none=C2=A0 uuid:
>>>>>>>>>>>>> c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 146.79GiB
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 198.45GiB used =
198.45GiB path
>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Smartctl tells me:
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > SMART Attributes Data Struc=
ture revision number: 16
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Vendor Specific SMART Attri=
butes with Thresholds:
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > ID# ATTRIBUTE_NAME=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FLAG=C2=A0=C2=A0=C2=A0=C2=A0=
 VALUE WORST
>>>>>>>>>>>>> THRESH
>>>>>>>>>>>>> TYPE
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > UPDATED=C2=A0 WHEN_FAILED R=
AW_VALUE
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 1 Raw_Rea=
d_Error_Rate=C2=A0=C2=A0=C2=A0=C2=A0 0x002f=C2=A0=C2=A0 100=C2=A0=C2=A0 10=
0=C2=A0=C2=A0 000
>>>>>>>>>>>>> =C2=A0Pre-fail=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 5 Realloc=
ate_NAND_Blk_Cnt 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 010
>>>>>>>>>>>>> =C2=A0Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 9 Power_O=
n_Hours=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=
=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> =C2=A0Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4930
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0 12 Power_Cycle_=
Count=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=
=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> =C2=A0Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1864
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 171 Program_Fail_Count=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=
=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 172 Erase_Fail_Count=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 10=
0=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 173 Ave_Block-Erase_Count=
=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 049=C2=A0=C2=A0 049=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 769
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 174 Unexpect_Power_Loss_Ct=
=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 183 SATA_Interfac_Downshift=
 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 184 Error_Correction_Count=
=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 187 Reported_Uncorrect=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=
=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 194 Temperature_Celsius=C2=
=A0=C2=A0=C2=A0=C2=A0 0x0022=C2=A0=C2=A0 068=C2=A0=C2=A0 051=C2=A0=C2=A0 0=
00
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32 (Min/Max 9/49)
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 196 Reallocated_Event_Count=
 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 197 Current_Pending_ECC_Cnt=
 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 198 Offline_Uncorrectable=
=C2=A0=C2=A0 0x0030=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Offline=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 199 UDMA_CRC_Error_Count=C2=
=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 202 Percent_Lifetime_Remain=
 0x0030=C2=A0=C2=A0 049=C2=A0=C2=A0 049=C2=A0=C2=A0 001
>>>>>>>>>>>>> Old_age
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Offline=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 51
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 206 Write_Error_Rate=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x000e=C2=A0=C2=A0 100=C2=A0=C2=A0 10=
0=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 246 Total_LBAs_Written=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=
=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 146837983747
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 247 Host_Program_Page_Count=
 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4592609183
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 248 FTL_Program_Page_Count=
=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4948954393
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 180 Unused_Reserve_NAND_Blk=
 0x0033=C2=A0=C2=A0 000=C2=A0=C2=A0 000=C2=A0=C2=A0 000
>>>>>>>>>>>>> Pre-fail=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2050
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 210 Success_RAIN_Recov_Cnt=
=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > What would you recommend wr=
t. the health of the drive
>>>>>>>>>>>>> (ssd) and to fix
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > these errors?
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>>>
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Scrub errors can only be corrected =
if the filesystem has
>>>>>>>>>>>>> redundancy.
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 You have a single device which in t=
he past defaulted to
>>>>>>>>>>>>> dup for
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 metadata and single for data. If er=
rors are in the data
>>>>>>>>>>>>> part, then the
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 only way to fix it is to delete fil=
es containing these
>>>>>>>>>>>>> blocks.
>>>>>>>>>>>>>
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Scrub error means data written to s=
table storage is bad.
>>>>>>>>>>>>> It is
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 unlikely caused by SSD error, could=
 be software bug,
>>>>>>>>>>>>> could
>>>>>>>>>>>>> be faulty
>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 RAM.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
>
>
>

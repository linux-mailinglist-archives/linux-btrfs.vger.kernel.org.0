Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4542A6FEDBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjEKIQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjEKIQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 04:16:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D21273B
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683792978; i=quwenruo.btrfs@gmx.com;
        bh=FwamH2QRQAcS68XVjz5KbF1Wl7boPkE+pMfphKeSY98=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fpj0rWYlBvQ1FCW5gDbUmAttPoeQI76dACeEcmCMli4z1Y0nFqpKfMAJTgBXn/ZdK
         t6mvn4ahR7g7hYrJk+1WoVguiCE8CpOrUP+LKv48FWSrww4cbR3Brv4tdHJEZ7CMNZ
         mcy1jFavDDrNzrpyH2NEd12RM1pC4IPG24nmt//AnvG4OSKHIJTUOnkXrrnEolylI9
         FGOuBxQLUQljRsIgD8n0pjkWsAtecQnIShnsZc7R2cYY65W2Nm7yJIgJZ96g+u/srM
         iEqyUvPEOmL2VUwPqJ21kDOWcI51IRBc1vDxLIjWPYtUdSGAS2DuTRxbKpCkHLBqai
         R/+51J0syTZFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTRH-1paHWG1py9-00NOz6; Thu, 11
 May 2023 10:16:18 +0200
Message-ID: <04805c00-ab15-f121-fd71-7d2ca4ffca9d@gmx.com>
Date:   Thu, 11 May 2023 16:16:14 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230511100430.Horde.Q4rsEEoGJiD70MPHAHrw-Ir@webmail.friedels.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b2FV6SG5UocqwPEQpFCiTePVLB/wjlgQazq8OapFdmO1E79uZ9q
 dNa8VIlwjtzIS4Ul1HOkzFZW1ZWme/mAKswSxEDjs0bmwEavbYubu0qEZFDFAT8mC/7eia8
 PXw9zEPCY/Snj+uDv1RWPqCgC4Pj0/Y0VObd5Cmo7YJN2RsGb3i6QP04PfNh+eMrDxkawZU
 gaTKFsrQy3Q2He3l5vLpQ==
UI-OutboundReport: notjunk:1;M01:P0:Ruh2PH7tqLI=;FbJHQdUIIH0zKYgVYlQqwx7IMqa
 bwYLUgvE+BkYv+HD6FR5mb+OtT9WHs3sdRWfCufpU9aSwdhpceRW4Q4YJGskvIFtErR2M5gRT
 BF8P6mTZTkhtuihlc4fPwp+e2iM/4NS2V5aZxU5vvfetEfHlnhfLUJUjqedRlo8nbrCovMWq4
 EQgxDlp1c7uLlfkfS26NrFXzFoR1kajvFfMWGS4zQyRCKrWH/faRp5mH2vreYV+Piza4tefRQ
 Xo4OU5KGmwP5r/QyH9UteY3MvpbeYPIei3uRtQzR2FQ/zuOTnvBZ1cdDDPWSF7ywUdpX8Ifdn
 /M/FgtbYL/B10K4A7xwWsZmrP1xCXSe0xJEvqNOh6ALJVnCKOFvpwamIadr+TCaHvhKmeVbte
 RclX0SEWURJgEwBemXNjDuh/AW7yBanO+cPkRnrsmrPsVW4420RefdvESRQVEokVOqeI9L7PE
 0AgLo9OahIXvfNcvI3q4YjwYK4B/ml3BTg32UwV5rzFooO0AUA3RbvBWT1WvcsF1wPJrf9mu2
 HejDXk9xXF+1VGwN91pmyEwKrobcFeYOaVN1lv8bQ2d7rVVhKxCGM42vkbyUYVrNve682oXIx
 VQsmVtYaSuYGkOnpHT4gMPYNogHePRv0tB6u8Rc6cBpYtQv5vhXpCzVrZ2agM0ct03LBorpAR
 kCc7ovycTviBsmL15n+yi6HaVmbxC70yHr0J3AWpLnYgDY08LMJz5/PHCTBMMO8NhyIY1gph+
 yCVNUtEsBBvHc8khGXdwCrDT8JQeoh8M2SCOEvluArJlAP5gn7Z8PbRUpg9tM3C/cgNye8PV3
 q1ctyhpH5UkHv4CWiU+mg8mCAzSfVbawLFioCOEzYdQNfMVWTZLoF9x379H27pZNacIUblJrf
 1w8xcr1aDjbAOsrTf/svrPGEEHQYXKcgle8dCQjZ5eHd+Fq23fd+LUV8OR8KmjG7HfUUKzMX8
 wHRcHaOAFury0QpbQCnq2HpET3k=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/11 16:04, hendrik@friedels.name wrote:
> Hello Quo,
>
> thanks, I ran scrub again:
>
> [124741.003800] BTRFS error (device sda3): unable to fixup (regular)
> error at logical 256655540224 on dev /dev/sda3
>
>
> root@homeserver:~# /root/btrfs/qu/btrfs-progs/btrfs inspect-internal
> logical-resolve 256655540224 /mnt/temp/
>
> /dev/sda3 on /mnt/temp type btrfs
> (rw,relatime,ssd,space_cache,subvolid=3D5,subvol=3D/)
>
> It does not seem to work as intended - or am I doing something wrong?

I believe that extent is already being marked orphan but by somehow the
cleaner is not working on cleaning it up.

Mind to use the following command to dump needed info?

# btrfs ins logical-resolve -P 256655540224 <mnt>

With output, I still need to dump the offending inode of the subvolume
later.

Thanks,
Qu
>
> Best regards,
> Hendrik
>
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>> On 2023/5/10 23:14, hendrik@friedels.name wrote:
>>> Thanks Qu,
>>>
>>> compiling (and make install) worked.
>>> However, I still get no list of the affected files:
>>> root@homeserver:/home/henfri# btrfs inspect-internal logical-resolve
>>> 256655245312 /mnt/temp/
>>> /dev/sda3 on /mnt/temp type btrfs
>>> (rw,relatime,ssd,space_cache,subvolid=3D5,subvol=3D/)
>>
>> It's possible the bytenr is for deleted files, in that case
>> logical-resolve won't find the filename.
>>
>>>
>>> Are the NNNNNNN (here 256655245312) changing after reboot?
>>> I did in the meantime reboot, so currently the dmesg does not have any
>>> errors...
>>> Do I need to run scrub again?
>>
>> It's better to scrub again to make sure if the affected extent is gone.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Greetings,
>>> Hendrik
>>>
>>>
>>> Quoting Qu Wenruo <wqu@suse.com>:
>>>
>>>> On 2023/5/10 01:26, hendrik@friedels.name wrote:
>>>>> Hi Qu,
>>>>>
>>>>> thanks for your reply.
>>>>>
>>>>> I feel a bit helpless:
>>>>> wget
>>>>> https://github.com/kdave/btrfs-progs/archive/16f9a8f43a4ed6984349b50=
2151049212838e6a0.zip
>>>>> unpack, change into dir
>>>>> patch --dry-run -ruN --strip 1 < ../patch
>>>>>
>>>>> checking file Documentation/btrfs-inspect-internal.rst
>>>>> checking file cmds/inspect.c
>>>>> Hunk #1 FAILED at 167.
>>>>> Hunk #2 FAILED at 216.
>>>>> Hunk #3 FAILED at 258.
>>>>> 3 out of 3 hunks FAILED
>>>>> checking file common/utils.c
>>>>> Hunk #1 FAILED at 424.
>>>>> Hunk #2 succeeded at 528 with fuzz 1.
>>>>> 1 out of 2 hunks FAILED
>>>>> checking file
>>>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>>>> Hunk #1 FAILED at 51.
>>>>> 1 out of 1 hunk FAILED
>>>>>
>>>>> What am I doing wrong?
>>>>
>>>> Please grab this branch directly:
>>>>
>>>> https://github.com/adam900710/btrfs-progs/tree/logic_resolve
>>>>
>>>> You can go git command to fetch that branch or through the webUI to
>>>> download the zip.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Best regards,
>>>>> Hendrik
>>>>>
>>>>>
>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>
>>>>>> On 2023/5/9 02:51, hendrik@friedels.name wrote:
>>>>>>> Dear Qu,
>>>>>>>
>>>>>>> great, thank you!
>>>>>>> Can you tell me, where to find the basis for this patch?
>>>>>>>
>>>>>>> I tried to patch against master of
>>>>>>> https://github.com/kdave/btrfs-progs, but that seems wrong:
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
>>>>>>> I have also tried to patch against v6.3 also with failed Hunks.
>>>>>>
>>>>>> It needs to be applied to David's devel branch.
>>>>>>
>>>>>> I applied against 16f9a8f43a4ed6984349b502151049212838e6a0
>>>>>> btrfs-progs: build: enable -Wmissing-prototypes, and it works as
>>>>>> expected.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Hendrik
>>>>>>>
>>>>>>>
>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>
>>>>>>>> On 2023/4/5 16:41, Hendrik Friedel wrote:
>>>>>>>>> Hello Andrei,
>>>>>>>>>
>>>>>>>>> this partially works:
>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>> logical-resolve 254530580480
>>>>>>>>
>>>>>>>> The user interface of logical-resolve is a total mess, it require=
s
>>>>>>>> every subvolume to be mounted.
>>>>>>>>
>>>>>>>> You can apply this patch, and mount the subvolid 5, then
>>>>>>>> logical-resolve would properly handle all the path lookup:
>>>>>>>>
>>>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/7ccf52d35f=
dcdf743a254f3c93065f9334d878f8.1681971385.git.wqu@suse.com/
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-p=
art3/
>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/582/snapshot could
>>>>>>>>> not be accessed: not mounted
>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/586/snapshot could
>>>>>>>>> not be accessed: not mounted
>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/583/snapshot could
>>>>>>>>> not be accessed: not mounted
>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/584/snapshot could
>>>>>>>>> not be accessed: not mounted
>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/581/snapshot could
>>>>>>>>> not be accessed: not mounted
>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/585/snapshot could
>>>>>>>>> not be accessed: not mounted
>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>> logical-resolve 224457719808
>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-p=
art3/
>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>> logical-resolve 196921389056
>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-p=
art3/
>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>> logical-resolve 254530899968
>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-p=
art3/
>>>>>>>>>
>>>>>>>>> I do not quite understand, why it complains of the subvol not
>>>>>>>>> being mounted, as I have mounted the root-volume...
>>>>>>>>>
>>>>>>>>> However, it already shows that some of the files (all that I
>>>>>>>>> found) are in snapshots, which are read only...
>>>>>>>>>
>>>>>>>>> I am not sure, what the best way would be to get rid of the
>>>>>>>>> errors. Do you have any suggestion?
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Hendrik
>>>>>>>>>
>>>>>>>>> ------ Originalnachricht ------
>>>>>>>>> Von "Andrei Borzenkov" <arvidjaar@gmail.com>
>>>>>>>>> An "Hendrik Friedel" <hendrik@friedels.name>
>>>>>>>>> Cc linux-btrfs@vger.kernel.org
>>>>>>>>> Datum 04.04.2023 21:07:42
>>>>>>>>> Betreff Re: Scrub errors unable to fixup (regular) error
>>>>>>>>>
>>>>>>>>>> On 03.04.2023 09:44, Hendrik Friedel wrote:
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> thanks.
>>>>>>>>>>> Can you Tell ne, how I identify the affected files?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> You could try
>>>>>>>>>>
>>>>>>>>>> btrfs inspect-internal logical-resolve NNNNN /btrfs/mount/point
>>>>>>>>>>
>>>>>>>>>> where NNNNN is logical address from kernel message
>>>>>>>>>>
>>>>>>>>>>> Best regards,
>>>>>>>>>>> Hendrik
>>>>>>>>>>>
>>>>>>>>>>> Am 03.04.2023 08:41 schrieb Andrei Borzenkov
>>>>>>>>>>> <arvidjaar@gmail.com>:
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 On Sun, Apr 2, 2023 at 10:26=E2=80=AF=
PM Hendrik Friedel
>>>>>>>>>>> <hendrik@friedels.name> wrote:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Hello,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > after a scrub, I had these er=
rors:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:28 2023=
] BTRFS info (device sda3):
>>>>>>>>>>> scrub: started on
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > devid 1
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, co=
rrupt 63, gen 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> unable to fixup
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical 22=
44718592 on dev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, co=
rrupt 64, gen 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> unable to fixup
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical 22=
60582400 on dev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, co=
rrupt 65, gen 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, co=
rrupt 66, gen 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> unable to fixup
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical 22=
60054016 on dev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> unable to fixup
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical 22=
59877888 on dev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, co=
rrupt 67, gen 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> unable to fixup
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical 22=
59935232 on dev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > errs: wr 0, rd 0, flush 0, co=
rrupt 68, gen 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > [Sa Apr=C2=A0 1 23:23:35 2023=
] BTRFS error (device sda3):
>>>>>>>>>>> unable to fixup
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > (regular) error at logical 22=
64600576 on dev /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > root@homeserver:~# btrfs scru=
b status /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > UUID:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c1534c07-d669-4f55-ae50-b=
87669ecb259
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Scrub started:=C2=A0=C2=A0=C2=
=A0 Sat Apr=C2=A0 1 23:24:01 2023
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Status:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Duration:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:09:03
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Total to scrub:=C2=A0=C2=A0 1=
46.79GiB
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Rate:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 241.40MiB/s
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Error summary:=C2=A0=C2=A0=C2=
=A0 csum=3D239
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 Corrected:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 Uncorrectab=
le:=C2=A0 239
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 Unverified:=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > root@homeserver:~# btrfs fi s=
how /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Label: none=C2=A0 uuid: c1534=
c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 146.79GiB
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 198.45GiB used 198=
.45GiB path
>>>>>>>>>>> /dev/sda3
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Smartctl tells me:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > SMART Attributes Data Structu=
re revision number: 16
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Vendor Specific SMART Attribu=
tes with Thresholds:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > ID# ATTRIBUTE_NAME=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FLAG=C2=A0=C2=A0=C2=A0=C2=A0=
 VALUE WORST THRESH
>>>>>>>>>>> TYPE
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > UPDATED=C2=A0 WHEN_FAILED RAW=
_VALUE
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 1 Raw_Read_=
Error_Rate=C2=A0=C2=A0=C2=A0=C2=A0 0x002f=C2=A0=C2=A0 100=C2=A0=C2=A0 100=
=C2=A0=C2=A0 000
>>>>>>>>>>> =C2=A0Pre-fail=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 5 Reallocat=
e_NAND_Blk_Cnt 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 010
>>>>>>>>>>> =C2=A0Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0 9 Power_On_=
Hours=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=
=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> =C2=A0Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4930
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0 12 Power_Cycle_Co=
unt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0=
 100=C2=A0=C2=A0 000
>>>>>>>>>>> =C2=A0Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1864
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 171 Program_Fail_Count=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=
=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 172 Erase_Fail_Count=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=
=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 173 Ave_Block-Erase_Count=C2=
=A0=C2=A0 0x0032=C2=A0=C2=A0 049=C2=A0=C2=A0 049=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 769
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 174 Unexpect_Power_Loss_Ct=C2=
=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 22
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 183 SATA_Interfac_Downshift 0=
x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 184 Error_Correction_Count=C2=
=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 187 Reported_Uncorrect=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=
=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 194 Temperature_Celsius=C2=A0=
=C2=A0=C2=A0=C2=A0 0x0022=C2=A0=C2=A0 068=C2=A0=C2=A0 051=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32 (Min/Max 9/49)
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 196 Reallocated_Event_Count 0=
x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 197 Current_Pending_ECC_Cnt 0=
x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 198 Offline_Uncorrectable=C2=
=A0=C2=A0 0x0030=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Offline=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 199 UDMA_CRC_Error_Count=C2=
=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 202 Percent_Lifetime_Remain 0=
x0030=C2=A0=C2=A0 049=C2=A0=C2=A0 049=C2=A0=C2=A0 001
>>>>>>>>>>> Old_age
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > Offline=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 51
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 206 Write_Error_Rate=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x000e=C2=A0=C2=A0 100=C2=A0=C2=A0 100=
=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 246 Total_LBAs_Written=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=
=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 146837983747
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 247 Host_Program_Page_Count 0=
x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4592609183
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 248 FTL_Program_Page_Count=C2=
=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4948954393
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 180 Unused_Reserve_NAND_Blk 0=
x0033=C2=A0=C2=A0 000=C2=A0=C2=A0 000=C2=A0=C2=A0 000
>>>>>>>>>>> Pre-fail=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2050
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > 210 Success_RAIN_Recov_Cnt=C2=
=A0 0x0032=C2=A0=C2=A0 100=C2=A0=C2=A0 100=C2=A0=C2=A0 000
>>>>>>>>>>> Old_age=C2=A0=C2=A0 Always
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > What would you recommend wrt.=
 the health of the drive
>>>>>>>>>>> (ssd) and to fix
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > these errors?
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Scrub errors can only be corrected if=
 the filesystem has
>>>>>>>>>>> redundancy.
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 You have a single device which in the=
 past defaulted to
>>>>>>>>>>> dup for
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 metadata and single for data. If erro=
rs are in the data
>>>>>>>>>>> part, then the
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 only way to fix it is to delete files=
 containing these
>>>>>>>>>>> blocks.
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Scrub error means data written to sta=
ble storage is bad.
>>>>>>>>>>> It is
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 unlikely caused by SSD error, could b=
e software bug, could
>>>>>>>>>>> be faulty
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 RAM.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
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

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FE72748F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 03:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjFHBoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 21:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjFHBnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 21:43:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA442D4A
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 18:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686188570; x=1686793370; i=quwenruo.btrfs@gmx.com;
 bh=KgW7Kywfv19RK7LKApetOBjB6QRb/LLEyLhOw+ZKZq8=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=ZbVNx9wAIFlS7/E4sXMVclK6kAU1aNB7bCLW8r5vf+AXOK6OkdDp81EVBnJqwu7hnKB3TK5
 WuA+9klM+MF8ZvsfKIIRY/JvbaSo7CY5i6sMFeyDEB9xCRKQnrBZUIVetmRgjXMidfaiMr5Q6
 LMjEwgQUIhSFwifvFwVOE9Ah5CWlb9pkeVlnzACvlcqVAmdPGkbMyrpN17x6Jew1XkGiqtyFa
 jR6WNn1BVrhkiMm7ZUG0iwMmEJD5HdlLJTz4HeR8dyI7IgHCn9O623q5FRaV1exuVDFL5OcFd
 Hi7Ub8kot+Ry7tq82UcBLpIHde8CD5OCnugZtQDDeLg5y8uTBa1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MStCe-1qbMsJ1P4Q-00ULrM; Thu, 08
 Jun 2023 03:42:49 +0200
Message-ID: <d8a2bb05-7f5b-baa9-fd4c-082acdbce9ce@gmx.com>
Date:   Thu, 8 Jun 2023 09:42:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686131669.git.anand.jain@oracle.com>
 <89e1a74a-e8e0-ea44-974c-ac8877caf549@gmx.com>
 <689772ce-010f-9017-4767-2d5770ac51df@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/9] btrfs-progs: btrfstune: accept multiple devices and
 cleanup
In-Reply-To: <689772ce-010f-9017-4767-2d5770ac51df@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o1zx8YPJ5FYfM+NavIzDnKUajL9aX0Lhn3mlolzLHk0Sg7P/PND
 E77NcvWDxV3zGPr1ARLRTBKCNPi0hVqG7fRFYP+tE2Egrxh9g2Sk7/9N4a1MEZixTqhWBjP
 Z4Iww/cbnWu6Y2eX7MuSrrvoDpJl0WG/lVpiepTOdxd74uWVhbI2GR57ylSdVQ9CD+nudIo
 DeFCyZ3tQLnlG8iky4TQw==
UI-OutboundReport: notjunk:1;M01:P0:23h4tT0+jXI=;5380OZWfjk4l92d594OpnwlmrYi
 2hZj2pnAOPxOoUOdDG/TB9q+lsKByMTW+rCsoyGxPMnwyCoqUMjxHjParaQ/xeqTd3SvAkXL+
 IuJdipn1FcBrloCPV7ywCT9Zk9iVNZuAKeOsxdCDLhmzO4ro+10rvzHQR+nfwVuOevycr1e36
 ZFDJ9hhB5lK53AWrT1jxU4Y2qKf8j5ki19Q54PoX1KgPdmoiGFYP1ljrMXsRt6bJcnSMTOy47
 EAMB2wEXy5F89AXXcUy/Sg251146Goe498BlDyMlzP7ciWt+o544tKSq5lAVA6HOMWdXGgsTp
 wJY1aHWyhcqT4S9C+N4SmYTZqADq6PQ8hbN1xa4RgW804qqZg6SeKHYoUK7qcIyrrfxytzJrf
 46LPduZMUsDQJZsc2wrlqwu8CnkOlmY9Q6bozhkiC2uj10374swMDbK7IMSyeOsv09PtFoIvt
 TdeROM5FaHYM/0xu5uIRQFPcNO+KTf1c9rVdKq9DRKiF3o9g8juCbAHFmr4Y+uxtRL/xrg9u1
 /yoZ3Xg6unyrCsh+Nh8/udBO6GjNs8cGZk/eWxWMx32JoodCS9FQVd0e2mGLEciC0AqUcnsEA
 6Q62weEZA0MKqAUsyARHLq+7JfMSRQL7I+vk4jYX8aH7q3b28I2zgHbh8G9zPfRGqzcrX7Wkz
 ItiqTH8/mFPGH6fIAV1KikTOssSURKCWpKlsz4wQsfPe339jvQpO/tewokDKE2is8NftxHDXk
 TJHIBJKZSYMlkpagorysjTJemrI1XtvmaV+hDFwLf+Mz+CMr5mgPSpSAascOlzywEcYvGbJ0/
 E4izfm6WpA2tJ48K7+AVh8KRIdMRtCOaD0y5n/0wUAMJeS1Ix7pm4xGmHh11d3B8hFcY1AFyw
 SbCMtzClGGatIt8r1FNnejE68mODoxaKFMCrPwr0d0YTVgKwdCtmDET+fCgjN82mGKoH4Ki4m
 pZqdKnrSf43SM28d36PRILl8y78=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 08:20, Anand Jain wrote:
> On 07/06/2023 19:06, Qu Wenruo wrote:
>>
>>
>> On 2023/6/7 17:59, Anand Jain wrote:
>>> In an attempt to enable btrfstune to accept multiple devices from the
>>> command line, this patch includes some cleanup around the related code
>>> and functions.
>>
>> Mind to share the use case of the new ability?
>>
>
>  =C2=A0As of now btrfstune works with only one regular file. Not possibl=
e
>  =C2=A0to use multiple regular files. Unless loop device is used. This
>  =C2=A0set fixes this limitation.

Here I want to make the point clear, is the patchset intended to handle
ONE multi-device btrfs?

If that's the case, then my initial concerns on the multiple different
fses case is still a concern.

>
>
>> My concern related to multi-device parameters are:
>>
>> - What if the provided devices are belonging to different filesystems?
>> =C2=A0=C2=A0 Should we still do the tune operation on all of them or ju=
st the
>> =C2=A0=C2=A0 first/last device?
>>
>
>  =C2=A0Hmm, the scan part remains same with/without this patchset.
>  =C2=A0The device_list_add() function organizes the devices based on the=
 fsid.
>  =C2=A0Any tool within the btrfs-progs uses this list to obtain the part=
ner5
>  =C2=A0device list. This patch set still relies the same thing.
>
>  =C2=A0btrfstune gets the fsid to work on from the first deivce in the l=
ist.
>
>  =C2=A0Here is an example:
>
> $ btrfs in dump-super ./td1 ./td2 ./td3 | egrep
> 'device=3D|^fsid|^metadata_uuid'
> superblock: bytenr=3D65536, device=3D./td1
> fsid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
931379a-a119-4eda-a338-badb0a197512
> metadata_uuid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f761b688-2642-4c=
94-be90-22f58e2a66d7
> superblock: bytenr=3D65536, device=3D./td2
> fsid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
9643d74-1d3d-4b0d-b56b-b05ada340f57
> metadata_uuid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f761b688-2642-4c=
94-be90-22f58e2a66d7
> superblock: bytenr=3D65536, device=3D./td3
> fsid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
931379a-a119-4eda-a338-badb0a197512
> metadata_uuid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f761b688-2642-4c=
94-be90-22f58e2a66d7
>
>
> $ btrfstune -m --noscan ./td2 ./td1 ./td3
> warning, device 1 is missing
> ERROR: cannot read chunk root
> ERROR: open ctree failed
>
> $ btrfstune -m --noscan ./td1 ./td2 ./td3
> $ echo $?
> 0

This is exactly my concern.

We're combining target fs and device assembly into the same argument list.

Thus changing the order of argument would lead to different results.

>
>  =C2=A0If you are concerned about the lack of explicit device's fsid to =
work
>  =C2=A0on. How about,
>
>  =C2=A0(proposal only, these options does not exists yet)
>
>  =C2=A0btrfstune -m --noscan --devices=3D./td2,./td3=C2=A0 ./td1

That much better, less confusion.

Furthermore, the --devices (Although my initial proposal looks more like
"--device td2 --device td3", which makes parsing a little simpler) can
be applied to all other btrfs-progs, allowing a global way to assemble
the device list.

>
>
>> - What's the proper error handling if operation on one of the parameter
>> =C2=A0=C2=A0 failed if we choose to do the tune for all involved device=
s?
>> =C2=A0=C2=A0 Should we revert the operation on the succeeded ones?
>> =C2=A0=C2=A0 Should we continue on the remaining ones?
>
>  =C2=A0Hm. That's a possible scenario even without this patch.!
>  =C2=A0However, we use the CHANGING_FSID flag to handle split-brain scen=
arios
>  =C2=A0with incomplete metadata_uuid changes. Currently, the kernel
>  =C2=A0fixes this situation based on the flag and generation number.
>  =C2=A0However, kernel should fail these split-brain scenarios and
>  =C2=A0instead address them in the btrfs-progs, which is wip.
>
>> I understand it's better to add the ability to do manual scan, but it
>> looks like the multi-device arguments can be a little more complex than
>> what we thought.
>
>  =C2=A0Hmm How? The device list enumeration logic which handles the auto=
matic
>  =C2=A0scan also handle the command line provided device list. So both a=
re
>  =C2=A0same.

The "--device=3D" option you proposed is exactly the way to handle it.

Thanks,
Qu
>
>> At least I think we should add a dedicate --scan/--device option, and
>> allow multiple --scan/--device to be provided for device list assembly,
>> then still keep the single argument to avoid possible confusion.
>
>  =C2=A0btrfs-progs scans all the block devices in the system, by default=
.
>  =C2=A0so IMO,
>  =C2=A0"--noscan" is reasonable, similar to 'btrfs in dump-tree --noscan=
'.
>
>  =C2=A0I am ok with with --device/--devices option.
>  =C2=A0So we could scan only commnd line provided devices
>  =C2=A0with --noscan:
>
>  =C2=A0=C2=A0 btrfstune -m --noscan --devices=3D./td1,/dev/sda1 ./td3
>
>  =C2=A0And to scan both command line and the block devices
>  =C2=A0without --noscan:
>
>  =C2=A0=C2=A0 btrfstune -m --devices=3D./td1 ./td3
>
>
> Thanks, Anand
>
>>
>> This also solves the problem I mentioned above. If multiple filesystems
>> are provided, they are just assembled into device list, won't have an
>> impact on the tune target.
>>
>> And since we still have a single device to tune, there is no extra erro=
r
>> handling, nor confusion.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Patches 1 to 5 primarily consist of cleanups. Patches 6 and 8 serve as
>>> preparatory changes. Patch 7 enables btrfstune to accept multiple
>>> devices. Patch 9 ensures that btrfstune no longer automatically uses t=
he
>>> system block devices when --noscan option is specified.
>>> Patches 10 and 11 are help and documentation part.
>>>
>>> Anand Jain (11):
>>> =C2=A0=C2=A0 btrfs-progs: check_mounted_where declare is_btrfs as bool
>>> =C2=A0=C2=A0 btrfs-progs: check_mounted_where pack varibles type by si=
ze
>>> =C2=A0=C2=A0 btrfs-progs: rename struct open_ctree_flags to open_ctree=
_args
>>> =C2=A0=C2=A0 btrfs-progs: optimize device_list_add
>>> =C2=A0=C2=A0 btrfs-progs: simplify btrfs_scan_one_device()
>>> =C2=A0=C2=A0 btrfs-progs: factor out btrfs_scan_stdin_devices
>>> =C2=A0=C2=A0 btrfs-progs: tune: add stdin device list
>>> =C2=A0=C2=A0 btrfs-progs: refactor check_where_mounted with noscan opt=
ion
>>> =C2=A0=C2=A0 btrfs-progs: tune: add noscan option
>>> =C2=A0=C2=A0 btrfs-progs: tune: add help for multiple devices and nosc=
an option
>>> =C2=A0=C2=A0 btrfs-progs: Documentation: update btrfstune --noscan opt=
ion
>>>
>>> =C2=A0 Documentation/btrfstune.rst |=C2=A0 4 ++++
>>> =C2=A0 btrfs-find-root.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 cmds/filesystem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 cmds/inspect-dump-tree.c=C2=A0=C2=A0=C2=A0 | 39 ++++-----------=
----------------------
>>> =C2=A0 cmds/rescue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>> =C2=A0 cmds/restore.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 common/device-scan.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 39 +++++++++++++++++++++++++++++++++++++
>>> =C2=A0 common/device-scan.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 1 +
>>> =C2=A0 common/open-utils.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 21 +++++++++++---------
>>> =C2=A0 common/open-utils.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 ++-
>>> =C2=A0 common/utils.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>> =C2=A0 image/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>> =C2=A0 kernel-shared/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++-=
---
>>> =C2=A0 kernel-shared/disk-io.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>> =C2=A0 kernel-shared/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++-----=
---
>>> =C2=A0 mkfs/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 tune/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 +++++++++++++++++++----=
-
>>> =C2=A0 18 files changed, 104 insertions(+), 75 deletions(-)
>>>
>

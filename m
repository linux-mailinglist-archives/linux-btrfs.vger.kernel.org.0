Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01F53FEC5C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbhIBKro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 06:47:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:38177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242667AbhIBKro (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 06:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630579604;
        bh=jO+F2QkTRpRjGAGm4zroH3ztLpU+Mvnn2JvkiJwgJZw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DQIxVOGcAocMxuzGlj56HDSaq0vieXzBT6YTNoL81xip6Ka1uT30W3QNtkQOVbyU4
         eu4BuXhzPhVzl6hN5Byoizddmd53Oj7o/0nZG/7m30JcIFTVdaOLq6RFocc00vubaH
         +FZseCL2EyVoWt7z7eJEF7feJt6qic6k+ktRlQxI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsYx-1mCe6O1OON-00HSBe; Thu, 02
 Sep 2021 12:46:43 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
Date:   Thu, 2 Sep 2021 18:46:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vyS/EWVjJpA0UGVXYUUB/MoPO0KbOE9p27CbLDDlY+FApU24knB
 R1pQg7kUgs9YNyPiYpkRqeghuNtKt1FQJXIZz7tm/LgYHXcFKfB8OghdoI5AILib5ZBwe6M
 kcvi2077oSgM6gUTBouwA2FTnhvDtS1qkhJYz08STPlYilAW6lgbgtGNl3LzBykBjlZX1lm
 CJGTQMYk3eUTNKhB5TGkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+rfEDJDQxbQ=:qVlTL0ks8zgHy0nTJaqeOo
 AYWpzIoFlvSAIKJdrM53oGNE+UFaVSXzbnXEHFOpAgx/ObdgVxqcIbpIZvRPwmxlumQxTBFDc
 muW8VCnwCVnkb0PYtbkjLhWsc/NMBB60XsSGs8wzcHCpQ3L5s9fTsR9osvdt6jkqtIz+GCmPo
 Evxf/YaI31ZICor7ebVf4PGFQ6jM7+Wx7dhPsLAnpkuFmgV2KDLXNC3wTT8kNzSnCMnAM2x1C
 ScKYyJ/e5TRn80L0nu7qBKOPZ0gZfD+tsLRCm1WSWdmXpyMLZImzwRCSUXvXsfvmDidmmVniw
 g2P51ls0/HLhDAYFXHCv7iVlv3+Aiv0aw1msvcBNDdz/f0yiJk9+42g97ZxcAoJLo7GAT2f+R
 41E61haY78rXYKwY/giz1mQDcCohllAEH6s3wnhu05pmi4qeZ4qe8Ii9h5ahnMsJm3j8uHQah
 RCPlmzNe3PSZ906oG7+epzrx8+MrMSVIIVNeEeDCCnu7J8xeUrhp+DzkA+HcJrtp/ki28Lsr8
 jTK8yu26hW9MOcWleHBDlwsJwCvCCxHJ3mXUuBnA4Q2i+j82LKLZT+rLMdEndmwJnrpaU2Ls/
 2oDtFH4/furoipTnhTOTOpyzhHzd+7u/V5lZwQQ9M3zr9eOokGAZFQKBUmxzZNOPTVapZFO/8
 mFsbG2N2okXjx49g8qxkfYAGksIOs7J7daeDq46I9Gqs4GrhOxCMGqoIyEoJ5+6DngwmSfYuu
 A2sinr+ffI469K65PxTmJILPST0Ew1lILrvfXsjIavBVOSf5pKRRHyPtaSEOQTlJayw67MWIe
 vbvyxfK4ADACbS4ct7OSBhIwWlSqBvqTBtlHt9X73s9IQnYH2f8SupQb2t4FpGF8h5E/LBfif
 eZ5lWqYPxsif1MKdoXipzLFyw7xL6WjYyV601RRGqDOrvc4WIrkZW0PQLUHMIjPZ1RnoBzk0N
 YeRDuZm88btHeZ6DlgP2aDNXpPTK66/rOT3k4OL6ydeJU29m0f5Mj32PcWFVu+osBbCxptOG+
 os8aOT5PF00yoAB9F/l4Y7fcuPgoYucUtFo7DjrvW3/++1RUgPCcBiDfmM4zFuMvIW+u2llFC
 G5t4zsSGCmO1NG9kLDvcIh85cDFV64zq7CTuE7akhz3MM4pa2mj7V+j/g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/2 =E4=B8=8B=E5=8D=886:41, Nikolay Borisov wrote:
>
>
> On 2.09.21 =D0=B3. 13:27, Qu Wenruo wrote:
>>
>>
>> On 2021/9/2 =E4=B8=8B=E5=8D=886:06, Nikolay Borisov wrote:
>>> Currently when a device is missing for a mounted filesystem the output
>>> that is produced is unhelpful:
>>>
>>> Label: none=C2=A0 uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 128.00KiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00GiB used 1=
.26GiB path /dev/loop0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0*** Some devices missing
>>>
>>> While the context which prints this is perfectly capable of showing
>>> which device exactly is missing, like so:
>>>
>>> Label: none=C2=A0 uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 128.00KiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00GiB used 1=
.26GiB path /dev/loop0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 0 used 0 path =
/dev/loop1 ***MISSING***
>>>
>>> This is a lot more usable output as it presents the user with the id
>>> of the missing device and its path.
>>
>> The idea is pretty awesome.
>>
>> Just one question, if one device is missing, how could we know its path=
?
>> Thus does the device path output make any sense?
>
> The path is not canonicalized but otherwise the paths comes from
> btrfs_ioctl_dev_info_args which is filled by a call to get_fs_info where
> we call get_device_info for every device in the fs_info.
>
> So the path is really dev->name from kernel space or if we don't have a
> dev->name it will be 0. In either case it's useful that we get the devid
> so that the user can do :
>
> btrfs device remove 2 (if we take the above example), alternatively the
> path would be a NULL-terminated string which aka empty. I guess that's
> still better than simply saying *some devices are missing*

Definitely the devid output is way better than the existing output.

I just wonder can we skip the path completely since it's missing (and
under most case its NULL anyway).

Despite that, I'm completely fine with the patch.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>  =C2=A0 cmds/filesystem.c | 7 +++----
>>>  =C2=A0 1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>>> index db8433ba3542..ff13de6ac990 100644
>>> --- a/cmds/filesystem.c
>>> +++ b/cmds/filesystem.c
>>> @@ -295,7 +295,6 @@ static int print_one_fs(struct
>>> btrfs_ioctl_fs_info_args *fs_info,
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fd;
>>> -=C2=A0=C2=A0=C2=A0 int missing =3D 0;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char uuidbuf[BTRFS_UUID_UNPARSED_SIZE]=
;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_dev_info_args *tmp_=
dev_info;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> @@ -325,8 +324,10 @@ static int print_one_fs(struct
>>> btrfs_ioctl_fs_info_args *fs_info,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add check f=
or missing devices even mounted */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open((c=
har *)tmp_dev_info->path, O_RDONLY);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd < 0) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
ssing =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf("\tdevid %4llu size 0 used 0 path %s
>>> ***MISSING***\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_dev_info->devid,tmp_dev_=
info->path);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fd);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 canonical_path=
 =3D path_canonicalize((char *)tmp_dev_info->path);
>>> @@ -339,8 +340,6 @@ static int print_one_fs(struct
>>> btrfs_ioctl_fs_info_args *fs_info,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(canonical=
_path);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 if (missing)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t*** Some devices=
 missing\n");
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\n");
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>
>>

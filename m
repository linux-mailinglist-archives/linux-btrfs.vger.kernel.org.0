Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88893FEDA5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbhIBMSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 08:18:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:34349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhIBMSv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 08:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630585071;
        bh=QqR9GxhkF/5FVeYrf4HgqjR9dpvUjM/tCri54jDUSpg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dwmpJePD4l4LfUef5K19oEkaDSQiSCAfpATJaUHzAcd2bCuO6OAqv02aag9G8QLOX
         FKNZGYPGJEFhfHJysNmJOTZp+02HxhOpXN9b462OgAflsqG6qfvS57GgInQ/vUmb1X
         P/BVU73KbCI9+ouIcdxzw4pS6rkceFVVS8uFIuyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp5a-1mTSk61QTM-00YCuD; Thu, 02
 Sep 2021 14:17:50 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
 <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
 <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b5dba5a6-256b-ee5c-57f2-84e9875e6c0a@gmx.com>
Date:   Thu, 2 Sep 2021 20:17:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FhW5RlAOpoyltkzeb5IHNIr4l2S3I+dYnlRZCCFR6FhV2y5E7Og
 46+ej7mV8DuUku7lUCyW8VXUCUMW+nNJgxxxsfS49IYRB+MhnLYY9VL2LoEPTnzXn1BI7Wl
 c2CTaDBhxnpkpd0T+I+ikxif0f1GbjiX2qA4ffHSBI+t1qFC9JYe1mhYlyXQOM9i9PDg+pj
 M+93CLAwiK909H3jkKunQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X6R386o4oR8=:z8s+ms7mW59roul5SjMc5C
 qeYJmmU2pv7X1u5Av7yDj19IpnEm/mnm3s70OAWTmhHZF9cwA9CACufR6mOljms+uNSu3GZzM
 nhcVcduQSuFhP/2lgi5hKlI+8lGFlFT5DbCtBIriHCzXjfyW3ulp+y2lmV8Wth9MHF/tTWjL2
 RqRhv8uEZzlv1YCDWJTAD67eOITY0AQ4baOoX1QrgeRazftebjfq78Yd1FPODGyKimYgvOVYS
 hMrQw6YEamm0RvE5fVSNdjKnV6o/GC8LljrIfqUP47DvVfKvWAbV74M1UPuSvy5wQp9guHyT2
 31YbZrYT1WA0JqTo85UO3fPlfbUoVcABS3yulueGEHTjaQ8QIjFSRHBhBEKznCBlszMgnjZSl
 8lBtsqu4tB1Fs0by2pv74DuCVJlZMtyqzbtT6mGBeghaFemNgbvq8AI3TsU5AiVWX+Degs56E
 cUfEaX1D0QokHQeC85oaqnOSC3qoi6OKcdwcdSY1lK9PH2tMAdA0tUfRJpSnJ99XkISxB4aVf
 feOzMQ6pbqFG9De2OaBRBEpWlC8t/R1vdp7kW+j5brohjMTGuESs+Akh2HTkmB7AQ5R2jbP1D
 jN2VA9qEuSJna6+XW1nUNghM3v7c0DO7pGH/BXqhpXVay17Ec2maxzrrHLSgDdk+SqimgyyY3
 gfJp2Qsfe4CiJXj0PKWyK2TmNpbxP/NsiLWg0kZVorEuZmBpuFXtd+R0hbJU1t4t/QbvghdcG
 fR0+IG8986S/ks57LcAJkKvWQsfD4IN1HJlxpKzrIAsA0lsBQTAQcbYHgCsInT4kOdb8j3uZg
 SIUhONEINx9DZRUNghDNEHgQreA4+mUdJX/IaBSNjhA4eyJPJ54bO7v/3ZIlm8rzB9Uot/CQA
 pWbWh9CbkNG+VMKG0DQjRzUfX114A48nFft+gYqDDDtibl83OY6DSab4o1pouqLDsPYn/viVC
 YPBLDP6e4Y6069GJL3tHZo4Kg0ogq/7nmH18EbByc1u8RUMc2Ox4xyxNlC1n09L5gZwh21p32
 dW8gRYJjRxZmUFj+GRVLU7GrAQdTAIYTktFE4QrcMBjY3jkRfue+INcJmP0hb7H/tPzpzA6Ub
 4chHh+1Yk7SQxInwLiRKUxEFBBVNm3w5LFuxSLOX2gN4IQtwg57z8CgTQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/2 =E4=B8=8B=E5=8D=886:59, Nikolay Borisov wrote:
>
>
> On 2.09.21 =D0=B3. 13:46, Qu Wenruo wrote:
>>
>>
>> On 2021/9/2 =E4=B8=8B=E5=8D=886:41, Nikolay Borisov wrote:
>>>
>>>
>>> On 2.09.21 =D0=B3. 13:27, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/9/2 =E4=B8=8B=E5=8D=886:06, Nikolay Borisov wrote:
>>>>> Currently when a device is missing for a mounted filesystem the outp=
ut
>>>>> that is produced is unhelpful:
>>>>>
>>>>> Label: none=C2=A0 uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 128.00K=
iB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00Gi=
B used 1.26GiB path /dev/loop0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*** Some devices missing
>>>>>
>>>>> While the context which prints this is perfectly capable of showing
>>>>> which device exactly is missing, like so:
>>>>>
>>>>> Label: none=C2=A0 uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 128.00K=
iB
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00Gi=
B used 1.26GiB path /dev/loop0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 0 used=
 0 path /dev/loop1 ***MISSING***
>>>>>
>>>>> This is a lot more usable output as it presents the user with the id
>>>>> of the missing device and its path.
>>>>
>>>> The idea is pretty awesome.
>>>>
>>>> Just one question, if one device is missing, how could we know its pa=
th?
>>>> Thus does the device path output make any sense?
>>>
>>> The path is not canonicalized but otherwise the paths comes from
>>> btrfs_ioctl_dev_info_args which is filled by a call to get_fs_info whe=
re
>>> we call get_device_info for every device in the fs_info.
>>>
>>> So the path is really dev->name from kernel space or if we don't have =
a
>>> dev->name it will be 0. In either case it's useful that we get the dev=
id
>>> so that the user can do :
>>>
>>> btrfs device remove 2 (if we take the above example), alternatively th=
e
>>> path would be a NULL-terminated string which aka empty. I guess that's
>>> still better than simply saying *some devices are missing*
>>
>> Definitely the devid output is way better than the existing output.
>>
>> I just wonder can we skip the path completely since it's missing (and
>> under most case its NULL anyway).
>>
>> Despite that, I'm completely fine with the patch.
>
> As you can see form the test I have added this was tested rather
> synthetically by simply moving a loop device, in this case the device's
> record was still in the fs_devices and had the name, though the name
> itself couldn't be acted on. So omitting the path entirely is definitely
> something we could do, but I'd rather try and be a bit cleverer, simply
> checking if the name is null or not and if not just print it?

Oh, I forgot the case where the stall path may still be there.

In that case your existing one should be enough to handle it.

printf() can handle NULL pointer for %s without problem.

Then it should be OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 cmds/filesystem.c | 7 +++----
>>>>>  =C2=A0=C2=A0 1 file changed, 3 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>>>>> index db8433ba3542..ff13de6ac990 100644
>>>>> --- a/cmds/filesystem.c
>>>>> +++ b/cmds/filesystem.c
>>>>> @@ -295,7 +295,6 @@ static int print_one_fs(struct
>>>>> btrfs_ioctl_fs_info_args *fs_info,
>>>>>  =C2=A0=C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fd;
>>>>> -=C2=A0=C2=A0=C2=A0 int missing =3D 0;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char uuidbuf[BTRFS_UUID_UNPARS=
ED_SIZE];
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_dev_info_ar=
gs *tmp_dev_info;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>> @@ -325,8 +324,10 @@ static int print_one_fs(struct
>>>>> btrfs_ioctl_fs_info_args *fs_info,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Add=
 check for missing devices even mounted */
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D=
 open((char *)tmp_dev_info->path, O_RDONLY);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd=
 < 0) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
missing =3D 1;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
printf("\tdevid %4llu size 0 used 0 path %s
>>>>> ***MISSING***\n",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_dev_info->devid,tmp_d=
ev_info->path);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 continue;
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(=
fd);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 canoni=
cal_path =3D path_canonicalize((char
>>>>> *)tmp_dev_info->path);
>>>>> @@ -339,8 +340,6 @@ static int print_one_fs(struct
>>>>> btrfs_ioctl_fs_info_args *fs_info,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(c=
anonical_path);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 if (missing)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\t*** Some devic=
es missing\n");
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\n");
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>  =C2=A0=C2=A0 }
>>>>>
>>>>
>>

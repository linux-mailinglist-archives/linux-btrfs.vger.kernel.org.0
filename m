Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926AB132084
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 08:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgAGHec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 02:34:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:34827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGHeb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 02:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578382465;
        bh=Js9+VKvBCn8II1S/XhAtEurYXoz8+IHT2D05XBo/DZo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fYELurWRl9KWWnP0iModpXVtGTN6LV1gDjqllkINQrs1XxMMALrxHY1h/1De2kxAh
         ZdpqfaaIwRT+XDe3FCEsdfPG1pE2CCXl0O7gIaOPY34/VV1fjWSDuakGFPSworXwt2
         2yhWEBCPKIIWN03ZzChiymVxzK2wIg+YYKutV13c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.186] ([104.199.231.176]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnps0-1jVAt80xaM-00pMSu; Tue, 07
 Jan 2020 08:34:25 +0100
Subject: Re: [PATCH 5/6] btrfs: copy fsid and metadata_uuid for pulled disk
 without INCOMPAT_METADATA_UUID
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-6-Damenly_Su@gmx.com>
 <4a825596-5e3b-8de4-2583-774a41e59db4@suse.com>
 <4ed7ac86-e9d5-f389-247f-d14f8a8b5af7@gmx.com>
 <f3877656-d20d-e857-a6cd-eb5fe09d4180@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <b7ae0b8b-cf4e-7f2a-866d-82fbad96a5ce@gmx.com>
Date:   Tue, 7 Jan 2020 15:34:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f3877656-d20d-e857-a6cd-eb5fe09d4180@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N6qPvsLeclDCin9TRSxj/jMuetoD5FAl0ks4SwIF6DlGvUWFvqR
 7FQZ4wHaBH+dClIu2ZO4JqiJfUiuCa11SKK6G5NjMnHEMqH2QmlO/5aESjSkOFCzOq71HS7
 llZUkVEX5ax5QI1TrzI7OCtBnAoQDKRHrozuBsONksM33eSdSR4RPYXK7BZsDpTJdFoF3SI
 xbMfmgxtixzIXhjVPDUEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u24fGzGuk0g=:06B8Z2sIEycZHpoa/TET49
 EOP7lMCg6ptzFy2PEI3IBVjxrXJHjmt666saL9iygtem29uMhZhtJP44QKQKfrRU5f7weQHjj
 RTEm5uai9pxyuLoSGMutndgz26SvTYGgdJIhYaDp6AdmK4q0HfpfBYIrK0c++p8c4DysYwKwN
 1LTFI/S0LZ+E2GdBlftyl1K/TLA43Ng0duqI7onpDqWvq/d/jy8C/qEe9QWU/r4+rt3LnDvsY
 6nWC/DuJHroDKYlzo0j8i8FmCkyEAOTZhyQdO9KfgaXqGQwQLiyFiKvDBS16rQz9QZmqzU2QE
 2mfkm9wAjmpYoIU0QAEKJHXpbkc9NawdJ1TFhIX3bxLIm9YXx7SpJsa2TE60NvTwW9YqRilPi
 /71Tl2e/UGbsSdI6lCPqo7dJt7+v+4F5v2OEHF5jfztn9ou+TfmBncvIzaPISn4ZItzD4Av6F
 ecD6L1Gv1Ee62WjLlA1iR/ePWI7GHiXZSHMajPqd5dw5T/JLmERC1J6RIJkuNOivSvmyeyhY5
 ilDxAeDdJGJUlG06TcYR1gThbCBoxwoxAGD0XNs7lUva1NhaowQ9VaNNyslxJq3OBK/vaEvGQ
 a2b7p7HHRfvGP35ANh4lS8QyjT8Toui6lND+1nfHgIHQ49CNkX0+U3YX5ay5T0vZ6yNN3UkWU
 RmjgweIiXkfNCiCG0m3xMym4A11l0BQJEGHjXpN7283VIX5BsJrtaCi9Eg1kjzzIqru5D+/Nw
 QgKGFKHRBF885sb+ZpSxcSFqgrPIz4OFQeH2nXjEV8hKv98H+vcrgm8qsdsw1r/KL71MjEcSr
 SEHptct5J3KP1YDP368F6QUNi5lbhacAkpS+pHDblrI3/ixp5c3TDncsqL0pwZrsGRvNJAKHl
 dAKJogW/oxhFDWd8WO8L1MhjRRhRIEJZAYlf4drz3FnUKPoU/ASy6LxTzeskIDHvBIwa+3qoG
 hmTBP4YNAqcou8Xxwf7SacV2rwXlUdqkWbJplHRILqU4UJLJ07e9EpTLPlC0H4ng8Q5zXeoUb
 2pL1PN2wRq915Kl6waxq32vhf1dcccp3M60I3LG6yovQ1YcL3pFPIwupmTxxk2CP0R9ypGfdj
 mKWNOjJI+JthLJ8oqtkDMw3tiIAW+layUIs54nb6jxUiIMrk6i3VVwgt8TrWX5Yd5SxB54Kay
 85lvPc//NqbHHc4CnHytXikYGWw0wCk7a/SerA1fM7zz01xBh2fZKZpd91Ya98b3UpoDUIhLx
 1EBVY8pcgOtnvAT11Bf0iq5396EYJkfShfMXH5v0tAXmflbTBwEUShuykFxk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/1/7 3:18 PM, Nikolay Borisov wrote:
>
>
> On 7.01.20 =D0=B3. 3:31 =D1=87., Su Yue wrote:
>> On 2020/1/6 11:12 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>>>> From: Su Yue <Damenly_Su@gmx.com>
>>>>
>>>> Since a scanned device may be the device pulled into disk without
>>>> metadata_uuid feature, there may already be changing devices there.
>>>> Here copy fsid and metadata_uuid for above case.
>>>>
>>>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>>>
>>>
>>> What does this patch fix, why is it needed? It seems to be independent
>>> of the split brain fixes?
>>>
>>
>> Sorry for the messy and short commit log.
>> It's one of the split brain fixes.
>>
>> As mails I replied you earlier, the case
>> is for device which succeed to sync in
>> the second transaction and is without
>> metadata_uuid feature. If there is fs_devices
>> already scanned, the device's fsid instead of
>> metadata_uuid(NULL here) should be copied into
>> the fs_devices->metada_uuid field.
>
> I figures as much as I started tackling the problem. So this must be
> part of the patch which fixes aforementioned split brain scenario. I
> have already developed some patches + tests. So will be sending those,
> since they are very similar to what you posted originally I will retain
> your SOB line.
>

I'm okay about this way. Thanks.
>>
>> Thanks.
>>
>>>> ---
>>>>  =C2=A0 fs/btrfs/volumes.c | 11 +++++++----
>>>>  =C2=A0 1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index faf9cdd14f33..b21ab45e76a0 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -964,13 +964,16 @@ static noinline struct btrfs_device
>>>> *device_list_add(const char *path,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * metadata_uuid/fsid values of =
the fs_devices.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*new_device_added && fs_devices_f=
ound &&
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has_metadata_uuid && fs_d=
evices->fsid_change &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->fsid_change &=
&
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_transid=
 > fs_devices->latest_generation) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(fs_dev=
ices->fsid, disk_super->fsid,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_FSID_SIZE);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(fs_devices->metada=
ta_uuid,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>>>> -
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (has_metadata_uuid)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emcpy(fs_devices->metadata_uuid,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_super->metadata_uuid, BTRF=
S_FSID_SIZE);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
emcpy(fs_devices->metadata_uuid,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disk_super->fsid, BTRFS_FSID_SI=
ZE);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->f=
sid_change =3D false;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>>
>>


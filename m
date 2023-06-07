Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D37251D5
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjFGBzR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjFGBzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 21:55:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5063A6
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686102894; x=1686707694; i=quwenruo.btrfs@gmx.com;
 bh=gZzMZsRKuV9KuiIezGQMoUN0FsZ4ZZEgoXJBfDle0w4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EOel0t+rJKcbk3SyUxQjnV5nX8qG9fA0HxofzWSDrLhw3PsPFSa/eTiOW/r/gAJmwsOYukT
 guZH70PxAHKmOT+M5luezxehNIXpERJaryvNQ4QNlHmSaqaIbZo5klNKJvV6WUXOkAFBUtsJp
 QqXx+rPdX2D7jZ4K8JacdbntnJcEuKCF5xsCYDCdehp+Wmnis69C8odhcOv8SlTdtUOtonSU2
 WqNLBXUjG2nge27i+la095qzy8z4EB9V/80xPEt3WCR/4+vlGhkDjTmGvEauBZs5XCLHVKSGI
 rAGN33n3dQP9qNUxm1oQljB6zjrExidhor90nCbq/V2IBxfaO8cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1pc68Q1DTz-00UbZv; Wed, 07
 Jun 2023 03:54:53 +0200
Message-ID: <7d5cf4b6-8dc9-8113-9c99-ab9c095c124d@gmx.com>
Date:   Wed, 7 Jun 2023 09:54:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Filesystem inconsistency on power cycle
Content-Language: en-US
To:     Gowtham <trgowtham123@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com>
 <CA+XNQ=i6Oq=nRStZ3P1gCB+NtCrR0u+E_gW1CraLFyz0OoeJrg@mail.gmail.com>
 <7d106d9e-9889-de54-e3b7-82858ce6be57@gmx.com>
 <CA+XNQ=j+r7LjSPch4Y7ptS3vBLsE6hU8yJvR0vi3-5_3puEVbQ@mail.gmail.com>
 <924010e8-f281-95f2-6f43-3f3ba9403aa7@gmx.com>
 <c5dc0c26-f8e3-146c-5f5c-779d801b925f@gmx.com>
 <CA+XNQ=jmX4GVB=Tc-xhaH0j7N4q7ZkW4o1OeHb2Wsu8dUrd50Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CA+XNQ=jmX4GVB=Tc-xhaH0j7N4q7ZkW4o1OeHb2Wsu8dUrd50Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bp0vla9k5EroGHc0hdRBUaFQ4FmYNecsPnz/n3mM74RBMbkYGX+
 SyT5GL9Y1h2s2Xh4oz5D4k6mxb+WtwAO/E1YQtaCwheU+hKgWjLP9tLNILP7Hk9qn8iHXI7
 DEW25OdluRRPuOApGrZpVw22Ir5t0ICg2LG8sdrrejjm5tKr67XNo2A2zcX8Iq4hLAcOyie
 MlDAGOH7F/XtBDtaU7K7Q==
UI-OutboundReport: notjunk:1;M01:P0:GCjcq6lZOPA=;8IexHiweXvH+O6Gj2nMpVVWSNOo
 966XDNwvlHnLgGtDNDIVmdeVZRaUDwXAjWK3VtPU231tJ3uVNf4wMiHH+aXrbrPMw5UT/Ef9E
 aWB21yB7Nf76s/bYVhqHiNDnltNQjj50t/nCaAPi8Fp9GPkFTPH+Akt/3otoTI8ML9+ALUpwY
 7PmUgDqo3ZvoyGLH2WuUm5iUoV1iX4Fdi0ILI4MQWucChyyzyuQmhnQvG0ZyYQbedB9uw9n8J
 c6GKu9GcTuSM9vODsiYpyJOYpGbmY9GTdAU3cAJ+7TEaZU710mKEaVGzIkL/SkvtZkRSnmOCo
 u8N4LpfwMG7Amhy1frNgJMTFYr21YE5m9nBicupE6fVEaegjXqTnYYD/+tbx9apLOLOyLE43w
 PUAQTwoEZEAzzj0EINm6qMvilKR/jzXp874NQWnSznkO6ycvplV3MvVOIG93fgloyo+WhADr/
 EIyRIRzgTMFWq7ww1nULe8G5SO2B+IPcCFwCP3TwQyy3cujaj6A3xk/KSoz8cCSs9hF9tZ40f
 +KoTzfsmiwQTQi3M0XxSQomq9XV03rzDOSdIOhpukzMQ5pmgwjUF96HOrYiEDonq+L+jmxbJN
 qaOrFB5sTqjlE6kia8fAEwlF5LX7xYtDOydeXFd1YCkLIFar8afzQo77Kr0aDTZA7TRwy4sR9
 hPRsxB5yr0F1TfaDV0ItfKAsPgKdQP9g2OnyBNkd1HBHQui9QQbrduHecTT38ivrv0WG+5/mk
 NQR4qX9VHysMS77E+dQFlBTukJ5b535IRLXyEw4GXBjaz2PvP/SaEN0Bc3wu5B7l+3Q3fgF5M
 3BFqjtfYINNL9m6vvwqPGfcc4YowouA27GxkkyLLsSwQRj+lD+zz2I+IU+rGI26785F6KtMOn
 qcWqMzbZCG+d95AezPEfihw0jbrb4nimQrssOx4B5LmOg45SUnem+sOMRifoVsvNpH0TEe4pM
 dgjJ1B2ckPcnZya8ZgJlwaz8ttg=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/7 08:58, Gowtham wrote:
> Qu,
>
> Thanks for the response. This issue is seen on multiple systems. So, a
> hardware problem can be ruled out.
>
> A btrfs check --repair does fix things but for that we need to move
> out of live running OS. And there is no guarantee if the content of
> the file after the repair will be proper. And this is not a suitable
> option for production.

The corruption itself doesn't involve the file content, it's only the
directory entries got corrupted.

And if the power cycle is involved, it looks more like a bug in log replay=
.
I'll add Filipe to the thread as he is the expert on log replay.

Thanks,
Qu

>
> Is there any way to take some precautionary steps and avoid the issue?
> We see this issue during a power-cycle when we are upgrading the
> firmware. The files getting corrupted is the one that the application
> accesses frequently. We can stop the application before the
> power-cycle to reduce the probability but we have earlier seen issues
> with /etc/shadow,passwd etc files as well which are probably not
> accessed by the application. Any other recommendations?
>
> Regards,
> Gowtham
>
> On Tue, Jun 6, 2023 at 7:59=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>>
>>
>> On 2023/6/6 08:40, Qu Wenruo wrote:
>>> Hi Gowtham,
>> [...]
>>>
>>> To further locate the root cause, I need the full dump of that inode
>>> 28804435, so please send me the file "28804435.ins.sda3" in private.
>>>
>>> This is a pretty big problem, it shows a de-sync between DIR_INDEX and
>>> DIR_ITEMS, definitely not a good thing, but we don't have any proof on
>>> the possible root cause.
>>
>> Have verified the dump, unfortunately no determine clue still.
>>
>> It only shows 5 duplicated DIR_INDEX for the same filename, but only th=
e
>> last one is valid.
>>
>> No obvious cause.
>>
>> So please try "btrfs check --repair" after you have defragged the other
>> files.
>>
>> Otherwise I can only recommend to do a memtest just to rule out the
>> possible hardware problems (I doubt if that's the case though).
>>
>> Thanks,
>> Qu
>>>
>>> In theory, these corrupted files can be repaired by "btrfs check
>>> --repair", but I still hope to find a more determining reason before
>>> repair.
>>>
>>> Especially if this is caused by some memory bitflip, repair itself can
>>> only solve the sympton, not the root cause.
>>>
>>> [...]
>>>>
>>>>
>>>> ONIE:/var/tmp # ./btrfs.static check --mode=3Dlowmem /dev/sda3
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/sda3
>>>> UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> [3/7] checking free space cache
>>>> [4/7] checking fs roots
>>>> ERROR: root 256 EXTENT_DATA[68469 0] compressed extent must have csum=
,
>>>> but only 0 bytes have, expect 4096
>>>> ERROR: root 256 EXTENT_DATA[68469 0] is compressed, but inode flag
>>>> doesn't allow it
>>>
>>> This is a minor problem, it shows a file extent is compressed but
>>> without any checksum.
>>>
>>> According to the dump, these files are pretty old:
>>>
>>>   > location key (68469 INODE_ITEM 0) type FILE
>>>   > transid 85 data_len 0 name_len 49
>>>
>>> It's very possible that those files are created using much older
>>> kernels, thus it doesn't follow the correct checks.
>>>
>>> For those files (can be located using the inode and root number), if y=
ou
>>> want to fix them, the easiest way would be defraging them.
>>>
>>> Thanks,
>>> Qu
>>>
>>> [...]
>>>> ERROR: root 336 INODE_ITEM[28828813] index 8160 name fabric_config.xm=
l
>>>> filetype 1 missing
>>>> ERROR: root 336 INODE_ITEM[28828814] index 8162 name fabric_config.xm=
l
>>>> filetype 1 missing
>>>> ERROR: root 336 INODE_ITEM[28828815] index 8164 name fabric_config.xm=
l
>>>> filetype 1 missing
>>>> ERROR: root 336 INODE_ITEM[28828816] index 8166 name fabric_config.xm=
l
>>>> filetype 1 missing
>>>> ERROR: root 336 DIR INODE [28804435] size 1106 not equal to 1174
>>>> ERROR: errors found in fs roots
>>>> found 13947932672 bytes used, error(s) found
>>>> total csum bytes: 13147016
>>>> total tree bytes: 271015936
>>>> total fs tree bytes: 204591104
>>>> total extent tree bytes: 44810240
>>>> btree space waste bytes: 57774424
>>>> file data blocks allocated: 22864171008
>>>>    referenced 17184763904
>>>>
>>>> #  ./btrfs.static ins dump-tree -t 256 /dev/sda3 | grep -A5 "(68469 "
>>>> key (68469 EXTENT_DATA 655360) block 61564944384 gen 1736288
>>>> key (68472 EXTENT_DATA 36864) block 60511285248 gen 1736279
>>>> key (68472 EXTENT_DATA 356352) block 60514881536 gen 1736279
>>>> key (68472 EXTENT_DATA 720896) block 60515426304 gen 1736279
>>>> key (68472 EXTENT_DATA 909312) block 60515491840 gen 1736279
>>>> key (68472 EXTENT_DATA 1363968) block 60516802560 gen 1736279
>>>> --
>>>> location key (68469 INODE_ITEM 0) type FILE
>>>> transid 85 data_len 0 name_len 49
>>>> name: system@0005ab8d9aa0a9fe-be4e94ec668e3a83.journal~
>>>> item 16 key (67417 DIR_ITEM 4104047264) itemoff 2351 itemsize 44
>>>> location key (68472 INODE_ITEM 0) type FILE
>>>> transid 85 data_len 0 name_len 14
>>>> --
>>>> location key (68469 INODE_ITEM 0) type FILE
>>>> transid 85 data_len 0 name_len 49
>>>> name: system@0005ab8d9aa0a9fe-be4e94ec668e3a83.journal~
>>>> item 19 key (67417 DIR_INDEX 13) itemoff 2181 itemsize 44
>>>> location key (68472 INODE_ITEM 0) type FILE
>>>> transid 85 data_len 0 name_len 14
>>>> --
>>>> item 25 key (68469 INODE_ITEM 0) itemoff 1372 itemsize 160
>>>> generation 78 transid 85 size 8388608 nbytes 8388608
>>>> block group 0 mode 100640 links 1 uid 0 gid 126 rdev 0
>>>> sequence 10 flags 0x13(NODATASUM|NODATACOW|PREALLOC)
>>>> atime 1595999111.194685019 (2020-07-29 05:05:11)
>>>> ctime 1595999556.507486909 (2020-07-29 05:12:36)
>>>> --
>>>> item 26 key (68469 INODE_REF 67417) itemoff 1313 itemsize 59
>>>> index 12 namelen 49 name:
>>>> system@0005ab8d9aa0a9fe-be4e94ec668e3a83.journal~
>>>> item 27 key (68469 XATTR_ITEM 843765919) itemoff 1259 itemsize 54
>>>> location key (0 UNKNOWN.0 0) type XATTR
>>>> transid 78 data_len 8 name_len 16
>>>> name: user.crtime_usec
>>>> data =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
>>>> item 28 key (68469 XATTR_ITEM 2038346239) itemoff 1162 itemsize 97
>>>> location key (0 UNKNOWN.0 0) type XATTR
>>>> transid 78 data_len 44 name_len 23
>>>> name: system.posix_acl_access
>>>> data
>>>> item 29 key (68469 EXTENT_DATA 0) itemoff 1109 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59567894528 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> item 30 key (68469 EXTENT_DATA 131072) itemoff 1056 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59568496640 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> item 31 key (68469 EXTENT_DATA 262144) itemoff 1003 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59568992256 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> item 32 key (68469 EXTENT_DATA 393216) itemoff 950 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59569881088 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> item 33 key (68469 EXTENT_DATA 524288) itemoff 897 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59570008064 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> leaf 61564944384 items 28 free space 1519 generation 1736288 owner 25=
6
>>>> --
>>>> item 0 key (68469 EXTENT_DATA 655360) itemoff 3942 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59570061312 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> item 1 key (68469 EXTENT_DATA 786432) itemoff 3889 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 59570167808 nr 4096
>>>> extent data offset 0 nr 131072 ram 131072
>>>> extent compression 2 (lzo)
>>>> item 2 key (68469 EXTENT_DATA 917504) itemoff 3836 itemsize 53
>>>> generation 85 type 1 (regular)
>>>> extent data disk byte 62197817344 nr 24576
>>>> extent data offset 0 nr 53248 ram 53248
>>>> extent compression 2 (lzo)
>>>> item 3 key (68469 EXTENT_DATA 970752) itemoff 3783 itemsize 53
>>>> generation 82 type 2 (prealloc)
>>>> prealloc data disk byte 61383217152 nr 8384512
>>>> prealloc data offset 966656 nr 7417856
>>>> item 4 key (68470 INODE_ITEM 0) itemoff 3623 itemsize 160
>>>> generation 79 transid 92 size 8388608 nbytes 8388608
>>>>
>>>> ONIE:/var/tmp # ./btrfs.static ins dump-tree -t 336 /dev/sda3 | grep
>>>> -A5 "(28804435 " > 28804435.ins.sda3 | head -50
>>>>
>>>> key (28804435 DIR_INDEX 7415) block 59427983360 gen 1911927
>>>> key (28804463 DIR_ITEM 2160938527) block 60599836672 gen 1911927
>>>> key (28804474 INODE_REF 28804473) block 58354487296 gen 1911925
>>>> key (28804477 DIR_ITEM 3425289705) block 70241230848 gen 1823843
>>>> key (28804477 DIR_INDEX 17) block 72880934912 gen 1823843
>>>> key (28804480 INODE_REF 28804478) block 70239948800 gen 1823843
>>>> --
>>>> location key (28804435 INODE_ITEM 0) type DIR
>>>> transid 1823843 data_len 0 name_len 6
>>>> name: Fabric
>>>> item 20 key (28804406 DIR_ITEM 3195268898) itemoff 1557 itemsize 37
>>>> location key (28804463 INODE_ITEM 0) type DIR
>>>> transid 1823843 data_len 0 name_len 7
>>>> --
>>>> location key (28804435 INODE_ITEM 0) type DIR
>>>> transid 1823843 data_len 0 name_len 6
>>>> name: Fabric
>>>> item 1 key (28804406 DIR_INDEX 5) itemoff 3922 itemsize 37
>>>> location key (28804463 INODE_ITEM 0) type DIR
>>>> transid 1823843 data_len 0 name_len 7
>>>> --
>>>> item 9 key (28804435 INODE_ITEM 0) itemoff 2903 itemsize 160
>>>> generation 1823843 transid 1911927 size 1106 nbytes 0
>>>> block group 0 mode 40700 links 1 uid 0 gid 0 rdev 0
>>>> sequence 24961 flags 0x0(none)
>>>> atime 1683000705.830348007 (2023-05-02 04:11:45)
>>>> ctime 1685702562.466279548 (2023-06-02 10:42:42)
>>>> --
>>>> item 10 key (28804435 INODE_REF 28804406) itemoff 2887 itemsize 16
>>>> index 4 namelen 6 name: Fabric
>>>> item 11 key (28804435 DIR_ITEM 97813801) itemoff 2830 itemsize 57
>>>> location key (28825999 INODE_ITEM 0) type FILE
>>>> transid 1903257 data_len 0 name_len 27
>>>> name: sys_flow_setting_config.xml
>>>> item 12 key (28804435 DIR_ITEM 320957542) itemoff 2785 itemsize 45
>>>> location key (28828931 INODE_ITEM 0) type FILE
>>>> transid 1911927 data_len 0 name_len 15
>>>> name: vlan_config.xml
>>>> item 13 key (28804435 DIR_ITEM 432850103) itemoff 2740 itemsize 45
>>>> location key (28826013 INODE_ITEM 0) type FILE
>>>> transid 1903257 data_len 0 name_len 15
>>>> name: vtep_config.xml
>>>> item 14 key (28804435 DIR_ITEM 453034874) itemoff 2695 itemsize 45
>>>> location key (28826000 INODE_ITEM 0) type FILE
>>>> transid 1903257 data_len 0 name_len 15
>>>> name: xact_config.log
>>>> item 15 key (28804435 DIR_ITEM 533509466) itemoff 2646 itemsize 49
>>>> location key (28826007 INODE_ITEM 0) type FILE
>>>> transid 1903257 data_len 0 name_len 19
>>>> name: vnet_mgr_config.xml
>>>>
>>>> # ./btrfs.static ins dump-tree -t 336 /dev/sda3 | grep -A5 "(28828813=
 "
>>>> location key (28828813 INODE_ITEM 0) type FILE
>>>> transid 1911922 data_len 0 name_len 17
>>>> name: fabric_config.xml
>>>> item 27 key (28804435 DIR_INDEX 8162) itemoff 2630 itemsize 47
>>>> location key (28828814 INODE_ITEM 0) type FILE
>>>> transid 1911922 data_len 0 name_len 17
>>>>
>>>> Thanks in advance. Please let me know .
>>>>
>>>> Regards,
>>>> Gowtham
>>>>
>>>> On Thu, May 4, 2023 at 6:43=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2023/5/4 08:24, Gowtham wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> Can anyone suggest a fix or a workaround for the issue in 5.4 kerne=
l?
>>>>>>
>>>>>> Regards,
>>>>>> Gowtham
>>>>>>
>>>>>> On Sun, Apr 30, 2023 at 3:50=E2=80=AFPM Gowtham <trgowtham123@gmail=
.com> wrote:
>>>>>>>
>>>>>>> Hi
>>>>>>>
>>>>>>> We have been running our application on BTRFS rootfs for quite a f=
ew
>>>>>>> Linux kernel versions (from 4.x to 5.x) and occasionally do a powe=
r
>>>>>>> cycle for firmware upgrade. Are there any known issues with BTRFS =
on
>>>>>>> Ubuntu 20.04 running kernel 5.4.0-137?
>>>>>
>>>>> I don't believe there are some known bugs that can lead to the same
>>>>> problem you described.
>>>>>
>>>>>>>
>>>>>>> On power cycles/outages, we have not seen the BTRFS being corrupte=
d
>>>>>>> earlier on 4.15 kernel. But we are seeing this consistently on a 5=
.4
>>>>>>> kernel(with BTRFS RAID1 configuration). Are there any known issues=
 on
>>>>>>> Ubuntu 20.04? We see some config files like /etc/shadow and other
>>>>>>> application config becoming zero size after the power-cycle. Also,=
 the
>>>>>>> btrfs check reports errors like below
>>>>>>>
>>>>>>> # btrfs check /dev/sda3
>>>>>>> Checking filesystem on /dev/sda3
>>>>>>> UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
>>>>>>> checking extents
>>>>>>> checking free space cache
>>>>>>> checking fs roots
>>>>>>> root 297 inode 28796828 errors 200, dir isize wrong
>>>>>>> root 297 inode 28796829 errors 200, dir isize wrong
>>>>>>> root 297 inode 28800233 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796828 index 506 namelen 14 name
>>>>>>> ip6tables.conf filetype 1 errors 5, no dir item, no inode ref
>>>>>
>>>>> Those corruptions are mismatch in inodes backref mismatch, some can =
even
>>>>> be bad key ordered.
>>>>>
>>>>> I want to look deeper into these offending inodes, as in the past we
>>>>> have seen some memory bitflip causing the same problem.
>>>>>
>>>>> Mind to dump the following info?
>>>>>
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28796828 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28796829 "
>>>>>
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800233 "
>>>>>
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800269 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800270 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800271 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800272 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800273 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800274 "
>>>>> # btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800275 "
>>>>>
>>>>> Furthermore, the output of the original mode sometimes is missing ne=
eded
>>>>> info.
>>>>>
>>>>> Please use a newer btrfs-progs (the easiest way is to grab a rolling
>>>>> distro liveCD), and paste the output of:
>>>>>
>>>>> # btrfs check --mode=3Dlowmem /dev/sda3
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>> root 297 inode 28800269 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 452 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> root 297 inode 28800270 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 454 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> root 297 inode 28800271 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 456 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> root 297 inode 28800272 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 458 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> root 297 inode 28800273 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 460 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> root 297 inode 28800274 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 462 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> root 297 inode 28800275 errors 1, no inode item
>>>>>>>       unresolved ref dir 28796829 index 464 namelen 30 name
>>>>>>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, n=
o
>>>>>>> inode ref
>>>>>>> found 13651775501 bytes used err is 1
>>>>>>> total csum bytes: 12890096
>>>>>>> total tree bytes: 267644928
>>>>>>> total fs tree bytes: 202223616
>>>>>>> total extent tree bytes: 45633536
>>>>>>> btree space waste bytes: 59752814
>>>>>>> file data blocks allocated: 16155500544
>>>>>>> referenced 16745402368
>>>>>>>
>>>>>>>
>>>>>>> We run the rootfs on BTRFS and mount it using below options
>>>>>>>
>>>>>>> # mount -t btrfs
>>>>>>> /dev/sda3 on / type btrfs
>>>>>>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,=
subvolid=3D292,subvol=3D/@/netvisor-5)
>>>>>>> /dev/sda3 on /.rootbe type btrfs
>>>>>>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,=
subvolid=3D256,subvol=3D/@)
>>>>>>> /dev/sda3 on /home type btrfs
>>>>>>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,=
subvolid=3D257,subvol=3D/@home)
>>>>>>> /dev/sda3 on /var/nvOS/log type btrfs
>>>>>>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,=
subvolid=3D258,subvol=3D/@var_nvOS_log)
>>>>>>> /dev/sda3 on /sftp/nvOS type btrfs
>>>>>>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,=
subvolid=3D292,subvol=3D/@/netvisor-5)
>>>>>>>
>>>>>>> # btrfs fi df /.rootbe
>>>>>>> System, RAID1: total=3D32.00MiB, used=3D12.00KiB
>>>>>>> Data+Metadata, RAID1: total=3D36.00GiB, used=3D34.19GiB
>>>>>>> GlobalReserve, single: total=3D132.65MiB, used=3D0.00B
>>>>>>>
>>>>>>> # btrfs --version
>>>>>>> btrfs-progs v5.4.1
>>>>>>>
>>>>>>> Regards,
>>>>>>> Gowtham

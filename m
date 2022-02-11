Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCE4B1D70
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 05:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiBKEsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 23:48:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiBKEsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 23:48:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA262DCE
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 20:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644554923;
        bh=Bq2rPlQpQb7MeclV4nHOvMP8E3/VjaGWAvhwAvNLzHA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=U65U21kb2b6n2dgt4QoA+q+a4cyQ7NnWHu9UtuogakAnvuOxmnBXxIifGxO9Vj5Xy
         o32607oSJj2mqSRZmdIQO3KG4SK2PS2D8gY0d4lUlMH0BQc9TvjbLfo+gfVn9cqz+c
         up6HTF7wUX7UhfP/1dudie5gUFElBtjW0EccEr1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1oLsk73Juj-014WGs; Fri, 11
 Feb 2022 05:48:43 +0100
Message-ID: <3a654f5d-e210-5c3e-4bcf-f0eae626cde2@gmx.com>
Date:   Fri, 11 Feb 2022 12:48:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Used space twice as actually consumed
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
 <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
 <65e916e1-61b4-0770-f570-8fd73c27fe03@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <65e916e1-61b4-0770-f570-8fd73c27fe03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GzV5Hi7MXMdOx/zrXpqdQ8wTIRuo42O1K3VXW67pH0S4l+jHngo
 65bchHUVLkpvdS4OgoAjQjjw0nKGMbjfNaTNKdVHLHmPhdpkdxZlQe+6txrH9z/zlBwUWcC
 XucqMtFvrgD8BKdnMxym6DoB7esmGYXbVdAqr02jsp478Jjel2MeziQGkmG+0y7gUW2GDwL
 eG9gHbS/cV9d266Xv6F9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tpvw52DB88U=:yfrcuYtxKu9wx9+ZUNMzXg
 UHHs4eIJZk4X5UVdSNrP3qsEk6Yp9IKY3OX5qnThosjQjpnxA4+yyZ7zyvkf/MSRcvEb1LsxC
 LwMsDoXpG5UBCwA6ORzfqOVfPcYa1DcIPG0muMjAanDtNOGP8JaciOENYkFNOXCwbe1nEV5d1
 xj6/to1DBkRALyCWSzEFz/20sk1YzffVJVkELpmBThUk/XVbi3Vo0efugONGh70JRoQOku8K2
 wmoQe9yJh8wZmjL3MZj/5Rj6o9ALFhNMHxZOXDfofsUtZdb94FJ5Ld19aASED4agRVSc0Rg6g
 Yi4IvlOQQhyzLqaEmvPNkINNl8QM9LMo5CgIkGkA8SXLk+naTRkDeX5BBnfLRbxcSIucYYtue
 jmbyogLx023Wf0Srccqdv1ask80FkAqHVHcJ6noBg5oOewUhQAb8vXTEUo0sV1suCUDskPwoN
 rajeCaO4g6Egn3MheieEmcj/1QCfz+c+zCahEvY2gTEsFen9n2OxsS/1F1ooG3omriQtIvV4I
 9NQvQRqAgHLSj86kyL0WaNuKO2TAWZQDJfpzx3U3B54ywlErSDa7cyuUvyz7dALERafSwlXji
 6Ww1MkY/1PSCzpcsg4EJbo5bqdV62g4cxaGL56w5ordgMEu2qi+5bnbxxZSliirriKxJRJSqh
 Wz1pk7ltZkCnIHbzVN4n/wi114ANVnJAbHAmoClfy9R1ir8yNhPHiQjFU9ObpoLtqfjS1/ymt
 7gQLAYUO9Fxdy07p+6yTW5xsQGXATClrEptIyJ/K/qeJDq0c4ds9Se9wG882DIzXF2Eo3+saS
 SyzOQ2JldHCzKb4fkszN3bd+CyO8tCUS7bMYLCfy53o626hQq19JGU4+x/zAwZcq1XRzlO/Vw
 lYoggoBRpqb4+fP5VZqpVRPrcRRoUrqQcxRINoH7tPeftQUy2JsHWnr9bhrqWwqtBibsDJZhC
 R2Lc2wU+bhR4P621Xhhmth7LGrH4kzcNOagGzhSgdvDgbw40Y7ogrChB+P+UavQ4Q8Xt2HZzd
 HaY5Qp/D6XHzXdJrLocheG37UMM2nXCFbv51OavfztwXH9QxWJjM6FnrxE/g/JWYR5XOZPNtl
 BPs1Q29nzBxk+A=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 12:45, Andrei Borzenkov wrote:
> On 11.02.2022 03:12, Qu Wenruo wrote:
>>
>>
>> On 2022/2/11 02:54, Andrei Borzenkov wrote:
>>> I am at a loss.
>>>
>>> bor@tw:~> uname -a
>>>
>>> Linux tw 5.16.4-1-default #1 SMP PREEMPT Sat Jan 29 12:57:02 UTC 2022 =
(b146677) x86_64 x86_64 x86_64 GNU/Linux
>>>
>>>
>>> opnSUSE Tumbleweed.
>>>
>>>
>>> bor@tw:~> sudo btrfs fi us -T /
>>>
>>> [sudo] password for root:
>>>
>>> Overall:
>>>
>>>       Device size:		  38.91GiB
>>>
>>>       Device allocated:		  38.91GiB
>>>
>>>       Device unallocated:		   1.00MiB
>>>
>>>       Device missing:		     0.00B
>>>
>>>       Used:			  23.91GiB
>>>
>>>       Free (estimated):		  13.14GiB	(min: 13.14GiB)
>>>
>>>       Free (statfs, df):		  13.14GiB
>>>
>>>       Data ratio:			      1.00
>>>
>>>       Metadata ratio:		      2.00
>>>
>>>       Global reserve:		  85.95MiB	(used: 0.00B)
>>>
>>>       Multiple profiles:		        no
>>>
>>>
>>>
>>>                Data     Metadata  System
>>>
>>> Id Path      single   DUP       DUP      Unallocated
>>>
>>> -- --------- -------- --------- -------- -----------
>>>
>>>    1 /dev/vda2 35.34GiB   3.51GiB 64.00MiB     1.00MiB
>>>
>>> -- --------- -------- --------- -------- -----------
>>>
>>>      Total     35.34GiB   1.75GiB 32.00MiB     1.00MiB
>>>
>>>      Used      22.19GiB 877.94MiB 16.00KiB
>>>
>>> bor@tw:~>
>>>
>>>
>>> Well, that's wrong for all I can tell.
>>>
>>> bor@tw:~> sudo btrfs qgroup show /
>>>
>>> qgroupid         rfer         excl
>>>
>>> --------         ----         ----
>>>
>>> 0/5          16.00KiB     16.00KiB
>>>
>>> 0/257        16.00KiB     16.00KiB
>>>
>>> 0/258        16.00KiB     16.00KiB
>>>
>>> 0/259         9.04GiB      8.92GiB
>>>
>>> 0/260         2.69MiB      2.69MiB
>>>
>>> 0/261        16.00KiB     16.00KiB
>>>
>>> 0/262       708.24MiB    708.24MiB
>>>
>>> 0/263        16.00KiB     16.00KiB
>>>
>>> 0/264        16.00KiB     16.00KiB
>>>
>>> 0/265        16.00KiB     16.00KiB
>>>
>>> 0/266        16.00KiB     16.00KiB
>>>
>>> 0/1411        2.12GiB      1.91GiB
>>>
>>> bor@tw:~>
>>>
>>>
>>> So it is about 11GiB in all subvolumes. Still btrfs claims 22GiB are u=
sed.
>>>
>>> There are no snapshots (currently). There is single root subvolume whi=
ch
>>> is 259. All snapshots have been removed.
>>>
>>> bor@tw:~> sudo btrfs sub li -u /
>>>
>>> ID 257 gen 96090 top level 5 uuid 257f04e8-e972-1a42-956f-1252b88713a4=
 path @
>>>
>>> ID 258 gen 120221 top level 257 uuid 2b9cfacf-5c3d-924e-90e6-8f01818df=
659 path @/.snapshots
>>>
>>> ID 259 gen 120339 top level 258 uuid 52afd41d-c722-4e48-b020-5b95a2d6f=
d84 path @/.snapshots/1/snapshot
>>>
>>> ID 260 gen 120221 top level 257 uuid 40812ba2-102c-ae42-bf07-2b51e531d=
923 path @/boot/grub2/i386-pc
>>>
>>> ID 261 gen 120221 top level 257 uuid 9105e591-b3d9-a84a-93e9-6902fd788=
97b path @/boot/grub2/x86_64-efi
>>>
>>> ID 262 gen 120339 top level 257 uuid be0f25f1-8505-7a4d-87bf-29bcb06ce=
55c path @/home
>>>
>>> ID 263 gen 120186 top level 257 uuid e95e8fd5-5bc0-e94a-bc56-c35535747=
9dc path @/opt
>>>
>>> ID 264 gen 120221 top level 257 uuid 4b0f5496-dc32-9d43-a36c-333b18b93=
70c path @/srv
>>>
>>> ID 265 gen 120331 top level 257 uuid d658c9bd-dbe2-e842-9e31-c943119b7=
25f path @/tmp
>>>
>>> ID 266 gen 120221 top level 257 uuid 71717a12-5b0c-8240-9ef4-907586ed9=
35c path @/usr/local
>>>
>>> ID 1411 gen 120340 top level 257 uuid f5f4dae5-fdbc-9141-8fba-83e95b9e=
a132 path @/var
>>>
>>> bor@tw:~>
>>>
>>>
>>>
>>>
>>>
>>>
>>> Any idea what's going on and where to look? I seem to have strange roo=
ts
>>> that are not visible as subvolumes, like
>>>
>>>           item 71 key (1329 ROOT_ITEM 81748) itemoff 7377 itemsize 439
>>>
>>>                   generation 81749 root_dirid 256 bytenr 70449102848 b=
yte_limit 0 bytes_used 313655296
>>>
>>>                   last_snapshot 81748 flags 0x1000000000001(RDONLY) re=
fs 0
>>>
>>>                   drop_progress key (9414435 INODE_ITEM 0) drop_level =
1
>>
>> This subvolume is still being dropped, thus it still takes up some spac=
e.
>>
>> I believe There are similar subvolumes waiting to be dropped, thus they
>> may be the reason they are taking up the extra space.
>>
>>>
>>>                   level 2 generation_v2 81749
>>>
>>>                   uuid 2c5e44c6-cb4d-1b4f-a3f0-df1ee3509f47
>>>
>>>                   parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
>>>
>>>                   received_uuid 00000000-0000-0000-0000-000000000000
>>>
>>>                   ctransid 81748 otransid 81748 stransid 0 rtransid 0
>>>
>>>                   ctime 1614326844.216735782 (2021-02-26 11:07:24)
>>>
>>>                   otime 1614326844.284742808 (2021-02-26 11:07:24)
>>>
>>>                   stime 0.0 (1970-01-01 03:00:00)
>>>
>>>                   rtime 0.0 (1970-01-01 03:00:00)without waiting for a=
nything

bor@tw:~> sudo btrfs subvolume sync /

bor@tw:~>


Also

bor@tw:~/python-btrfs> sudo ./bin/btrfs-orphan-cleaner-progress /

0 orphans left to c
>>>
>>>
>>> This apparently was once snapshot of root subvolume (52afd41d-c722-4e4=
8-b020-5b95a2d6fd84).
>>> There are more of them.
>>>
>>> Any chance those "invisible" trees continue to consume space? How can =
I remove them?
>>
>> They are being dropped in the background.
>> You can wait for them to be completely dropped by using command "btrfs
>> subvolume sync".
>>
>
>
> It returns immediately without waiting for anything
>
> bor@tw:~> sudo btrfs subvolume sync /
>
> bor@tw:~>
>
>
> Also
>
> bor@tw:~/python-btrfs> sudo ./bin/btrfs-orphan-cleaner-progress /
>
> 0 orphans left to clean
>
>
>
> btrfs check does not show any issues.

There used to be a bug that some root doesn't get properly cleaned up.

To be sure, please provide the following dump:

# btrfs ins dump-tree -t root <device>

Thanks,
Qu

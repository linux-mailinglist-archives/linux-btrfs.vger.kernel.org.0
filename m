Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA104EE6A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbiDADUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 23:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiDADUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 23:20:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9704B1B6975
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648783133;
        bh=kVnq2Tz7u4yOW2zZxyKI+/YXf1oVJ7JKEHokMn3R7rw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gxTTno5QtBZcSrZr3ZVdl3viEEBFi+MWCHWSpNdiyqCkGop2ONwCHE3GmQt5QOq1C
         0crmYAnmIBLeHxLYiQxIc67olmvMfeTTg+UaWY8He8AmmzasQPnNRJnGF41CMIyqmx
         mSQrGWYAxYRwzRLcRuqL6hO3BRzcReSdoes46TjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiDd-1nNgQN1j2t-00QDCG; Fri, 01
 Apr 2022 05:18:53 +0200
Message-ID: <190b793d-4f31-2993-42d6-931ec8d0b039@gmx.com>
Date:   Fri, 1 Apr 2022 11:18:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: btrfs volume can't see files in folder
Content-Language: en-US
To:     Rosen Penev <rosenp@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com>
 <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
 <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com>
 <CAKxU2N8JiE9n+qEM8LMKz60v46k0+P2whjzK49Z=jUooNdkDRQ@mail.gmail.com>
 <d70042e2-1f05-1052-d6a1-2d8b57b0300f@gmx.com>
 <CAKxU2N9Lg-Xnwc45Ej8-ewO1WQYEwTe2wwJvRNppDjkMq3xoOA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKxU2N9Lg-Xnwc45Ej8-ewO1WQYEwTe2wwJvRNppDjkMq3xoOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yd3W+tFj6KlaRY6SvtzU+t2uVVonmx/63JclSrYOonfXt0IszAl
 ykAU7JTQCCwIlZ46hZRpwm2tQjSTBkyEr74NBiUGDZAxAoEajAxqu7F1amf8FFpmuFeU0Rd
 LRAVhXvb85tOpi5x/fdXyH+pxIv8hQi6gYHW403zbcF3SoQvuJLoxy+MPFqZ3zUzFToSu2P
 BfoaqcFv5WS+j2QOthV8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zFCIKdp5IRg=:TG2b315TRz48XtceYt7li1
 GPjuVlv/26A2boSIVibBab8ohS6YTJ0FufznRasQ5npY9lI1cgNV5qWFcc/rxm8oRSPHTABqz
 joX4FdEfqW8jtrYZxHfhr4q5W4RYsBs5DDCn0zw89wDRbdSskLzpZUSNIPjbkPbGw4R0fU2sY
 gRN/bakaE4Lgr6Ke73WhEL6tvy954evaNZnPQ4mRE6lcpTo5wNmkL5Yq1fiOrRjXF6vjEr+Nr
 E2KW44Ess8Q2unDOImwHEJZRlsYs5XQNFUpI5QK+45ui5sPjDZmvz6nBoHc45+hYInCm5/Upp
 UJ45RLqZ68N+s6T6JYft/WXuG0AmeNVAK6R9uKqOL6feFY5vo6UG14ckkyakeGRI5rU9IXZHb
 rXPZEozET9qWDfSL9WS+FtqFpNh2tNDDIrJ+rDXU+J6mDuynGTzleV7LbkTYTwTPpdOF0FNlo
 nEM470vle+GX28x4H0B+KgYn2wGswA2ZVQZm3B/7idBIt8hUoIIs6C1tnvTkl9Sym/S3WanFz
 IpCbDxL4kLSoKprBI8vd87jgvfkGXtdluY8RDLxzr4lMLG+jpS5SaBH3c1pD0EfRAeOijuUkE
 VpvTnTBPMhfrjGTzXdmPckbblVxz8De5OxwzlpcEZXX7mT6yjKppHLyOoRZl0dReCA7jgMejQ
 9AOZRHFUVp1Z8/JQ6TYgVL8TBcC6HQUXghItWK4X2LBh5m+MFwngNfg4Rgwovwt69hrDIKxeF
 +0XQSGMV3ZnKC05TArbg76yQS+3yGbCNeZbaJEew2+DBm8uizOKjaTkHKQ7ZzB3H8LbhTUJ1B
 JX7pQ41HC1MN1gZifP5E57pFpQCReSY/Z1kkM/HJVUumLmoSVx4Z06JZhT3mOQw/8wxIJiJtf
 AuESKLjsUA1P2bEDGtd65kJZnxHZ8AoUpzxXWn3Xp2LBCNxvgiogbLCJIoUeLDN5URcHa3n9A
 HzxnWDK/k3uN0R5qLbv4rj047HrtGEx8d0G/PstYQvbEHksv5Vn0AiE4kq/J541EaGAP1j1yR
 XptoKYTuyPaOJ/nmBcTn6tybfzICaxFel0YqRJNSrgs9/6fIORCwDoKAVsFnjGmSFyOOpAkNw
 9ylZnCoK01IMaE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/1 11:05, Rosen Penev wrote:
> On Thu, Mar 31, 2022 at 7:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/4/1 10:48, Rosen Penev wrote:
>>> On Thu, Mar 31, 2022 at 5:59 PM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/4/1 08:24, Rosen Penev wrote:
>>>>> On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022/4/1 03:29, Rosen Penev wrote:
>>>>>>> A specific folder has files in it. Directly accessing the path wor=
ks
>>>>>>> but ls in the directory returns empty.
>>>>>>>
>>>>>>> Any way to fix this issue? I believe it happened after a btrfs
>>>>>>> replace(failed drive in RAID5) + btrfs balance.
>>>>>>
>>>>>> Btrfs check please.
>>>>> btrfs check --force /dev/sda
>>>>
>>>> Force is not recommended unless it's your root fs and you don't reall=
y
>>>> want to run btrfs check on an liveCD.
>>> Same result without force and unmounted:
>>>
>>> btrfs check /dev/sda
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sda
>>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> block group 4885757034496 has wrong amount of free space, free space
>>> cache has 286720 block group has 290816
>>> failed to load free space cache for block group 4885757034496
>>> block group 4898641936384 has wrong amount of free space, free space
>>> cache has 36864 block group has 53248
>>> failed to load free space cache for block group 4898641936384
>>> block group 4953402769408 has wrong amount of free space, free space
>>> cache has 262144 block group has 274432
>>> failed to load free space cache for block group 4953402769408
>>> block group 5478462521344 has wrong amount of free space, free space
>>> cache has 716800 block group has 729088
>>> failed to load free space cache for block group 5478462521344
>>> block group 5484904972288 has wrong amount of free space, free space
>>> cache has 811008 block group has 819200
>>> failed to load free space cache for block group 5484904972288
>>
>> Only non-critical free space cache problem, and kernel can detect and
>> rebuild them without problem.
>>
>>> [4/7] checking fs roots
>>
>> This is the most important part, and it turns no problem at all.
>>
>> So at least your fs is completely fine.
>>
>>
>> It must be something else causing the problem.
>>
>> Mind to provide the subvolume id and the inode number (`stat` command
>> can return the inode number) of the offending directory?
>   stat .
>    File: .
>    Size: 0               Blocks: 0          IO Block: 4096   directory
> Device: 44h/68d Inode: 259         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: ( 1000/  mangix)   Gid: ( 1000/  mangix)
> Access: 2022-03-31 19:58:36.577915854 -0700
> Modify: 2022-03-13 22:57:55.825138581 -0700
> Change: 2022-03-13 22:57:55.825138581 -0700
>   Birth: 2020-05-16 20:14:31.577476911 -0700
>
> btrfs subvolume list shows:
> ID 259 gen 1084405 top level 5 path Torrents
>>
>> And some example command output when you can access the files inside th=
e
>> directory but `ls -alh` shows nothing?
> shows . and .. . That's it.

Mind to dump the the following contents?
NOTE: this will include file names, feel free to censor filenames if neede=
d:

# btrfs ins dump-tree -t 259 <mnt> | grep "(259 " -A8

This will dump all info related to inode 259 inside subvolume "Torrents".

If there is really nothing but the subvolume itself, it may be something
else.

Thanks,
Qu
>
> The reason I know there are files here is because my torrent client is
> currently seeding them. If I change the Catagory (which moves the
> files elsewhere), the files show up in the given directory.
>>
>> Thanks,
>> Qu
>>
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 2689565679616 bytes used, no error found
>>> total csum bytes: 2620609300
>>> total tree bytes: 5374935040
>>> total fs tree bytes: 1737539584
>>> total extent tree bytes: 511115264
>>> btree space waste bytes: 889131100
>>> file data blocks allocated: 41913072627712
>>>    referenced 2675025698816
>>>
>>>>
>>>> As sometimes it can report false positive if the fs is not mounted
>>>> read-only.
>>>>
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/sda
>>>>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 139616845824
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 146059296768
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 3183842689024
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 3184916430848
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 3185990172672
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 3187063914496
>>>>> btrfs: space cache generation (1084391) does not match inode (108438=
9)
>>>>> failed to load free space cache for block group 3190318694400
>>>>> block group 4885757034496 has wrong amount of free space, free space
>>>>> cache has 286720 block group has 290816
>>>>> failed to load free space cache for block group 4885757034496
>>>>> block group 4898641936384 has wrong amount of free space, free space
>>>>> cache has 36864 block group has 53248
>>>>> failed to load free space cache for block group 4898641936384
>>>>> block group 4953402769408 has wrong amount of free space, free space
>>>>> cache has 262144 block group has 274432
>>>>> failed to load free space cache for block group 4953402769408
>>>>> block group 5478462521344 has wrong amount of free space, free space
>>>>> cache has 716800 block group has 729088
>>>>> failed to load free space cache for block group 5478462521344
>>>>> block group 5484904972288 has wrong amount of free space, free space
>>>>> cache has 811008 block group has 819200
>>>>> failed to load free space cache for block group 5484904972288
>>>>> [4/7] checking fs roots
>>>>>
>>>>> It's currently stuck on that last one.
>>>>
>>>> If the fs is pretty large, it can take quite some time.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>>
>>>>>> It looks like an DIR_ITEM/DIR_INDEX corruption.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>
>>>>

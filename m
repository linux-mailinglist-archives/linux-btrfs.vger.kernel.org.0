Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DB4EE785
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 07:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiDAFHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 01:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiDAFHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 01:07:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6B25F677
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648789554;
        bh=UzNnYlqN0Wbwb/Sd7YqOsfwXx//h4OnUJWJsCjmLN7Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YJ9WmI6T059CMmfkhNNlxgi4ue9crmifiCMlzJLqGH7Mfsl+ELZHydwiudKbejKAx
         h9EWoqZyzKYHNtYtMBcLp0i/87y/a/JOfBHq2T17hyWLELt//Y9DDIx7WSG5GlVvoT
         fyLC96huLeb8VydLB76b7v0P4y9K+B4AMTglwfx8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeCpR-1o7qTO2sVz-00bHBE; Fri, 01
 Apr 2022 07:05:54 +0200
Message-ID: <b9ccc5f3-a003-bde1-deea-a988959c3ea6@gmx.com>
Date:   Fri, 1 Apr 2022 13:05:50 +0800
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
 <190b793d-4f31-2993-42d6-931ec8d0b039@gmx.com>
 <CAKxU2N_X12tZ49pGkoip7ALPc_tc5XZpB2HCria9ou2k-j5P-w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAKxU2N_X12tZ49pGkoip7ALPc_tc5XZpB2HCria9ou2k-j5P-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ylzoI3mOfFODL92rVwdYE6+Tf74Tj0WotPJ0dBB/YqdykU8QFzc
 lOHGr+5QXpLEsHnlXmvhPnjas6wwNFSms5FS1T8KsjMrSZkOcKZBzCW85ZlOFVG4Af16hLo
 oGSk94uhIRAC8oxWD/NKOoaUQ5Itza6FsZtzbtjXGUyiltCCrWZo+OP/qd7scg/3Zr2JlMx
 onNqPnTBbZC/dIBAbuiAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lS+vFhWLTag=:GMmakxXrpjPlN3RIK79ZSQ
 hLl67PmkZDt8aqZPkhhtaYrETLSsA9opVs5rhSuxTgLKTEwFmWvHfdfOsRxWmpJwthlgP4tfs
 f5r8hipI09SCSbmezrJijCGVWRZExjD+jShqPa3Mrj/EsaRCi3RnI/JkBHKeGzAPjIbqI9HEB
 a29fJ0ywksxpWE9RXch+2Qsau2DRMPE/nQQaJU+OKAoyjz8SwUNPknVOTO/89XtnSt3S+uid2
 S4efviUgNFMA3IEeAC3X4lhTey0HFxfx2sdQvoYlCVjf4+Hub16Cm8cu/nx/zvtL6TUs0UWMt
 TyYB5o4PkFmnALtgSI2W7BsM4Vl6OFSCtHaIyOpvTcqHEZibpekm+uU7us8ixN8J+eG1lyPLr
 SxupD+re+L8bgLYwmOLXUMd3ffeEADJ7DHGT1T0zHV+SiUUQmDuDFIWpQ68cQCgdD1vA2uMoL
 tI0t3ZuznDlt7bQQms3GqgcthM7NDbqS0CSO8czz48rWANHiW/0OzpZwkDLypNGVPWwlUPbXd
 Y72Sf7rMO/aosFePTaAHVPpesAY22pAESozqm29X0k8EYL+/ToIVeHGn+Egc25DuQ//4yvESE
 alqdy3ecp1f72SCoa0LNzS9hK7OWQ8E6YpyoeC/AqucuE3tu0v/Bh0cILn6Iy0sMuBqlkOr6H
 h0DFNKWlQ08xSZsniN5ju9Dpz+zsUsil7DNt2abzXedy2/56wKbPt1kJTw5BglgTHKFnOFWi0
 H9NFwtin+ssfyex1PUZHUdND9ygqhukvP+Fid8GKPpj0yiLuScce+NxkQeuLLt4fvXNFOMNeT
 7xjoXRgghOGkVd6Sgx4wkRBO8x2KgXRr//aKww4RTRuelDP7FstTZtRvH9eXXklrq53sOYl/M
 Z/gMpnuUGDKuw97rHHONkK00Q13PUXFoxZTVGKiPx9SZ+VS2Ss1FSYfI3NsIZhzO/6bPAiurz
 U7Up5vbPRyY/sutBJg7dy5HmyHuECcnAs4Qu7SRMZjdlVC0H6Jado89Tnr7DCj3IbKZdWDXUq
 v4+nAR1l4lw0UGXdD+x5mvnd6kNjfzW+ZaCokKzuTSlWjSaSgG1W8KMYRoe+fUqYv0eZF9s5X
 x3pjA3jJDPQP4M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/1 11:25, Rosen Penev wrote:
> On Thu, Mar 31, 2022 at 8:18 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/4/1 11:05, Rosen Penev wrote:
>>> On Thu, Mar 31, 2022 at 7:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2022/4/1 10:48, Rosen Penev wrote:
>>>>> On Thu, Mar 31, 2022 at 5:59 PM Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022/4/1 08:24, Rosen Penev wrote:
>>>>>>> On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2022/4/1 03:29, Rosen Penev wrote:
>>>>>>>>> A specific folder has files in it. Directly accessing the path w=
orks
>>>>>>>>> but ls in the directory returns empty.
>>>>>>>>>
>>>>>>>>> Any way to fix this issue? I believe it happened after a btrfs
>>>>>>>>> replace(failed drive in RAID5) + btrfs balance.
>>>>>>>>
>>>>>>>> Btrfs check please.
>>>>>>> btrfs check --force /dev/sda
>>>>>>
>>>>>> Force is not recommended unless it's your root fs and you don't rea=
lly
>>>>>> want to run btrfs check on an liveCD.
>>>>> Same result without force and unmounted:
>>>>>
>>>>> btrfs check /dev/sda
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/sda
>>>>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
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
>>>>
>>>> Only non-critical free space cache problem, and kernel can detect and
>>>> rebuild them without problem.
>>>>
>>>>> [4/7] checking fs roots
>>>>
>>>> This is the most important part, and it turns no problem at all.
>>>>
>>>> So at least your fs is completely fine.
>>>>
>>>>
>>>> It must be something else causing the problem.
>>>>
>>>> Mind to provide the subvolume id and the inode number (`stat` command
>>>> can return the inode number) of the offending directory?
>>>    stat .
>>>     File: .
>>>     Size: 0               Blocks: 0          IO Block: 4096   director=
y
>>> Device: 44h/68d Inode: 259         Links: 1
>>> Access: (0755/drwxr-xr-x)  Uid: ( 1000/  mangix)   Gid: ( 1000/  mangi=
x)
>>> Access: 2022-03-31 19:58:36.577915854 -0700
>>> Modify: 2022-03-13 22:57:55.825138581 -0700
>>> Change: 2022-03-13 22:57:55.825138581 -0700
>>>    Birth: 2020-05-16 20:14:31.577476911 -0700
>>>
>>> btrfs subvolume list shows:
>>> ID 259 gen 1084405 top level 5 path Torrents
>>>>
>>>> And some example command output when you can access the files inside =
the
>>>> directory but `ls -alh` shows nothing?
>>> shows . and .. . That's it.
>>
>> Mind to dump the the following contents?
>> NOTE: this will include file names, feel free to censor filenames if ne=
eded:
>>
>> # btrfs ins dump-tree -t 259 <mnt> | grep "(259 " -A8
>>
>> This will dump all info related to inode 259 inside subvolume "Torrents=
".
> Now it errors :)
>
> btrfs ins dump-tree -t 259 /dev/sda | grep "(259 " -A8
> file tree key (259 ROOT_ITEM 0)
> node 3184169484288 level 2 items 37 free space 456 generation 1084405 ow=
ner 259
> node 3184169484288 flags 0x1(WRITTEN) backref revision 1
> fs uuid bfa267c0-df2c-45a6-ad88-9d76b3844326
> chunk uuid 69378187-7a8d-42cc-a28d-a935000d8a94
>          key (256 INODE_ITEM 0) block 3184169500672 gen 1084405
>          key (1707 INODE_ITEM 0) block 3190334537728 gen 1081752
>          key (3045 INODE_ITEM 0) block 3184776314880 gen 1082176
>          key (7354 INODE_ITEM 0) block 3184775987200 gen 1082176
> --
>                  location key (259 INODE_ITEM 0) type DIR
>                  transid 398 data_len 0 name_len 6
>                  name: B
>          item 9 key (256 DIR_ITEM 2983476959) itemoff 15743 itemsize 35
>                  location key (257 INODE_ITEM 0) type DIR
>                  transid 398 data_len 0 name_len 5
>                  name: A
>          item 10 key (256 DIR_ITEM 3061133479) itemoff 15682 itemsize 61
>                  location key (372987 INODE_ITEM 0) type FILE
> --
>                  location key (259 INODE_ITEM 0) type DIR
>                  transid 398 data_len 0 name_len 6
>                  name: B
>          item 19 key (256 DIR_INDEX 5) itemoff 15286 itemsize 36
>                  location key (260 INODE_ITEM 0) type DIR
>                  transid 398 data_len 0 name_len 6
>                  name: C
>          item 20 key (256 DIR_INDEX 6) itemoff 15250 itemsize 36
>                  location key (261 INODE_ITEM 0) type DIR
> --
>          item 30 key (259 INODE_ITEM 0) itemoff 13737 itemsize 160
>                  generation 398 transid 1084405 size 0 nbytes 0
>                  block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev=
 0
>                  sequence 176 flags 0x0(none)
>                  atime 1648781916.577915854 (2022-03-31 19:58:36)
>                  ctime 1647237475.825138581 (2022-03-13 22:57:55)
>                  mtime 1647237475.825138581 (2022-03-13 22:57:55)
>                  otime 1589685271.577476911 (2020-05-16 20:14:31)
>          item 31 key (259 INODE_REF 256) itemoff 13721 itemsize 16
>                  index 4 namelen 6 name: B
>          item 32 key (260 INODE_ITEM 0) itemoff 13561 itemsize 160
>                  generation 398 transid 1074067 size 56 nbytes 0
>                  block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev=
 0
>                  sequence 405 flags 0x0(none)
>                  atime 1648367720.152037253 (2022-03-27 00:55:20)
>                  ctime 1646816503.726286540 (2022-03-09 01:01:43)
>                  mtime 1646816503.726286540 (2022-03-09 01:01:43)
> parent transid verify failed on 3184315432960 wanted 1084439 found 10844=
42
> parent transid verify failed on 3184315432960 wanted 1084439 found 10844=
42
> parent transid verify failed on 3184315432960 wanted 1084439 found 10844=
42
> parent transid verify failed on 3184315432960 wanted 1084439 found 10844=
42
> Ignoring transid failure
> parent transid verify failed on 3184315498496 wanted 1084439 found 10844=
42
> parent transid verify failed on 3184315498496 wanted 1084439 found 10844=
42
> parent transid verify failed on 3184315498496 wanted 1084439 found 10844=
42
> parent transid verify failed on 3184315498496 wanted 1084439 found 10844=
42
> Ignoring transid failure
> parent transid verify failed on 3184317464576 wanted 1084439 found 10844=
43
> parent transid verify failed on 3184317464576 wanted 1084439 found 10844=
43
> parent transid verify failed on 3184317464576 wanted 1084439 found 10844=
43
> parent transid verify failed on 3184317464576 wanted 1084439 found 10844=
43
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D3184315416576 item=3D4 parent
> level=3D1 child bytenr=3D3184317464576 child level=3D2

Transid mismatch, a big problem.
It can explain the problem.

Maybe kernel can solve it but progs can not really utilize RAID5 parity
to rebuild.

BTW, when you access the directory, no dmesg output?

Thanks,
Qu

>
> Note that name B is the problematic one. I can access A and C just
> fine. Interestingly enough there are many more directories.
>
>>
>> If there is really nothing but the subvolume itself, it may be somethin=
g
>> else.
>>
>> Thanks,
>> Qu
>>>
>>> The reason I know there are files here is because my torrent client is
>>> currently seeding them. If I change the Catagory (which moves the
>>> files elsewhere), the files show up in the given directory.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>> found 2689565679616 bytes used, no error found
>>>>> total csum bytes: 2620609300
>>>>> total tree bytes: 5374935040
>>>>> total fs tree bytes: 1737539584
>>>>> total extent tree bytes: 511115264
>>>>> btree space waste bytes: 889131100
>>>>> file data blocks allocated: 41913072627712
>>>>>     referenced 2675025698816
>>>>>
>>>>>>
>>>>>> As sometimes it can report false positive if the fs is not mounted
>>>>>> read-only.
>>>>>>
>>>>>>> Opening filesystem to check...
>>>>>>> Checking filesystem on /dev/sda
>>>>>>> UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
>>>>>>> [1/7] checking root items
>>>>>>> [2/7] checking extents
>>>>>>> [3/7] checking free space cache
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 139616845824
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 146059296768
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 3183842689024
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 3184916430848
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 3185990172672
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 3187063914496
>>>>>>> btrfs: space cache generation (1084391) does not match inode (1084=
389)
>>>>>>> failed to load free space cache for block group 3190318694400
>>>>>>> block group 4885757034496 has wrong amount of free space, free spa=
ce
>>>>>>> cache has 286720 block group has 290816
>>>>>>> failed to load free space cache for block group 4885757034496
>>>>>>> block group 4898641936384 has wrong amount of free space, free spa=
ce
>>>>>>> cache has 36864 block group has 53248
>>>>>>> failed to load free space cache for block group 4898641936384
>>>>>>> block group 4953402769408 has wrong amount of free space, free spa=
ce
>>>>>>> cache has 262144 block group has 274432
>>>>>>> failed to load free space cache for block group 4953402769408
>>>>>>> block group 5478462521344 has wrong amount of free space, free spa=
ce
>>>>>>> cache has 716800 block group has 729088
>>>>>>> failed to load free space cache for block group 5478462521344
>>>>>>> block group 5484904972288 has wrong amount of free space, free spa=
ce
>>>>>>> cache has 811008 block group has 819200
>>>>>>> failed to load free space cache for block group 5484904972288
>>>>>>> [4/7] checking fs roots
>>>>>>>
>>>>>>> It's currently stuck on that last one.
>>>>>>
>>>>>> If the fs is pretty large, it can take quite some time.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> It looks like an DIR_ITEM/DIR_INDEX corruption.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>
>>>>>>

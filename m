Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D212A4D2930
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 07:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiCIG5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 01:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIG5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 01:57:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA7161126
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 22:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646809011;
        bh=GfAshEmhY+ELxPUkS6nqNpNw3kmPoqapx8KhHtWwPas=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MU/cdLcLci66E1e8emlTFi5hC7IZfGUzbDj5nqBc1t1qPL9CyL2yUV8+UcQ65+Wor
         w1D1g+LLqP7q4gEaxJAYVr32nN7KJ9z2Ni8uFeeTNJlsR4mGr0JqYktXpElTGchjAq
         GKCNY+x8k/BdfQgekayGmt0BEtB6+B391M3yojnI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17Ye-1o8HUJ3lHe-012YJf; Wed, 09
 Mar 2022 07:56:50 +0100
Message-ID: <056e2062-2e52-1df0-8604-f66e148365cc@gmx.com>
Date:   Wed, 9 Mar 2022 14:56:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Updated to new kernel, and btrfs suddenly refuses to mount home
 directory fs.
Content-Language: en-US
To:     bill gates <framingnoone@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
 <7a4962a0-b007-59a4-282e-8912b2425c5e@gmx.com>
 <CALPV6DtuY6KxFKF6WR2HDPzzVm8TbcGEXwTMiDAy6MdL+jC7jA@mail.gmail.com>
 <ca8e7647-9996-d05d-1438-ff2b82c7038b@gmx.com>
 <CALPV6DvuD5Tn_mepbVPcWkbNA-s9Nj-jc1dsY8Cm5KOrYfbu0Q@mail.gmail.com>
 <8120882e-d5ce-d8d8-fc5a-1a9b2e3eb39a@gmx.com>
 <CALPV6Ds8dQ8rro6N=1xQbW09uwKnNdayVim=VPRgS47zpG-KuQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALPV6Ds8dQ8rro6N=1xQbW09uwKnNdayVim=VPRgS47zpG-KuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZntBYBMy/A+fyb3XnZ4EDqPyXvxR9EcvquqQQHrTTNcWwI5KHr
 Otdol8iZ2oY6c443Vr1eI7Fh/hU6uAZ/6u7GwU/BbPZHmXlTpUGiWZWZ9KuiOmNS4lANJ0s
 zJ7lqa/XaadmoG5FwKM3tsJCxaA+Zb1AMFncqKN9LnYhx+3qob0B1tdlJhkPdz/jv1eUCws
 mOeD6+vLj6GyOan/iGzug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nXB1KDF6zJI=:aG1F7kMeElzFC/gbw+q4CA
 wH+h/NLSlq1fwAcpHoXacJ9HAn3udDx3P78YvqtX1jlmNoXOOY4CY5BdxDm8ITPf110zFQ86p
 Jv1KPiNNZc3KWal4ZxmOdq0TjaQ5aLast7KxW2TamPcaYd6u9U8l3iePH0nJ1nNhMGbdyjyU8
 UMB2x6Y/qX+TgMrLa+3UCCq39fguMubcw1jX2NX4+/CLooqDzLMRmrkXQooPNYagLo0yr+jLS
 LIRumKlaLrVFuTp8Qd3aUnytxpc4zwcL39e9VXr1Lll58T7Xw8FGP9RHwn3jGcBmUhNKkQXQY
 IWZrKIg/aByyVMjQ924Nf2tTb/Zs8251VHBgeUf8exTnE0eTu6lDbJ8yRf6gACLJh9YW2GYFK
 x7PIcVqDxAkf84hb/56d4ezpa3U3Va5MOOKkfChr88WOA8GXp5YreQr/JWzUuywFx0/APKlcO
 3e5QwqM100ZPXfNUg/qCBG5J6FehmbFa0YCQMbQAfsOlP8Ud0OV3BtnaYd87ZXB/dAnJVBcj7
 kGtdAh52r3TAsNr2pWORoPiz8rtXb2MXSkQ7djSz3a3El2oNEVyaseaFmC/gaObVVT2cClJwb
 6D8VDWuTKl7OZ7AZ/y+zI1+CdQ7J+OnPtJiYmIhA7F0wQ6d0/JceJBYVvwQ/uCjBJ4owxSSPB
 7zwPqLyrNtQjmjkJGdpkC9IOKrzg4i/cDiJGqC/Yn8AMc0U+pvpSGAYWW6jwc1aWOAf9PMwnd
 9LaLlxP5dc4xQiHwKwegD1T8ETYAo6TvQMauWKFMuUAR0uSPM6SgbayHs86hgl/p8/mJg5LfB
 Nocwbm0yXIfrCQE9l4gMEkevp60q78shZ8xJJsi+qoIA8+xt8f2mhLLJKMCKfNdz+O5nv2oHo
 NgF6eE6hdtLQhy1GIsrOwAr0cPQLhIuYBEpRMZ9JGumiXXLf71wuZKPIMj3B1+NFIKYJmxiyI
 voqKZnFXNJ7q3Z4napb2qea91Pc+KFGn/o5Drn3JiEyhKolodpC4kirb0uKe6KwBRMnHJ9Seg
 9n+6NRM1j9BP1cwNr80g01TNfpmPDSLJwD/YHDuHDjOX81CgAKN13pjt/1+N+byubPE0+WZ4L
 cyU0HD97rrfSlo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 13:21, bill gates wrote:
> Qu,
>
> here's what I got on 5.15.23
>
> dump-tree root /dev/sda2 on kernel 5.15.23 here: https://paste.ee/p/kSdI=
2

Exactly what I'm expecting:

	item 8 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14697 itemsize 37
		location key (ROOT_TREE UNKNOWN.0 0) type DIR
		transid 0 data_len 0 name_len 7
		name: default

Note the location key, it doesn't point to any real subvolume.
Thus newer kernel is rejecting it.

To fix it, you can try the following command using your older working
kernel:

# btrfs subvolume set-default 5 <mount point>

Then try if the newer kernel handles it without problem.

Thanks,
Qu
>
> Warning: 2+MB text dump, this is a good-sized, and well-used, fs.
>
> Thank you,
> -- Laurence
>
> On Tue, Mar 8, 2022 at 10:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/3/9 12:28, bill gates wrote:
>>> Oh... I ran the ins dump-tree on the old kernel (4.19), not the new
>>> one. The new kernel sees it differently (!)
>>
>> No, this is still not the old result.
>>
>> It looks like a mount using older kernel changed the result.
>>
>> Please use the following command instead:
>>
>> # btrfs ins dump-tree -t root /dev/sda2
>>
>> Thanks,
>> Qu
>>
>>>
>>> ----- kernel 5.15 ins dump-tree
>>> btrfs-progs v5.15.1
>>> leaf 10442806968320 items 169 free space 3439 generation 6835704 owner
>>> EXTENT_TREE
>>> leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
>>> fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
>>> chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
>>>          item 0 key (10442625581056 EXTENT_ITEM 16384) itemoff 16232 i=
temsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111548533555=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 1 key (10442625597440 EXTENT_ITEM 16384) itemoff 16181 i=
temsize 51
>>>                  refs 1 gen 307924 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1099758461747=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 2 key (10442625630208 EXTENT_ITEM 16384) itemoff 16130 i=
temsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111550195302=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 3 key (10442625646592 EXTENT_ITEM 16384) itemoff 16079 i=
temsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111551857049=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 4 key (10442625662976 EXTENT_ITEM 16384) itemoff 16028 i=
temsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111553518796=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 5 key (10442625679360 EXTENT_ITEM 16384) itemoff 15977 i=
temsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111555180544=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 6 key (10442625695744 EXTENT_ITEM 16384) itemoff 15926 i=
temsize 51
>>>                  refs 1 gen 308431 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1105287568179=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 7 key (10442625712128 EXTENT_ITEM 16384) itemoff 15875 i=
temsize 51
>>>                  refs 1 gen 308431 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1105285906432=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 8 key (10442625728512 EXTENT_ITEM 16384) itemoff 15824 i=
temsize 51
>>>                  refs 1 gen 308431 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1105289229926=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 9 key (10442625744896 EXTENT_ITEM 16384) itemoff 15773 i=
temsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12064823508992 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 10 key (10442625761280 EXTENT_ITEM 16384) itemoff 15722 =
itemsize 51
>>>                  refs 1 gen 6745444 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1249647278489=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 11 key (10442625794048 EXTENT_ITEM 16384) itemoff 15671 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111563928371=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 12 key (10442625810432 EXTENT_ITEM 16384) itemoff 15620 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111565590118=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 13 key (10442625826816 EXTENT_ITEM 16384) itemoff 15569 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111567251865=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 14 key (10442625843200 EXTENT_ITEM 16384) itemoff 15518 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2068362 INODE_REF 2066150) level 0
>>>                  tree block backref root 257
>>>          item 15 key (10442625875968 EXTENT_ITEM 16384) itemoff 15467 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2068385 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 16 key (10442625892352 EXTENT_ITEM 16384) itemoff 15416 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12065235910656 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 17 key (10442625908736 EXTENT_ITEM 16384) itemoff 15365 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12065187733504 EXTENT_ITEM 57344) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 18 key (10442625925120 EXTENT_ITEM 16384) itemoff 15314 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111568913612=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 19 key (10442625941504 EXTENT_ITEM 16384) itemoff 15263 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111570575360=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 20 key (10442625990656 EXTENT_ITEM 16384) itemoff 15212 =
itemsize 51
>>>                  refs 1 gen 6833576 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 9686276972544=
) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 21 key (10442626007040 EXTENT_ITEM 16384) itemoff 15161 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12065510035456 EXTENT_ITEM 1052672) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 22 key (10442626023424 EXTENT_ITEM 16384) itemoff 15110 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12065890512896 EXTENT_ITEM 49152) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 23 key (10442626039808 EXTENT_ITEM 16384) itemoff 15059 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12065799458816 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 24 key (10442626072576 EXTENT_ITEM 16384) itemoff 15008 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12065947615232 EXTENT_ITEM 712704) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 25 key (10442626088960 EXTENT_ITEM 16384) itemoff 14957 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764131 INODE_ITEM 0) level 0
>>>                  tree block backref root 257
>>>          item 26 key (10442626105344 EXTENT_ITEM 16384) itemoff 14906 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764153 INODE_REF 76762106) level 0
>>>                  tree block backref root 257
>>>          item 27 key (10442626121728 EXTENT_ITEM 16384) itemoff 14855 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764176 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 28 key (10442626138112 EXTENT_ITEM 16384) itemoff 14804 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040513145241=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 29 key (10442626154496 EXTENT_ITEM 16384) itemoff 14753 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764289 INODE_ITEM 0) level 0
>>>                  tree block backref root 257
>>>          item 30 key (10442626170880 EXTENT_ITEM 16384) itemoff 14702 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111572237107=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 31 key (10442626187264 EXTENT_ITEM 16384) itemoff 14651 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12066310410240 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 32 key (10442626203648 EXTENT_ITEM 16384) itemoff 14600 =
itemsize 51
>>>                  refs 1 gen 6724925 flags TREE_BLOCK
>>>                  tree block key (10241601216512 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 33 key (10442626220032 EXTENT_ITEM 16384) itemoff 14549 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2541168 DIR_INDEX 9) level 0
>>>                  tree block backref root 257
>>>          item 34 key (10442626236416 EXTENT_ITEM 16384) itemoff 14498 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040514804531=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 35 key (10442626252800 EXTENT_ITEM 16384) itemoff 14447 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2541180 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 36 key (10442626269184 EXTENT_ITEM 16384) itemoff 14396 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2541188 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 37 key (10442626285568 EXTENT_ITEM 16384) itemoff 14345 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040516466278=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 38 key (10442626334720 EXTENT_ITEM 16384) itemoff 14294 =
itemsize 51
>>>                  refs 1 gen 6264604 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1123084849971=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 39 key (10442626400256 EXTENT_ITEM 16384) itemoff 14243 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1023562968268=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 40 key (10442626416640 EXTENT_ITEM 16384) itemoff 14192 =
itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1220366489190=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 41 key (10442626449408 EXTENT_ITEM 16384) itemoff 14141 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12067359137792 EXTENT_ITEM 12288) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 42 key (10442626465792 EXTENT_ITEM 16384) itemoff 14090 =
itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (12204759490560 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 43 key (10442626482176 EXTENT_ITEM 16384) itemoff 14039 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12067310555136 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 44 key (10442626498560 EXTENT_ITEM 16384) itemoff 13988 =
itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1220476263628=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 45 key (10442626514944 EXTENT_ITEM 16384) itemoff 13937 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1056753568153=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 46 key (10442626531328 EXTENT_ITEM 16384) itemoff 13886 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (11216497197056 EXTENT_ITEM 16384) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 47 key (10442626547712 EXTENT_ITEM 16384) itemoff 13835 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (12894114234368 EXTENT_ITEM 16384) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 48 key (10442626564096 EXTENT_ITEM 16384) itemoff 13784 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (13092730437632 EXTENT_ITEM 16384) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 49 key (10442626580480 EXTENT_ITEM 16384) itemoff 13733 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764473 INODE_REF 76762122) level 0
>>>                  tree block backref root 257
>>>          item 50 key (10442626596864 EXTENT_ITEM 16384) itemoff 13682 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12067776978944 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 51 key (10442626613248 EXTENT_ITEM 16384) itemoff 13631 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040518128025=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 52 key (10442626629632 EXTENT_ITEM 16384) itemoff 13580 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (13092764860416 EXTENT_ITEM 16384) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 53 key (10442626662400 EXTENT_ITEM 16384) itemoff 13529 =
itemsize 51
>>>                  refs 1 gen 1434043 flags TREE_BLOCK
>>>                  tree block key (15409727 DIR_INDEX 1378) level 0
>>>                  tree block backref root 257
>>>          item 54 key (10442626678784 EXTENT_ITEM 16384) itemoff 13478 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1056755229900=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 55 key (10442626711552 EXTENT_ITEM 16384) itemoff 13427 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12068306247680 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 56 key (10442626727936 EXTENT_ITEM 16384) itemoff 13376 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12068680613888 EXTENT_ITEM 81920) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 57 key (10442626744320 EXTENT_ITEM 16384) itemoff 13325 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764584 INODE_REF 76762122) level 0
>>>                  tree block backref root 257
>>>          item 58 key (10442626793472 EXTENT_ITEM 16384) itemoff 13274 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1056756891648=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 59 key (10442626859008 EXTENT_ITEM 16384) itemoff 13223 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (10442421272576 EXTENT_ITEM 16384) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 60 key (10442626875392 EXTENT_ITEM 16384) itemoff 13172 =
itemsize 51
>>>                  refs 1 gen 4570110 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1169408712704=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 61 key (10442626908160 EXTENT_ITEM 16384) itemoff 13121 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12069107830784 EXTENT_ITEM 102400) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 62 key (10442626940928 EXTENT_ITEM 16384) itemoff 13070 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12069177942016 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 63 key (10442626957312 EXTENT_ITEM 16384) itemoff 13019 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12069211504640 EXTENT_ITEM 131072) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 64 key (10442626973696 EXTENT_ITEM 16384) itemoff 12968 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764814 INODE_REF 76762122) level 0
>>>                  tree block backref root 257
>>>          item 65 key (10442626990080 EXTENT_ITEM 16384) itemoff 12917 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538301 INODE_ITEM 0) level 0
>>>                  tree block backref root 257
>>>          item 66 key (10442627006464 EXTENT_ITEM 16384) itemoff 12866 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538310 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 67 key (10442627022848 EXTENT_ITEM 16384) itemoff 12815 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040519789772=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 68 key (10442627039232 EXTENT_ITEM 16384) itemoff 12764 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (9708461223936 EXTENT_ITEM 8192) level=
 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 69 key (10442627055616 EXTENT_ITEM 16384) itemoff 12713 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (9709536043008 EXTENT_ITEM 4096) level=
 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 70 key (10442627088384 EXTENT_ITEM 16384) itemoff 12662 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111573898854=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 71 key (10442627104768 EXTENT_ITEM 16384) itemoff 12611 =
itemsize 51
>>>                  refs 1 gen 6698785 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1217784969216=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 72 key (10442627121152 EXTENT_ITEM 16384) itemoff 12560 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538341 INODE_REF 2537331) level 0
>>>                  tree block backref root 257
>>>          item 73 key (10442627137536 EXTENT_ITEM 16384) itemoff 12509 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538361 INODE_REF 2537394) level 0
>>>                  tree block backref root 257
>>>          item 74 key (10442627153920 EXTENT_ITEM 16384) itemoff 12458 =
itemsize 51
>>>                  refs 1 gen 672522 flags TREE_BLOCK
>>>                  tree block key (2552451 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 75 key (10442627170304 EXTENT_ITEM 16384) itemoff 12407 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111575560601=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 76 key (10442627186688 EXTENT_ITEM 16384) itemoff 12356 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764880 INODE_REF 76762122) level 0
>>>                  tree block backref root 257
>>>          item 77 key (10442627203072 EXTENT_ITEM 16384) itemoff 12305 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12069486489600 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 78 key (10442627219456 EXTENT_ITEM 16384) itemoff 12254 =
itemsize 51
>>>                  refs 1 gen 4416707 flags TREE_BLOCK
>>>                  tree block key (17422551 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 79 key (10442627252224 EXTENT_ITEM 16384) itemoff 12203 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538389 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 80 key (10442627268608 EXTENT_ITEM 16384) itemoff 12152 =
itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76765020 INODE_REF 76762122) level 0
>>>                  tree block backref root 257
>>>          item 81 key (10442627284992 EXTENT_ITEM 16384) itemoff 12101 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538408 DIR_INDEX 53) level 0
>>>                  tree block backref root 257
>>>          item 82 key (10442627301376 EXTENT_ITEM 16384) itemoff 12050 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12069821075456 EXTENT_ITEM 974848) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 83 key (10442627334144 EXTENT_ITEM 16384) itemoff 11999 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12070201597952 EXTENT_ITEM 1052672) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 84 key (10442627350528 EXTENT_ITEM 16384) itemoff 11948 =
itemsize 51
>>>                  refs 1 gen 6698785 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1219323527168=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 85 key (10442627399680 EXTENT_ITEM 16384) itemoff 11897 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>                  tree block key (2538447 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 86 key (10442627432448 EXTENT_ITEM 16384) itemoff 11846 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (9723383021568 EXTENT_ITEM 950272) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 87 key (10442627481600 EXTENT_ITEM 16384) itemoff 11795 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040521451520=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 88 key (10442627497984 EXTENT_ITEM 16384) itemoff 11744 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040523113267=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 89 key (10442627514368 EXTENT_ITEM 16384) itemoff 11693 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12087570075648 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 90 key (10442627530752 EXTENT_ITEM 16384) itemoff 11642 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1056758553395=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 91 key (10442627563520 EXTENT_ITEM 16384) itemoff 11591 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12088286089216 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 92 key (10442627579904 EXTENT_ITEM 16384) itemoff 11540 =
itemsize 51
>>>                  refs 1 gen 6698785 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1224332204851=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 93 key (10442627596288 EXTENT_ITEM 16384) itemoff 11489 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12068807602176 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 94 key (10442627629056 EXTENT_ITEM 16384) itemoff 11438 =
itemsize 51
>>>                  refs 1 gen 6727271 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1218353594368=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 95 key (10442627645440 EXTENT_ITEM 16384) itemoff 11387 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040524775014=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 96 key (10442627678208 EXTENT_ITEM 16384) itemoff 11336 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111577222348=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 97 key (10442627694592 EXTENT_ITEM 16384) itemoff 11285 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12157162041344 EXTENT_ITEM 790528) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 98 key (10442627710976 EXTENT_ITEM 16384) itemoff 11234 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 9756884873216=
) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 99 key (10442627727360 EXTENT_ITEM 16384) itemoff 11183 =
itemsize 51
>>>                  refs 1 gen 6464632 flags TREE_BLOCK
>>>                  tree block key (65735848 INODE_REF 58323055) level 0
>>>                  tree block backref root 257
>>>          item 100 key (10442627776512 EXTENT_ITEM 16384) itemoff 11132=
 itemsize 51
>>>                  refs 1 gen 6139527 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1183006424268=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 101 key (10442627792896 EXTENT_ITEM 16384) itemoff 11081=
 itemsize 51
>>>                  refs 1 gen 6464632 flags TREE_BLOCK
>>>                  tree block key (65736607 INODE_REF 65731578) level 0
>>>                  tree block backref root 257
>>>          item 102 key (10442627858432 EXTENT_ITEM 16384) itemoff 11030=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12180178153472 EXTENT_ITEM 8192) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 103 key (10442627874816 EXTENT_ITEM 16384) itemoff 10979=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12180343758848 EXTENT_ITEM 14528512) =
level 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 104 key (10442627891200 EXTENT_ITEM 16384) itemoff 10928=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12142622306304 EXTENT_ITEM 24576) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 105 key (10442627907584 EXTENT_ITEM 16384) itemoff 10877=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12180880535552 EXTENT_ITEM 155648) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 106 key (10442627923968 EXTENT_ITEM 16384) itemoff 10826=
 itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1220440795545=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 107 key (10442627940352 EXTENT_ITEM 16384) itemoff 10775=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12180491771904 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 108 key (10442627956736 EXTENT_ITEM 16384) itemoff 10724=
 itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764087 INODE_ITEM 0) level 0
>>>                  tree block backref root 257
>>>          item 109 key (10442627973120 EXTENT_ITEM 16384) itemoff 10673=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12185288880128 EXTENT_ITEM 49152) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 110 key (10442627989504 EXTENT_ITEM 16384) itemoff 10622=
 itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1220651537612=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 111 key (10442628005888 EXTENT_ITEM 16384) itemoff 10571=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12185404018688 EXTENT_ITEM 1052672) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 112 key (10442628022272 EXTENT_ITEM 16384) itemoff 10520=
 itemsize 51
>>>                  refs 1 gen 6464632 flags TREE_BLOCK
>>>                  tree block key (27390978 INODE_ITEM 0) level 0
>>>                  tree block backref root 257
>>>          item 113 key (10442628038656 EXTENT_ITEM 16384) itemoff 10469=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12196305096704 EXTENT_ITEM 12288) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 114 key (10442628055040 EXTENT_ITEM 16384) itemoff 10418=
 itemsize 51
>>>                  refs 1 gen 6464632 flags TREE_BLOCK
>>>                  tree block key (17346964 INODE_REF 17346635) level 0
>>>                  tree block backref root 257
>>>          item 115 key (10442628071424 EXTENT_ITEM 16384) itemoff 10367=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12202632044544 EXTENT_ITEM 135168) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 116 key (10442628104192 EXTENT_ITEM 16384) itemoff 10316=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12184667025408 EXTENT_ITEM 4198400) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 117 key (10442628120576 EXTENT_ITEM 16384) itemoff 10265=
 itemsize 51
>>>                  refs 1 gen 6236744 flags TREE_BLOCK
>>>                  tree block key (76764208 EXTENT_DATA 0) level 0
>>>                  tree block backref root 257
>>>          item 118 key (10442628136960 EXTENT_ITEM 16384) itemoff 10214=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12223140970496 EXTENT_ITEM 1114112) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 119 key (10442628153344 EXTENT_ITEM 16384) itemoff 10163=
 itemsize 51
>>>                  refs 1 gen 6464632 flags TREE_BLOCK
>>>                  tree block key (57503313 INODE_REF 5903664) level 0
>>>                  tree block backref root 257
>>>          item 120 key (10442628169728 EXTENT_ITEM 16384) itemoff 10112=
 itemsize 51
>>>                  refs 1 gen 6727271 flags TREE_BLOCK
>>>                  tree block key (12282814701568 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 121 key (10442628186112 EXTENT_ITEM 16384) itemoff 10061=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12223473651712 EXTENT_ITEM 729088) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 122 key (10442628202496 EXTENT_ITEM 16384) itemoff 10010=
 itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12224274079744 EXTENT_ITEM 3145728) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 123 key (10442628218880 EXTENT_ITEM 16384) itemoff 9959 =
itemsize 51
>>>                  refs 1 gen 6835701 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 9822438273024=
) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 124 key (10442628251648 EXTENT_ITEM 16384) itemoff 9908 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12224877871104 EXTENT_ITEM 15855616) =
level 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 125 key (10442628268032 EXTENT_ITEM 16384) itemoff 9857 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12225476325376 EXTENT_ITEM 208896) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 126 key (10442628284416 EXTENT_ITEM 16384) itemoff 9806 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12226798768128 EXTENT_ITEM 2101248) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 127 key (10442628300800 EXTENT_ITEM 16384) itemoff 9755 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12227805872128 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 128 key (10442628317184 EXTENT_ITEM 16384) itemoff 9704 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12233946206208 EXTENT_ITEM 20480) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 129 key (10442628333568 EXTENT_ITEM 16384) itemoff 9653 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12233996038144 EXTENT_ITEM 233472) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 130 key (10442628349952 EXTENT_ITEM 16384) itemoff 9602 =
itemsize 51
>>>                  refs 1 gen 6698785 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1216056250777=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 131 key (10442628366336 EXTENT_ITEM 16384) itemoff 9551 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12237278531584 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 132 key (10442628382720 EXTENT_ITEM 16384) itemoff 9500 =
itemsize 51
>>>                  refs 1 gen 6727271 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1242112118374=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 133 key (10442628399104 EXTENT_ITEM 16384) itemoff 9449 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12237030932480 EXTENT_ITEM 118784) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 134 key (10442628415488 EXTENT_ITEM 16384) itemoff 9398 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12237580976128 EXTENT_ITEM 4194304) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 135 key (10442628431872 EXTENT_ITEM 16384) itemoff 9347 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12241256226816 EXTENT_ITEM 200704) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 136 key (10442628448256 EXTENT_ITEM 16384) itemoff 9296 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12241758822400 EXTENT_ITEM 28672) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 137 key (10442628464640 EXTENT_ITEM 16384) itemoff 9245 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12253141274624 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 138 key (10442628481024 EXTENT_ITEM 16384) itemoff 9194 =
itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1132125015654=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 139 key (10442628497408 EXTENT_ITEM 16384) itemoff 9143 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040526436761=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 140 key (10442628513792 EXTENT_ITEM 16384) itemoff 9092 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1040528093593=
6) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 141 key (10442628562944 EXTENT_ITEM 16384) itemoff 9041 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12265441398784 EXTENT_ITEM 2097152) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 142 key (10442628579328 EXTENT_ITEM 16384) itemoff 8990 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12271441833984 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 143 key (10442628595712 EXTENT_ITEM 16384) itemoff 8939 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12272561885184 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 144 key (10442628612096 EXTENT_ITEM 16384) itemoff 8888 =
itemsize 51
>>>                  refs 1 gen 309972 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1111578884096=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 145 key (10442628628480 EXTENT_ITEM 16384) itemoff 8837 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12282866843648 EXTENT_ITEM 905216) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 146 key (10442628644864 EXTENT_ITEM 16384) itemoff 8786 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12283205406720 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 147 key (10442628661248 EXTENT_ITEM 16384) itemoff 8735 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1043432770355=
2) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 148 key (10442628677632 EXTENT_ITEM 16384) itemoff 8684 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12289339404288 EXTENT_ITEM 81920) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 149 key (10442628694016 EXTENT_ITEM 16384) itemoff 8633 =
itemsize 51
>>>                  refs 1 gen 302689 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1043434432102=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 150 key (10442628710400 EXTENT_ITEM 16384) itemoff 8582 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12299776696320 EXTENT_ITEM 3145728) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 151 key (10442628726784 EXTENT_ITEM 16384) itemoff 8531 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12299871612928 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 152 key (10442628743168 EXTENT_ITEM 16384) itemoff 8480 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12302335598592 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 153 key (10442628759552 EXTENT_ITEM 16384) itemoff 8429 =
itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1220765532160=
0) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 154 key (10442628775936 EXTENT_ITEM 16384) itemoff 8378 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12302453288960 EXTENT_ITEM 2097152) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 155 key (10442628792320 EXTENT_ITEM 16384) itemoff 8327 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12303679279104 EXTENT_ITEM 98304) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 156 key (10442628808704 EXTENT_ITEM 16384) itemoff 8276 =
itemsize 51
>>>                  refs 1 gen 6680401 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1220925557964=
8) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 157 key (10442628825088 EXTENT_ITEM 16384) itemoff 8225 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12306045173760 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 158 key (10442628841472 EXTENT_ITEM 16384) itemoff 8174 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12306189029376 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 159 key (10442628857856 EXTENT_ITEM 16384) itemoff 8123 =
itemsize 51
>>>                  refs 1 gen 6487789 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1059696801382=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 160 key (10442628874240 EXTENT_ITEM 16384) itemoff 8072 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12310012329984 EXTENT_ITEM 131072) le=
vel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 161 key (10442628923392 EXTENT_ITEM 16384) itemoff 8021 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12311480930304 EXTENT_ITEM 61440) lev=
el 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 162 key (10442628972544 EXTENT_ITEM 16384) itemoff 7970 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12317130739712 EXTENT_ITEM 1052672) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 163 key (10442628988928 EXTENT_ITEM 16384) itemoff 7919 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12317269188608 EXTENT_ITEM 2097152) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 164 key (10442629005312 EXTENT_ITEM 16384) itemoff 7868 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12317973839872 EXTENT_ITEM 4096) leve=
l 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 165 key (10442629021696 EXTENT_ITEM 16384) itemoff 7817 =
itemsize 51
>>>                  refs 1 gen 6834895 flags TREE_BLOCK
>>>                  tree block key (EXTENT_CSUM EXTENT_CSUM 1005156458086=
4) level 0
>>>                  tree block backref root CSUM_TREE
>>>          item 166 key (10442629038080 EXTENT_ITEM 16384) itemoff 7766 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12318824312832 EXTENT_ITEM 2097152) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 167 key (10442629054464 EXTENT_ITEM 16384) itemoff 7715 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12319312617472 EXTENT_ITEM 4993024) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>          item 168 key (10442629070848 EXTENT_ITEM 16384) itemoff 7664 =
itemsize 51
>>>                  refs 1 gen 6787103 flags TREE_BLOCK
>>>                  tree block key (12319524802560 EXTENT_ITEM 1048576) l=
evel 0
>>>                  tree block backref root EXTENT_TREE
>>>
>>> ----
>>>
>>> Thanks,
>>> -- Laurence
>>>
>>>
>>> On Tue, Mar 8, 2022 at 9:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>>
>>>>
>>>>
>>>> On 2022/3/9 09:09, bill gates wrote:
>>>>> This filesystem was most likely created in 2014 using the tools of
>>>>> that time, at least that's the oldest file in my home directory. It
>>>>> _might_ have been made in 2019, that's the date on the mount point.
>>>>>
>>>>> There are 2 subvolumes on /dev/sda2, /home and /var.
>>>>>
>>>>> My btrfs-progs version is 5.15.1.
>>>>>
>>>>> Per your request:
>>>>> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
>>>>> btrfs-progs v5.15.1
>>>>
>>>> Weird, the output doesn't match the dmesg.
>>>>
>>>> This tree belongs to csum tree, not root tree.
>>>>
>>>> Thanks,
>>>> Qu
>>>>> leaf 10442806968320 items 34 free space 6225 generation 6834902 owne=
r CSUM_TREE
>>>>> leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
>>>>> fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
>>>>> chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
>>>>>           item 0 key (EXTENT_CSUM EXTENT_CSUM 9848629587968) itemoff
>>>>> 16075 itemsize 208
>>>>>                   range start 9848629587968 end 9848629800960 length=
 212992
>>>>>           item 1 key (EXTENT_CSUM EXTENT_CSUM 9848630026240) itemoff
>>>>> 15823 itemsize 252
>>>>>                   range start 9848630026240 end 9848630284288 length=
 258048
>>>>>           item 2 key (EXTENT_CSUM EXTENT_CSUM 9848630714368) itemoff
>>>>> 15815 itemsize 8
>>>>>                   range start 9848630714368 end 9848630722560 length=
 8192
>>>>>           item 3 key (EXTENT_CSUM EXTENT_CSUM 9848630984704) itemoff
>>>>> 14723 itemsize 1092
>>>>>                   range start 9848630984704 end 9848632102912 length=
 1118208
>>>>>           item 4 key (EXTENT_CSUM EXTENT_CSUM 9848632160256) itemoff
>>>>> 14703 itemsize 20
>>>>>                   range start 9848632160256 end 9848632180736 length=
 20480
>>>>>           item 5 key (EXTENT_CSUM EXTENT_CSUM 9848632180736) itemoff
>>>>> 14279 itemsize 424
>>>>>                   range start 9848632180736 end 9848632614912 length=
 434176
>>>>>           item 6 key (EXTENT_CSUM EXTENT_CSUM 9848632942592) itemoff
>>>>> 14067 itemsize 212
>>>>>                   range start 9848632942592 end 9848633159680 length=
 217088
>>>>>           item 7 key (EXTENT_CSUM EXTENT_CSUM 9848633286656) itemoff
>>>>> 13815 itemsize 252
>>>>>                   range start 9848633286656 end 9848633544704 length=
 258048
>>>>>           item 8 key (EXTENT_CSUM EXTENT_CSUM 9848633548800) itemoff
>>>>> 13579 itemsize 236
>>>>>                   range start 9848633548800 end 9848633790464 length=
 241664
>>>>>           item 9 key (EXTENT_CSUM EXTENT_CSUM 9848633810944) itemoff
>>>>> 13527 itemsize 52
>>>>>                   range start 9848633810944 end 9848633864192 length=
 53248
>>>>>           item 10 key (EXTENT_CSUM EXTENT_CSUM 9848633950208) itemof=
f
>>>>> 12671 itemsize 856
>>>>>                   range start 9848633950208 end 9848634826752 length=
 876544
>>>>>           item 11 key (EXTENT_CSUM EXTENT_CSUM 9848634826752) itemof=
f
>>>>> 12659 itemsize 12
>>>>>                   range start 9848634826752 end 9848634839040 length=
 12288
>>>>>           item 12 key (EXTENT_CSUM EXTENT_CSUM 9848634970112) itemof=
f
>>>>> 12643 itemsize 16
>>>>>                   range start 9848634970112 end 9848634986496 length=
 16384
>>>>>           item 13 key (EXTENT_CSUM EXTENT_CSUM 9848635056128) itemof=
f
>>>>> 12583 itemsize 60
>>>>>                   range start 9848635056128 end 9848635117568 length=
 61440
>>>>>           item 14 key (EXTENT_CSUM EXTENT_CSUM 9848635117568) itemof=
f
>>>>> 12151 itemsize 432
>>>>>                   range start 9848635117568 end 9848635559936 length=
 442368
>>>>>           item 15 key (EXTENT_CSUM EXTENT_CSUM 9848635592704) itemof=
f
>>>>> 12135 itemsize 16
>>>>>                   range start 9848635592704 end 9848635609088 length=
 16384
>>>>>           item 16 key (EXTENT_CSUM EXTENT_CSUM 9848635703296) itemof=
f
>>>>> 11791 itemsize 344
>>>>>                   range start 9848635703296 end 9848636055552 length=
 352256
>>>>>           item 17 key (EXTENT_CSUM EXTENT_CSUM 9848636108800) itemof=
f
>>>>> 11719 itemsize 72
>>>>>                   range start 9848636108800 end 9848636182528 length=
 73728
>>>>>           item 18 key (EXTENT_CSUM EXTENT_CSUM 9848636669952) itemof=
f
>>>>> 11691 itemsize 28
>>>>>                   range start 9848636669952 end 9848636698624 length=
 28672
>>>>>           item 19 key (EXTENT_CSUM EXTENT_CSUM 9848636698624) itemof=
f
>>>>> 11371 itemsize 320
>>>>>                   range start 9848636698624 end 9848637026304 length=
 327680
>>>>>           item 20 key (EXTENT_CSUM EXTENT_CSUM 9848637026304) itemof=
f
>>>>> 10979 itemsize 392
>>>>>                   range start 9848637026304 end 9848637427712 length=
 401408
>>>>>           item 21 key (EXTENT_CSUM EXTENT_CSUM 9848637468672) itemof=
f
>>>>> 10131 itemsize 848
>>>>>                   range start 9848637468672 end 9848638337024 length=
 868352
>>>>>           item 22 key (EXTENT_CSUM EXTENT_CSUM 9848638631936) itemof=
f
>>>>> 10079 itemsize 52
>>>>>                   range start 9848638631936 end 9848638685184 length=
 53248
>>>>>           item 23 key (EXTENT_CSUM EXTENT_CSUM 9848638685184) itemof=
f
>>>>> 9791 itemsize 288
>>>>>                   range start 9848638685184 end 9848638980096 length=
 294912
>>>>>           item 24 key (EXTENT_CSUM EXTENT_CSUM 9848638980096) itemof=
f
>>>>> 9787 itemsize 4
>>>>>                   range start 9848638980096 end 9848638984192 length=
 4096
>>>>>           item 25 key (EXTENT_CSUM EXTENT_CSUM 9848638984192) itemof=
f
>>>>> 9735 itemsize 52
>>>>>                   range start 9848638984192 end 9848639037440 length=
 53248
>>>>>           item 26 key (EXTENT_CSUM EXTENT_CSUM 9848639045632) itemof=
f
>>>>> 9111 itemsize 624
>>>>>                   range start 9848639045632 end 9848639684608 length=
 638976
>>>>>           item 27 key (EXTENT_CSUM EXTENT_CSUM 9848639684608) itemof=
f
>>>>> 9091 itemsize 20
>>>>>                   range start 9848639684608 end 9848639705088 length=
 20480
>>>>>           item 28 key (EXTENT_CSUM EXTENT_CSUM 9848639967232) itemof=
f
>>>>> 8003 itemsize 1088
>>>>>                   range start 9848639967232 end 9848641081344 length=
 1114112
>>>>>           item 29 key (EXTENT_CSUM EXTENT_CSUM 9848641150976) itemof=
f
>>>>> 7947 itemsize 56
>>>>>                   range start 9848641150976 end 9848641208320 length=
 57344
>>>>>           item 30 key (EXTENT_CSUM EXTENT_CSUM 9848641409024) itemof=
f
>>>>> 7887 itemsize 60
>>>>>                   range start 9848641409024 end 9848641470464 length=
 61440
>>>>>           item 31 key (EXTENT_CSUM EXTENT_CSUM 9848641695744) itemof=
f
>>>>> 7643 itemsize 244
>>>>>                   range start 9848641695744 end 9848641945600 length=
 249856
>>>>>           item 32 key (EXTENT_CSUM EXTENT_CSUM 9848642043904) itemof=
f
>>>>> 7615 itemsize 28
>>>>>                   range start 9848642043904 end 9848642072576 length=
 28672
>>>>>           item 33 key (EXTENT_CSUM EXTENT_CSUM 9848642162688) itemof=
f
>>>>> 7075 itemsize 540
>>>>>                   range start 9848642162688 end 9848642715648 length=
 552960
>>>>>
>>>>>
>>>>> On Tue, Mar 8, 2022 at 5:48 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022/3/9 03:05, bill gates wrote:
>>>>>>> So, I recently attempted to upgrade from Linux kernel 4.19.82 to
>>>>>>> 5.15.23, and I'm getting a critical error in dmesg about a corrupt
>>>>>>> leaf (and no mounting of /home allowed with the options I'm aware =
of)
>>>>>>>
>>>>>>> [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=3D1
>>>>>>> block=3D10442806968320 sl
>>>>>>> ot=3D8 ino=3D6, invalid location key objectid: has 1 expect 6 or [=
256,
>>>>>>> 18446744073709551360]
>>>>>>> or 18446744073709551604
>>>>>>
>>>>>> Please provide the following output:
>>>>>>
>>>>>> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
>>>>>>
>>>>>>
>>>>>> The error message means, we got a DIR_ITEM in root tree.
>>>>>>
>>>>>> Normally that is used to indicate what default subvolume is.
>>>>>> Thus it's normally 6 or 5, or any valid subvolume id.
>>>>>>
>>>>>> But in your case, it's 1, thus tree-checker is rejecting your root =
tree.
>>>>>>
>>>>>> I didn't thought we could have 1 as default subvolume (as 1 is the =
root
>>>>>> tree, which is not a subvolume).
>>>>>>
>>>>>> But it looks like we should update btrfs check to fix this case.
>>>>>>
>>>>>> Is the fs created using older btrfs-progs? I guess that may be the =
cause...
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>
>>>>>>> [ 396.218967] BTRFS error (device sda2): block=3D10442806968320 re=
ad
>>>>>>> time tree block corru
>>>>>>> ption detected
>>>>>>>
>>>>>>>
>>>>>>> Interestingly. that 18446... number is a power of 2, looks like ma=
ybe
>>>>>>> a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
>>>>>>> check" found no problems with fs on either kernel version. Would l=
ike
>>>>>>> to figure out how to fix this, if possible.
>>>>>>>
>>>>>>> https://pastebin.com/0ESPU9Z6
>>>>>>>
>>>>>>> Thank you for any assistance,
>>>>>>> -- Laurence Michaels.

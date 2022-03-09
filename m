Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF954D2985
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 08:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiCIHgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 02:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCIHgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 02:36:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80983162022
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 23:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646811329;
        bh=j3aQ9sOX//iRS/iZUcdVBSdEDWRVt7BFZACKUalMvDI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YyMPPBfkMbY8IXmRsvy2G7yxKwerm/QL5QnzKG9gmqPbmhwOmxCj+NLuyXLwLgK8r
         WkKudPcWa30DJyy+ClOY18bCIjss5sM76lSZoG2jLpCJ7ByH17P8lld4L+4jmor1d0
         aGchJGtQkZOLpeCYbsPYrOQvK/DVrj9FDzsIPviE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mr9Bk-1nySb00Mp4-00oGg8; Wed, 09
 Mar 2022 08:35:29 +0100
Message-ID: <29e58290-e16c-ef4c-4be2-536d17df6f11@gmx.com>
Date:   Wed, 9 Mar 2022 15:35:25 +0800
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
 <056e2062-2e52-1df0-8604-f66e148365cc@gmx.com>
 <CALPV6Dtq3PYeK_RaCMuskOPGid42y=uvfTDT_mbb1YrBmkga2A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALPV6Dtq3PYeK_RaCMuskOPGid42y=uvfTDT_mbb1YrBmkga2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:moqtZcEBxchqPhVTDLaAIfr6wn0+sD0Mr0G8ECu/OUMOCkyQQHx
 rJFUF4D1rbNOmzm0qNxAu4AYjJqeq+1JWRr0n+vaBi6HuWBEURXIVO4/TkNS5ccvYM7bsKE
 4vnzRlCFM1f79tpPdT57j84neDmMCPuGGBBP6pcS2EC9neTVas/fQ0HRlu5HmJ2W4FJTMD+
 8c8Pxsr0fRhHMu/xMw/fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/s02SuO5zI=:MKYDH9eJ/aO61WeRiwL7UK
 4jICEb8EYXt/LTU1+7j0vBeLOojgGf2OG15Oh1SPdjCtlmka7GEvZproqzpTHsSFDTzP0mTUn
 9XchrVAc1w2obUa8bmIacg7NXrXty9e+n7S/9V2wCSJgFD4SATZ/he9DcC3AWKZd3GP2Hbw3d
 s11Ls8dFMTOGPBLM4+QchdBy/Uyi0f05XGuEMItI5VhURg22nyq2ZGLYjLelpjXTWjbrjU1Pd
 twg6F+kdrQn3npsn3qQOmIyrv5wqSFwIIuDnVDoHcfZiy4oGSfHvoTVF+IDlKNkzlmaitC/nd
 EzBNnAtoMbuBWYW+nTEcAP/g0v/HpfoIISwxX3SY8mSv5IJh3A/vmUMEsBDxZr4KUraOmRsl7
 aYJ9V/1ob8S4xyCW0YXhZdqhKoIWWU8WWNza8cYGWv0hvktAdGRDBFFBVBV6Ra9QFhHupS/kh
 14dD8lFcTxafymhi49iZhLnfmhbnJKJycVPS94JVX4fAIN5PfWAh2xDipGlSvdF0iRsTmdYB6
 5qmSw0hP/3sfaLHM/95u91NJvDZEi+4HfWXZmgWhCNb+u72c0vcOTC29Aac2Y0MlL9LnHhPIy
 aaxYyb29lFe5aQr5Gy+U7YE+WM/rHoa6UN9cXprSB7yeAeaVZQUJfyDjUknSdyG+6xFmOmgw8
 avNjgfNvCk2sNpldArnIn9N4BpenT2WS46yrOhqxYM2kjpapYlweb6HjGtJBorm2LtskpAG5Y
 esVzOWYUuRS5hytB6ABUTvSNzz2cdFgLzs9SxqgV+iNsWyvRq/wpOg/A3DplXrlKKTr/4tzIS
 aAJXRA1bXSoZPYo3ahUbEzgX08wyIAGzQMNa4AC3tOZTX1sLHaxgTeCWAq2JGILgPx71s4PTK
 7do7r36fXXOuVaQGZloUUrfIIm42ft+fdAjJVQJI+CjSNKPOm4ne9KH4S/Y37Rb5cQFRLrjbh
 bvvKSorESjHU2lDilw892CZu1J0c+5/eWO4A6lhLZJOK3HsU8EmDpJIyF3SKlr3RLDRbLyhdE
 sLSgowUxDmTU1oVZ557hpbC12q7WoqIGbrXqxYqKjXDFhiSB8ivv8UmcVLlph7RvFLtHJOuPT
 B9jDeI9dVIASXE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 15:28, bill gates wrote:
> That seems to have got it, send this email from the new kernel.
>
> I'm guessing this means the hard disk is not failing, and it's just an o=
ld bug?

Yep, I guess it's old bug from mkfs.btrfs.

And normally users setting any default subvolume would solve it.

Also recent sanity checks on steroid exposed it.

Thanks,
Qu
>
> Thanks so much for this help, and have a good one!
> -- L
>
> On Wed, Mar 9, 2022 at 12:56 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/3/9 13:21, bill gates wrote:
>>> Qu,
>>>
>>> here's what I got on 5.15.23
>>>
>>> dump-tree root /dev/sda2 on kernel 5.15.23 here: https://paste.ee/p/kS=
dI2
>>
>> Exactly what I'm expecting:
>>
>>          item 8 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14697 i=
temsize 37
>>                  location key (ROOT_TREE UNKNOWN.0 0) type DIR
>>                  transid 0 data_len 0 name_len 7
>>                  name: default
>>
>> Note the location key, it doesn't point to any real subvolume.
>> Thus newer kernel is rejecting it.
>>
>> To fix it, you can try the following command using your older working
>> kernel:
>>
>> # btrfs subvolume set-default 5 <mount point>
>>
>> Then try if the newer kernel handles it without problem.
>>
>> Thanks,
>> Qu
>>>
>>> Warning: 2+MB text dump, this is a good-sized, and well-used, fs.
>>>
>>> Thank you,
>>> -- Laurence
>>>
>>> On Tue, Mar 8, 2022 at 10:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2022/3/9 12:28, bill gates wrote:
>>>>> Oh... I ran the ins dump-tree on the old kernel (4.19), not the new
>>>>> one. The new kernel sees it differently (!)
>>>>
>>>> No, this is still not the old result.
>>>>
>>>> It looks like a mount using older kernel changed the result.
>>>>
>>>> Please use the following command instead:
>>>>
>>>> # btrfs ins dump-tree -t root /dev/sda2
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> ----- kernel 5.15 ins dump-tree
>>>>> btrfs-progs v5.15.1
>>>>> leaf 10442806968320 items 169 free space 3439 generation 6835704 own=
er
>>>>> EXTENT_TREE
>>>>> leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
>>>>> fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
>>>>> chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
>>>>>           item 0 key (10442625581056 EXTENT_ITEM 16384) itemoff 1623=
2 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111548533=
5552) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 1 key (10442625597440 EXTENT_ITEM 16384) itemoff 1618=
1 itemsize 51
>>>>>                   refs 1 gen 307924 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1099758461=
7472) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 2 key (10442625630208 EXTENT_ITEM 16384) itemoff 1613=
0 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111550195=
3024) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 3 key (10442625646592 EXTENT_ITEM 16384) itemoff 1607=
9 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111551857=
0496) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 4 key (10442625662976 EXTENT_ITEM 16384) itemoff 1602=
8 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111553518=
7968) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 5 key (10442625679360 EXTENT_ITEM 16384) itemoff 1597=
7 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111555180=
5440) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 6 key (10442625695744 EXTENT_ITEM 16384) itemoff 1592=
6 itemsize 51
>>>>>                   refs 1 gen 308431 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1105287568=
1792) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 7 key (10442625712128 EXTENT_ITEM 16384) itemoff 1587=
5 itemsize 51
>>>>>                   refs 1 gen 308431 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1105285906=
4320) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 8 key (10442625728512 EXTENT_ITEM 16384) itemoff 1582=
4 itemsize 51
>>>>>                   refs 1 gen 308431 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1105289229=
9264) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 9 key (10442625744896 EXTENT_ITEM 16384) itemoff 1577=
3 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12064823508992 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 10 key (10442625761280 EXTENT_ITEM 16384) itemoff 157=
22 itemsize 51
>>>>>                   refs 1 gen 6745444 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1249647278=
4896) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 11 key (10442625794048 EXTENT_ITEM 16384) itemoff 156=
71 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111563928=
3712) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 12 key (10442625810432 EXTENT_ITEM 16384) itemoff 156=
20 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111565590=
1184) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 13 key (10442625826816 EXTENT_ITEM 16384) itemoff 155=
69 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111567251=
8656) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 14 key (10442625843200 EXTENT_ITEM 16384) itemoff 155=
18 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2068362 INODE_REF 2066150) level 0
>>>>>                   tree block backref root 257
>>>>>           item 15 key (10442625875968 EXTENT_ITEM 16384) itemoff 154=
67 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2068385 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 16 key (10442625892352 EXTENT_ITEM 16384) itemoff 154=
16 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12065235910656 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 17 key (10442625908736 EXTENT_ITEM 16384) itemoff 153=
65 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12065187733504 EXTENT_ITEM 57344) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 18 key (10442625925120 EXTENT_ITEM 16384) itemoff 153=
14 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111568913=
6128) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 19 key (10442625941504 EXTENT_ITEM 16384) itemoff 152=
63 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111570575=
3600) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 20 key (10442625990656 EXTENT_ITEM 16384) itemoff 152=
12 itemsize 51
>>>>>                   refs 1 gen 6833576 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 9686276972=
544) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 21 key (10442626007040 EXTENT_ITEM 16384) itemoff 151=
61 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12065510035456 EXTENT_ITEM 1052672=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 22 key (10442626023424 EXTENT_ITEM 16384) itemoff 151=
10 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12065890512896 EXTENT_ITEM 49152) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 23 key (10442626039808 EXTENT_ITEM 16384) itemoff 150=
59 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12065799458816 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 24 key (10442626072576 EXTENT_ITEM 16384) itemoff 150=
08 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12065947615232 EXTENT_ITEM 712704)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 25 key (10442626088960 EXTENT_ITEM 16384) itemoff 149=
57 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764131 INODE_ITEM 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 26 key (10442626105344 EXTENT_ITEM 16384) itemoff 149=
06 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764153 INODE_REF 76762106) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 27 key (10442626121728 EXTENT_ITEM 16384) itemoff 148=
55 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764176 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 28 key (10442626138112 EXTENT_ITEM 16384) itemoff 148=
04 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040513145=
2416) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 29 key (10442626154496 EXTENT_ITEM 16384) itemoff 147=
53 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764289 INODE_ITEM 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 30 key (10442626170880 EXTENT_ITEM 16384) itemoff 147=
02 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111572237=
1072) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 31 key (10442626187264 EXTENT_ITEM 16384) itemoff 146=
51 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12066310410240 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 32 key (10442626203648 EXTENT_ITEM 16384) itemoff 146=
00 itemsize 51
>>>>>                   refs 1 gen 6724925 flags TREE_BLOCK
>>>>>                   tree block key (10241601216512 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 33 key (10442626220032 EXTENT_ITEM 16384) itemoff 145=
49 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2541168 DIR_INDEX 9) level 0
>>>>>                   tree block backref root 257
>>>>>           item 34 key (10442626236416 EXTENT_ITEM 16384) itemoff 144=
98 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040514804=
5312) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 35 key (10442626252800 EXTENT_ITEM 16384) itemoff 144=
47 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2541180 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 36 key (10442626269184 EXTENT_ITEM 16384) itemoff 143=
96 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2541188 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 37 key (10442626285568 EXTENT_ITEM 16384) itemoff 143=
45 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040516466=
2784) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 38 key (10442626334720 EXTENT_ITEM 16384) itemoff 142=
94 itemsize 51
>>>>>                   refs 1 gen 6264604 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1123084849=
9712) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 39 key (10442626400256 EXTENT_ITEM 16384) itemoff 142=
43 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1023562968=
2688) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 40 key (10442626416640 EXTENT_ITEM 16384) itemoff 141=
92 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1220366489=
1904) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 41 key (10442626449408 EXTENT_ITEM 16384) itemoff 141=
41 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12067359137792 EXTENT_ITEM 12288) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 42 key (10442626465792 EXTENT_ITEM 16384) itemoff 140=
90 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (12204759490560 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 43 key (10442626482176 EXTENT_ITEM 16384) itemoff 140=
39 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12067310555136 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 44 key (10442626498560 EXTENT_ITEM 16384) itemoff 139=
88 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1220476263=
6288) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 45 key (10442626514944 EXTENT_ITEM 16384) itemoff 139=
37 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1056753568=
1536) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 46 key (10442626531328 EXTENT_ITEM 16384) itemoff 138=
86 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (11216497197056 EXTENT_ITEM 16384) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 47 key (10442626547712 EXTENT_ITEM 16384) itemoff 138=
35 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (12894114234368 EXTENT_ITEM 16384) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 48 key (10442626564096 EXTENT_ITEM 16384) itemoff 137=
84 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (13092730437632 EXTENT_ITEM 16384) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 49 key (10442626580480 EXTENT_ITEM 16384) itemoff 137=
33 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764473 INODE_REF 76762122) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 50 key (10442626596864 EXTENT_ITEM 16384) itemoff 136=
82 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12067776978944 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 51 key (10442626613248 EXTENT_ITEM 16384) itemoff 136=
31 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040518128=
0256) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 52 key (10442626629632 EXTENT_ITEM 16384) itemoff 135=
80 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (13092764860416 EXTENT_ITEM 16384) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 53 key (10442626662400 EXTENT_ITEM 16384) itemoff 135=
29 itemsize 51
>>>>>                   refs 1 gen 1434043 flags TREE_BLOCK
>>>>>                   tree block key (15409727 DIR_INDEX 1378) level 0
>>>>>                   tree block backref root 257
>>>>>           item 54 key (10442626678784 EXTENT_ITEM 16384) itemoff 134=
78 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1056755229=
9008) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 55 key (10442626711552 EXTENT_ITEM 16384) itemoff 134=
27 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12068306247680 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 56 key (10442626727936 EXTENT_ITEM 16384) itemoff 133=
76 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12068680613888 EXTENT_ITEM 81920) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 57 key (10442626744320 EXTENT_ITEM 16384) itemoff 133=
25 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764584 INODE_REF 76762122) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 58 key (10442626793472 EXTENT_ITEM 16384) itemoff 132=
74 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1056756891=
6480) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 59 key (10442626859008 EXTENT_ITEM 16384) itemoff 132=
23 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (10442421272576 EXTENT_ITEM 16384) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 60 key (10442626875392 EXTENT_ITEM 16384) itemoff 131=
72 itemsize 51
>>>>>                   refs 1 gen 4570110 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1169408712=
7040) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 61 key (10442626908160 EXTENT_ITEM 16384) itemoff 131=
21 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12069107830784 EXTENT_ITEM 102400)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 62 key (10442626940928 EXTENT_ITEM 16384) itemoff 130=
70 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12069177942016 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 63 key (10442626957312 EXTENT_ITEM 16384) itemoff 130=
19 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12069211504640 EXTENT_ITEM 131072)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 64 key (10442626973696 EXTENT_ITEM 16384) itemoff 129=
68 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764814 INODE_REF 76762122) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 65 key (10442626990080 EXTENT_ITEM 16384) itemoff 129=
17 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538301 INODE_ITEM 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 66 key (10442627006464 EXTENT_ITEM 16384) itemoff 128=
66 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538310 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 67 key (10442627022848 EXTENT_ITEM 16384) itemoff 128=
15 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040519789=
7728) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 68 key (10442627039232 EXTENT_ITEM 16384) itemoff 127=
64 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (9708461223936 EXTENT_ITEM 8192) le=
vel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 69 key (10442627055616 EXTENT_ITEM 16384) itemoff 127=
13 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (9709536043008 EXTENT_ITEM 4096) le=
vel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 70 key (10442627088384 EXTENT_ITEM 16384) itemoff 126=
62 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111573898=
8544) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 71 key (10442627104768 EXTENT_ITEM 16384) itemoff 126=
11 itemsize 51
>>>>>                   refs 1 gen 6698785 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1217784969=
2160) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 72 key (10442627121152 EXTENT_ITEM 16384) itemoff 125=
60 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538341 INODE_REF 2537331) level 0
>>>>>                   tree block backref root 257
>>>>>           item 73 key (10442627137536 EXTENT_ITEM 16384) itemoff 125=
09 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538361 INODE_REF 2537394) level 0
>>>>>                   tree block backref root 257
>>>>>           item 74 key (10442627153920 EXTENT_ITEM 16384) itemoff 124=
58 itemsize 51
>>>>>                   refs 1 gen 672522 flags TREE_BLOCK
>>>>>                   tree block key (2552451 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 75 key (10442627170304 EXTENT_ITEM 16384) itemoff 124=
07 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111575560=
6016) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 76 key (10442627186688 EXTENT_ITEM 16384) itemoff 123=
56 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764880 INODE_REF 76762122) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 77 key (10442627203072 EXTENT_ITEM 16384) itemoff 123=
05 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12069486489600 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 78 key (10442627219456 EXTENT_ITEM 16384) itemoff 122=
54 itemsize 51
>>>>>                   refs 1 gen 4416707 flags TREE_BLOCK
>>>>>                   tree block key (17422551 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 79 key (10442627252224 EXTENT_ITEM 16384) itemoff 122=
03 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538389 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 80 key (10442627268608 EXTENT_ITEM 16384) itemoff 121=
52 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76765020 INODE_REF 76762122) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 81 key (10442627284992 EXTENT_ITEM 16384) itemoff 121=
01 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538408 DIR_INDEX 53) level 0
>>>>>                   tree block backref root 257
>>>>>           item 82 key (10442627301376 EXTENT_ITEM 16384) itemoff 120=
50 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12069821075456 EXTENT_ITEM 974848)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 83 key (10442627334144 EXTENT_ITEM 16384) itemoff 119=
99 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12070201597952 EXTENT_ITEM 1052672=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 84 key (10442627350528 EXTENT_ITEM 16384) itemoff 119=
48 itemsize 51
>>>>>                   refs 1 gen 6698785 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1219323527=
1680) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 85 key (10442627399680 EXTENT_ITEM 16384) itemoff 118=
97 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
>>>>>                   tree block key (2538447 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 86 key (10442627432448 EXTENT_ITEM 16384) itemoff 118=
46 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (9723383021568 EXTENT_ITEM 950272) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 87 key (10442627481600 EXTENT_ITEM 16384) itemoff 117=
95 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040521451=
5200) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 88 key (10442627497984 EXTENT_ITEM 16384) itemoff 117=
44 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040523113=
2672) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 89 key (10442627514368 EXTENT_ITEM 16384) itemoff 116=
93 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12087570075648 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 90 key (10442627530752 EXTENT_ITEM 16384) itemoff 116=
42 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1056758553=
3952) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 91 key (10442627563520 EXTENT_ITEM 16384) itemoff 115=
91 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12088286089216 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 92 key (10442627579904 EXTENT_ITEM 16384) itemoff 115=
40 itemsize 51
>>>>>                   refs 1 gen 6698785 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1224332204=
8512) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 93 key (10442627596288 EXTENT_ITEM 16384) itemoff 114=
89 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12068807602176 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 94 key (10442627629056 EXTENT_ITEM 16384) itemoff 114=
38 itemsize 51
>>>>>                   refs 1 gen 6727271 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1218353594=
3680) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 95 key (10442627645440 EXTENT_ITEM 16384) itemoff 113=
87 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040524775=
0144) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 96 key (10442627678208 EXTENT_ITEM 16384) itemoff 113=
36 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111577222=
3488) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 97 key (10442627694592 EXTENT_ITEM 16384) itemoff 112=
85 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12157162041344 EXTENT_ITEM 790528)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 98 key (10442627710976 EXTENT_ITEM 16384) itemoff 112=
34 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 9756884873=
216) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 99 key (10442627727360 EXTENT_ITEM 16384) itemoff 111=
83 itemsize 51
>>>>>                   refs 1 gen 6464632 flags TREE_BLOCK
>>>>>                   tree block key (65735848 INODE_REF 58323055) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 100 key (10442627776512 EXTENT_ITEM 16384) itemoff 11=
132 itemsize 51
>>>>>                   refs 1 gen 6139527 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1183006424=
2688) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 101 key (10442627792896 EXTENT_ITEM 16384) itemoff 11=
081 itemsize 51
>>>>>                   refs 1 gen 6464632 flags TREE_BLOCK
>>>>>                   tree block key (65736607 INODE_REF 65731578) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 102 key (10442627858432 EXTENT_ITEM 16384) itemoff 11=
030 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12180178153472 EXTENT_ITEM 8192) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 103 key (10442627874816 EXTENT_ITEM 16384) itemoff 10=
979 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12180343758848 EXTENT_ITEM 1452851=
2) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 104 key (10442627891200 EXTENT_ITEM 16384) itemoff 10=
928 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12142622306304 EXTENT_ITEM 24576) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 105 key (10442627907584 EXTENT_ITEM 16384) itemoff 10=
877 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12180880535552 EXTENT_ITEM 155648)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 106 key (10442627923968 EXTENT_ITEM 16384) itemoff 10=
826 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1220440795=
5456) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 107 key (10442627940352 EXTENT_ITEM 16384) itemoff 10=
775 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12180491771904 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 108 key (10442627956736 EXTENT_ITEM 16384) itemoff 10=
724 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764087 INODE_ITEM 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 109 key (10442627973120 EXTENT_ITEM 16384) itemoff 10=
673 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12185288880128 EXTENT_ITEM 49152) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 110 key (10442627989504 EXTENT_ITEM 16384) itemoff 10=
622 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1220651537=
6128) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 111 key (10442628005888 EXTENT_ITEM 16384) itemoff 10=
571 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12185404018688 EXTENT_ITEM 1052672=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 112 key (10442628022272 EXTENT_ITEM 16384) itemoff 10=
520 itemsize 51
>>>>>                   refs 1 gen 6464632 flags TREE_BLOCK
>>>>>                   tree block key (27390978 INODE_ITEM 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 113 key (10442628038656 EXTENT_ITEM 16384) itemoff 10=
469 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12196305096704 EXTENT_ITEM 12288) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 114 key (10442628055040 EXTENT_ITEM 16384) itemoff 10=
418 itemsize 51
>>>>>                   refs 1 gen 6464632 flags TREE_BLOCK
>>>>>                   tree block key (17346964 INODE_REF 17346635) level=
 0
>>>>>                   tree block backref root 257
>>>>>           item 115 key (10442628071424 EXTENT_ITEM 16384) itemoff 10=
367 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12202632044544 EXTENT_ITEM 135168)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 116 key (10442628104192 EXTENT_ITEM 16384) itemoff 10=
316 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12184667025408 EXTENT_ITEM 4198400=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 117 key (10442628120576 EXTENT_ITEM 16384) itemoff 10=
265 itemsize 51
>>>>>                   refs 1 gen 6236744 flags TREE_BLOCK
>>>>>                   tree block key (76764208 EXTENT_DATA 0) level 0
>>>>>                   tree block backref root 257
>>>>>           item 118 key (10442628136960 EXTENT_ITEM 16384) itemoff 10=
214 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12223140970496 EXTENT_ITEM 1114112=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 119 key (10442628153344 EXTENT_ITEM 16384) itemoff 10=
163 itemsize 51
>>>>>                   refs 1 gen 6464632 flags TREE_BLOCK
>>>>>                   tree block key (57503313 INODE_REF 5903664) level =
0
>>>>>                   tree block backref root 257
>>>>>           item 120 key (10442628169728 EXTENT_ITEM 16384) itemoff 10=
112 itemsize 51
>>>>>                   refs 1 gen 6727271 flags TREE_BLOCK
>>>>>                   tree block key (12282814701568 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 121 key (10442628186112 EXTENT_ITEM 16384) itemoff 10=
061 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12223473651712 EXTENT_ITEM 729088)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 122 key (10442628202496 EXTENT_ITEM 16384) itemoff 10=
010 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12224274079744 EXTENT_ITEM 3145728=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 123 key (10442628218880 EXTENT_ITEM 16384) itemoff 99=
59 itemsize 51
>>>>>                   refs 1 gen 6835701 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 9822438273=
024) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 124 key (10442628251648 EXTENT_ITEM 16384) itemoff 99=
08 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12224877871104 EXTENT_ITEM 1585561=
6) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 125 key (10442628268032 EXTENT_ITEM 16384) itemoff 98=
57 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12225476325376 EXTENT_ITEM 208896)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 126 key (10442628284416 EXTENT_ITEM 16384) itemoff 98=
06 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12226798768128 EXTENT_ITEM 2101248=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 127 key (10442628300800 EXTENT_ITEM 16384) itemoff 97=
55 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12227805872128 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 128 key (10442628317184 EXTENT_ITEM 16384) itemoff 97=
04 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12233946206208 EXTENT_ITEM 20480) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 129 key (10442628333568 EXTENT_ITEM 16384) itemoff 96=
53 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12233996038144 EXTENT_ITEM 233472)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 130 key (10442628349952 EXTENT_ITEM 16384) itemoff 96=
02 itemsize 51
>>>>>                   refs 1 gen 6698785 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1216056250=
7776) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 131 key (10442628366336 EXTENT_ITEM 16384) itemoff 95=
51 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12237278531584 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 132 key (10442628382720 EXTENT_ITEM 16384) itemoff 95=
00 itemsize 51
>>>>>                   refs 1 gen 6727271 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1242112118=
3744) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 133 key (10442628399104 EXTENT_ITEM 16384) itemoff 94=
49 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12237030932480 EXTENT_ITEM 118784)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 134 key (10442628415488 EXTENT_ITEM 16384) itemoff 93=
98 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12237580976128 EXTENT_ITEM 4194304=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 135 key (10442628431872 EXTENT_ITEM 16384) itemoff 93=
47 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12241256226816 EXTENT_ITEM 200704)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 136 key (10442628448256 EXTENT_ITEM 16384) itemoff 92=
96 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12241758822400 EXTENT_ITEM 28672) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 137 key (10442628464640 EXTENT_ITEM 16384) itemoff 92=
45 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12253141274624 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 138 key (10442628481024 EXTENT_ITEM 16384) itemoff 91=
94 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1132125015=
6544) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 139 key (10442628497408 EXTENT_ITEM 16384) itemoff 91=
43 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040526436=
7616) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 140 key (10442628513792 EXTENT_ITEM 16384) itemoff 90=
92 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1040528093=
5936) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 141 key (10442628562944 EXTENT_ITEM 16384) itemoff 90=
41 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12265441398784 EXTENT_ITEM 2097152=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 142 key (10442628579328 EXTENT_ITEM 16384) itemoff 89=
90 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12271441833984 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 143 key (10442628595712 EXTENT_ITEM 16384) itemoff 89=
39 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12272561885184 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 144 key (10442628612096 EXTENT_ITEM 16384) itemoff 88=
88 itemsize 51
>>>>>                   refs 1 gen 309972 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1111578884=
0960) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 145 key (10442628628480 EXTENT_ITEM 16384) itemoff 88=
37 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12282866843648 EXTENT_ITEM 905216)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 146 key (10442628644864 EXTENT_ITEM 16384) itemoff 87=
86 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12283205406720 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 147 key (10442628661248 EXTENT_ITEM 16384) itemoff 87=
35 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1043432770=
3552) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 148 key (10442628677632 EXTENT_ITEM 16384) itemoff 86=
84 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12289339404288 EXTENT_ITEM 81920) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 149 key (10442628694016 EXTENT_ITEM 16384) itemoff 86=
33 itemsize 51
>>>>>                   refs 1 gen 302689 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1043434432=
1024) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 150 key (10442628710400 EXTENT_ITEM 16384) itemoff 85=
82 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12299776696320 EXTENT_ITEM 3145728=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 151 key (10442628726784 EXTENT_ITEM 16384) itemoff 85=
31 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12299871612928 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 152 key (10442628743168 EXTENT_ITEM 16384) itemoff 84=
80 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12302335598592 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 153 key (10442628759552 EXTENT_ITEM 16384) itemoff 84=
29 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1220765532=
1600) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 154 key (10442628775936 EXTENT_ITEM 16384) itemoff 83=
78 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12302453288960 EXTENT_ITEM 2097152=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 155 key (10442628792320 EXTENT_ITEM 16384) itemoff 83=
27 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12303679279104 EXTENT_ITEM 98304) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 156 key (10442628808704 EXTENT_ITEM 16384) itemoff 82=
76 itemsize 51
>>>>>                   refs 1 gen 6680401 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1220925557=
9648) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 157 key (10442628825088 EXTENT_ITEM 16384) itemoff 82=
25 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12306045173760 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 158 key (10442628841472 EXTENT_ITEM 16384) itemoff 81=
74 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12306189029376 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 159 key (10442628857856 EXTENT_ITEM 16384) itemoff 81=
23 itemsize 51
>>>>>                   refs 1 gen 6487789 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1059696801=
3824) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 160 key (10442628874240 EXTENT_ITEM 16384) itemoff 80=
72 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12310012329984 EXTENT_ITEM 131072)=
 level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 161 key (10442628923392 EXTENT_ITEM 16384) itemoff 80=
21 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12311480930304 EXTENT_ITEM 61440) =
level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 162 key (10442628972544 EXTENT_ITEM 16384) itemoff 79=
70 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12317130739712 EXTENT_ITEM 1052672=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 163 key (10442628988928 EXTENT_ITEM 16384) itemoff 79=
19 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12317269188608 EXTENT_ITEM 2097152=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 164 key (10442629005312 EXTENT_ITEM 16384) itemoff 78=
68 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12317973839872 EXTENT_ITEM 4096) l=
evel 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 165 key (10442629021696 EXTENT_ITEM 16384) itemoff 78=
17 itemsize 51
>>>>>                   refs 1 gen 6834895 flags TREE_BLOCK
>>>>>                   tree block key (EXTENT_CSUM EXTENT_CSUM 1005156458=
0864) level 0
>>>>>                   tree block backref root CSUM_TREE
>>>>>           item 166 key (10442629038080 EXTENT_ITEM 16384) itemoff 77=
66 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12318824312832 EXTENT_ITEM 2097152=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 167 key (10442629054464 EXTENT_ITEM 16384) itemoff 77=
15 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12319312617472 EXTENT_ITEM 4993024=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>           item 168 key (10442629070848 EXTENT_ITEM 16384) itemoff 76=
64 itemsize 51
>>>>>                   refs 1 gen 6787103 flags TREE_BLOCK
>>>>>                   tree block key (12319524802560 EXTENT_ITEM 1048576=
) level 0
>>>>>                   tree block backref root EXTENT_TREE
>>>>>
>>>>> ----
>>>>>
>>>>> Thanks,
>>>>> -- Laurence
>>>>>
>>>>>
>>>>> On Tue, Mar 8, 2022 at 9:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022/3/9 09:09, bill gates wrote:
>>>>>>> This filesystem was most likely created in 2014 using the tools of
>>>>>>> that time, at least that's the oldest file in my home directory. I=
t
>>>>>>> _might_ have been made in 2019, that's the date on the mount point=
.
>>>>>>>
>>>>>>> There are 2 subvolumes on /dev/sda2, /home and /var.
>>>>>>>
>>>>>>> My btrfs-progs version is 5.15.1.
>>>>>>>
>>>>>>> Per your request:
>>>>>>> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
>>>>>>> btrfs-progs v5.15.1
>>>>>>
>>>>>> Weird, the output doesn't match the dmesg.
>>>>>>
>>>>>> This tree belongs to csum tree, not root tree.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> leaf 10442806968320 items 34 free space 6225 generation 6834902 ow=
ner CSUM_TREE
>>>>>>> leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
>>>>>>> fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
>>>>>>> chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
>>>>>>>            item 0 key (EXTENT_CSUM EXTENT_CSUM 9848629587968) item=
off
>>>>>>> 16075 itemsize 208
>>>>>>>                    range start 9848629587968 end 9848629800960 len=
gth 212992
>>>>>>>            item 1 key (EXTENT_CSUM EXTENT_CSUM 9848630026240) item=
off
>>>>>>> 15823 itemsize 252
>>>>>>>                    range start 9848630026240 end 9848630284288 len=
gth 258048
>>>>>>>            item 2 key (EXTENT_CSUM EXTENT_CSUM 9848630714368) item=
off
>>>>>>> 15815 itemsize 8
>>>>>>>                    range start 9848630714368 end 9848630722560 len=
gth 8192
>>>>>>>            item 3 key (EXTENT_CSUM EXTENT_CSUM 9848630984704) item=
off
>>>>>>> 14723 itemsize 1092
>>>>>>>                    range start 9848630984704 end 9848632102912 len=
gth 1118208
>>>>>>>            item 4 key (EXTENT_CSUM EXTENT_CSUM 9848632160256) item=
off
>>>>>>> 14703 itemsize 20
>>>>>>>                    range start 9848632160256 end 9848632180736 len=
gth 20480
>>>>>>>            item 5 key (EXTENT_CSUM EXTENT_CSUM 9848632180736) item=
off
>>>>>>> 14279 itemsize 424
>>>>>>>                    range start 9848632180736 end 9848632614912 len=
gth 434176
>>>>>>>            item 6 key (EXTENT_CSUM EXTENT_CSUM 9848632942592) item=
off
>>>>>>> 14067 itemsize 212
>>>>>>>                    range start 9848632942592 end 9848633159680 len=
gth 217088
>>>>>>>            item 7 key (EXTENT_CSUM EXTENT_CSUM 9848633286656) item=
off
>>>>>>> 13815 itemsize 252
>>>>>>>                    range start 9848633286656 end 9848633544704 len=
gth 258048
>>>>>>>            item 8 key (EXTENT_CSUM EXTENT_CSUM 9848633548800) item=
off
>>>>>>> 13579 itemsize 236
>>>>>>>                    range start 9848633548800 end 9848633790464 len=
gth 241664
>>>>>>>            item 9 key (EXTENT_CSUM EXTENT_CSUM 9848633810944) item=
off
>>>>>>> 13527 itemsize 52
>>>>>>>                    range start 9848633810944 end 9848633864192 len=
gth 53248
>>>>>>>            item 10 key (EXTENT_CSUM EXTENT_CSUM 9848633950208) ite=
moff
>>>>>>> 12671 itemsize 856
>>>>>>>                    range start 9848633950208 end 9848634826752 len=
gth 876544
>>>>>>>            item 11 key (EXTENT_CSUM EXTENT_CSUM 9848634826752) ite=
moff
>>>>>>> 12659 itemsize 12
>>>>>>>                    range start 9848634826752 end 9848634839040 len=
gth 12288
>>>>>>>            item 12 key (EXTENT_CSUM EXTENT_CSUM 9848634970112) ite=
moff
>>>>>>> 12643 itemsize 16
>>>>>>>                    range start 9848634970112 end 9848634986496 len=
gth 16384
>>>>>>>            item 13 key (EXTENT_CSUM EXTENT_CSUM 9848635056128) ite=
moff
>>>>>>> 12583 itemsize 60
>>>>>>>                    range start 9848635056128 end 9848635117568 len=
gth 61440
>>>>>>>            item 14 key (EXTENT_CSUM EXTENT_CSUM 9848635117568) ite=
moff
>>>>>>> 12151 itemsize 432
>>>>>>>                    range start 9848635117568 end 9848635559936 len=
gth 442368
>>>>>>>            item 15 key (EXTENT_CSUM EXTENT_CSUM 9848635592704) ite=
moff
>>>>>>> 12135 itemsize 16
>>>>>>>                    range start 9848635592704 end 9848635609088 len=
gth 16384
>>>>>>>            item 16 key (EXTENT_CSUM EXTENT_CSUM 9848635703296) ite=
moff
>>>>>>> 11791 itemsize 344
>>>>>>>                    range start 9848635703296 end 9848636055552 len=
gth 352256
>>>>>>>            item 17 key (EXTENT_CSUM EXTENT_CSUM 9848636108800) ite=
moff
>>>>>>> 11719 itemsize 72
>>>>>>>                    range start 9848636108800 end 9848636182528 len=
gth 73728
>>>>>>>            item 18 key (EXTENT_CSUM EXTENT_CSUM 9848636669952) ite=
moff
>>>>>>> 11691 itemsize 28
>>>>>>>                    range start 9848636669952 end 9848636698624 len=
gth 28672
>>>>>>>            item 19 key (EXTENT_CSUM EXTENT_CSUM 9848636698624) ite=
moff
>>>>>>> 11371 itemsize 320
>>>>>>>                    range start 9848636698624 end 9848637026304 len=
gth 327680
>>>>>>>            item 20 key (EXTENT_CSUM EXTENT_CSUM 9848637026304) ite=
moff
>>>>>>> 10979 itemsize 392
>>>>>>>                    range start 9848637026304 end 9848637427712 len=
gth 401408
>>>>>>>            item 21 key (EXTENT_CSUM EXTENT_CSUM 9848637468672) ite=
moff
>>>>>>> 10131 itemsize 848
>>>>>>>                    range start 9848637468672 end 9848638337024 len=
gth 868352
>>>>>>>            item 22 key (EXTENT_CSUM EXTENT_CSUM 9848638631936) ite=
moff
>>>>>>> 10079 itemsize 52
>>>>>>>                    range start 9848638631936 end 9848638685184 len=
gth 53248
>>>>>>>            item 23 key (EXTENT_CSUM EXTENT_CSUM 9848638685184) ite=
moff
>>>>>>> 9791 itemsize 288
>>>>>>>                    range start 9848638685184 end 9848638980096 len=
gth 294912
>>>>>>>            item 24 key (EXTENT_CSUM EXTENT_CSUM 9848638980096) ite=
moff
>>>>>>> 9787 itemsize 4
>>>>>>>                    range start 9848638980096 end 9848638984192 len=
gth 4096
>>>>>>>            item 25 key (EXTENT_CSUM EXTENT_CSUM 9848638984192) ite=
moff
>>>>>>> 9735 itemsize 52
>>>>>>>                    range start 9848638984192 end 9848639037440 len=
gth 53248
>>>>>>>            item 26 key (EXTENT_CSUM EXTENT_CSUM 9848639045632) ite=
moff
>>>>>>> 9111 itemsize 624
>>>>>>>                    range start 9848639045632 end 9848639684608 len=
gth 638976
>>>>>>>            item 27 key (EXTENT_CSUM EXTENT_CSUM 9848639684608) ite=
moff
>>>>>>> 9091 itemsize 20
>>>>>>>                    range start 9848639684608 end 9848639705088 len=
gth 20480
>>>>>>>            item 28 key (EXTENT_CSUM EXTENT_CSUM 9848639967232) ite=
moff
>>>>>>> 8003 itemsize 1088
>>>>>>>                    range start 9848639967232 end 9848641081344 len=
gth 1114112
>>>>>>>            item 29 key (EXTENT_CSUM EXTENT_CSUM 9848641150976) ite=
moff
>>>>>>> 7947 itemsize 56
>>>>>>>                    range start 9848641150976 end 9848641208320 len=
gth 57344
>>>>>>>            item 30 key (EXTENT_CSUM EXTENT_CSUM 9848641409024) ite=
moff
>>>>>>> 7887 itemsize 60
>>>>>>>                    range start 9848641409024 end 9848641470464 len=
gth 61440
>>>>>>>            item 31 key (EXTENT_CSUM EXTENT_CSUM 9848641695744) ite=
moff
>>>>>>> 7643 itemsize 244
>>>>>>>                    range start 9848641695744 end 9848641945600 len=
gth 249856
>>>>>>>            item 32 key (EXTENT_CSUM EXTENT_CSUM 9848642043904) ite=
moff
>>>>>>> 7615 itemsize 28
>>>>>>>                    range start 9848642043904 end 9848642072576 len=
gth 28672
>>>>>>>            item 33 key (EXTENT_CSUM EXTENT_CSUM 9848642162688) ite=
moff
>>>>>>> 7075 itemsize 540
>>>>>>>                    range start 9848642162688 end 9848642715648 len=
gth 552960
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Mar 8, 2022 at 5:48 PM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2022/3/9 03:05, bill gates wrote:
>>>>>>>>> So, I recently attempted to upgrade from Linux kernel 4.19.82 to
>>>>>>>>> 5.15.23, and I'm getting a critical error in dmesg about a corru=
pt
>>>>>>>>> leaf (and no mounting of /home allowed with the options I'm awar=
e of)
>>>>>>>>>
>>>>>>>>> [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=
=3D1
>>>>>>>>> block=3D10442806968320 sl
>>>>>>>>> ot=3D8 ino=3D6, invalid location key objectid: has 1 expect 6 or=
 [256,
>>>>>>>>> 18446744073709551360]
>>>>>>>>> or 18446744073709551604
>>>>>>>>
>>>>>>>> Please provide the following output:
>>>>>>>>
>>>>>>>> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
>>>>>>>>
>>>>>>>>
>>>>>>>> The error message means, we got a DIR_ITEM in root tree.
>>>>>>>>
>>>>>>>> Normally that is used to indicate what default subvolume is.
>>>>>>>> Thus it's normally 6 or 5, or any valid subvolume id.
>>>>>>>>
>>>>>>>> But in your case, it's 1, thus tree-checker is rejecting your roo=
t tree.
>>>>>>>>
>>>>>>>> I didn't thought we could have 1 as default subvolume (as 1 is th=
e root
>>>>>>>> tree, which is not a subvolume).
>>>>>>>>
>>>>>>>> But it looks like we should update btrfs check to fix this case.
>>>>>>>>
>>>>>>>> Is the fs created using older btrfs-progs? I guess that may be th=
e cause...
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>
>>>>>>>>> [ 396.218967] BTRFS error (device sda2): block=3D10442806968320 =
read
>>>>>>>>> time tree block corru
>>>>>>>>> ption detected
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Interestingly. that 18446... number is a power of 2, looks like =
maybe
>>>>>>>>> a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
>>>>>>>>> check" found no problems with fs on either kernel version. Would=
 like
>>>>>>>>> to figure out how to fix this, if possible.
>>>>>>>>>
>>>>>>>>> https://pastebin.com/0ESPU9Z6
>>>>>>>>>
>>>>>>>>> Thank you for any assistance,
>>>>>>>>> -- Laurence Michaels.

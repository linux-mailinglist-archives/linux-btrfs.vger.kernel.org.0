Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282CB4D272E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 05:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiCIDB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 22:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiCIDB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 22:01:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7988413DE18
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 19:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646794826;
        bh=IWEu7gmp3ZVmfj2FZjwQHIJtFrJACy4NwyhQmMd+xMg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Jg2Jlo6bI3WECK5y/XvydVClvyGju+2/xTdnEOeEBP3YNvyBZ4ExbiU/zMhI5+w7c
         C4NVd9W5lwSqjN1gKQKz7Hm0YKypcOJ6IdsTtkpK3+jc4Uz9N/UltwlAbmB69Ri7q3
         yXvtZjKCyikns1LDrHHlJa5lYa+GvDTNEijXVUVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1nKfpU0Quk-00AVUE; Wed, 09
 Mar 2022 04:00:26 +0100
Message-ID: <ca8e7647-9996-d05d-1438-ff2b82c7038b@gmx.com>
Date:   Wed, 9 Mar 2022 11:00:23 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALPV6DtuY6KxFKF6WR2HDPzzVm8TbcGEXwTMiDAy6MdL+jC7jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ADEO3zlJ8KZu4ZQDwaBjtZwipOswaZv4EetDJkm+lCYAL/stre6
 NGX/FZSh3vl8TdDuvs7Tjm+32eBmwO0nOsjJsbCWjUeUiR9kqVcu3M/Df9yUeqA87tqsM/T
 Ta8QusIw+0ub8uv3ZQH1QcbYxa138/mr8tMXKnGtjWBPtTZODkPyj+PaghA4+Ll7oBP2HGW
 Mkk3HMaXzejYynD5BUo+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jv6kLqUF8VI=:wtP55C9h0qPU4w+HxSD9pI
 6AFR5xwlA2fAl/kIO9K8IFOCVJjYDRS9/tcZlNCNUdj3X5t9Wg1JK3/yhBlQZvgNH/XzRjz2d
 vsi/ZNKDtfS0c+jFy3rZb1w56qbq4+Zz9++qkOl/muXQ87FMoMQrj7GoxKgtBlDUsSL3McJkO
 VuLysgv03eVq3uf0aQ96HEyF+riIenNhybDT6DskzaSW27/ttNdZfsPea4qKny+gPcAA3wH3h
 BDYpzReTsrhQTmmWUyGyELxdVr65PKBZqEmTDieOx+sf/e7T17MZwsPCILyrI+kZaJPZXGMhS
 mL41muMSQcA/9Dt7Sg33OH/aFsTR7DvS8paa6lilG+29dopRCDRwTvbtFUpchPfHTY5ePL5Su
 u62fy5xv/ekf8aNf8CnPqsizYNZ+Voad6s7Ih9QpygmDA49cPvLBAJ+0jIgV27vArXjTDoR4y
 KdaRPEFNAbXeZBiSu0nuHIw/AsTbPaQ4pUmMhNYkpopqSx2Kiy28apbrI6Px/cEXcEydC8luc
 yUODbPYNBV9DLpzIiDf9GUYy9VxS1wdr77OXUdeGFOVQzIq0xRGV+dPjwO84pO0CJVhqAkVGS
 xlrZkR4sL6ypaNlGMrZVSZcJs3qWUtdsg4hkqi1KUWTVtgqzGDakur1DoCBxv14kHlGqomAQ2
 UK78ceJ9LPuoPLcofjMN3+96Lp7kSYoswlfp7pMuCHgirKeoDGUEFj/VhDVkpzeKhPr9ZjLk9
 VRRLdv2NQNxH67pP32dop4VeWrmcBsnsbCuXq2CueuaA3+pZBIYnZb6oKlXHHomI/u1fnTsSE
 aAD+EgTvNTL3z1SzmWJvM6nqFrjs4vzkx37iX+12wAz6yBI2lfpTwR3NN/LCBkNBSnrW8ZKvL
 +HcRWARU/rRoOmeFdGpy3gIW8Ys6ylFYRNrKyp9cnVLK2RrGkmjwmtRAq9XiTEFG49w6br4UF
 TnfHqrBhGSCzycWbWT/+0J/Hyxcp8EqJrIPadEkTogijsZSTA7OG7S4g/vbeiGpjNxwceqHwN
 2EHY62GlCjLfEc+LvZXiRnm4zRB4d2eSQ/TI5iRCRf3z+kz+K54QTgRdIljrRQpJZ9H7cC3WM
 1mukn6oP5LqRUc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 09:09, bill gates wrote:
> This filesystem was most likely created in 2014 using the tools of
> that time, at least that's the oldest file in my home directory. It
> _might_ have been made in 2019, that's the date on the mount point.
>
> There are 2 subvolumes on /dev/sda2, /home and /var.
>
> My btrfs-progs version is 5.15.1.
>
> Per your request:
> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
> btrfs-progs v5.15.1

Weird, the output doesn't match the dmesg.

This tree belongs to csum tree, not root tree.

Thanks,
Qu
> leaf 10442806968320 items 34 free space 6225 generation 6834902 owner CS=
UM_TREE
> leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
> fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
> chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 9848629587968) itemoff
> 16075 itemsize 208
>                 range start 9848629587968 end 9848629800960 length 21299=
2
>         item 1 key (EXTENT_CSUM EXTENT_CSUM 9848630026240) itemoff
> 15823 itemsize 252
>                 range start 9848630026240 end 9848630284288 length 25804=
8
>         item 2 key (EXTENT_CSUM EXTENT_CSUM 9848630714368) itemoff
> 15815 itemsize 8
>                 range start 9848630714368 end 9848630722560 length 8192
>         item 3 key (EXTENT_CSUM EXTENT_CSUM 9848630984704) itemoff
> 14723 itemsize 1092
>                 range start 9848630984704 end 9848632102912 length 11182=
08
>         item 4 key (EXTENT_CSUM EXTENT_CSUM 9848632160256) itemoff
> 14703 itemsize 20
>                 range start 9848632160256 end 9848632180736 length 20480
>         item 5 key (EXTENT_CSUM EXTENT_CSUM 9848632180736) itemoff
> 14279 itemsize 424
>                 range start 9848632180736 end 9848632614912 length 43417=
6
>         item 6 key (EXTENT_CSUM EXTENT_CSUM 9848632942592) itemoff
> 14067 itemsize 212
>                 range start 9848632942592 end 9848633159680 length 21708=
8
>         item 7 key (EXTENT_CSUM EXTENT_CSUM 9848633286656) itemoff
> 13815 itemsize 252
>                 range start 9848633286656 end 9848633544704 length 25804=
8
>         item 8 key (EXTENT_CSUM EXTENT_CSUM 9848633548800) itemoff
> 13579 itemsize 236
>                 range start 9848633548800 end 9848633790464 length 24166=
4
>         item 9 key (EXTENT_CSUM EXTENT_CSUM 9848633810944) itemoff
> 13527 itemsize 52
>                 range start 9848633810944 end 9848633864192 length 53248
>         item 10 key (EXTENT_CSUM EXTENT_CSUM 9848633950208) itemoff
> 12671 itemsize 856
>                 range start 9848633950208 end 9848634826752 length 87654=
4
>         item 11 key (EXTENT_CSUM EXTENT_CSUM 9848634826752) itemoff
> 12659 itemsize 12
>                 range start 9848634826752 end 9848634839040 length 12288
>         item 12 key (EXTENT_CSUM EXTENT_CSUM 9848634970112) itemoff
> 12643 itemsize 16
>                 range start 9848634970112 end 9848634986496 length 16384
>         item 13 key (EXTENT_CSUM EXTENT_CSUM 9848635056128) itemoff
> 12583 itemsize 60
>                 range start 9848635056128 end 9848635117568 length 61440
>         item 14 key (EXTENT_CSUM EXTENT_CSUM 9848635117568) itemoff
> 12151 itemsize 432
>                 range start 9848635117568 end 9848635559936 length 44236=
8
>         item 15 key (EXTENT_CSUM EXTENT_CSUM 9848635592704) itemoff
> 12135 itemsize 16
>                 range start 9848635592704 end 9848635609088 length 16384
>         item 16 key (EXTENT_CSUM EXTENT_CSUM 9848635703296) itemoff
> 11791 itemsize 344
>                 range start 9848635703296 end 9848636055552 length 35225=
6
>         item 17 key (EXTENT_CSUM EXTENT_CSUM 9848636108800) itemoff
> 11719 itemsize 72
>                 range start 9848636108800 end 9848636182528 length 73728
>         item 18 key (EXTENT_CSUM EXTENT_CSUM 9848636669952) itemoff
> 11691 itemsize 28
>                 range start 9848636669952 end 9848636698624 length 28672
>         item 19 key (EXTENT_CSUM EXTENT_CSUM 9848636698624) itemoff
> 11371 itemsize 320
>                 range start 9848636698624 end 9848637026304 length 32768=
0
>         item 20 key (EXTENT_CSUM EXTENT_CSUM 9848637026304) itemoff
> 10979 itemsize 392
>                 range start 9848637026304 end 9848637427712 length 40140=
8
>         item 21 key (EXTENT_CSUM EXTENT_CSUM 9848637468672) itemoff
> 10131 itemsize 848
>                 range start 9848637468672 end 9848638337024 length 86835=
2
>         item 22 key (EXTENT_CSUM EXTENT_CSUM 9848638631936) itemoff
> 10079 itemsize 52
>                 range start 9848638631936 end 9848638685184 length 53248
>         item 23 key (EXTENT_CSUM EXTENT_CSUM 9848638685184) itemoff
> 9791 itemsize 288
>                 range start 9848638685184 end 9848638980096 length 29491=
2
>         item 24 key (EXTENT_CSUM EXTENT_CSUM 9848638980096) itemoff
> 9787 itemsize 4
>                 range start 9848638980096 end 9848638984192 length 4096
>         item 25 key (EXTENT_CSUM EXTENT_CSUM 9848638984192) itemoff
> 9735 itemsize 52
>                 range start 9848638984192 end 9848639037440 length 53248
>         item 26 key (EXTENT_CSUM EXTENT_CSUM 9848639045632) itemoff
> 9111 itemsize 624
>                 range start 9848639045632 end 9848639684608 length 63897=
6
>         item 27 key (EXTENT_CSUM EXTENT_CSUM 9848639684608) itemoff
> 9091 itemsize 20
>                 range start 9848639684608 end 9848639705088 length 20480
>         item 28 key (EXTENT_CSUM EXTENT_CSUM 9848639967232) itemoff
> 8003 itemsize 1088
>                 range start 9848639967232 end 9848641081344 length 11141=
12
>         item 29 key (EXTENT_CSUM EXTENT_CSUM 9848641150976) itemoff
> 7947 itemsize 56
>                 range start 9848641150976 end 9848641208320 length 57344
>         item 30 key (EXTENT_CSUM EXTENT_CSUM 9848641409024) itemoff
> 7887 itemsize 60
>                 range start 9848641409024 end 9848641470464 length 61440
>         item 31 key (EXTENT_CSUM EXTENT_CSUM 9848641695744) itemoff
> 7643 itemsize 244
>                 range start 9848641695744 end 9848641945600 length 24985=
6
>         item 32 key (EXTENT_CSUM EXTENT_CSUM 9848642043904) itemoff
> 7615 itemsize 28
>                 range start 9848642043904 end 9848642072576 length 28672
>         item 33 key (EXTENT_CSUM EXTENT_CSUM 9848642162688) itemoff
> 7075 itemsize 540
>                 range start 9848642162688 end 9848642715648 length 55296=
0
>
>
> On Tue, Mar 8, 2022 at 5:48 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/3/9 03:05, bill gates wrote:
>>> So, I recently attempted to upgrade from Linux kernel 4.19.82 to
>>> 5.15.23, and I'm getting a critical error in dmesg about a corrupt
>>> leaf (and no mounting of /home allowed with the options I'm aware of)
>>>
>>> [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=3D1
>>> block=3D10442806968320 sl
>>> ot=3D8 ino=3D6, invalid location key objectid: has 1 expect 6 or [256,
>>> 18446744073709551360]
>>> or 18446744073709551604
>>
>> Please provide the following output:
>>
>> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
>>
>>
>> The error message means, we got a DIR_ITEM in root tree.
>>
>> Normally that is used to indicate what default subvolume is.
>> Thus it's normally 6 or 5, or any valid subvolume id.
>>
>> But in your case, it's 1, thus tree-checker is rejecting your root tree=
.
>>
>> I didn't thought we could have 1 as default subvolume (as 1 is the root
>> tree, which is not a subvolume).
>>
>> But it looks like we should update btrfs check to fix this case.
>>
>> Is the fs created using older btrfs-progs? I guess that may be the caus=
e...
>>
>> Thanks,
>> Qu
>>
>>
>>> [ 396.218967] BTRFS error (device sda2): block=3D10442806968320 read
>>> time tree block corru
>>> ption detected
>>>
>>>
>>> Interestingly. that 18446... number is a power of 2, looks like maybe
>>> a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
>>> check" found no problems with fs on either kernel version. Would like
>>> to figure out how to fix this, if possible.
>>>
>>> https://pastebin.com/0ESPU9Z6
>>>
>>> Thank you for any assistance,
>>> -- Laurence Michaels.

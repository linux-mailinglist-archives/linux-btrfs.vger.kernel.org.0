Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2D38DB54
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEWNwR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 09:52:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:48105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhEWNwQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 09:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621777847;
        bh=qnLf2LJMJBdBLcLUxciDUOVqBUWCSV7o5/3ZMW5sOgk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=e0KNb+5YIYiZJp5fIYJ55H40r1hSd1ONOjYR+JhZyGVopQowtmw7ob2VF/PxevVpv
         YATflwT2WIQ0NY3ogMxbDWugdxegvv9ihNsbE1vhVD0fiai7MofWGRF1fOjppdAD9j
         vBE0c6e/FoybEqGST5Xi8FEtesMglKg/jCB4aqMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1lt1ym3qyY-00R4pY; Sun, 23
 May 2021 15:50:47 +0200
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
 <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
 <11a47593-81a3-12a9-a3c9-a6d3316922d7@gmx.com>
 <0543dddf-d86e-fcfb-42d7-57b2e8993997@gmx.com>
 <3423895f-5d21-ab98-b8c4-6c3c2b40d8ea@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7570c44c-6032-ebbe-5623-79ce16dcd3fe@gmx.com>
Date:   Sun, 23 May 2021 21:50:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3423895f-5d21-ab98-b8c4-6c3c2b40d8ea@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n/w5fSMevFTUYCB3rZtLR+fEa0FXUEWT2TYSPbdADRKUFGVgSOi
 53rKBx16+r7vX75HTLBQdnli4yIXHBO2pXddkJC1IHFWWRRwn6Pk2OJcpUuu1l12f7SSS4V
 CCa5KqjHPjZ3SyLQeRThnvrtyDNvEBRWyRedSypVQAk/JHWPQFTJ/IWVwa4Mug88AO6Sa7G
 VxIHaQOqFOfWm+yhXGjAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQNTodVffGc=:JydakVQ8mpDA0XuCj4monN
 aSjBJsgoRYptXMha8oxHXgv/8JLNaiy+vk8JR9Xbr1V6u032KeEI6JGiMA7RyFkKHKkxoQi5u
 bBHr5Hm30cnghXg2qbfyk8O8KQYmDLlTq8cTBEMlqX+NtSpyO/jtCsMI3IZEQxm2ePmb5vZH3
 zyIp15HSjDc585fLXH41HiAyy1wMCgMzCKq5ilgv0wxM7Jcai2UvudWg4rS9ckkik9f+IsaTQ
 9rPaZe/5OEkJHLRSCAcrW5mG6Ud//GNhgdtMKqFHtxZH7DLRNYltreiqbQLc4uFZERPxsx/dY
 B1C09OZT1VMzFpduk/qN9svju8tSyAKPI5BL9l8E5vm3j0JjUr8FFPPpOWwCIKIFt40QGTjE/
 VqGLXiNkkr+FaRYWKXXzYZwyX4czidKkJ0oGn4VGb6TVBPwOAoLxVBTHlF6x77EuG1O6K5GoZ
 LZ/qzGFT/j6FA1Os08WVJsfC3mO28pNUlxaK7F4s7mzOrAXgUVyjioZQOyMa+mLAtSgBkMa+T
 SFb0Zf+Vd9bApdjKtrlhpTBMs4ds6+6xojALCN2h+6SOs5KT6NzxGprvNLJLISpnNlhDcyhTT
 8TTAZpB8jbG/tcAQst96VkrbJSJUyK+5ZaD0BL05xsBBZy0ijJ1mG6M1lcrvBxKwmUfDkZJbr
 mSPGFyztoZXOhh8x/YsXY629ZInyCoPQ9pbNJ8/vXQKtU5Tx/24ZxYLQQJzQAaOHPwAxPs4hB
 q84upF3nMCMfufCzLuumHnMdJFWh7iYEzvLYbbDRG+Ed/zKNGgw+5eK5K8g9fp9dLj8+YNsRP
 OluuxF/CijHh5oBVZDUr45J2m4vPjgqtZYRZO3SKoSAGm6anQshRHV99CSNwfm9ZgcRfRwhSI
 dN0PYZkaRcEKCZ2VF6TLRQ0Iti2DjGHRRGiPm5iVVAofeit7N31dd/0t4Te+IPe697+JGXQNi
 59k9ZcEpXYex7ltvvUeyh88lM/nLakmvADx6/DehAP0PukdZPbhhoGrhpfG44noQ5X5389srj
 l/DZQU76/AdRrshpY2QScUHACJL9L+P0x4fU1uFPpOwjMkLfaKLlliPJ40RJAkxeVma5XWiWY
 4q9b9702ZE0c3pHDrDc22cneyDsKrtx8Btb3IvGEfPGr7+KvH1undMuqismGspDHhsk+XQwM+
 FOPZVyWw4lSJLB18ygI91OGgcB1LDZqYP5QNw/Gyp8Tf9VaR+EHYmnNMVYXgHc6smh+PISZMF
 +cxRcfwpqnjyIdywm
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/23 =E4=B8=8B=E5=8D=889:43, Josef Bacik wrote:
> On 5/23/21 3:40 AM, Qu Wenruo wrote:
>>
>>
>> On 2021/5/22 =E4=B8=8A=E5=8D=888:24, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/21 =E4=B8=8B=E5=8D=8810:27, Josef Bacik wrote:
>>>> On 4/27/21 7:03 PM, Qu Wenruo wrote:
>>>>> There is a pretty bad abuse of
>>>>> btrfs_writepage_endio_finish_ordered() in
>>>>> end_compressed_bio_write().
>>>>>
>>>>> It passes compressed pages to btrfs_writepage_endio_finish_ordered()=
,
>>>>> which is only supposed to accept inode pages.
>>>>>
>>>>> Thankfully the important info here is the inode, so let's pass
>>>>> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), an=
d
>>>>> make @page parameter optional.
>>>>>
>>>>> By this, end_compressed_bio_write() can happily pass page=3DNULL whi=
le
>>>>> still get everything done properly.
>>>>>
>>>>> Also, to cooperate with such modification, replace @page parameter f=
or
>>>>> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
>>>>> Although this removes page_index info, the existing start/len
>>>>> should be
>>>>> enough for most usage.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>
>>>> This was merged into misc-next yesterday it looks like, and it's caus=
ed
>>>> both of my VM's that do compression variations to panic on different
>>>> tests, one on btrfs/011 and one on btrfs/027.=C2=A0 I bisected it to =
this
>>>> patch, I'm not sure what's wrong with it but it needs to be dropped
>>>> from
>>>> misc-next until it gets fixed otherwise it'll keep killing the
>>>> overnight
>>>> xfstests runs.=C2=A0 Thanks,
>>>
>>> Any dying message to share?
>>>
>>> I just tried with "-o compress" mount option for btrfs/011 and
>>> btrfs/027, none of them crashed on my local branch (full subpage RW
>>> branch).
>>
>> A full day passed, and still no reproduce.
>>
>> And this patch really doesn't change anything for the involved
>> compressed write path.
>>
>> And considering it's the BUG_ON() triggered inside btrfs_map_bio(), it
>> means we have some bio crossed stripe boundary.
>> It may be related to device size as that may change the on-disk data
>> layout.
>>
>> Mind to shared the full fstests config and disk layout?
>>
>
> Just 10gib slice of a LV with -o compress.=C2=A0 Though I got panics las=
t
> night and I think Dave pulled your patches, so maybe bisect lied to me.
> I'm going to re-run again to see what pops.=C2=A0 THanks,

And if possible, please re-run the branch of ext/qu/subpage-prep-13
(commit 42793356463a9674f45118125304fd92c4679c27), which folded one
known fix in patch
"btrfs: refactor submit_extent_page() to make bio and its flag tracing
easier".

Really hope it's not a bug in the subpage preparation patchset.

Thanks,
Qu
>
> Josef
>
>

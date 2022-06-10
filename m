Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5319F545B5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 06:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbiFJExY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 00:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbiFJExT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 00:53:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCC031AE9E
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654836788;
        bh=48Q4ZNNiidv2QVG8Jr36th6O9DeGUjjoPH+UicyvgWE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hlofNst+160y/WLYklegqodtT3DUSWrPjaEw4KqStT+wSUiFZnQhtiwCiz/bCi6l/
         pgr2pDt7637FrM5DmMA2HGhVp0lcnNTH8Y1xSkxm7Zz02fGDC4qk8n4ufGUldwc8bp
         pk5N8XwelAVVICMx+mYM0kYna8uDYgtFYcFu0cE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1o4DbO1moz-004fxb; Fri, 10
 Jun 2022 06:53:08 +0200
Message-ID: <bb7a1b32-07aa-c128-6df4-ac68611ad471@gmx.com>
Date:   Fri, 10 Jun 2022 12:53:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
 <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
 <20220609225906.GX20633@twin.jikos.cz>
 <YqKhCDu0tOcdGpKA@casper.infradead.org>
 <60abd620-0ec0-9ab2-74ac-8fc06e21d193@gmx.com>
 <YqK7FZrz+xVxl541@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YqK7FZrz+xVxl541@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1nKn0ojWNZg3p8PzD3+Sxk+mIUUHs9EVae90jWLnV2zKu93n1Wp
 lDkEi0asdSheWUIQg9DbWL4A8eueyrKjWS+J5XvSSihTx/C9VkrY3Mf1bdyIvPnsLtpxwQK
 iRDQ81BVSZN+H7hNOg9Uu7NRm/TETOlLSALVU8IZ/h0zq++zBL7lgVU6SbKyb/XKLqgx36z
 f7NplPUMKlGy5QuVbx6bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QJ/pi+deD48=:Ityg+a8+s7TlqvLlCuydSN
 aieg5RDprd04IraK3U1ylkgk4EmKUXGMilIfA5UNVwX7UkdVVfL8BpCegkGIN6fseRltjWnXl
 WlOIRPQ46qTKkjQzJsmO/CqqnwCgeaFe175gTbydjcJL+97KFUZB0Ie3lt7yqkIG19aRdb7PY
 dAA0G5d+czV9cArhPC5UPLkHDwlaqqsPL6X3Eq5pPRC1dfSiUE84rBM+ZFKuv/MYfEHvdbmf8
 8qJOOpmpLNXWgkotuw9E3ORsJ5Ci7rk9rKYnKY6aCOsaSzm8yuIuBRDN0uaDZlq3lw0MdNddT
 X/zKL8FPshZZyY/uKJivCEVUxxFsif+HPLaOMvu0Xt9u7DAJXJ/rRscRn7vla4xgoPYTi/U74
 DiRRGbW3LlrqnRignxdYzpyCr8Fq55Wxt5EhynXyYxLoIh2r6Bvy5jErGeY35w8y+jHsgQwuS
 mewPOP593nK+VlDnc93cp2XkcpZdp76mg+sdzBmHZphCKLQjw8nCHT7cIUwSzZgu5BqyuSGpS
 QhYfQMtMhZO3i2IdZDmrmvMm3D87vgcKNSaVsIsco8l4Sv4HrmulgbulpH+4J19+Xb1tycd2D
 fa356JHHopKY12tSnX7HtX2Ui9bSLONdekD318tHIKb5R6vU6m/3pguoSJZLEs6aFe1vmYl0H
 hvac7MWKUidD76KlUCMrwTRZf+6D55j/K18x0JTuGQvtuGyUPZmIlKoncyRafGi+H2GK38Y62
 YJ/zadg07EwpGXFrG/KJA7H3jDzqVFDKfocEsSOYGeL2MytqL+L7dS/pvWHx14T6MG5Li7miZ
 QP7EIPJUhrDu0fKleK9+uzOZdFUrZY/vekfhzPvcvFDmKJhUVthiMMRaVsSmoXZusCOtUYbQ4
 91Bk9FD7QZz82Tip8+xW8buzfT1qO014E+fD3dBQmYD4DI8USTXmxDegqnN653s/DSMqMVS5y
 FKJoHztwhGncUJI+aLgnl4TtMKDSUO7N1X1y1pLnliU2aIFcFnyI6vq1Zfegat0cNu7CWXIJz
 kUVyjKsb74B/ITW+9zhFxEY8NU2PXjdxMhji3qgJcgvEgAbmLYMfu2T12C9qODc86QlC0O+O+
 BoHzwE8UOlUZAldst3sM29wnBVUpqIhXG7YsF1Dx89pgzxBtFdJt5y9gw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 11:31, Matthew Wilcox wrote:
> On Fri, Jun 10, 2022 at 10:46:18AM +0800, Qu Wenruo wrote:
>> On 2022/6/10 09:40, Matthew Wilcox wrote:
>>> On Fri, Jun 10, 2022 at 12:59:06AM +0200, David Sterba wrote:
>>>> On Fri, Jun 10, 2022 at 06:58:00AM +0800, Qu Wenruo wrote:
>>>>>> v2:
>>>>>>
>>>>>> - allocate 3 pages per device to keep parallelism, otherwise the
>>>>>>      submission would be serialized on the page lock
>>>>>
>>>>> Wouldn't this cause extra memory overhead for non-4K page size syste=
ms?
>>>>>
>>>>> Would simpler kmalloc() fulfill the requirement for both 4K and non-=
4K
>>>>> page size systems?
>>>>
>>>> Yeah on pages larger than 4K it's a bit wasteful. kmalloc should be
>>>> possible, for bios we need the page pointer but we should be able to =
get
>>>> it from the kmalloc address. I'd rather do that in a separate change
>>>> though.
>>>
>>> Slab uses the entirety of the struct page; if you use kmalloc, you
>>> need a separate side structure to keep your metadata in rather than
>>> using the struct page for your metadata.
>>
>> Any idea what structure in page we need for this super block write scen=
ario?
>>
>> Currently in btrfs_end_super_write(), it only handle PageUptodate and
>> PageError.
>>
>> But we only set them, and never really utilize them, resulting btrfs to
>> ignore any IO error on superblocks.
>
> Huh?  I see btrfs reporting errors using them.  eg write_all_supers()
> sums up total_errors.

Unfortunately, it doesn't take IO error into consideration.

In btrfs_end_super_write() it just set PageError, output an error
message for the error, and that's all.

The total_errors doesn't include the most important and common error...

>
> I mean, it's your filesystem; you decide what information you need to
> keep about each write.
>

But sometimes we can have such stupid bugs like missing error handling
for super block writeback...

And thank you for touching this part of code, and let us find this
hidden bug.

Thanks,
Qu

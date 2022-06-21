Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2775552B78
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbiFUHFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiFUHFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 03:05:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9F21E03
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655795104;
        bh=XT/8ECjh1+DMAgaQYjymLzwyy0GdbzYxPBo19WFSaLs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ATH4piRov56xKZhsHTxZITftCRuwbvL2iRSakPX245i042PJcldj0zfDNvQB92MzC
         TdelimeRFWuuFFIyAMq3RDRgbzFPm4KSVyc3JyO/uFoJSosdSZhwJpz9TuvzF0GAKd
         YfQ+4UwtYd5FEKn+70G+9RlWZTxblLGtlORw2btU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1nxivS0kxh-00CNPv; Tue, 21
 Jun 2022 09:05:04 +0200
Message-ID: <94e5a6cf-8547-f1dd-ce41-3ab71eae8bd1@gmx.com>
Date:   Tue, 21 Jun 2022 15:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20220621062627.2637632-1-hch@lst.de>
 <221407c5-0aec-6ab0-4f7f-e74a5873e4e0@gmx.com> <20220621064010.GA893@lst.de>
 <2bb7e620-fb2c-52d3-0ecf-87c2f75a1305@suse.com>
 <20220621065909.GA1186@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220621065909.GA1186@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BwVG9m/sHy08YzehQunVqU3hSmreWy7/Fn6pT6McBivEqb53TDA
 0NIEI3+V3dNz282QzR+S74QwPwXRbaZ5igjZwcHCYs0OQtBgTHG4Q42ynalLIuWsNsKvQaJ
 2K8+/DTp1EmqkXwpg5gpMZi+5YulS8fu4CTeZb56+p6F0CF+q1aaGbKattPLmBHXrMBdY5a
 NcX1y89Duub6NuUM1YsWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mB6giQ90ZsE=:5BMRx2GBrDqGRpszAHbEsr
 4mmu+apSyXmqc1j2EMsowJFdLYLGdpvmld0wpDkE0BMq/eeOR9PRukR3dHrbe16+7/VPGe+xd
 RMUgWUSTzdT+5VVJFEj/Ahd9QvdMGqbXG/Lj3d4w39UWKNMNecLGkvaIzfzlnR7o4HNT1qG3M
 3pItfZy0BLbywB3+rMvfWyOWq4gW8jZ5t74oglur2dIiSoCsezU9DvdCNkDVtUQ3TswOQezQJ
 TknQg+IvKvuGsc/fp8QvOiV9lxjkJ5RaC8LsdpvCH+c7U/mecmNNu2LNJCFv7BmiLN7Z8AHm+
 iKUAbpCyvywRSINwR/nVJQkHY7fpyUFW703+jQcTgzdtPEgOwbD6FLxrsNh++u7pRZlmw/Kse
 mXyoYgxzDiZjvhpHsRAxO3WqMZFWRP8zj1L9eIgZoi2myuIPxjwFVZ34PUlbg20Al8BtWKbad
 AtnnHKZ56iNF4kpZYqPP0gPkeD6m2CxBPvlJPVa+5tL/ytA3lMMmZt+ScVMjcPeoM9bveuKMR
 7lh6JER5iXFpx2UTo8X8l1alTr6FkGi3q5jcb14JRkFssw1GhYzVq74vMjatoN0FDrnvCjbZZ
 Qwh3Goy18WxJIqw5yrfNXcth0kfFRP054Ac0cc2ToTXo78/XBxaDU414Gq3sk6OEIf9dpilch
 LD6YsdEpSlPKJFZQBvAJw0m2tBzetHRpdzJEB/KDQLx3oY5/Xp4DWTwd/DPkXw24G3+o9dPi/
 nwMFvvf7NDQ1r6gDfquEHUHqQ6aDMoFQAmyaZuRGmIViuqqHJrAlQMT1U+x3SCeR1TvwYBsij
 z4wgtPgpRDXTEKthZHMSZ45KOM5tiurj+9HTKzvPt1mcbwy+m58Lva+Sxn05w2cj4nwYrYhVV
 4iIcDk4HINfGOU8sxAb8RBdoJLdrDEd0bUvpvxy/dQpzS0UNuif5SPuKcCnsVsBPTvUOQgP2O
 9mWFdjdciFtfLyvxq2HPqxWycOCMU0PSLNwGpgTnRZLJSzWggzaL/SsVgBwsctxnDdvNuxE1q
 d2reUdPin3WXxWtawUs98Uy15JtpAw0eA6Mb/wVmAA0BW/1CkUzn4DBOYuAQcxNNmVQLFSTaC
 MAflMUpuQDRLTZHXY3j9lFfiRq7wVvZkSv6QrSfXNNK34c5bEU+8AUbDg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 14:59, Christoph Hellwig wrote:
> On Tue, Jun 21, 2022 at 02:55:06PM +0800, Qu Wenruo wrote:
>> A little off-topic here, what did the extra XFS/iomap do here?
>>
>> IIRC the multi-page bio vector is already there for years.
>
> Yes.
>
>> As long as the pages in page cache are contiguous, bio_add_page() will
>> create such multi-page vector, without any extra support from fs.
>
> Yes.  Every file system supports that case right now, but that only
> covers the case where pages are contiguous by luck because the
> allocations worked that way.  The iomap THP support is all about
> having I/O map (and to a small extent the file system, which for now
> is just xfs) to be able to deal with large folios, that is > PAGE_SIZE
> compound allocations.

That sounds interesting.

>
>>>   At which point
>>> allocating the larger csums array is also not a problem as we can
>>> find contigous memory for that easily as well.  For direct I/O on the
>>> other hand the destination could be THPs or hugetlbs even when memory
>>> is badly fragmented.
>>
>> My point here is just no need to align any limit.
>>
>> Smash a good enough value here is enough, or we need to dig way deeper =
to
>> see if the MAX_SECTORS based one is really correct or not.
>
> So my plan here was to also enforce the limit for buffered I/O and
> provide a mempool for the maximum allocation size instead of just
> failing on memory presure right now.

Not sure if mempool is really needed for this case, but since I have
seen memory allocation failure for extent io tree (and directly leads to
BUG_ON()), so I guess it will make sense.

>  But there is another series
> or two I need to finish first to have the buffered I/O code in the
> shape where this can be easily added.
>
More and more pending patches, and I never see an end...

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4074712062
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 08:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbjEZGnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbjEZGna (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 02:43:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D712F
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685083397; i=quwenruo.btrfs@gmx.com;
        bh=srROJW4MUg7Mrl6o5I4Kp1S6Uhgf38hilxwYp1Zxqgk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Q2OY1JuwkKvFYT0D3zOJf/qW6PoHv0GL9dZuCPKoAkQH8e6ZffalpJzNCP3L7KttO
         KmMNVsN6P8Qy/4jmiWBAm+lSRkpXFwkiLhpcFn9oOQHk0R6chEhYgTBd26uTa5TJ5z
         OPA1In43BMOV1tqHb4wsv9PijBTrlf/yFxWtuWuRHH2L58lLsd0r2VwxCBoiFbZUo1
         /h/Fq/V0IpC8k0D6HaPsi3EYTwwgURJpVqx6Ky89mL48DKecW/QjI5LnCNfOhNFy8Y
         5hqvABbLh9ecWcVRPFossaGD/KGYrEQTqacfGyJUrjvJIQIwI5ulEB8DjGIPRSfmNJ
         F0uBkH/qjSkJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1qPge03RYa-00ndrI; Fri, 26
 May 2023 08:43:17 +0200
Message-ID: <e288cd7d-2f49-f517-a406-b511cae36cb7@gmx.com>
Date:   Fri, 26 May 2023 14:43:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree
 block checksumming
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-16-hch@lst.de>
 <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com>
 <20230526064123.GA10378@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230526064123.GA10378@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kUnlXYS2UVZMEMxAm1Sdj6y6lL9bHmn5rbBWTEn1lUaOnvdXsg2
 n7qY/QXMAgM999/yEiec/SDHpQOaolUhlwtFJMDPWAoVOh1bjqbmH23JqNj9EscsRepqt3h
 O51dkF0hBXbNAXdGOXwuSyCefBmM6sd66fTaQZ0T1aW7KWRGnPuthp0xQJ+5gt39mx2XAWj
 a3t7RdMTMk3zM+AyMxv0A==
UI-OutboundReport: notjunk:1;M01:P0:3sFNsbm1+8E=;OPBvLwyHVxCvZvcSvN9sAt9cDc6
 U2IxS9cod/uh7aJQGGJ9xSt43GJ1tOasCR7JEkv3qmmnPM9uRIWdAms+YUKw93f2RFstsYqIA
 Ides14YyQ/DPOJYIdloDoBoSor62c75608XwnBrSuKMaa0ZE5JBj23UCIVl8Meif0aTaRDE2G
 hH5TPCLyXcgxu33g0zPOUnzbZEQkkN00iObigqFDcwbYhqVWpOub3P8QKOZbk84PZLtExzGuE
 ZojcjVeSKGyJhrMl0+u5YaMsh4vLmR4td5KJZfGBtWQYIGf03Z9ov3Py7ClENsoPjkXbmFdeN
 Cp5clKXb/k1HgkFS0Q8EVrdtl9pfi6EEtNFpYIc20M2Cdm0Y/fEB2R4AtBnsEllsmt/W6y2Jn
 al+NGRmwslU284hHqlbUw7g3tCdOH87omwMOx/w5E6YA/e43TILXltl8z1ZhAkrP8pwz4fibS
 pRiQtL0HH6yQZH15PiunE41N89lX7mUNfKtzvBteajMT0tU44mphEKfL6XZC6thliASBKMt7f
 916nX7OdTgDdfS+ru0GT7AEI+PBnyG+BX5UehD80PwUKsUX4xWprSypkjjcHN01gOGPHhsNzM
 VW9eXIR66KpMAWxhLerxsSv+RrkuP2jwjBo2s7T8IFeLutvVMwbgE9EybFCWKPI+1rKZKn2rJ
 1EdhaVFzXXZiHwsqPGM4gkRxC4CGH8IV0MmkQW0McY3Zg/sF+JTBTPZ/6Jw0AE6y7xFfqH7b0
 BM6AGVArb/MAwhn5bq5DruuV/tjoMf49SAvCVw49I8ALq8XXd1+r11SLV/o8XRWEwYS+6vMV3
 +FU4wdqyVS2cOgA6PNaj4dUQ6e0xoiEVlxQtYdjkhReVUu5yKQTtS+EsKQVfIp5E/3ToQ/nS/
 6QDJ3xYO2WujICAGl1b2rzc55fzlmoE0/UyxA0EDM2mvC99CpQO85qpoxQHAHVozgJ8BwdPoX
 tahzOOwNA/vAbREQvXj6dIFAev4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/26 14:41, Christoph Hellwig wrote:
> On Fri, May 26, 2023 at 02:39:54PM +0800, Qu Wenruo wrote:
>>> +	if (WARN_ON_ONCE(found_start !=3D eb->start))
>>> +		return BLK_STS_IOERR;
>>> +	if (WARN_ON_ONCE(!PageUptodate(eb->pages[0])))
>>> +		return BLK_STS_IOERR;
>>
>> Unfortunately this is screwing up subpage support.
>>
>> Previously subpage goes its own helper, which replaces the uptodate
>> check to using the subpage helper.
>>
>> Since PageUptodate flag is only set when all eb in that page is uptodat=
e.
>> If we have a hole in the page range, the page will never be marked Upto=
date.
>>
>> Thus for any subpage mount, this would lead to transaction abort during
>> metadata writeback.
>>
>> We have btrfs_page_clamp_test_uptodate() for this usage.
>
> True, this should use the sub page helper.  Or maybe just drop
> this assert altogether?

It may be better to keep it, as there is also another case related to
subpage fs got its PageUptodate and bitmaps de-synced.

Thus the assert can have a chance to catch such problem.

Thanks,
Qu

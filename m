Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DA539B6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 04:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiFACzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 22:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiFACzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 22:55:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CFB6C0E8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654052123;
        bh=baN+12waLghZjNJNVqIYXDP7IXLXnTL7f+sD+JLlarw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NeUzFQMG1HrPIVzJhcQKqDkcS/Bzz4Jd3srm4YhfsP7CqoUld3yElhSIwwldnnqlI
         22s4islJWChmN8DI27FU41LYvLtGy3MJSZn/EqCdrrc5vv1reMH6ZlFAS5p9kPyC2y
         XUFpSOsYD5Un1O5NTvkXHRnO60qTgLxoDa7d7XKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26vL-1nyiQ71kDp-002YuX; Wed, 01
 Jun 2022 04:55:23 +0200
Message-ID: <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
Date:   Wed, 1 Jun 2022 10:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220601100645.6500.409509F4@e16-tech.com>
 <1bcadb40-e478-1c56-27fc-ca87e7fae715@suse.com>
 <20220601102532.D262.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220601102532.D262.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pxt2/ts0fxAU5/L+ZI/nvs22YVz9S4ZvjRd5M8r9iiZ4FLVv7W6
 NE3wCFONGnwIQjWwOEmqLHs0EGxSD24HU+DcirbGBfSnJlFKBvb25mrHC0j8N7a0qpVsX3u
 Vfejhns/mRFwfNpxtS71vS5iGbk7RHxvjhpAfEw7FrOl8IV5vxG8LiBHV3sLggsqX64po6E
 y0pSTEqn2ldNgohPFnoZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bXQQqCQ0lBU=:1U8nXY/FNTdO5FaajBD05I
 2KJ063RC5/1Ffi51uW+TTEKIZcVfdidsqeUsX9T+kUAebC0sGCVTeWMyzCxeNKaSKi6iXGr5y
 u5JC+dGD56+1f0s8N5iP9h3S/HrWNA/EduWAuBlPLyCIUORu5jkNcXcKHraOJR7nzGxhHK8r/
 1cVSNmY34FMZLeelH2Z9UVkgEQ10z0eEEVukxL0MOgrxQ7W9JxLkqp9pmx7t3wWc4dBctagm7
 ZUXxhY777UMOyTrmcNd8E6yBYGId44Hoyuri+5hF3hNaTE5k8s7KJ4LFgHI1G2kJUXReSz1JM
 u4pCzRLrc6Gva896mpgOKene8z5780Tw/fbXYWBuyfDdQE8V1gXBOdZHOWJ+itk3bPmYueF6v
 s5nEIUnFRrYXPRsi3XfapaOCQhXmCATkhhFzqHpQVQL5F71xR01kDpG4Tff0TGU/7K5e2Pvd0
 7uMj6IhT3A9tiVwJcLQIRusrOk7+dbxMYHFl8sSlyq+jIGUGVRV2JWcV/Q88segMzHoFeVAGc
 IdBiviPM+ZRiCJ/TsUARds9sySX9deYob7NXzrjF6ejwdGb8xv2EhU/3V2pJEw+xd5HA3QZbj
 Le1IcMnl9dMyaecxS6jkmijGgbdxJ0qAG1C9Kgm1pBDQlLKmbUs9N8QLki5FbP+xVtc0XT2lw
 Zz6bOFhfo+qBUnYZXoY+ehp7+G0ZsqlJrFajCKpNuuFmSpNvY1daL+HJizzt+dFKNGYOko7wx
 Lj6pQ3Zg7/gT9Rci+FxY9zSacR/H9SU7aRJIEJPPX7ImDCOy10mcl22XLd51LF7l9fxKrz0hd
 DVfdLhN3X3LWvSNA7o/rsoKKXHgUtSEjdBBnH5jcrdbGzgdeqymYqKqGEKjbz8ijn+IkMeA00
 vyiIkhKoyzWMFmBX0ZdqukGKUaD/7BRGebYOb/4AwfSdqzeiBvfJF0BBwBjEt1EtfzXEx6LW8
 3LECq/jY4871FyEIF62N9f/blgyplVE58pHCq7GZpMwZaaSvJbiplibnsRfRSHzYZ+fmOFZLU
 JSSCTnnS1PIyNmYkkHRuadd3a5LW/t5+aIZoXodRsZULkVNeboXUyr4VbpqWHdOt2VqUZ3GUu
 Vl3Ju0mIPapGN3raYgb6PgyTash94SK3lYlk29Br1JErsDXbf77irvQiQ==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/1 10:25, Wang Yugui wrote:
> Hi,
>
>> On 2022/6/1 10:06, Wang Yugui wrote:
>>> Hi,
>>>
>>>> This is the draft version of the on-disk format for RAID56J journal.
>>>>
>>>> The overall idea is, we have the following elements:
>>>>
>>>> 1) A fixed header
>>>>      Recording things like if the journal is clean or dirty, and how =
many
>>>>      entries it has.
>>>>
>>>> 2) One or at most 127 entries
>>>>      Each entry will point to a range of data in the per-device reser=
ved
>>>>      range.
>>>
>>> Can we put this journal in a device just like 'mke2fs -O journal_dev'
>>> or 'mkfs.xfs -l logdev'?
>>>
>>> A fast & small journal device may help the performance.
>>
>> Then that lacks the ability to lose one device.
>>
>> The journal device must be there no matter what.
>>
>> Furthermore, this will still need a on-disk format change for a special=
 type of device.
>
> If we save journal on every RAID56 HDD, it will always be very slow,
> because journal data is in a different place than normal data, so HDD
> seek is always happen?
>
> If we save journal on a device just like 'mke2fs -O journal_dev' or 'mkf=
s.xfs
> -l logdev', then this device just works like NVDIMM?  We may not need
> RAID56/RAID1 for journal data.

That device is the single point of failure. You lost that device, write
hole come again.

RAID56 can tolerant one or two device failures for sure.
Thus one point failure is against RAID56.


If one is not bothered with writehole, then they doesn't need any
journal at all.

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/01
>
>

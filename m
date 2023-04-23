Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4356EBEB4
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDWKuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Apr 2023 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWKuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Apr 2023 06:50:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922311A5
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 03:50:48 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6ux-1qfad13HEh-00pfBA; Sun, 23
 Apr 2023 12:50:09 +0200
Message-ID: <d44ed6bf-d8e4-a7aa-4713-72102f261bbe@gmx.com>
Date:   Sun, 23 Apr 2023 18:50:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
Content-Language: en-US
To:     waxhead@dirtcellar.net, joshua <joshua@mailmag.net>,
        Qu Wenruo <wqu@suse.com>
Cc:     Remi Gauvin <remi@georgianit.com>, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <44-64431b80-5-7f085200@250139773>
 <cd4024f7-3ff6-328a-08f5-7f405d5a9491@gmx.com>
 <1fbcdce2-a268-aa1d-1e6c-bb1e61e18ad9@dirtcellar.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1fbcdce2-a268-aa1d-1e6c-bb1e61e18ad9@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:icD6hoAuKfF/htKSrz8R6IGojmGiELEFMNUTKkJ982mHOJbiT0R
 /88TxJLVrk/wD01PsWe+V6M6PrgRFFpNIsr8LCjOnMu9O5kp3FqGkkNXcbq03p9eMbx7sxV
 QsWiAHLgWOUkOV/x00pntbgsCrjfN5gdVOaKZRhJ7oWuNm/7xwxy+11vvahLEWYSGn1xeRs
 wBTGXuKSLzMk9nZ5XblKA==
UI-OutboundReport: notjunk:1;M01:P0:zP53lEZSSp8=;NQzik/LDUrxgnZK04g9+dvbrO8k
 s31Bon234z6ulhMgfsiLzm7DMDOdx7z3ftnsDLlGd99UBmwl9TIaadodMo1P1LF8fNTRlOrXj
 BSvovkIPeaJnRIzMRaSc27JstJkuzQUwxO8F0Ir+eSPOb1j+6G2ejYNje50+03LKT74q6bEA5
 zMsdAmU2gZpM8ube2yMhzDnZ6Zl+zkrTlU0JywhpH0a25+bCHD0nLJEr1W5B26qtedEylcS7M
 WUxdwHTe5jN0ji8pUHjfE0c/UYh2CoSBEbZcZFX1wO3mBmg1khx/ucMYFjtIFpfN7aHABjPBk
 xwCdoYMjxFDBvzuH929r+5V07zyynjdDMzUaAmZHEARZ1WWNLRPdHNHX9ONvGFqWzCdwYCWXl
 JJsPj+mOSCkdJl50OYqXQN2aIz5ypr6wBzFEhribw0iuiZ4N6CPVCw5fQXldqnaY4TA2DICLc
 x/4jvHSE7vMxIqJGTv8j+/UN1vv0U0NPLAHys8F93evcd6J9tXFgbd1r9gS8y/3VfQfba9ikK
 yX8EmGa3fV8oc61XNZzEbKhmv401P1zzMRx+G5ai4/cAtwprifLEqvQj8khTFCv32iDjn5RUI
 Wzvwuf3K4Dl6aHuVDcxplokG27BMx6mhEPnYzib4Gqjjxh66BZmxbU7Pj9z4pKXnHbgd2YWdy
 4h6YZVptUnD1nkr6ciUK75Af20yUt+ooPM9cZYEGhuGgfVqLH5SIVTqCsxFWWCHFKWxYdP5hA
 yWEUalHFR2z1+JGK4Y2T6oK3Zl8NI24uFg3GIW94QG9HlgIJ8j2QCaMVgqP9y2oGBRcOwsyVE
 27laO5nvfOdTi6amRGxpxHrRLs4q+mAjvSo0/a3ikmdtyDkSfaTb20P9G+mWA8lEOKT43yifO
 YuBqpb/A1uW3E/dB8kpN+p2cquN0HO9nKeiCYg4aB3Rq5+lI7cj2YhjRKnybpzZqtpIT03nER
 letE5HIgQkWzfQc8TDgpgccKQk8=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/23 17:34, waxhead wrote:
>>
>> On 2023/4/22 07:25, joshua wrote:
>>> For my situation, (and others with large arrays) yes definitely.
>>> It's definitely the feature I'm most interested in patiently waiting 
>>> for....
>>>
>>
>> You can already compile the current btrfs-progs release with 
>> experimental features, which enables the "btrfstune -b" command to 
>> convert your existing btrfs to the new feature.
>>
>> I believe David would release the next btrfs-progs with bg tree moved 
>> to regular features.
>>
>> And even better, the new bg-tree feature is compat_ro, meaning 
>> unsupported kernel can still mount the fs RO.
>>
>> Thanks,
>> Qu
> 
> And for those of us that have BTRFS as root? Would we live happily ever 
> after or would GRUB choke on this?

Compat_ro feature means, any implementation, which only does read-only 
operations, would be fine.

Although for GRUB, I'm not that confident about their implementation...

Thanks,
Qu

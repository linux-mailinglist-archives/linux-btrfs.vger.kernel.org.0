Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59136C74AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 01:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCXAma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjCXAm3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 20:42:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FAE2B60B
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 17:42:28 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1q8miY2NgZ-00gqt4; Fri, 24
 Mar 2023 01:42:26 +0100
Message-ID: <10dba572-0877-b372-3790-32bd6c116afa@gmx.com>
Date:   Fri, 24 Mar 2023 08:42:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <20230321000918.GI10580@twin.jikos.cz>
 <0a96db1a-84a0-5fc5-3e92-8824c29907b9@gmx.com>
 <20230323175118.GV10580@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230323175118.GV10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UE9TAmH4n1kE5KtWTVFQ6beIznl0hj4Jrh/nX0KYjOXboQJJ/8C
 zhjvqKmZjB81D6Vs1Qik8Nbf4HRaJMX8V6dvg4gFJ1CkSuPn4GhxxW7fCTlp47pANrS4Iaz
 Ccdp+/d52DxFbcLi79hXM7OuUq1KGYLAG8nu/2qVNpktzESVuyszd5HP5pzRGqmkwD1XXRR
 4lBJkw1Ezg32zEyo/KLdA==
UI-OutboundReport: notjunk:1;M01:P0:9rjJvTQ1buI=;7ICzcjMOAK2xO/n3fix0CJUGbre
 Mcio1jDKAqQlsq2EdgMyWGPGl8yEKQX0lqlhi7EMWSXzqk9W1gzIQXWgR/oqFDtjNqsnahATh
 13GFF35xnz2SXb6+875UD34cTKnPtHnF53GUB3/EnsLdQws45nMnoTvNpvi3qcQ7iV0IsXQ6q
 Xx6e8I62CROfimiqQ24HZfVJfuvHzOgsJ1KRKbuTV1U80PZALItKBaJ3+0MqNz1Y+xtJE/wK2
 88ocZwbsgmheQ+bGDm0I9L9QPbvTQX2tKlKbUWPM3Bffx3L9qhg0fZ491YhTGAHxCSUDy3q6F
 8qj92HfjdO2uzgPMTarjQgsi2ydevzopPEZwH2ASBy9GGQulGVg6u/uHj0gBhZ1X00Xv6IabB
 CHlk2eAP03eCTeYSNaXxpfrlaJcQ9vthhaodhsRMPG4qKBaI10gAVl75IB47f5uu9gfatKoEj
 1oqdYQAxorM762e3YxlsCj0Zs3638pEY8F9Zb+s5nCH7Exw+vZiQqW13oxMvV6NJn/zqkCzHn
 GPuoNzOxaXW5+T1GRlMk7JTU7X+DZrdfhPc2ZYWgsXxJnYuYW5bT782hVqGNBF/50U13MUanq
 YtnQN1XWHpnnxrv+ZieHZMA3uOhZU/LlWBO2t3HSiY/SZu0DtKqHA7wWmzon1h0vFB3Vs3+vj
 r/ZoviOhZwUnD28gZdhje71zl7kDSbNRQMj1cX3YxYFxbOCSjKMWsDBp9RZjvn1aJ2Fxl8QX4
 9hc/14daSJfcuaSnAB/WV51KKXfCleT6SFsfS7rzPdfP8NvmONMsS8HjxTvs2knAV3sxyC1yG
 pYKGFZoZaCace9jlO227nfcj3g9mkN9cViXSyR4S7jIuecDdWU5m4nKeUyJqd/M2vJkR1ReW9
 avJao4CDH6jKYbhlldpvsa2mb5COv2rap9uGNIhNVZwitF+pO5yE9tO0ZQU336Umlp89BYu8L
 4C7Mq49yaURHEhq7Sk3Xp81Vz9k=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/24 01:51, David Sterba wrote:
> On Thu, Mar 23, 2023 at 02:28:16PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/3/21 08:09, David Sterba wrote:
>>> On Mon, Mar 20, 2023 at 10:12:46AM +0800, Qu Wenruo wrote:
>>>> [TODO]
>>>>
>>>> - More testing on zoned devices
>>>>     Now the patchset can already pass all scrub/replace groups with
>>>>     regular devices.
>>>
>>> I think I noticed some disparity in the old and new code for the zoned
>>> devices. This should be found by testing so I'd add this series to
>>> for-next and see.
>>
>> Just want to be sure, if I want to further update the series (mostly
>> style and small cleanups), I should just base all my updates on your
>> for-next branch, right?
> 
> No, please base it on misc-next. For-next is for an early testing but
> patchsets can be updated or completely dropped.

My bad, my question should be: Should I fetch all the patches from for-next?

Because I thought there may be some modification when you apply the 
patches, but it turns out it's really applied as is, so no need for that.

All my patches are and will always be based on misc-next.
(Although sometimes it's some older misc-next)

Thanks,
Qu

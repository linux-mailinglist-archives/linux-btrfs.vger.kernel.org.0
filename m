Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E36CCE2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 01:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjC1XpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 19:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjC1XpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 19:45:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FD7271C
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 16:45:15 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDIu-1q7o2o4AN6-00iCMd; Wed, 29
 Mar 2023 01:45:03 +0200
Message-ID: <c7ad6682-a3e0-ba70-b3f6-eed85388595f@gmx.com>
Date:   Wed, 29 Mar 2023 07:44:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1678777941.git.wqu@suse.com>
 <ZBF5M5R3pDdp/075@infradead.org>
 <2dfc49ef-e041-3efd-1c55-3685df22acb6@gmx.com>
 <ZCN6Itm8dkY8w9P/@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCN6Itm8dkY8w9P/@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uoNv4V403KM36f+oT+yU3jxuDxh0cvpeW17C75Phd1vT9U0jtd8
 tT57sJgR66CajGxavxjGaGvix4ki2EVddxrMzX0qNni1zKH/iDvPfbj5xR8sW+AyHBBOYJf
 u5NP6uOdndGHc2aB/av7agv4H8dEFMQNk0NNRbsmxypKOa+f3cL6E98413IyrWQzsCqlVFE
 TeUoO1qkl6xlBIZzsFnjA==
UI-OutboundReport: notjunk:1;M01:P0:+yGmITdLT9U=;OqDVBmR7CnhtmZbAYAYWXpddiKW
 90vGOl3gvgNsh4R3NcR+rvjqMZJqaBK1VDADJyC9AtZkZYKfR/N1HMG8pR4oKBihJ+Jtg9kp+
 9n9eugNCieGynt9UUOvX+prvEGMVqWu5d9sJIvZws6tiQaA/hbtCaom7h9LBVyUQuiZwt29Us
 3MV6Q6Elf3c9ibR7MN+c0Y5Nv6ZTz9XeUQgbNUCi0PSEr91x1RuxNAgBAMPewJj39Kf0utgNG
 AXKi4URfnLLeZXnMZq1ZGOTBiqq+ixIqfxV4Ld/Y6A5FRyJ0Xb+fRMrb79JHDeHECHn6wKJIy
 GVGMveSPVXMWmBCzlxH2ajs/zWRyDyPRfeTHqgI5Iz1cJ0cAExr/yoXOanWfE7RVXKQsDDYMP
 TocumLPJ3i7TXat8DNXwEKWE7lVYtP5wQnacOkjMSa+jfTS9bIRnPJgPN9L+6Urz3TdlOPaA4
 aAptOdYU1Opoo/QdMNRsoUEJMn0K+RCB/Ry25TxDkk1QPM4nXcnNdJf3KZvT1Gxdhg23D4i0S
 pYTlxkEVZev233wZcUh427ZyiCRbfAYnjtqkPs0qDC9IbeWIgMEfb/0Afu3z+FHlLaMumGNVi
 scPdrmybbQGmtXJWiLDDDHHpFrfDKTx1I1hXC+y58SdcXjXdSJqR2n8gjH2pw6QAtZVhSblbe
 fSc75vorHza5UPoN8XxYey6RNaYyl8A2HBPJhyWEcBqTeyWEq+gDjgFwMfe1qAUTVqr8H3gAE
 d1CknqAimi3BK19tBB7Ek+n59k86FfEu1oO5o85l808CfhuThaAKHHe5S3w53eJqkpBBJXiTy
 dSP11NQjmGmgdIwZKwXKAKoL0FYhrex3FaQHNYjzFXkDq4RmfDZY/NNQM7dlncIuDlmtgREad
 dyhOdJutitvEx0Ue89FWN6ETrOo6wYv0WtkA/NEAh4i3ixT2x8WJxRUkvWMUNTvgIVQ1qpRLr
 3HRy21GroFkTVRQAU7sQMuyl1xQ=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/29 07:37, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 05:34:03PM +0800, Qu Wenruo wrote:
>> Currently I just do a single patch to cleanup, the result is super aweful:
>>
>>   fs/btrfs/scrub.c | 2513 +---------------------------------------------
>>   fs/btrfs/scrub.h |    4 -
>>   2 files changed, 5 insertions(+), 2512 deletions(-)
> 
> To me this looks perfect.  A patch that just removes a lot of code is
> always good.

Isn't the patch split also important?

Anyway I will try some different methods to split that.

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CB62D40C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 08:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiKQH2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 02:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiKQH2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 02:28:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F14299C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 23:28:10 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McY8T-1pVT5p2ajd-00cunO; Thu, 17
 Nov 2022 08:27:53 +0100
Message-ID: <b5bc72c9-aa43-2aca-8c37-29c2d5f74ee1@gmx.com>
Date:   Thu, 17 Nov 2022 15:27:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <41c43c7d6aa25af13391905061e2d203f7853382.1660199812.git.wqu@suse.com>
 <Y3XWvjr/lISvY8E+@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y3XWvjr/lISvY8E+@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aJgUqgDYlEGNLIqAm3+skob5HaK2YC4ruvDXIneiRoyLdZwNftO
 uwGEYuDZ5PZTPZHfIkXaNLyc68K2hTQov/wcHItTeBuO1JfE7fw6LAbBuyR8dLDqUhx/tHu
 d444p6J/vPr1BrVVh9dzv2SlgsQqdmhdvAT/Qf+iNv7pL9z+9dFghbHgFKz1t3+rUtAx4Ov
 KSlmF1FbaUHoTcrdh9tXg==
UI-OutboundReport: notjunk:1;M01:P0:sT3QchhbGQE=;uE9B9ypJZAM0AFweIdTw9Dfwdxo
 ryoEya5RnBCGqPSgct0GH8wfzuNdWpSmS2OifA2pot2AJ/hm6eYUKJYZQcqZIMeJIIXTNA0Vz
 IuAjuSl4wgrOYt4voHt3KITE+ErXqv2d11gLS2lirccbXjOVz0rXOQw2mTCR6CYIAwEH9sxpD
 EbHRwaQ3XztXWnY9rCpR/rOiQo+53OlsDGx0J40+DtacNnSejMjZPGZmKxuiJYAEor35gx9KF
 bP/bF2A+A17hvejzaZ4QuT427oGysYsRTUdSw1WFckzrtESKBg+lQrd5djYQkYVeTtisyGfid
 ZDbsCDD6XrInHn+Z4crtV+WkXtymy0n4RRweSqO6xIbR4Ecjm8oJm1IYJvDo/+jPM5z17JaCg
 MxaLAQT+NdRIAPsg2Xfb3O6I/nB9EO6LY7fJMREYMOA2UylsRSYa8hYbkSCT6hHg80XYa5tHZ
 CtyTu2l7J44fgoOUSz9ckA1jb4UfOn54ahcpw6268a3KWuX5vJ5uUVyEju/FfeJ6OOK2HVBWd
 x72F5KMR4pClnEx6RRaqHpl4N1ooOOUzYAM8QhOlzx+EoltkuBa1dmOjhBWaW7rOym+6jwjkV
 1k272RKS8fBI4zOeQh6TM40iWg27gXAD8i0Ce6evV2htD4gcjJwooCT7To2ygCLdM2rBgHXos
 neFtrBLQD/o+gpWbkFL67n9mp8TSbW8nQQp/7aW61PgQS6I0Ke80H1puSt6jDS04NkBJCnDuU
 Oh/Tl2FEkUtnGCREdyww34cgY7b2PNHUCabBlTuTRN0uytPYKfijxwGgMRJD9QZ7x9TVcIBWl
 UAvkzUGTehErk86hTxkDVf/+tsdSqWtgOEDICQn/5nWt5KwvLtiIEWDBhABc3utNTQLPNBrOC
 iZj9BJ3ZCZkUJZgvG3u0TKILuIdNGR+YOw0b19K+vEMFoe/0TSMBOjwM++ITcMRF/xrlktdi8
 hRsg+6mtAbApTg8tL6bi9FnzoBI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/17 14:37, Christoph Hellwig wrote:
> On Thu, Aug 11, 2022 at 02:36:56PM +0800, Qu Wenruo wrote:
>> [REPRODUCER]
>> We can emulate the situation using the following small script:
> 
> Can you wire this tst up for xfstests?

Oh, sorry, it got extra feedback some time ago, I should update the old 
one soon.

Thanks,
Qui

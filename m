Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE246CF7BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjC2Xvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjC2Xvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:51:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBC658A
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:51:21 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1pv7wG0iiP-00V939; Thu, 30
 Mar 2023 01:51:13 +0200
Message-ID: <70968e38-20e6-0db6-5c46-a7904b4ca0df@gmx.com>
Date:   Thu, 30 Mar 2023 07:51:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 02/13] btrfs: introduce a new allocator for scrub
 specific btrfs_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680047473.git.wqu@suse.com>
 <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1680047473.git.wqu@suse.com>
 <ZCTKola6a+tbtyrL@infradead.org>
 <3289eba8-8492-3c14-6e3c-f6ef7df7cbb1@gmx.com>
 <ZCTOJ28lA8OR/LFy@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCTOJ28lA8OR/LFy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PWroNETa/vU07cqK3sSR2b2ZYumQrf8O23k3KBO7P0wGcyM6r5z
 3Jx3GjDiouNzLqu5PAzlD/LG7dgEG6FD7yhuJoYU02xjfwSLyWmBfk0/TRzN4ysDogk2pxK
 Fr1xR2J28JV/CPquVqwA1r3z8N0/aFlvRsRl2GjlQ3kSlPQaS8xvpdzgAmVb1Ml6WOS4O6D
 oiAOAqeOzQGGZ5gnKY53A==
UI-OutboundReport: notjunk:1;M01:P0:gA+C09I8WVM=;k1GdPAz2hu2mkWfauo+YmcSPIFt
 h4tONpfYytCxKsXfn1AzUrRURUsP5ZfqmKui8QRIUHLWi0fv6kMc2/6zudWm/vydx3avsT5JJ
 cB6fI8ATF8UPUMhfcwuI5HVwuy7Xdkzc3XiVAJSESDQH6jVYF3SLXEs2cd/HRuDkxHYLj8gJD
 8AV8eGUZRlK9ela2IDiqBvObte6kItZZApYD3qRM3YhlBcWqxuDsP25wxqxryNdC8f8VW97cU
 SQpPQQNp2cPY6OA7R7wGvGvVQopwZyWZkrMmReDZJJ0DvjeiaT3ZBHb7+NtnyXx77xC8yNorX
 C7A+tD1Aj1IUL4Hrcxmuo8TdnPQv7Ll+sm1UqyQof0gNVBJO9gQ0NX2/SwPNMjHqV4/NTkiTv
 gREN/5LhvphnpklGp4Yqpx+wXtNoBYh8ADbxQKP0NfPppQg9sf61Y+090vAcX8IHHaUbI5Oet
 IajiK3+CdOFv+ZYeYxs2Lc186gwTEzdka1ObRbl59Fe8lZ1TEnNvefqf/0d+dG5L5Gy1s9QlY
 0LePWob0Eczmxjd1VATL3xjBgO4Lb/8dQPH1T+VGLBDtYnO9Zl7sceqMOZmyL++0dUhQRTJMN
 2ZWYf/Ao9HnQFh38uLwSNMprenwoP3wbiGK/9iPfvJrIvqAQURzHy8Qaf8W5SbbmGhAdtWZab
 ykle/UVfYaKpImHANqET2h70hG9UNLkrisUGtPSxLAJ0qyLtew1pHZTi5oSfWgBtEkYfahomp
 h7pGbPdAR7Dg1jJllw1MKdGtvFft1ISOeG2fbpX2P0BXRAJoIkdErRd0lMv9s73K/BKLeMjrg
 H/yWQodbPTHDKCOFi7UaUZFAzl5qitPjz8T8987QaydE5raEVtZKC24/h04w3fywqkvffQKFw
 mdWv8ORgAO/9x+J83Il8j76KG6j4EP3/2N72vpsvbtS4TWAiN0YWaltlwMubIfcKzrC3vLjZY
 iHpfN4buyfGhBnHWHsK0tmv4LjY=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/30 07:47, Christoph Hellwig wrote:
> On Thu, Mar 30, 2023 at 07:39:43AM +0800, Qu Wenruo wrote:
>> But as my usual tendency, it would still be better to have some ASSERT()s to
>> make sure we're properly populating @inode for needed call sites.
> 
> Well, where would you place them?  The only place where we could do it
> would be in btrfs_submit_chunk, but without having the inode there is
> no way to know if we would have needed one.

Can we do something like "if (bbio->file_offset) ASSERT(bbio->inode);"?

> 
>> Or we can easily pass some bbio, which should go through csum verification,
>> without a valid @inode pointer, and to be treated as NODATACSUM.
>> Such problem can be very hard to detect.
> 
> That's what we have tests or that check that csums were there and used
> to detect and fix problems.

OK, I guess I'd better change my ASSERT()s happy behavior...

Thanks,
Qu

> 
> In the new world order I'd rather see bbio->inode != NULL as flag to
> run the checksumming and repair infrastructure.  Especially as with a
> bit more work I'll be able to never set bbio->inode for all metadata
> I/O either, and possibly get rid of the btree inode entirely.

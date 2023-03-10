Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769396B3A32
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCJJTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 04:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCJJTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 04:19:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FB7DD03
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 01:15:02 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1qfOa40Cyy-015JOH; Fri, 10
 Mar 2023 10:14:40 +0100
Message-ID: <4c6be204-8afe-bb42-a3b4-ea03f696231c@gmx.com>
Date:   Fri, 10 Mar 2023 17:14:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-6-hch@lst.de>
 <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
 <20230310074723.GA14897@lst.de>
 <17c86afa-41af-a8d4-094e-81f1d47e8788@gmx.com>
 <20230310080331.GA15272@lst.de>
 <3f4ec877-4d19-80a8-1dcd-84fbdbd54745@gmx.com>
 <20230310081509.GA15515@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230310081509.GA15515@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wsoEd+z8AznJz/tgc72VpMCwdAzfQJcLL1mSBhIdX044bkBWUba
 uwa2Ae7ozWJ89vB/uQJ5xj2RpQf+ShClWKifIeB13qNsUQr3jjaRw/48rCmY74F1A5QnSCj
 9hjj41T/LU67QtIx6C/xVebkFNAnR8m1rnvpbGObUPkirbYY0SEO3DBcvmpSY9zuqHfx5Vv
 DhCRP6CsDEn9H1ZNG8jAA==
UI-OutboundReport: notjunk:1;M01:P0:d/znhvTmKRU=;inunaqKhZfYzXP5B6T67SMhvJ/L
 WkaYQEEE23wN6yKNPqNfiYANWSidx3AkHxdFt1KKcdCDMZ/sKCAxdT9dCmXPgSPr5Xj/Xp/Mn
 d+ZOw3Zha4FLtQjhhO/pl+b5UN+YLNYV93a98lQe9NBSPVDIXJ06HKHaLZHmkZProLq/4uLc+
 SATSuPWBHJ2Gbe7rrUwVM6iXAGNdMbOBQfu3pgzw58mQ/oBwfhX5r00v6+g1r05kx9PaqCqoq
 IdUU42sOeaCi74OMzHCYcQXkC47JOBh1Gi+VDKhnCe5JGUMe/YgJ2uFCkKzPRgNRlmsR5kVM0
 a4m9ytYC/2abek/cTSII6ckEATVjhMso+j7vhyAFTQ1GJNBPpWtkfZ/H/RJBifdUo/yTRWDDs
 PAtvhk1bn/+HQob/2yw+kwdaruAxvsNOo3t/JYrWx9hF6hD6GDiNruVPgoezYKVGfnGyS1Tb+
 qghciuXBsaaxvWGpXhREEgWC6GIykV+EqNqR2l43mvJ1ic+frqPBmp5JeIu89LsnGia0Iq7NY
 UCH4LzfX5FGIABIVK2euatJkrTTV0/tjNjRC/hiXd4iE6m7gjsNh9PNEc0vJDAdhOoqq6caZU
 6zWSqBRnintLXjXuDvDzNgrM4exbNCIwsUfzhA5AeZbbl1KqWgzLBdpO+tYEwJ4ANJe6Dei7R
 18nsn9GwM7uqWactSnMs0bdYAOGrl3XcfhzrOCLc3DcTRD7wOyzvxqiX/VEhAf2tqGERS7CEH
 1Uz57SI8Vf2SJClkccgceniJEVpBUlAr21N8PG2cptKk8mIiXw16s4I4e/1Pqki6bd8LeHK94
 5s4RQNBcQl8J29Tg+U/Lhm5jYWqGx5ROIEIS6rpTIS9BGQ0yBhEhPC/PrMJdeLY3j9eXJ0txK
 vEC0WsCkRQySQ7eSQNredyZ+ToT8cJ6TK10TSD6qHwCikJ+4KrpOWAMk41Y3EjC1rBb6gJJoN
 ByPWUNokuGgNg+FThNm+2DOe24k=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/10 16:15, Christoph Hellwig wrote:
> On Fri, Mar 10, 2023 at 04:07:42PM +0800, Qu Wenruo wrote:
>> Yes, but you don't need to spend too much time on that.
>> We haven't hit such case for a long long time.
>>
>> Unless the fs is super old and never balanced by any currently supported
>> LTS kernel, it should be very rare to hit.
> 
> Well, if it is a valid format we'll need to handle it.  And we probably
> want a test case to exercise the code path to make sure it doesn't break
> when it is so rarely exercised.

Then we're already in a big trouble:

- Fstests doesn't accept binary dump

- We don't have any good way to create such slightly unaligned chunks
   Older progs may not even compile, and any currently supported LTS
   kernel won't create such chunk at all...

Thanks,
Qu

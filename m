Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0686C5FB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 07:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCWG22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 02:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCWG2Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 02:28:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11AA1EFE2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 23:28:23 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6R1-1qDT3Q31Ah-00aF1S; Thu, 23
 Mar 2023 07:28:20 +0100
Message-ID: <0a96db1a-84a0-5fc5-3e92-8824c29907b9@gmx.com>
Date:   Thu, 23 Mar 2023 14:28:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <20230321000918.GI10580@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230321000918.GI10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iDRpfvHnXFZMfN/Qpu/JiRbZSfre7H0YAp4oEI4cf/aOjX9U35b
 ZKFaFB0P1C3dvz3snAxqHLV7tt8/y1OQmL8jNju8Z6u3ZMVJ7/F1efu+AEB/BgV8GCFbk8t
 KwMZIuUOgnTw5pkOHg73OyLXb9+7DgDsbkp/Fa0IkN3h/Xk7WUg+abGg7ldUOzlDDjvF0nj
 J00z04fjxLDSr9+hP6VUw==
UI-OutboundReport: notjunk:1;M01:P0:Ka32lbWIn5I=;k99X1p7t6TWpQMwu4Ut0hcGJ/W6
 TrGeDK7TU9YJsXryTiuLc1ihWaxEK1O+ro6P2+U4/oxY0Ckoj5/RreC31U0QHE264oE7HPddP
 q3iy25fQlusSxhPPcPUT1bLh55n047TnLZDftCYdeCn+q7rBOqJD/i7u6e750qvQDcF5PEJI4
 6i1uCpW47X9lZGm95ls7aiAXwrU8nj5l9JfZ+ls0crj4JtG8Gji+5tM30E9HgvWQbNlfmMavx
 RxFObJ3GIZJkmuuRtULKyn6of47tm1t1eJzrAVA5MaCNrmgja84pvU7y7TAAiaOAyovrY8xKg
 iT8feOrrOYufpvGSi2EX/jFzjPRD8gDu/JEpQ5Ahh5mZtcjInox+qBfwOTZ2G4A4ZZrUrzNZ9
 GQmpAofNBErqoeNNCjwJqVn7MuZgQkdrEIa0VE/QkwOMYl23PGcNCBTlw2jw5oJIA6oCg1yKi
 gjLBD82QEExzGpUq2aRifKKEixlf9ARgLpwqAsJpBCNY7CN18gFVaYh24nGQ0M9eqsqNmmlbg
 BOyyC9efc3e9Jq7pr0PpvfXYlUaCKlAIe/gHTc4kg31drJDIBnrBWvSRywpoJCXAdg+Nj7ie3
 GGRXjobURFvPpteMp6UZegaqmJpki3/8qMm2Kaup7iOOmaaUxvUk0EM+1eo8r8VMMbzuWoA2R
 Mixb+pKp9nQNntYxSyfmqeJ1wj4PgbyTUPiS/YTjsZLUyVLaF4z9crWaxmSYkQOanTIJvU3Ce
 F1KsqZH9WUtXRHijxP9FtoXiX/D0LLQOVrvr2kwa2JutXcmjh0mJGKnNbJ0beZQHGeec8vYzd
 9yEsoRiWzCBoSjV4Lss15TMoj4ncya5FpGd/P80QSrHDkg5x4BQcTkfWugPeW7i5eUZqGu/w0
 qJmVS0h45yr7bvr73FbzxluPVCqqXuEW5q7Zp18W++9JixbTT0J1l1VKOmrmAiENmzPsm2CRa
 bAAhzmDeH7Rx1RcZc9iJUxuHEjA=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 08:09, David Sterba wrote:
> On Mon, Mar 20, 2023 at 10:12:46AM +0800, Qu Wenruo wrote:
>> [TODO]
>>
>> - More testing on zoned devices
>>    Now the patchset can already pass all scrub/replace groups with
>>    regular devices.
> 
> I think I noticed some disparity in the old and new code for the zoned
> devices. This should be found by testing so I'd add this series to
> for-next and see.

Just want to be sure, if I want to further update the series (mostly 
style and small cleanups), I should just base all my updates on your 
for-next branch, right?

Thanks,
Qu

> 
>> - More cleanup on RAID56 path
>>    Now RAID56 still uses some old facility, resulting things like
>>    scrub_sector and scrub_bio can not be fully cleaned up.
> 
> We can do that incrementally, as long as the raid56 scrub works the
> cleanups can be done later, the series changes a lot of code already.
> 
>> Qu Wenruo (12):
>>    btrfs: scrub: use dedicated super block verification function to scrub
>>      one super block
>>    btrfs: introduce a new helper to submit bio for scrub
>>    btrfs: introduce a new helper to submit write bio for scrub
>>    btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based
>>      interface
>>    btrfs: scrub: introduce a helper to find and fill the sector info for
>>      a scrub_stripe
>>    btrfs: scrub: introduce a helper to verify one metadata
>>    btrfs: scrub: introduce a helper to verify one scrub_stripe
>>    btrfs: scrub: introduce the main read repair worker for scrub_stripe
>>    btrfs: scrub: introduce a writeback helper for scrub_stripe
>>    btrfs: scrub: introduce error reporting functionality for scrub_stripe
>>    btrfs: scrub: introduce the helper to queue a stripe for scrub
>>    btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe
>>      infrastructure
> 
> The whole series follows the pattern to first introduce the individual
> helpers that can be reviewed separately and then does the switch in one
> patch. As the whole scrub IO path is reworked I don't think we can do
> much better so clearly separating the old and new logic sounds OK.
> 
> One comment I have, the functional switch in the last patch should not
> be mixed with deleting of the unused code. As the last patch activates
> code from all the previous patches it would also show up in any
> bisection as the cause so it would help to narrow the focus only on the
> real changes.
> 
> There are some minor coding style issues I'll point out under the
> patches. I'm assuming that the scrub structure won't change again soon
> (the old code is from 3.x times) so let's use this opportunity to make
> the style most up to date.

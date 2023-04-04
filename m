Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821476D55B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 03:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjDDBIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDDBIl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 21:08:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20B01FDA
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 18:08:39 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3DW-1pcqGR27bs-00FPqM; Tue, 04
 Apr 2023 03:08:36 +0200
Message-ID: <25f1df54-9abd-d4e0-7dba-9b341bc4ad6e@gmx.com>
Date:   Tue, 4 Apr 2023 09:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1680225140.git.wqu@suse.com>
 <20230331161716.GV10580@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v8 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
In-Reply-To: <20230331161716.GV10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/5dO6R4ATlGViReCBMxtZFExhprOC6wtoOn5o2oEp9Im3ntfuXq
 eKmyb72ZY9yRphMtE4WtlVOAgV2EW8B//WSF0/ks+8BhEndX/hGB3mnGftCtDcXHCBybC1h
 HtVdoo4zv8/DCJGGj/zf9k9a7eRVUGWt6UwBQIfWvxRyTt49XIQQSgRXlMITFW1Qa3LlD0s
 cZZa4B3DDW5LpxYXKIqdA==
UI-OutboundReport: notjunk:1;M01:P0:viDWnFb9ukY=;uNrFsXUMEJHoyxXe340iQe+SdLy
 Xwy4vtWaWqyKL2o5YjCiWmV6N9SmhW0h/E00fuKbC9TbzrvwZSLLWKeMq5DTpe1ToHYc50CZ+
 S7xlI1rcXgGKy9LtlIrQI0vPrcQOOVaHK0WnWhoCpOu4tvu0ZxufN018thSPUn1tpIZ6sZ61l
 NN10F+SVJt1Qptyp2eBfEFNmFI98M1BuqlkLdmRZR+FJkMcWUemHo9p6zD99UUUVezMHtO7MG
 vdUy8nSgP6dJQFr+HeWnKfKeQtQh1FVpKkJAxGHCk1pksD+2KoOnaXGOsfY8NsUithEkjIWSS
 HPaP+Do/k2B6bmJPn5kQxerPbjNLszmemw8/m1E3a2SvLo3vcbIXS/qNBzi7tSdVurJdVaaL7
 lfvS6/eLNCCn6CWviZYN016OWAKuGDmYfBc5YD9rYqSuwHlEl0IjsYpyB05N6OatDwj1OILnH
 s9rGyw1l0kUitMoKeyU8jrrXE50VapfX/Tkmjr7vxwWdAe1SOTqD9C0tKyZN6uISIkHKE/aCR
 MZ7S2/kU7acO7EUvLHtpMtceZqnsuWmZu6fzndjsqmyhnuoXN8tAwAhLBULqdTTndsUpzLCOD
 14MAN+CYZb6DlHbJ6tWFPf8CP2Prf2bqxUh7X9N8tAhG9e3PsBtub7NkkftYgMIZGmcUv2OyM
 ABPhcGO+vW/oJMRKJCYS5cfywAY0EZCxyK1Jh/9ShYBXxeRR2OvCOzKKjUmvCeNM6ohzcgbXg
 uiA8CoRJIL71eG9xpVlOssyu5hx+7YhZrI8saWchDffP8NlfJJhtSujxmGeO3GF3BT9QeMTa0
 StPhiR21zOIpedPTShrmjooso2jxjuMfs4/J6R+jxMGNmJcWRZXJWHkTCI93gbndyA6GgbF2B
 icgM9yHWS+PHptWUz009vELohUqey8OTi47ZXZNi6P3CfROLAt/f0VoXoeaJNpA+Vm5PFIOw/
 etHjynJdmdlzhaoU/B9TrhHojeI=
X-Spam-Status: No, score=-2.0 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/1 00:17, David Sterba wrote:
> On Fri, Mar 31, 2023 at 09:20:03AM +0800, Qu Wenruo wrote:
>> This series can be found in my github repo:
>>
>> https://github.com/adam900710/linux/tree/scrub_stripe
> 
> This also includes the cleanup branch so I'll use this as topic branch
> in for-next.

Thanks for that.

Just some questions inspired by the series.

[WAY TO CLEANUP]
Just want to ask what's the proper way to do the cleanup.

Christoph mentioned in other subsystems they accept huge cleanup as long 
as it's only deleting code, while in my series I did the split to try 
keep each cleanup small.

But the split itself sometimes introduced dead code which is only going 
to be removed later, and most of the time, such new code makes no sense 
other than for patch split.

So I'm wondering what's the proper way to do huge cleanup in btrfs.

[FUTURE SCRUB UPDATE]
There are still something I may want to do improving scrub.

One such objective is to enhance RAID56 scrubbing.

In that case, what branch should I base my code on?
Normally I would go misc-next, but the new scrub is only in for-next.

Thanks,
Qu

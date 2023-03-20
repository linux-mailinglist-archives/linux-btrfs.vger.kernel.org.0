Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA96C25C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 00:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCTXjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 19:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCTXj0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 19:39:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B525E16
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 16:38:52 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1qEpsx26IX-00anAq; Tue, 21
 Mar 2023 00:37:51 +0100
Message-ID: <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
Date:   Tue, 21 Mar 2023 07:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-4-hch@lst.de>
 <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
In-Reply-To: <20230320123059.GB9008@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:scgquC6bBRoJoFtCnU1+J7jfrvZN48eFjZaRVL7V6JpeFqGGQxd
 1OMjgyKDiaWHshbDwfyDP4LB7e3Me2VXSPvocsfuADPiIFg5BuRrc1Bt6yoItr9kZ1qy3hb
 FgcDaftbyhFkdjGwAuyxm5zDqCy87m9LDfItfvfQA39mbbpAyNOYUwe46XHgYWeswTRgddw
 sU5hkBau7jA+yDr5QkeJQ==
UI-OutboundReport: notjunk:1;M01:P0:srOGr1we/Fs=;5xOnVNLx8cz+eM4lTkMjZOc7gMN
 iU1V8E9O+QlkLbNeRj4CFgx/SPhF7DDAr0Rizp02ZzaSaLpFTF0rbfqyYs3pEzxB1bcgLKRkA
 ISbDtuoAIetN0g/WlrD62gafvGNPx0J1d8J7SQImHurtDJakQewVe1Xpfg2V9iC5Vs7+oJC/m
 Dw4xPFxSnpxoJhrsoDRSy2mR3fIDBfz1iXIYNxeVHspmhpfoyMefj+lminWisY9Lw2F0VeTr8
 DQSaCMYzdtBlnP1/azxYgIF1FJuzH7d+UTtSGoT53Bn8q7zflDtsDzl3kLWp39aihxDKGU5Ot
 PBAmjHwh7gl/CVoKGI+5BeLjNrRRLhZAhws3xme6Q5MTXm7kTyo82ORkMM78agr9BVpbK66JG
 6J6WeC8S6N5qBFn378YWAo4sQkSQGuypGJNIBtILg6ecTTBpfM7R1qebg7NVFVH1MwcgxAZSc
 UFMMdP97ANIDTgFXunQOBT9gS+Yw/WzElAHbz52PnlHsCR3eL8eO1KL+bpdCa3pHH7AvM0py4
 Ls3+bzk33OQGGvVD+OOjzHNFsnxM6Z832V7tNERk2QvUSPBweCbEFXKpfFKCE8/XKzB9Av5VS
 p+lMB+hs84RDrkGV4EDeC2auOmFsX/6qIExIDPtrKIyJ2kqsxdlhDM/C/VcIRV8ee/5KYH0dE
 p2SJ2JGydauQ2EJow0pXPHg7KKYwTAPRg1BVsdOt5AWcGYEbufxcLOxqn0XiqqeEambizHd3v
 hqdXViLnssJ4MjZV2NH8WlwKa4GpPSDea3DeYDiVmWEyemqg7HLTtFuOtWIOxrvwaSC98mCxv
 Mv4KbFy5KKUx5wEXETCiM+Eqgg6n3+BhfOJ8dX6cPYpn/hKRxpTcvZ6ErIOnFIVp8YJvgIPYM
 VtyL00/CnvtnqT7tGiQgjW/rvazZxIDAbhHLHahGSjHaXlirr+Jop3vGAaep/moydnKgOTh1b
 rDRsgLJj8cPGo3ja5SxKeQhD5FI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/20 20:30, Christoph Hellwig wrote:
> On Mon, Mar 20, 2023 at 07:29:38PM +0800, Qu Wenruo wrote:
>> Sure, they are called in very strict context, thus we should keep them
>> short.
>> But on the other hand, we're already having too many workqueues, and I'm
>> always wondering under what situation they can lead to deadlock.
>> (e.g. why we need to queue endios for free space and regular data inodes
>> into different workqueues?)
> 
> In general the reason for separate workqueues is if one workqueue depends
> on the execution of another.  It seems like this is Josef's area, but
> my impression is that finishing and ordered extent can cause writeback
> and a possible wait for data in the freespace inode.  Normally such
> workqueue splits should have comments in the code to explain them, but
> so far I haven't found one.
> 
>> My current method is always consider the workqueue has only 1 max_active,
>> but I'm still not sure for such case, what would happen if one work slept?
> 
> That's my understanding of the workqueue mechanisms, yes.
> 
>> Would the workqueue being able to choose the next work item? Or that
>> workqueue is stalled until the only active got woken?
> 
> I think it is stalled.  That's why the workqueue heavily discourages
> limiting max_active unless you have a good reason to, and most callers
> follow that advise.

To me, this looks more like hiding a bug in the workqueue user.
Shouldn't we expose such bugs instead of hiding them?

Furthermore although I'm a big fan of plain workqueue, the old btrfs 
workqueues allows us to apply max_active to the plain workqueues, but 
now we don't have this ability any more.

Thus at least, we should bring back the old behavior, and possibly fix 
whatever bugs in our workqueue usage.

> 
>> Personally speaking, I'd like to keep the btrfs bio endio function calls in
>> the old soft/hard irq context, and let the higher layer to queue the work.
> 
> Can you explain why?

Just to keep the context consistent.

Image a situation, where we put some sleep functions into a endio 
function without any doubt, and fully rely on the fact the endio 
function is executed under workqueue context.

Or we have to extra comments explain the situation every time we're 
doing something like this.

Thanks,
Qu
> 
>> However we have already loosen the endio context for btrfs bio, from the
>> old soft/hard irq to the current workqueue context already...
> 
> read I/O are executed in a workqueue.  For write completions there also
> are various offloads, but none that is consistent and dependable so far.

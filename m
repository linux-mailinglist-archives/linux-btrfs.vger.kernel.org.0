Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB06C258B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 00:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCTXUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 19:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCTXTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 19:19:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA65E1AF
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 16:19:46 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1pxa641vUc-00JLzR; Tue, 21
 Mar 2023 00:19:35 +0100
Message-ID: <675712c0-ac72-f923-247c-31f0b22a8657@gmx.com>
Date:   Tue, 21 Mar 2023 07:19:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-2-hch@lst.de>
 <c797c695-cd20-9ab6-7b12-19e43ab1069c@gmx.com>
 <65e3dc23-6e86-dc4d-0a1b-2ec69060dd44@gmx.com> <20230320122420.GA9008@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230320122420.GA9008@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZdK3YEfcjMQ3zYVX3AbgkZgluaaUol1yLBieBpY2XTmFdb54Ibz
 pFGSb/IrEggjEZkFjidEbVJB48Qv06+f+kdZmugDJ+81yDUK81rJuXTZhwbGyYESRD3VkPe
 SdOWbvCApA625xm8OhQ6SUWPlOruJUyVb3UPto5+gpFMep+gTRmJGpjKp+neTW68KNIJ8O4
 qDyPTLT0rHFzsE1b1oy6g==
UI-OutboundReport: notjunk:1;M01:P0:ds0LmzeMpRc=;Opxj1K06LzqBlEfIPOIyjFBihrJ
 3dvKKF8zx/p3dFYLrh9gdBkgH/yyML51tonziZwPw4Uq3msbc3yMpnpzqiWC5fgLYQRHf09Ht
 f6qlbuZst8pmfcn4fwGYHTc4/yWAmUux+JvNJS23Hq6bf3Irzk9H85KWomnRXvgweSfM/uZD4
 bppGP/slHmbzvc3klZAIXndWFfjRWDiddKxHkE7d7F+Cfq9lXzWlA5yYroFF/DlQ6tjv7jMFE
 /9qluooo+Rxx0zJm6ec5YF+MOcPJ+NhrHLGp2r0OPKf7nGvQiUEPFQIP0E/fSTr1zISwenOkF
 jvDIepERh+IC5+ReY1KvDVUIoln1dSrHJYbcIovjmeSvj3x5GlSogbucG3MRRAHXmYvO5bUhQ
 cJmNQocDtYFtWpmeejtcse9KsWGy4lIXqqe/qlVJ/ezIvE1OszQxRff4Z61X+aWk59oay8fP3
 HemFrtweYGG6axCcVe4tCYSWTCvdQk1MWwi8gbEBpmI5uPsJnm2CqMCwUu9kb2RaRQcQTVCQ+
 gFyfcwCVBk9UNY68hvusGvIUUmN4+0WLDQwkQRWbv9N/QKTQlKOxME47PDo9Ky0ANm2vuzYbs
 NaEuCxE58bFPVMNs0WnAnGUUw9EFFY9CZMW1o8t0FW1hlMnbqn3es0pWhczPLul+4grFwFX8F
 U+m4Zf7dqjfoZLcC8zOvSqEYJC0axuv9eYG91nItByQ2tf6jKjwXqsHaS6WZjs/JsFo/qK2G1
 HYFPAqNDIt2o5cV2M/0o4x7x/RzMVG+M9PuWpJIPg4FV61ArOKfO9sx2XlxKrmgAcm/OpHtx5
 gOPAoYv2gU1/2pBoVb1sQYuTdPFu2J4rJVAXW4SSHGlNAt6kiiT8vDdKasQnvFRXufv/pbQad
 cayjBhpXginVy+iBVF1l94XNjEBrS2SCwps5Uyc9FcThY3Vb/bkuEX/Vfo0zR44f5l4IRMulY
 0Fzx6bEK64zcrFMN4rgddCotUK4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/20 20:24, Christoph Hellwig wrote:
> On Mon, Mar 20, 2023 at 07:35:45PM +0800, Qu Wenruo wrote:
>> In fact, I believe we not only need to add workqueue_set_max_active() for
>> the thread_pool= mount option, but also add a test case for thread_pool=1
>> to shake out all the possible hidden bugs...
>>
>> Mind me to send a patch adding the max_active setting for all plain
>> workqueues?
> 
> I don't think blindly doing that is a good idea.  As explained in my
> reply to Dave, going all the way back to 2014, all workqueues hat had
> a less than default treshold never used it to start with.
> 
> I'm also really curious (and I might have to do some digging) what
> the intended use case is, and if it actually works as-is.  I know
> one of your workloads mentioned a higher concurrency for some HDD
> workloads, do you still remember what the workloads are?

In fact, recently we had a patchset trying to adding a new mount option 
to pin workqueue loads to certain CPUs.

The idea of that patchset is to limit the CPU usage for compression/csum 
generation.

This can also apply to scrub workload.


The other thing is, I also want to test if we could really have certain 
deadlock related to workqueue.
Currently thread_pool= mount option only changes the btrfs workqueues, 
not the new plain ones.

Thanks,
Qu
>  Because
> I'm pretty sure it won't be needed for all workqueues, and the fact
> that btrfs is the only caller of workqueue_set_max_active in the
> entire kernel makes me very sceptical that we do need it everywhere.
> 
> So I'd be much happier to figure out where we needed it first, but even
> if not and we want to restore historic behavior from some point in the
> past we'd still only need to apply it selectively.

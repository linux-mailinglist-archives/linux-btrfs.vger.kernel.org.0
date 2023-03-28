Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0706B6CBB3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC1Jjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1Jjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 05:39:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D3261A2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 02:39:35 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1qfEY50l0Z-00zWzl; Tue, 28
 Mar 2023 11:34:07 +0200
Message-ID: <2dfc49ef-e041-3efd-1c55-3685df22acb6@gmx.com>
Date:   Tue, 28 Mar 2023 17:34:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1678777941.git.wqu@suse.com>
 <ZBF5M5R3pDdp/075@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
In-Reply-To: <ZBF5M5R3pDdp/075@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:q86JIrmUMzWpHZP1nJFUv2qrLYpt8F4LianZfNkFJBbwy4cUXu4
 JxKafn6cNr/IrFiI0ArHOcFAmgZMqFn2iXJF+mDVsRtxLgS2zSIGcQj08ag+lQnJKtHB9IA
 pBtgPeTIwVxoBdWL5G5XAcCXNLcoumTHP9RsGtcshtaYG/tVqd+6q/Ftq1HTh96mmp9gI37
 wybvm1fg8pCzwNqzPfDQQ==
UI-OutboundReport: notjunk:1;M01:P0:sbkjqpOHVt4=;ELyvcdF0yGfG0Ec5rF4zW+P2Qou
 ZESF4jFpegUG5NQkMrkWPHOLTf9a/cFjCQYlkvnr/LUK5vxqhLxWwZlfOPVI98j+yLWz/Z7WX
 87eOYycXBOdBTwUCQwya5jhpPiVZjxly08E0apH1Pmcwp5MQ11D7neo+iYe6aNVmnbDafzT0n
 480One+Tj+Sa94ofBR3U8iM2pUBcENhhfGCVYvMpkX2kTxcGY+jF1OL1dqjhsHyDiOZEMSpPS
 760f92aXTmypQSe96qpvBWZAB1DW/JMTUX4KKlpDxHtkEYAO8o4p85Tbk7lF1ic8Ec87fi/7o
 UKdcA7+dvKBJbKJuByjwh4BRmg8ZMdXjIkJn7N6mfhf9njeJTVcGuR3s2CYfh6bSzftSy0xfN
 UH7g+VrASU01ZZr2feA/2odbjVGra4wUDZ0iIh3fYGERySqQ3Xh3nFBG4F6+tgofrQeHqrzOm
 e3F9LriHMurIVQOBiHOXdrULbbwjJzsRsnFJZU9wLhNwB6Qs0olBTUUqz60SCosK4xjBEEW/H
 j5EtXbc4NcYboCZTYN0x7TGOf/4DKL4faRWLBW07n9hXsZCk5WWQQTv+P8QGwVVX8QANp1YG+
 7TcOxaTrgXv3rwRhGO+HLNtfKaIstjsUQuF7fOtdVy0yK4Z7FmqEgIeCZqMHlNNNq8Dq8tKQt
 PyXKvVtwLVGlffRNsq13QyP7P7EvDDCHcJGSL1lqWt0fpsNNR+TMWn9YODYF6mdBaDJWMeNui
 7KGcXaKdQ1kv9aWlcx3QmD9/oOnoBZLNUNpCbM2fSRCI7HkgUJxt9w1T33+DRmGmAftWphiE0
 zOHlxciXkKyVY+F+SnkC27RLtrJlfMDgYArGZc/wYa5FYQak30YCsSJpTEi1CPBCOYNhbnWfh
 4AF0vCYWDVAC4qJsvJbs2eYMXOVFkv5uWXr6QE3Svn0ZFbkJJTbuuU856cMAQrQ6NPLlGT3zS
 fop/LDhIyAKHS63+XkUKuBGALGI=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 15:52, Christoph Hellwig wrote:
> On Tue, Mar 14, 2023 at 03:34:55PM +0800, Qu Wenruo wrote:
>> - More cleanup on RAID56 path
>>    Now RAID56 still uses some old facility, resulting things like
>>    scrub_sector and scrub_bio can not be fully cleaned up.
> 
> I think converting the raid path is something that should be done
> before merging the series, instead of leaving the parallel
> infrastructure in.

BTW, finally I have a local branch with the remaining path converted to 
the new infrastructure.

The real problem is not converting the raid path.
The patch doing the convert is pretty small, mostly thanks to the new 
scrub_stripe infrastructure, we can get rid of the complex scrub_parity 
and scrub_recover related code.

  fs/btrfs/scrub.c | 168 ++++++++++++++++++++++++++++++++++++++++++++---
  fs/btrfs/scrub.h |   4 ++
  2 files changed, 162 insertions(+), 10 deletions(-)

The problem is how I cleanup the existing scrub infrastructure 
(scrub_sector, scrub_block, scrub_recover, scrub_parity structures and 
involved calls).

Currently I just do a single patch to cleanup, the result is super aweful:

  fs/btrfs/scrub.c | 2513 +---------------------------------------------
  fs/btrfs/scrub.h |    4 -
  2 files changed, 5 insertions(+), 2512 deletions(-)

To be honest, I'm more concerned on how to split the cleanup patch.

Thanks,
Qu

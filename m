Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40176BC672
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 08:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCPHCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCPHCo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 03:02:44 -0400
X-Greylist: delayed 84972 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 00:02:41 PDT
Received: from mail.render-wahnsinn.de (static.104.84.201.195.clients.your-server.de [195.201.84.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206EDA8831
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 00:02:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C7527EF34
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1678950159; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=0fftNPVhmEy/BZ9qyLhMzDxf27UL4yCh8gfSzaMqsQA=;
        b=fiViqJHQ2/meug+hY3q2/mNfgymuAmKWedieqnx0aut99PRpB09RND+bFf/g7OWLWVpePt
        RozHH4oZJDu737dma0IrjFHFRQbaI8CdLnXy289WErHNTL7cpUghb0eBt8xHgE2tIu/TEG
        lSSAQP3h1wOjsWzjvcUz48bV2qNu7kiGEWL7ROIG9ABLNRFM0Dt2jQtskM5mCztKTzBnaB
        qdAY9+SNCfnmTMpZl5Kb7lMgfNGLEKmowy5QndD+hac7dE0jlRyN5Y5y7doSLzCoQSRCYM
        xBEM3aBKOS8rDPUWIeXWy+5DTBuX4rQzbPECdwqY65k/FvrvvXICGWiyctoomg==
Message-ID: <2a0c8279-9521-2661-056f-bc5560094356@render-wahnsinn.de>
Date:   Thu, 16 Mar 2023 08:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Btrfs Raid10 eating all Ram on Mount
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
 <8121e6ba-f6e5-77ba-8a82-2c65d271c115@libero.it>
From:   Robert Krig <robert.krig@render-wahnsinn.de>
In-Reply-To: <8121e6ba-f6e5-77ba-8a82-2c65d271c115@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There were quite a few snapshots that I deleted on that system. But 
those snapshots were probably heavily de-duplicated since I was using 
the beesd tool to deduplicate the filesystem while in use.
At the moment, I just want to copy off some data from that filesystem, 
since that server is going to be cancelled.

Could I just mount the FS readonly, would that prevent the btrfs-cleaner 
from running and eating all my ram?




Am 15.03.23 um 19:48 schrieb Goffredo Baroncelli:
> On 15/03/2023 08.26, Robert Krig wrote:
>> Hi,
>>
>>
>> I've got a bit of a strange situation here.  I've got a server with 
>> 4x16TB Drives in a RAID10 for data and a Raid1C4 for metadata 
>> configuration.
>> I'm currently retiring that server so I've been transferring and 
>> deleting snapshots from it.
>
> Deleting a snapshot requires a background process to release all the 
> resource allocated on the filesystem.
>
>>
>> For some reason, this server (Debian with kernel 6.2.1) suddenly 
>> starts eating all of my ram (64GB). Even if completely idle. I see 
>> that there is a btrfs-transaction process and a btrfs-cleaner process 
>> that are running and using quite a bit of cpu.
>>
>> Basically, even after a fresh reboot. Once I mount the array, the 
>> memory usage will slowly start to creep up, until it reaches OOM and 
>> the system freezes.
>
> Could you share some numbers about the filesystem, like the number of 
> the snapshots deleted, the number of files of each snapshot and the 
> kind of workload on the filesystem ? This to understand if 
> 'btrfs-cleaner' is busy to 'unlink' the shared references between the 
> files or not.
>
> Unfortunately btrfs-cleaner even if interrupted by an unmount, 
> restarts at the next mount.
>
> Hoping that you had encountered a bug of the new 6.2.x series, may be 
> a downgrading of the kernel could help. But before doing that, wait 
> some other comments by other developers...
>>
>> I'm currently running a read-only check on the system and as far as I 
>> recall, I've never enabled Quotas on that system.
>>
>> Does anyone have any idea what's causing this, or how I can fix it?
>>
>

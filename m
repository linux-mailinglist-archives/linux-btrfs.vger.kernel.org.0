Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC358294F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiG0PJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiG0PJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 11:09:13 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A831DC6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 08:09:12 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 284638006E;
        Wed, 27 Jul 2022 11:09:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658934551; bh=U/UWpStK6PyKIAOCAmeP/qpa61cbWsfg5PUE6AHb5lw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=lTItA+8JYDXhs4a/SmvF0WwYpoi0uO98MoFzmBdjcl6fehK42GFOAM3Wmh82a9aN3
         DGtf7fKxyEuLJS41pIpQsIoLa5zJXk375gtbBKHv77bKcB+MQqCgl3D0cFRWbl/ZZ7
         PphBqSTLak53Q2XWx7AQMsX4a1Pi8ZdPHkI1SiVhTdbe3Io410a6IoYh8wRZEf2l3V
         60QXhIpi1FjkTsXw8ffxK81ozbVyxHcILQk/9MnCXG1PiqaKg68XTg3iMuiytrKqbv
         IuJ6Ylho/PLTTQ7PsSNjiD3Yfdq21WZ91U21QEM7LEycX9JVX5t8NrSLIoFrTsu55S
         EjNivBH5xqOpQ==
Message-ID: <05e134a8-c26e-0cd4-29b4-a9fdfdcef2b3@dorminy.me>
Date:   Wed, 27 Jul 2022 11:09:09 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Boris Burkov <boris@bur.io>,
        dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
 <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
 <20220726181353.GJ13489@twin.jikos.cz> <YuBUTX1i63o7Uo1O@zen>
 <20220726213928.GP13489@twin.jikos.cz> <YuB238MyKE0VTDtq@zen>
 <a33107a0-1207-7b56-39f4-1465a74f8fe3@dorminy.me>
 <59e228e2-9927-56a1-5fac-ab6b7e49451e@gmx.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <59e228e2-9927-56a1-5fac-ab6b7e49451e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/26/22 21:44, Qu Wenruo wrote:
> 
> 
> On 2022/7/27 09:21, Sweet Tea Dorminy wrote:
>>
>>
>> On 7/26/22 19:21, Boris Burkov wrote:
>>> On Tue, Jul 26, 2022 at 11:39:28PM +0200, David Sterba wrote:
>>>> On Tue, Jul 26, 2022 at 01:53:33PM -0700, Boris Burkov wrote:
>>>>>> Yes we shold care about readability but kernel printk output lines 
>>>>>> can
>>>>>> be interleaved, single line is much easier to grep for and all the
>>>>>> values are from one event. The format where it's a series of
>>>>>> "key=value"
>>>>>> is common and I think we're used to it from tracepoints too. There 
>>>>>> are
>>>>>> lines that do not put "=" between keys and values we could unify that
>>>>>> eventually.
>>>>>
>>>>> Agreed that a long line is OK, and preferable to full on splitting.
>>>>>
>>>>> What about making some btrfs printing macros that use KERN_CONT? I
>>>>> think
>>>>> that would do what Qu wants without splitting the lines or being bad
>>>>> for
>>>>> ratelimiting.
>>>>
>>>> IIRC I've read some discussions about KERN_CONT suggesting not to use
>>>> it, I'll ask what's the status.
>>>
>>> I just saw a comment at its definition that reads:
>>>
>>> /*
>>>   * Annotation for a "continued" line of log printout (only done after a
>>>   * line that had no enclosing \n). Only to be used by core/arch code
>>>   * during early bootup (a continued line is not SMP-safe otherwise).
>>>   */
>>> #define KERN_CONT       KERN_SOH "c"
>>>
>>> So that's not an encouraging sign. OTOH, I found some code in
>>> ext4/super.c that prints its errors with KERN_CONT here:
>>> 'ext4: super.c: Update logging style using KERN_CONT
>>
>> Some other log message from somewhere else could be emitted to the
>> printk ringbuffer between the original and the continued message. In
>> such a case, the continued message instead gets treated as its own
>> message of loglevel default. (kernel/printk/printk.c:2173ish) Using
>> KERN_CONT seems like it has a lot of potential for confusion, especially
>> if the default message level has been changed to be different from the
>> original messages' level.
> 
> Thanks for all the discussion, it looks like the current long single
> line is the way to go (in fact, the space info dumping itself is still
> two lines, and we may want to fix it).
> 
> Although it's not that human readable, the racy nature of message output
> is indeed a concern.
> This also means the old DUMP_BLOCK_RSV() function calls are not safe 
> either.
> 
> 
> But on the other hand, what if we output one line with multiple '\n'?
> Would it keep things readable while still count as one single line?

Yes, it would count as only one message, but it would break scripts that 
assume dmesg etc outputs a timestamp for every line; I think many kernel 
log scrapers make that assumption.

sample dmesg -T

[Wed Jul 27 10:59:54 2022] test three
                            line message

[Wed Jul 27 11:03:50 2022] next message.

sample journalctl:

Jul 27 10:59:54 vmcentral unknown: test three
                            line message
Jul 27 11:03:50 vmcentral unknown: next message.

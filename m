Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DF539CF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 08:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349743AbiFAGHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbiFAGHT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 02:07:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286DB958E
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 23:07:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCAD21F93E;
        Wed,  1 Jun 2022 06:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654063636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/V3AUVNF/ntyPS+pKIwLNFMmgQES/LWVcIfOG2gttY=;
        b=GPwEYePb+tff07Wm4RrHOTdf6Ilr83SJPiWEyIs/KyVDBBExbtRwaf3AhVVemj7URBSK1N
        8crLUbmQzh5h6C1ltn/OtVUcIAxjWo524isXSVinr7CQwsNGoAtXpjSYB8mXNEoRwnv4xJ
        cq7sEqsPU2gEWhzTy6FeQSzgiAT6z8s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 968191330F;
        Wed,  1 Jun 2022 06:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DonzIRQCl2LoEgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 01 Jun 2022 06:07:16 +0000
Message-ID: <d1dd5698-52fd-3992-0233-f03ce2049d34@suse.com>
Date:   Wed, 1 Jun 2022 09:07:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: add btrfs_debug() output for every bio submitted
 by btrfs RAID56
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <de8cc48c6141a20fb2ccf2b774981b150caee27b.1653988869.git.wqu@suse.com>
 <20220531144328.GI20633@twin.jikos.cz>
 <a0a1b6af-30f4-d785-a905-60a053a60bc6@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <a0a1b6af-30f4-d785-a905-60a053a60bc6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.06.22 г. 2:12 ч., Qu Wenruo wrote:
> 
> 
> On 2022/5/31 22:43, David Sterba wrote:
>> On Tue, May 31, 2022 at 05:22:56PM +0800, Qu Wenruo wrote:
>>> For the later incoming RAID56J, it's better to know each bio we're
>>> submitting from btrfs RAID56 layer.
>>>
>>> The output will look like this:
>>>
>>>   BTRFS debug (device dm-4): partial rmw, full stripe=389152768 
>>> opf=0x0 devid=3 type=1 offset=16384 physical=323043328 len=49152
>>>   BTRFS debug (device dm-4): partial rmw, full stripe=389152768 
>>> opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
>>>   BTRFS debug (device dm-4): full stripe rmw, full stripe=389152768 
>>> opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=16384
>>>   BTRFS debug (device dm-4): full stripe rmw, full stripe=389152768 
>>> opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=16384
>>>
>>> The above debug output is from a 16K data write into an empty RAID56
>>> data chunk.
>>>
>>> Some explanation on them:
>>>   opf:        bio operation
>>>   devid:        btrfs devid
>>>   type:        raid stripe type.
>>>         >=1 are the Nth data stripe.
>>>         -1 for P stripe, -2 for Q stripe.
>>>         0 for error (btrfs device not found)
>>>   offset:    the offset inside the stripe.
>>>   physical:    the physical offset the bio is for
>>>   len:        the lenghth of the bio
>>>
>>> The first two lines are from partial RMW read, which is reading the
>>> remaining data stripes from disks.
>>>
>>> The last two lines are for full stripe RMW write, which is writing the
>>> involved two 16K stripes (one for data1, one for parity).
>>> The stripe for data2 is doesn't need to be written.
>>>
>>> To enable any btrfs_debug() output, it's recommended to use kernel
>>> dynamic debug interface.
>>>
>>> For this RAID56 example:
>>>
>>>    # echo 'file fs/btrfs/raid56.c +p' > 
>>> /sys/kernel/debug/dynamic_debug/control
>>
>> Have you considered using a tracepoint instead of dynamic debug?
>>
> 
> I have considered, but there is still a problem I can not solve that well.
> 
> When using trace events, we have an advantage that everything in trace
> event is only executed if that event is enabled.
> 
> But I'm not able to put the devid/stripe type search code into trace event.
> It will need to iterate through the rbio->bioc->stripes[] array.
> I'm not even sure if it's possible in trace events.

With the trace event you can do:

if (trace_btrfs_raid56_enabled()) {
	stripe = expensive_search_code()

}


trace_btrfs_raid56(..., stripe)


I.e execute the code iff that particular event is enabled and pass the 
resulting information to the event. For reference you can lookup how 
'start_ns' variable is assigned in __reserve_bytes and later passed to 
handle_reserve_ticket which in turn passes it to 
trace_btrfs_reserve_ticket.



> 
> So I go dynamic debug, with the extra cost of running devid/stripe
> search every time even the debug code is not enabled.
> 
> Thanks,
> Qu
> 

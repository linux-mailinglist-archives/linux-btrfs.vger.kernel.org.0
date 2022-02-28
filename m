Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E143E4C656F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiB1JIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 04:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiB1JIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 04:08:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D013F52
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 01:07:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97C5A1F3A7;
        Mon, 28 Feb 2022 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646039275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ji9+fy/4nQ2V2yu33HTmuSjuovjiDFj60wHBpNysBNM=;
        b=meRXH9R0GZnLk3e9dFbFWLhDjRsn+GX+ZvXabM2tpHz9J1wtUZBQpfNOb8dCsU91uUnH30
        5oPSzvpeIWaumcpvfAHyJ5nw8Iq6Hd2Oso0xyvmVtwE3JKA87Qrvgq4Y2ECzgBgBEqXA5X
        Med5M29Qr1UFH4RW6Krqofd39EeBrNY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FB3212FC5;
        Mon, 28 Feb 2022 09:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3qJ2EOuQHGIoTAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 28 Feb 2022 09:07:55 +0000
Message-ID: <cbbcd956-968c-de3f-8817-4774d2031cb0@suse.com>
Date:   Mon, 28 Feb 2022 11:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
 <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
 <3c25d70c-43fe-cf38-33f8-05e35ceb03f0@suse.com>
 <b964eb55-537f-dab4-e8a0-1326d5ee2c67@tnonline.net>
 <90be0040-74f9-29fa-4552-57f45dbf0a86@suse.com>
 <5a8a1ecf-d8ef-7db3-7a97-3f9f29b57bb1@tnonline.net>
 <173dc4fc-21fa-1534-9e6e-d1ff4c1b7564@suse.com>
 <dfb3e621-7331-2733-1735-34d0a252e4d8@suse.com>
 <ef34c380-dfae-dc5e-17fa-efde40ff02af@tnonline.net>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <ef34c380-dfae-dc5e-17fa-efde40ff02af@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.02.22 г. 11:03 ч., Forza wrote:
> 
> 
> On 2/24/22 10:30, Nikolay Borisov wrote:
>>
>>
>> On 24.02.22 г. 2:33 ч., Qu Wenruo wrote:
>> <snip>
>>
>>>
>>> OK, this is indeed chunk discard optimization causing the problem.
>>>
>>> @nik, any idea on this problem?
>>
>> No, so looking at the code it we can exclude a race condition since 
>> set/clear bit are taking the spinlock for the extent_io_tree. From the 
>> first screenshot we can see we want to insert an extent whose start is 
>> after it's end and the difference is 1: 8590983167 - 8590983168
>>
>>
>> Since we are passing well-formed chunks as the original input into 
>> add_extent_mapping respectively into discard-related routines.
>>
>> So in order to be able to debug this we should really find a way to 
>> reproduce it and dump the state of the in-memory device_alloc tree to 
>> see how the search logic goes awry.
>>
> 
> I have not been able to reproduce the problem with several runs on 
> device add and device delete in various configurations.
> 
> One thing I did notice is that when removing multiple devices on the 
> same command line, btrfs seems to remove data from one device at the 
> time, putting data on the other devices also scheduled to be deleted. 
> This is very ineffective and means data is rewritten multiple times and 
> takes twice as long to perform, than if data would be balanced over to 
> the remaining devices from the beginning.
> 

Yes, this works as intended as the underlying kernel interface supports 
deleting 1 device at a time, so from the POV of the kernel it doesn't 
care if you are deleting 1 or 5 devices. Fixing this would involve 
extending the BTRFS_IOC_RM_DEV_V2 with supporting passing of multiple 
devices and gating this support behind a flag.

<snip>


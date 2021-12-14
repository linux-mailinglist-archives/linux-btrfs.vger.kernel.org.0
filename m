Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E923474DE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 23:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhLNWZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 17:25:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhLNWZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 17:25:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7CD7210E8;
        Tue, 14 Dec 2021 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639520704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2VJp5tz8QE9d9DblbqM8CrpkrjZKmlpSZWUCgjE+P8=;
        b=K/kKnjG5sc/fXYWFQCoNsyDou8tXPKyKiuy+78APBEVIFFhVKCxKIRJH4Jgzm0cIJlb901
        gO+hzIEWjRkbA4oBNZ4gttkRQwchTj09CBmjQ8YdHylGqVcfcU72fx9T1gACsVJo375nS2
        gxRtwEeUVIk4BHp3XyZzwfUP+KzHk3U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9934413ED3;
        Tue, 14 Dec 2021 22:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OfdwIsAZuWFNAwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Dec 2021 22:25:04 +0000
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10 vfs:
 verify source area in vfs_dedupe_file_range_one()
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
 <Ybj1jVYu3MrUzVTD@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
Date:   Wed, 15 Dec 2021 00:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybj1jVYu3MrUzVTD@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.12.21 г. 21:50, Zygo Blaxell wrote:
> On Tue, Dec 14, 2021 at 01:11:24PM +0200, Nikolay Borisov wrote:
>>
>>
>> On 14.12.21 г. 1:12, Zygo Blaxell wrote:
>>> On Mon, Dec 13, 2021 at 03:28:26PM +0200, Nikolay Borisov wrote:
>>>> On 10.12.21 г. 20:34, Zygo Blaxell wrote:
>>>>> I've been getting deadlocks in dedupe on btrfs since kernel 5.11, and
>>>>> some bees users have reported it as well.  I bisected to this commit:
>>>>>
>>>>> 	3078d85c9a10 vfs: verify source area in vfs_dedupe_file_range_one()
>>>>>
>>>>> These kernels work for at least 18 hours:
>>>>>
>>>>> 	5.10.83 (months)
>>>>> 	5.11.22 with 3078d85c9a10 reverted (36 hours)
>>>>> 	btrfs misc-next 66dc4de326b0 with 3078d85c9a10 reverted
>>>>>
>>>>> These kernels lock up in 3 hours or less:
>>>>>
>>>>> 	5.11.22
>>>>> 	5.12.19
>>>>> 	5.14.21
>>>>> 	5.15.6
>>>>> 	btrfs for-next 279373dee83e
>>>>>
>>>>> All of the failing kernels include this commit, none of the non-failing
>>>>> kernels include the commit.
>>>>>
>>>>> Kernel logs from the lockup:
>>>>>
>>>>> 	[19647.696042][ T3721] sysrq: Show Blocked State
>>>>> 	[19647.697024][ T3721] task:btrfs-transacti state:D stack:    0 pid: 6161 ppid:     2 flags:0x00004000
>>>>> 	[19647.698203][ T3721] Call Trace:
>>>>> 	[19647.698608][ T3721]  __schedule+0x388/0xaf0
>>>>> 	[19647.699125][ T3721]  schedule+0x68/0xe0
>>>>> 	[19647.699615][ T3721]  btrfs_commit_transaction+0x97c/0xbf0
>>>>
>>>> Can you run this through symbolize script as I'd like to understand
>>>> where in transaction commit the sleep is happening. 
>>>
>>> 	btrfs_commit_transaction+0x97c/0xbf0:
>>>
>>> 	btrfs_commit_transaction at fs/btrfs/transaction.c:2159 (discriminator 9)
>>> 	 2154
>>> 	 2155           ret = btrfs_run_delayed_items(trans);
>>> 	 2156           if (ret)
>>> 	 2157                   goto cleanup_transaction;
>>> 	 2158
>>> 	>2159<          wait_event(cur_trans->writer_wait,
>>> 	 2160                      extwriter_counter_read(cur_trans) == 0);
>>> 	 2161
>>> 	 2162           /* some pending stuffs might be added after the previous flush. */
>>> 	 2163           ret = btrfs_run_delayed_items(trans);
>>> 	 2164           if (ret)
>>>
>>
>> So it seems there is an open transaction handle thus commit can't
>> continue and everything is stalled behind. Would you be able to run the
>> attached python script on a host which is stuck. It requires you having
>> debug symbols for the kernel installed as well as
>> https://github.com/osandov/drgn/ which is a scriptable debugger. The
>> easiest way would to follow the instructions at
>> https://drgn.readthedocs.io/en/latest/installation.html and just get it
>> via pip.
>>
>>
>> Once you have it installed run it by doing:
>>
>> "sudo drgn get-num-extwriters.py 310dd372-0fd1-4496-a232-0fb46ca4afd6"
>>
>> Where 310dd372-0fd1-4496-a232-0fb46ca4afd6 is the fsid as taken from
>> 'blkid' which corresponds to the wedged fs.
> 
> [drum roll noises...]
> 
> 	[f79c1081-d81d-4abc-8b47-3b15bf2f93c5] num_extwriters is: 1

Huhz, this means there is an open transaction handle somewhere o_O. I
checked back the stacktraces in your original email but couldn't see
where that might be coming from. I.e all processes are waiting on
wait_current_trans and this happens _before_ the transaction handle is
opened, hence num_extwriters can't have been incremented by them.

When an fs wedges, and you get again num_extwriters can you provde the
output of "echo w > /proc/sysrq-trigger"

<snip>

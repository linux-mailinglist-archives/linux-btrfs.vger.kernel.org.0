Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C794C7B42
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 22:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiB1VCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 16:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiB1VCX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 16:02:23 -0500
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8D5DB489
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 13:01:41 -0800 (PST)
Received: from [192.168.1.27] ([78.12.27.75])
        by smtp-18.iol.local with ESMTPA
        id On9EnXFWojPTCOn9EnJyda; Mon, 28 Feb 2022 22:01:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1646082099; bh=qsqDYF20lhrP5svtfqSs/z7ORMd0h0tSgQ7J1czEZrY=;
        h=From;
        b=Ep6yVgZS65iH8AOdPx2XRJnFGtkqZrhvLUCgy8v1vxFia5X2LDA5YHYjXPs7idvQk
         JzQ9/wUWa1eLOxvKmelSreElO1RtlGV7MaKFKFLeIxjWuuInYT3zWR/zo2GRjIbm8M
         oqhYABPN7qnA0lcBPYoru3ccIaAJpWd0x9nQHvwYsBJLj7anX6Ho6KcARYxmsk5Dn9
         pr6K/6WD9yFyZS0P/3MBkzQodKYXyj3uBoCmMz8K9s2cpX0GIKyyW4pYRxWkk4uzKq
         9gig3ncO0LRQ+gI29Ic81z4PByRIel3EENcxkAHnjW8nYiy66aPnxSObUokNAhA3WN
         /04JgzM1THM9g==
X-CNFS-Analysis: v=2.4 cv=DvGTREz+ c=1 sm=1 tr=0 ts=621d3833 cx=a_exe
 a=aCiYQ2Po16U8px2wfyNKfg==:117 a=aCiYQ2Po16U8px2wfyNKfg==:17
 a=IkcTkHD0fZMA:10 a=7c-nXvJwevJccmOILLUA:9 a=QEXdDO2ut3YA:10
Message-ID: <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
Date:   Mon, 28 Feb 2022 22:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Yh0AnKF1jFKVfa/I@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCWErf1JCGkEAcT0CCVTBmTH23T31nqrtjNWmftCT1C07K7doboYvr8HA4PSc6zsMcETvSHX0rNDf57q6hAH/J24IIRVO1onbBZsaYqxPl+tp8Knt+yq
 S1LdgNq/YY04ujhgk+asLWiIvOHhEw5ngq2tSfGXKvcB2oXyw64/UGxM7uuA74jCaVfexC2m9DWZ+N1BIBgN3x3wGFALtt4EcukDxiqxChrBulZTtZ0c1F1t
 uag8B0/Ti+GhiFn2/NP3nGvKkucqI8zDY8e/BshEW2z+ldJoDWdfAzsQ38EzekG3qBy16xFv9m+3jp5d+cI5cUFyLWBPGTMQ+tEfhrQhvvFkY3vkGC/6PTVV
 fe+Kz+UOTP4j9yLGAX79X+uMZKb5DaBI/0ZhoEcCQ2bC6OwG4VZBMHa2L/t5zn2jgXik4IsJ
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

On 28/02/2022 18.04, Josef Bacik wrote:
> On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Hi all,
>>
[...

>> In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
>> to help the detection of the allocation_hint feature.
>>
> 
> Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
> down and done so we can get it merged.  The code overall looks good, I just have
> two things I want changed
> 
> 1. The sysfs file should use a string, not a magic number.  Think how
>     /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
>     allocation_hint, you cat allocation_hint and it says "none" or
>     "metadata_only".  If you want to be fancy you can do exactly like
>     queue/scheduler and show the list of options with [] around the selected
>     option.

Ok.
> 
> 2. I hate the major_minor thing, can you do similar to what we do for devices/
>     and symlink the correct device sysfs directory under devid?
> 
Ok, do you have any suggestion for the name ? what about bdev ?

> Other than that the code is perfect.  I think these two changes make it solid
> enough to merge.  Thanks,
> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

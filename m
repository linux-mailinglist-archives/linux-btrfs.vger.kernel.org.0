Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068F74C104E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 11:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiBWKbE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 05:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWKbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 05:31:03 -0500
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DF8C7DA
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 02:30:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 675BB3FBE1;
        Wed, 23 Feb 2022 11:30:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jFL_4eJkUmnu; Wed, 23 Feb 2022 11:30:31 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2309D3F8B4;
        Wed, 23 Feb 2022 11:30:30 +0100 (CET)
Received: from [192.168.0.134] (port=32992)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nMour-000MFH-JG; Wed, 23 Feb 2022 11:30:30 +0100
Message-ID: <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
Date:   Wed, 23 Feb 2022 11:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/23/22 11:06, Qu Wenruo wrote:
> 
> 
> On 2022/2/23 17:01, Forza wrote:
>> Subject:
>> Crash/BUG on during device delete
>> From:
>> Forza <forza@tnonline.net>
>> Date:
>> 2/23/22, 09:59
>> To:
>> linux-btrfs@vger.kernel.org
>>
>> Hi!
>>
>> I am running a test system and experienced a hard lockup with the
>> following message:
>>
>> [53869.712800] BTRFS critical: panic in extent_io_tree_panic:689:
>> locking error: extent tree was modified by another thread while locked
>> (errno=-17 Object already exists)
>> [53869.712825] kernel BUG at fs/btrfs/extent_io.c:689!
>>
>> Kernel: 5.15.16-0-lts #1-Alpine SMP
>> CPU: Xeon(R) E-2126G
>> MB: SuperMicro X11SCL-F, 64GB ECC RAM
>> Broadcom 9500-8i HBA SAS controller
>>
>>
>> I had 5 SSDs in a RAID1 filesystem and wanted to delete 3 of them.
>>
>> # btrfs device delete /dev/sdf /dev/sdd /dev/sdd /mnt/nas_ssd
>>
>> When about 6GB was left on the last device I got a kernel BUG message
>> with stack trace. Unfortunately the message was not saved to syslog -
>> anything trying to access the system disk froze, even though the "btrfs
>> device delete" operation was not performed on the root filesystem. I
>> managed to get some screenshots of the trace.
>>
>> I performed a hard reset and the system booted normally. A scrub showed
>> no errors and a new "btrfs device delete /dev/sde /mnt/nas_ssd/"
>> finished without errors.
>>
>> Attached images (wasn't able to send them to the list):
>> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083359.png 
>>
> 
>  From the stack, it looks like related to chunk discard optimization?
> 
> Can you provide the code line number of btrfs_alloc_chunk+0x570 and
> add_extent_mapping+0x1c6?
> 
> Better with the code context.
> 
> Thanks,
> Qu

Hi Qu,

I could only make the two screenshots as the system was frozen and logs 
were not saved to disk =(

* 
https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083359.png
* https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg

Thanks.

>>
>> https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>>
>> I can do some further tests if needed. otherwise I need to deploy this
>> system in about a week.
>>
>> Thanks.
>>
>>

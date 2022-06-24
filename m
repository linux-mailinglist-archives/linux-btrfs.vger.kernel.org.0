Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0132755A479
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 00:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiFXWqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 18:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXWqD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 18:46:03 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBE88586
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 15:46:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E9A023F8DA;
        Sat, 25 Jun 2022 00:45:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.703
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o4nD-u7a6QzO; Sat, 25 Jun 2022 00:45:57 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C8FC73F5EB;
        Sat, 25 Jun 2022 00:45:57 +0200 (CEST)
Received: from [192.168.0.134] (port=53432)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1o4s3n-0004i9-R0; Sat, 25 Jun 2022 00:45:57 +0200
Message-ID: <fae6e07f-6ad3-218c-f220-c8b159d5ec3c@tnonline.net>
Date:   Sat, 25 Jun 2022 00:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: FSTRIM timeout/errors on WD RED SA500 NAS SSD
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Mamedov <rm@romanrm.net>
References: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
 <20220624233722.05038e48@nvm>
From:   Forza <forza@tnonline.net>
In-Reply-To: <20220624233722.05038e48@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/24/22 20:37, Roman Mamedov wrote:
> On Fri, 24 Jun 2022 17:23:27 +0200
> Forza <forza@tnonline.net> wrote:
> 
>> Can we work around the Btrfs fstrim issue, for example by splitting up
>> fstrim requests in "discard_max_bytes" sized chunks?
> 
> If I'm not mistaken, those discard_max_* are honoured automatically by a lower
> level than the submitting filesystem (i.e. the block layer).
> 
> It seems like the linux-ide list (or is it linux-scsi for SAS?) could be better
> suited to hunt down this issue. Especially if aside from Btrfs even just a
> simple blkdiscard also shows trouble.
> 
> Btw, did you try lowering discard_max_bytes in sysfs, and then retrying
> blkdiscard?
> 

I have tried lowering the discard_max_bytes, but it did not help - on 
the contrary it takes much longer to do the blkdiscard /dev/sdf and does 
not solve the problem.

However, since btrfs-progs do split discard ranges into smaller chunks, 
and that ext4 seems to handle this as well, I think it is worth looking 
into handling.

The mpt3sas[1] driver seem to have a lot of hardcoded 30 second 
timeouts[2], and fixing that might be a much bigger task. I will bring 
this up to the linux-scsi mailing list to see if they have any suggestions.

Thanks,
Forza


[1] 
https://github.com/torvalds/linux/blob/master/drivers/scsi/mpt3sas/mpt3sas_scsih.c
[2] 
https://github.com/torvalds/linux/blob/6a0a17e6c6d1091ada18d43afd87fb26a82a9823/drivers/scsi/mpt3sas/mpt3sas_scsih.c#L3303-L3306


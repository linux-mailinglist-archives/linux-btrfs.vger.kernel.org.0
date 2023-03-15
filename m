Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0A6BBCAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 19:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjCOSs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCOSs5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 14:48:57 -0400
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C5017CFC
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 11:48:11 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id cWARpay655FHKcWARpYIrl; Wed, 15 Mar 2023 19:48:08 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1678906088; bh=/2nyMO9l7aycqvGK5wt/0ra6RmcJUjmDCAP+DetvJQo=;
        h=From;
        b=kKx1V7DKnfuWbJq7lcHJ8EkL4zmYO6jxIgnXWlCEGl/6k8O3air8Px3ynd0ANXhDM
         jeH6n0djQ51up2lJvJin8fOU/8AVhgE6afsiYrrJTPVilwVvrpOhoQ8vyMLRNMSFU6
         X4K22faIYgwVOewaHogBRfmTcavpwY24VJ9u5+sq1lgAey01vRKPKJ5goSTFRSPdi/
         D9Xxyaxw/WYPyDdj0mGhOOd/SpuECnoYMOjCPWQBAw8mm0D9LXWXiYhtB/FU3Gqz8G
         wdGl25RZSnlD6353yJq4/eWA6xQNQjBPM52EsVBRjDKDBasakOnhaBU8gPL4XYhShK
         JZI31WvJFR81w==
X-CNFS-Analysis: v=2.4 cv=Q7IUoa6a c=1 sm=1 tr=0 ts=641212e8 cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=rwVX8z6m4csjdQ4dzw0A:9 a=QEXdDO2ut3YA:10
Message-ID: <8121e6ba-f6e5-77ba-8a82-2c65d271c115@libero.it>
Date:   Wed, 15 Mar 2023 19:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: kreijack@inwind.it
Subject: Re: Btrfs Raid10 eating all Ram on Mount
Content-Language: en-US
To:     Robert Krig <robert.krig@render-wahnsinn.de>,
        linux-btrfs@vger.kernel.org
References: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <dd155011-37a5-b597-a3ff-db63176d8fa1@render-wahnsinn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJ8lkLWppK3VjcSKDdNlFIEhIaXypaXeiB2rIcv/R6GI1U5Rn4mJKbkdPGcurdIVik9i1vWrBONWnSwtilA7GfwITn3boQYTSualQT45rTeced3ZINV9
 rC0uAx/ark9K2qP//jOg3Ad/Yy01eSaydOQVCmLVG2PBlQlSdet7Rqv0s42QaaoEzcE7sS1RfbGEcmil8vwRHYAF3FCZjrThYGk5XaRVjfyfv0Fy0Y/8OlTd
 JzZ1G6QAVlvD5VzPy7qmyg==
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,FREEMAIL_REPLYTO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2023 08.26, Robert Krig wrote:
> Hi,
> 
> 
> I've got a bit of a strange situation here.  I've got a server with 4x16TB Drives in a RAID10 for data and a Raid1C4 for metadata configuration.
> I'm currently retiring that server so I've been transferring and deleting snapshots from it.

Deleting a snapshot requires a background process to release all the resource allocated on the filesystem.

> 
> For some reason, this server (Debian with kernel 6.2.1) suddenly starts eating all of my ram (64GB). Even if completely idle. I see that there is a btrfs-transaction process and a btrfs-cleaner process that are running and using quite a bit of cpu.
> 
> Basically, even after a fresh reboot. Once I mount the array, the memory usage will slowly start to creep up, until it reaches OOM and the system freezes.

Could you share some numbers about the filesystem, like the number of the snapshots deleted, the number of files of each snapshot and the kind of workload on the filesystem ? This to understand if 'btrfs-cleaner' is busy to 'unlink' the shared references between the files or not.

Unfortunately btrfs-cleaner even if interrupted by an unmount, restarts at the next mount.

Hoping that you had encountered a bug of the new 6.2.x series, may be a downgrading of the kernel could help. But before doing that, wait some other comments by other developers...
> 
> I'm currently running a read-only check on the system and as far as I recall, I've never enabled Quotas on that system.
> 
> Does anyone have any idea what's causing this, or how I can fix it?
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


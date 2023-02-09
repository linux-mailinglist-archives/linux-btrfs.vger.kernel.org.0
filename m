Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A73690F7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBIRrP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 9 Feb 2023 12:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBIRrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 12:47:13 -0500
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC25C89F
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 09:47:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0ECAD3F591;
        Thu,  9 Feb 2023 18:47:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IyUj6V4MbtoD; Thu,  9 Feb 2023 18:47:01 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 107F83F50F;
        Thu,  9 Feb 2023 18:47:00 +0100 (CET)
Received: from [104.28.225.223] (port=48073 helo=[192.168.1.6])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pQB0c-0002uY-TS; Thu, 09 Feb 2023 18:47:00 +0100
Date:   Thu, 9 Feb 2023 18:46:57 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <31bf44b.fe8fe284.1863749a10f@tnonline.net>
In-Reply-To: <2563c87.c11a58e.18636bcdf0b@tnonline.net>
References: <e99483.c11a58d.1863591ca52@tnonline.net> <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com> <2563c87.c11a58e.18636bcdf0b@tnonline.net>
Subject: Re: Automatic block group reclaim not working as expected?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Forza <forza@tnonline.net> -- Sent: 2023-02-09 - 16:13 ----

> 
> 
> ---- From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com> -- Sent: 2023-02-09 - 11:36 ----
> 
>> On 09.02.23 11:02, Forza wrote:
>>> I have set set /sys/fs/btrfs/<uuid>/allocation/data/bg_reclaim_threshold to 75
>>> 
>>> It seems that the calculation isn't correct as I can see chunks with 300-400% usage in dmesg, which obviously seems wrong.
>>> 
>>> The filesystem is a raid10 with 10 devices.
>>> 
>>> dmesg:
>>> [865863.062502] BTRFS info (device sdi1): reclaiming chunk 35605527068672 with 369% used 0% unusable
>>> [865863.062552] BTRFS info (device sdi1): relocating block group 35605527068672 flags data|raid10
>>> [865892.749204] BTRFS info (device sdi1): found 5729 extents, stage: move data extents
>>> [866217.588422] BTRFS info (device sdi1): found 5721 extents, stage: update data pointers
>>> 
>>> I have tested with kernels 6.1.6 and 6.1.8
>>> 
>> 
>> Ooops this indeed is not what it should be.
>> 
>> Can you re-test with the 'btrfs_reclaim_block_group' tracepoint enabled,
>> so I can see the raw values of the block group's length and used?
> 
> I dont have this option in sysfs. Do I need to enable some additional settings in the kernel for this?
> 
> Current kernel has the following config:
> 
> # grep -i btrfs .config
> CONFIG_BTRFS_FS=y
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> 
> 

I compiled kernel with debug enabled.

Is it enough to do `echo 1 > /sys/kernel/debug/tracing/events/btrfs/btrfs_reclaim_block_group/enable`, or do i need to set the `trigger` to some value too?



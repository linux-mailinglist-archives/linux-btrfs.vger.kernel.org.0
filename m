Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636B5F0B93
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiI3MTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiI3MTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 08:19:45 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 05:19:43 PDT
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47F1EC4E
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 05:19:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DE8D43FFE7;
        Fri, 30 Sep 2022 14:12:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -4.219
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OEALvKJQCCoz; Fri, 30 Sep 2022 14:12:24 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1BF903FE2E;
        Fri, 30 Sep 2022 14:12:23 +0200 (CEST)
Received: from [192.168.0.134] (port=55622)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oeEsR-000AUz-Eo; Fri, 30 Sep 2022 14:12:23 +0200
Message-ID: <093db874-03f3-7504-8fd8-488d5ce8ef10@tnonline.net>
Date:   Fri, 30 Sep 2022 14:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: btrfs and hibernation to swap file on it?
Content-Language: en-GB
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
From:   Forza <forza@tnonline.net>
In-Reply-To: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-09-27 17:45, Christoph Anton Mitterer wrote:
> Hey.
> 
> Maybe someone could help me with that question:
> 
> I'd like to set up hibernation, using a swapfile on btrfs (which itself
> is on dm-crypt).
> 
> Now I'm aware of the section on swaptfiles in btrfs(5) and their
> restrictions... and I think these should be fine for me.
> 
> 
> What I don't quite get is:
> 
> a) Hibernate seems to want an offset parameter for the swapfile. How is
> that used respectively why is it needed.
> 
> Does that mean that hibernation directly writes/reads to/from the block
> device?

Yes. The kernel stores Hibernation information (RAM contents) in the file.

> And wouldn't that be kind of fragile (if something internally moves in
> the fs... or if it's split in several extents and not one big
> contiguous space)?
> 

Btrfs will not move the swap-file once it is created, so it is ok.

> Guess I would be kinda scared to get some corruptions if something
> writes directly to the btrfs' block device - other than btrfs.
> 
> Are there any suggestions with respect to btrfs? Like not using a
> swapfile for hibernation, or is it considered safe?

Swapfile should work fine. Btrfs tells the kernel on what blocks it can 
write to. This brings the limitations as you already mentionee; no 
snapshots, no datacow, no compression and also no DUP/RAID profile.

For those reasons I usually prefer to have a separate swap partition so 
that I am free to use snapshots and other Btrfs features. If you use 
dm-crypt you can setup another lv or another partition for swap.

> 
> 
> b) Internet resources say that for btrfs one cannot use filefrag to get
> the offset.
> I found Omar's tool, but wondered whether the same had been directly
> integrated into btrfs-progs in the meantime?
> 
> 
> 
> Thanks,
> Chris.

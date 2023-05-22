Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC15F70C5A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjEVTEO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 22 May 2023 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEVTEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 15:04:14 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3FFB0;
        Mon, 22 May 2023 12:04:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2A9173F7EB;
        Mon, 22 May 2023 21:04:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JiL1dCS8CrPZ; Mon, 22 May 2023 21:04:08 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 62B483F6F0;
        Mon, 22 May 2023 21:04:07 +0200 (CEST)
Received: from [192.168.0.127] (port=37066)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1q1ApC-0007Lc-S2; Mon, 22 May 2023 21:04:06 +0200
Date:   Mon, 22 May 2023 21:04:05 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
Message-ID: <fcf1d04.faed4a1a.18844d8e78f@tnonline.net>
In-Reply-To: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Bagas Sanjaya <bagasdotme@gmail.com> -- Sent: 2023-05-22 - 15:25 ----

> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> after updating from 6.2.x to 6.3.x, vmalloc error messages started to appear in the dmesg
>> 
>> 
>> 
>> # free 
>>                total        used        free      shared  buff/cache   available
>> Mem:        16183724     1473068      205664       33472    14504992    14335700
>> Swap:       16777212      703596    16073616
>> 
>> 
>> (zswap enabled)
> 
> See bugzilla for the full thread and attached dmesg.
> 
> On the report, the reporter can't perform the required bisection,
> unfortunately.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217466
> #regzbot title: btrfs_work_helper dealloc error in v6.3.x
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217466
> 

I have a similar experience with kernel 6.3 where vmalloc fails in a similar way. I was able to reproduce it in a QEMU VM as well as on my system. 

https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/T/




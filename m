Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D733D636D05
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKWWXP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 23 Nov 2022 17:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKWWXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:23:05 -0500
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 14:22:59 PST
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84942F666
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:22:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A6F3F3F92A;
        Wed, 23 Nov 2022 23:15:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 79h5f1ohM5ps; Wed, 23 Nov 2022 23:15:11 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id C70D93F8FB;
        Wed, 23 Nov 2022 23:15:11 +0100 (CET)
Received: from [104.28.225.223] (port=56895 helo=[10.92.241.26])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oxy1P-000N6K-5I; Wed, 23 Nov 2022 23:15:11 +0100
Date:   Wed, 23 Nov 2022 23:15:09 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Joakim <ahoj79@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <aff65aa.d623d93e.184a68f2476@tnonline.net>
In-Reply-To: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
References: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
Subject: Re: Speed up mount time?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Joakim <ahoj79@gmail.com> -- Sent: 2022-11-23 - 13:33 ----

> I have a couple of machines (A and B) set up where each machine has a
> ~430 TB BTRFS subvolume, same data on both. Mounting these volumes
> with the following flags: noatime,compress=lzo,space_cache=v2
> 
> Initially mount times were quite long, about 10 minutes. But after i
> did run a defrag with -c option on machine B the mount time increased
> to over 30 minutes. This volume has a little over 100 TB stored.
> 
> How come the mount time increased by this?

You now have now extents to keep track of, which means more metadata to parse at mount. 

> 
> And is there any way to decrease the mount times? 10 minutes is long
> but acceptable, while 30 minutes is way too long.
> 
> Advice would be highly appreciated. :)
> 

You can defrag the subvolume and extent trees by using `btrfs fi defrag /path/to/subvol`. You can do this on each subvol and on the top level volume. This can reduce amounts of seeks, improving performance some. 

> 
> 
> Linux sm07b 5.4.17-2136.311.6.1.el8uek.x86_64 #2 SMP Thu Sep 22
> 19:29:28 PDT 2022 x86_64 x86_64 x86_64 GNU/Linux
> btrfs-progs v5.15.1
> Label: 'Storage'  uuid: 6ecd172e-3ebd-478c-9515-68162a41590d
>         Total devices 1 FS bytes used 105.04TiB
>         devid    1 size 436.57TiB used 107.87TiB path /dev/sdb
> 
> Data, single: total=107.34TiB, used=104.82TiB
> System, DUP: total=40.00MiB, used=11.23MiB
> Metadata, DUP: total=269.00GiB, used=221.57GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> [   51.764445] BTRFS info (device sdb): flagging fs with big metadata feature
> [   51.764450] BTRFS info (device sdb): use lzo compression, level 0
> [   51.764454] BTRFS info (device sdb): using free space tree
> [   51.764455] BTRFS info (device sdb): has skinny extents



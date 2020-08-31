Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA626258485
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 01:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHaXuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 19:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHaXup (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 19:50:45 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9587FC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7EhXC1vWcLbYwR0yuYPM6UpbEMJb0eynTnXHqR17WT8=; b=U+SoBWx+GCGyLSyVBCdolpzXuf
        WSgYMEXfNrVdszj+CPVXQypv8DwOMBjR4dzusuh8OjnKtg5DLy4gxxA6EXPuEykwfCqRmKOBLgNz+
        0wZVp320rCRCOUCq6mnYmKoKkP/TMLSKMR31S7onv//HbVFyA0mL/xSu1o9i8AfFxeF4=;
Received: from 2403-5800-3100-142-29dd-7142-531-d249.ip6.aussiebb.net ([2403:5800:3100:142:29dd:7142:531:d249])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kCtZJ-0006jP-Hh; Tue, 01 Sep 2020 09:50:33 +1000
Subject: Re: new database files not compressed
To:     Nikolay Borisov <nborisov@suse.com>, Roman Mamedov <rm@romanrm.net>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <20200831161505.369be693@natsu>
 <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
 <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <2d060b13-7a1a-7cc5-927f-2c6a067f9c03@moffatt.email>
Date:   Tue, 1 Sep 2020 09:50:33 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <41107373-cc61-ea3f-7ae9-c9eef0ee47f9@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 10:57 pm, Nikolay Borisov wrote:
>
> This means the data being passed to btrfs is not compressible. I.e after
> coompression the data is not smaller than the original, input data.

It is though - if I copy it, or run defrag, it compresses very well:


$ mount | grep btrfs
/dev/sdb on /mnt/test type btrfs 
(rw,relatime,compress-force=zstd:3,space_cache,subvolid=5,subvol=/)
$ zcat ~/*.zip | gbak -REP -page 16384 stdin test2.fdb
$ sudo compsize test2.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      194M         194M         191M
none       100%      194M         194M         191M

$ dd if=test2.fdb of=test2.fdb2 bs=16k
12250+0 records in
12250+0 records out
200704000 bytes (201 MB, 191 MiB) copied, 0.151375 s, 1.3 GB/s
$ sync
$ sudo compsize test2.fdb2
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        8%       17M         191M         191M
zstd         8%       17M         191M         191M

$ sudo btrfs fi defrag -czstd test2.fdb
$ sudo compsize test2.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        8%       17M         191M         191M
zstd         8%       17M         191M         191M


So it must be something about how Firebird is creating or writing the 
file, as Zygo wrote. I set the page size to 16k (default 4k) and 
although I see Firebird making 16k writes, it is not affecting the result.


Hamish


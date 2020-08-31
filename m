Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7702579C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgHaMzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaMzA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:55:00 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C722C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E3V3kCYUTEuWLt6PFzegiEmcZRJVVH9w3M+vKqfC8Z0=; b=KKLFGVfsYmdsN2942PjrgH9dFe
        fstkrmqvNvkQ5ew+xu6cvxAHvDkltsG2V2hx5LNoqe3xzQkQwuq/jOxmkuHprbrtDm8udYJdm3ikr
        PVWkWsG8miTy1YAS+RAy2LBDY5Q6hIr2YIlyIx95p5YRsOvMBUNfMpwBo9Yg0yCXSrIs=;
Received: from 2403-5800-3100-142-a53d-5245-55a7-71b4.ip6.aussiebb.net ([2403:5800:3100:142:a53d:5245:55a7:71b4])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kCjKn-0006gN-31; Mon, 31 Aug 2020 22:54:53 +1000
Subject: Re: new database files not compressed
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <20200831161505.369be693@natsu>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <c7415ce2-f025-6c31-60b7-f0b927ed4808@moffatt.email>
Date:   Mon, 31 Aug 2020 22:54:51 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831161505.369be693@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 9:15 pm, Roman Mamedov wrote:
> On Mon, 31 Aug 2020 18:53:54 +1000
> Hamish Moffatt <hamish-btrfs@moffatt.email> wrote:
>
>> $ sudo mount -O compress-force=zstd /dev/sdb /mnt/test
> Specifying the filesystem mount options is done with -o, not -O.
> See "man mount".
>
Argh, I messed up the dd test. It does work for dd from /dev/zeroes when 
mounted properly. It still doesn't compress my Firebird files though.


$ mount | grep btrfs
/dev/sdb on /mnt/test type btrfs 
(rw,relatime,compress-force=zstd:3,space_cache,subvolid=5,subvol=/)
$ dd if=/dev/zero of=zeroes bs=32k count=1024
1024+0 records in
1024+0 records out
33554432 bytes (34 MB, 32 MiB) copied, 0.0244041 s, 1.4 GB/s
$ sudo compsize zeroes
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        3%      1.0M          32M          32M
zstd         3%      1.0M          32M          32M
$ zcat ~/*.zip | gbak -REP -page 16384 stdin test2.fdb
$ sudo compsize test2.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      194M         194M         191M
none       100%      194M         194M         191M
$ isql-fb
Use CONNECT or CREATE DATABASE to specify a database
SQL> create database 'test3.fdb' page_size 16384;
SQL> ^D
$ sudo compsize test3.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      2.2M         2.2M         2.2M
none       100%      2.2M         2.2M         2.2M


Hamish


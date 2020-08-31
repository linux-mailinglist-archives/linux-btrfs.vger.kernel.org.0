Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE32579CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHaM4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaM4a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:56:30 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CEFC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AsAQ0luJjbQGxFuOhqcjb+vJ97X5fwHw3chzyt0UzH8=; b=mDz/vhPmC7GhfCdaeabpDuUy19
        J1OSUGXR0xX5TG/GSrlWR/eCeWjSqDF+RDdk3AcxzFJS7Cfu7mDqvJiHlu60378Z96cWBlKa845Dr
        WqD1IC0vJa8gHO/hsJCU1e48LCjmYy5Nb2/ArE/CNT8Ja2noV57PS+sJcgg1Qs3yfTgM=;
Received: from 2403-5800-3100-142-a53d-5245-55a7-71b4.ip6.aussiebb.net ([2403:5800:3100:142:a53d:5245:55a7:71b4])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kCjMF-0006nH-Nt; Mon, 31 Aug 2020 22:56:23 +1000
Subject: Re: new database files not compressed
To:     Nikolay Borisov <nborisov@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <1ba6d793-30c5-39fc-3b6f-46fee70e5dd8@suse.com>
 <4b5ff37f-2659-0757-cdc4-e3704ba9768b@moffatt.email>
 <68468502-c0e4-d126-3e09-4b5afa0a1f29@suse.com>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <2eb111da-204d-e723-2245-38c3d9256cfe@moffatt.email>
Date:   Mon, 31 Aug 2020 22:56:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <68468502-c0e4-d126-3e09-4b5afa0a1f29@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 8:47 pm, Nikolay Borisov wrote:
> <SNIP>
>
>> I created a new file system, ran dd bs=32k count=1024, then the dump
>> shows me items all the way up to item 161. https://pastebin.com/0MPPdqqM
>>
>>      item 160 key (258 EXTENT_DATA 33292288) itemoff 7750 itemsize 53
>>          generation 7 type 1 (regular)
>>          extent data disk byte 14671872 nr 4096
>>          extent data offset 0 nr 131072 ram 131072
>>          extent compression 3 (zstd)
>>      item 161 key (258 EXTENT_DATA 33423360) itemoff 7697 itemsize 53
>>          generation 7 type 1 (regular)
>>          extent data disk byte 14675968 nr 4096
>>          extent data offset 0 nr 131072 ram 131072
>>          extent compression 3 (zstd)
>> total bytes 32196018176
>> bytes used 1245184
>> uuid 53eaed91-1060-445b-bf7c-5efe9917adbc
> This output indicates that extents are compressed, what does compsize
> report on this file?

Yes it is right actually, I had wrong mount options before as Roman 
observed.


$ sudo compsize zeroes
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        3%      1.0M          32M          32M
zstd         3%      1.0M          32M          32M


But it is not working for Firebird still.

$ isql-fb
Use CONNECT or CREATE DATABASE to specify a database
SQL> create database 'test3.fdb' page_size 16384;
SQL> ^D
$ sudo compsize test3.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      2.2M         2.2M         2.2M
none       100%      2.2M         2.2M         2.2M

Hamish


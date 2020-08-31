Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7E257785
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHaKk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 06:40:26 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75426C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a8Z909a5OqEE6wnnSxiZKgzyjNQnOJBTkcce5oy0VK4=; b=VotY1xEoVXd7PZNlXUD+ttEjSi
        cQktptHE1dfidTUZAnecA6v7XN2+P5OJfHqTeiWInoHuca3GvVj1XS7WeKsRHzprwadtlEDegEkRw
        p450bL3gv3nxiy2KpXSoDdEOMNpfHNc/owuAxzMoKTZw1Rsd3POTn6Xd2hyJzchEMUkQ=;
Received: from 2403-5800-3100-142-30c0-d0ff-28cd-e22a.ip6.aussiebb.net ([2403:5800:3100:142:30c0:d0ff:28cd:e22a])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kChEZ-0001ii-Bf; Mon, 31 Aug 2020 20:40:19 +1000
Subject: Re: new database files not compressed
To:     Nikolay Borisov <nborisov@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831034731.GX5890@hungrycats.org>
 <baadab71-61a7-704e-86f7-3607895df663@moffatt.email>
 <1ba6d793-30c5-39fc-3b6f-46fee70e5dd8@suse.com>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <4b5ff37f-2659-0757-cdc4-e3704ba9768b@moffatt.email>
Date:   Mon, 31 Aug 2020 20:40:18 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1ba6d793-30c5-39fc-3b6f-46fee70e5dd8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 7:25 pm, Nikolay Borisov wrote:
>
> Doing the following test :
>
> root@ubuntu18:~# mount -O compress-force=zstd /dev/vdc /media/scratch/
> root@ubuntu18:~# rm -rf /media/scratch/zero
> root@ubuntu18:~# dd if=/dev/zero of=/media/scratch/zero bs=16k count=1024
> sync
> btrfs inspect-internal dump-tree -t5 /dev/vdc
>
> results in:
>
>
> item 6 key (259 EXTENT_DATA 0) itemoff 15816 itemsize 53
> 		generation 12 type 1 (regular)
> 		extent data disk byte 315621376 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 3 (zstd)
> 	item 7 key (259 EXTENT_DATA 131072) itemoff 15763 itemsize 53
> 		generation 12 type 1 (regular)
> 		extent data disk byte 315625472 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 3 (zstd)
> 	item 8 key (259 EXTENT_DATA 262144) itemoff 15710 itemsize 53
> 		generation 12 type 1 (regular)
> 		extent data disk byte 315629568 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 3 (zstd)
>
>
>
> I.e a bunch of 128k extents, which in fact take only 4k on disk each.
>
> Whereas if I write the same file but without the compress-force mount
> option I get:
>
> item 138 key (260 EXTENT_DATA 0) itemoff 8787 itemsize 53
> 		generation 14 type 1 (regular)
> 		extent data disk byte 298844160 nr 16777216
> 		extent data offset 0 nr 16777216 ram 16777216
> 		extent compression 0 (none)
>
>
> I.e a single extent, 16m in size. So instead of using this compsize
> utility or whatever it is can you dump the state of the filesystem as
> per the btrfs inspect-internal command shown above?

I used compsize as recommended by the wiki page: 
https://btrfs.wiki.kernel.org/index.php/Compression#How_can_I_determine_compressed_size_of_a_file.3F

I created a new file system, ran dd bs=32k count=1024, then the dump 
shows me items all the way up to item 161. https://pastebin.com/0MPPdqqM

     item 160 key (258 EXTENT_DATA 33292288) itemoff 7750 itemsize 53
         generation 7 type 1 (regular)
         extent data disk byte 14671872 nr 4096
         extent data offset 0 nr 131072 ram 131072
         extent compression 3 (zstd)
     item 161 key (258 EXTENT_DATA 33423360) itemoff 7697 itemsize 53
         generation 7 type 1 (regular)
         extent data disk byte 14675968 nr 4096
         extent data offset 0 nr 131072 ram 131072
         extent compression 3 (zstd)
total bytes 32196018176
bytes used 1245184
uuid 53eaed91-1060-445b-bf7c-5efe9917adbc


 From mount: /dev/sdb on /mnt/test type btrfs 
(rw,relatime,compress-force=zstd:3,space_cache,subvolid=5,subvol=/)

Hamish


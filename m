Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C195364AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353175AbiE0Pae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiE0Pab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 11:30:31 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 08:30:29 PDT
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B378CED8C6
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 08:30:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 400C13FCDC;
        Fri, 27 May 2022 17:25:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.1
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vZUABHfZbD-i; Fri, 27 May 2022 17:25:21 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 63F993F35F;
        Fri, 27 May 2022 17:25:21 +0200 (CEST)
Received: from [192.168.0.10] (port=50675)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nubq4-000CPD-HQ; Fri, 27 May 2022 17:25:20 +0200
Message-ID: <33e31083-99d5-b8d8-e082-a1260849b8da@tnonline.net>
Date:   Fri, 27 May 2022 17:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
Content-Language: en-GB
To:     efkf@firemail.cc, Chris Murphy <lists@colorremedies.com>,
        linux-btrfs@vger.kernel.org
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
 <4e7fdc9608777774595bf060a028b600@firemail.cc>
From:   Forza <forza@tnonline.net>
In-Reply-To: <4e7fdc9608777774595bf060a028b600@firemail.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2022-05-27 17:13, efkf@firemail.cc wrote:
...

>> Some older kernels would create single
>> profile chunks when a raid1 file system was mounted in degraded,rw
>> mode with a missing device. This happens silently.
> 
> I had mounted the fs with -o degraded and one drive a couple of times 
> just as a sanity check to make sure the data really is in both drives, i 
> assume this would mount it rw and fall into the category you described. 

With Btrfs, this is not good practice. If you mount RAID mirrors 
independently as degraded, the metadata could be updated differently and 
when you combine the drives again, the data would not be the same on 
each device - which would lead to corruption. This is true even for ro 
mounts. ro is a Linux VFS thing, Btrfs will still write to the disk for 
its internal things.


> The first chunks were created before having updated to debian testing 
> under kernel 5.10.0-11 but the same thing happened after updating to 
> testing
> I think i had tried to mount ro,degraded and it failed but i'm not sure.
> 
> Once again thank you so much for suggesting -o rescue=all, i had 
> previously managed to recover around 300G and now i think i got the full 
> ~800G with a very small amount of corrupted files !!

Good to hear that you got most of your data back. :)

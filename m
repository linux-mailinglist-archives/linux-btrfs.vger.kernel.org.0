Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2313D2049BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgFWGSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgFWGSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 02:18:00 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB1C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jun 2020 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xEEaC95sa59D5yFU/xjlHyT5ajhYNzgKyfta3c81wRI=; b=LRlExN9pOziljfPq9HS/n1bHKY
        b78KK8pq6E6b4XAQZTjg3gd7Sp17NGZ7nUUIu0zXk0wTOxmgtKxGxzNTYmOTjA0A+sFwBhtkvnyc9
        Yh/YQa0qwqYyUCp3762dppaIDFpE1kEsOe+2VM1ZbZJzFrcMmZ/cOdA0pBlfQ/qsC0VXyr5DBZBMD
        0DBvAObjYbMY80ljVPHMd5+hFgYdtf4k5su3F5HMl4IFYnjnR5aIt+eMA/4qUpGfQB3FYfji65lS2
        /irYDuKNvpSvLgsPnrWwPCdp4tY1ujZB8uQQ3xJoOp4lztlA5GktjA4AcaA75KCJdjq+b+trEaGdr
        /YT2dLeg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:29235 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jncFn-0007C1-Uy; Tue, 23 Jun 2020 08:17:55 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: btrfs dev sta not updating
To:     Nikolay Borisov <nborisov@suse.com>,
        Russell Coker <russell@coker.com.au>,
        linux-btrfs@vger.kernel.org
References: <4857863.FCrPRfMyHP@liv>
 <08121825-9c05-87c4-4015-f6f508193fa8@suse.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <39073b9b-360c-81d1-3c3a-22631b6c2b27@dirtcellar.net>
Date:   Tue, 23 Jun 2020 08:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <08121825-9c05-87c4-4015-f6f508193fa8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Nikolay Borisov wrote:
> 
> 
> On 23.06.20 г. 5:09 ч., Russell Coker wrote:
>> [395198.926320] BTRFS warning (device sdc1): csum failed root 5 ino 276 off
>> 19267584 csum 0x8941f998 expected csum 0xccd545e0 mirror 1
>> [395199.147439] BTRFS warning (device sdc1): csum failed root 5 ino 276 off
>> 20611072 csum 0x8941f998 expected csum 0xdaf657cb mirror 1
>> [395199.183680] BTRFS warning (device sdc1): csum failed root 5 ino 276 off
>> 24190976 csum 0x8941f998 expected csum 0xcddce0b1 mirror 1
>> [395199.185172] BTRFS warning (device sdc1): csum failed root 5 ino 276 off
>> 19267584 csum 0x8941f998 expected csum 0xccd545e0 mirror 1
>> [395199.330841] BTRFS warning (device sdc1): csum failed root 5 ino 277 off 0
>> csum 0x8941f998 expected csum 0xa54d865c mirror 1
>>
>> I have a USB stick that's corrupted, I get the above kernel messages when I
>> try to copy files from it.  But according to btrfs dev sta it has had 0 read
>> and 0 corruption errors.
>>
>> root@xev:/mnt/tmp# btrfs dev sta .
>> [/dev/sdc1].write_io_errs    0
>> [/dev/sdc1].read_io_errs     0
>> [/dev/sdc1].flush_io_errs    0
>> [/dev/sdc1].corruption_errs  0
>> [/dev/sdc1].generation_errs  0
>> root@xev:/mnt/tmp# uname -a
>> Linux xev 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64 GNU/Linux
>>
> 
> The read/write io err counters are updated when even repair bio have
> failed. So in your case you had some checksum errors, but btrfs managed
> to repair them by reading from a different mirror. In this case those
> aren't really counted as io errs since in the end you did get the
> correct data.
> 
I don't think this is what most people expect.
A simple way to solve this could be to put the non-fatal errors in 
parentheses if this can be done easily.

For example:
[/dev/sdc1].write_io_errs    0 (5)

IMHO this would be more readable and more useful.

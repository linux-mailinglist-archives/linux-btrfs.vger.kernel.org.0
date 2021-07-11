Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2603C3BF4
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhGKLnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jul 2021 07:43:53 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:47498 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKLnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jul 2021 07:43:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 075C93F401
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 13:41:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id asCal5mkLmFV for <linux-btrfs@vger.kernel.org>;
        Sun, 11 Jul 2021 13:41:04 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 1387B3F375
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jul 2021 13:41:04 +0200 (CEST)
Received: from [192.168.0.10] (port=62817)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m2XpX-0002kf-I1
        for linux-btrfs@vger.kernel.org; Sun, 11 Jul 2021 13:41:03 +0200
Subject: Re: cannot use btrfs for nfs server
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <475ccf1.ca37f515.17a8a262a72@tnonline.net>
 <20210709073444.GA582@tik.uni-stuttgart.de>
 <CAJCQCtR=Xar+0pD9ivhk-kfrWxTxbJpVYu3z8A617GKshf2AsA@mail.gmail.com>
 <20210710063535.GE1548@tik.uni-stuttgart.de>
From:   Forza <forza@tnonline.net>
Message-ID: <2fd105cb-c097-63e8-0c43-049dceeb93c9@tnonline.net>
Date:   Sun, 11 Jul 2021 13:41:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210710063535.GE1548@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-07-10 08:35, Ulli Horlacher wrote:
> On Fri 2021-07-09 (10:30), Chris Murphy wrote:
>> On Fri, Jul 9, 2021 at 1:34 AM Ulli Horlacher
>> <framstag@rus.uni-stuttgart.de> wrote:
>>
>>>
>>> root@tsmsrvj:/# du -s /nfs/localhost/fex
>>> du: WARNING: Circular directory structure.
>>> This almost certainly means that you have a corrupted file system.
>>> NOTIFY YOUR SYSTEM MANAGER.
>>> The following directory is part of the cycle:
>>>    /nfs/localhost/fex/spool
>>
>> What do you get for:
>>
>> btrfs subvolume list -to /nfs/localhost/fex
> 
> root@tsmsrvj:~# btrfs subvolume list -to /nfs/localhost/fex
> ERROR: not a btrfs filesystem: /nfs/localhost/fex
> ERROR: can't access '/nfs/localhost/fex'
> 
> 
> root@tsmsrvj:~# mount | grep localhost
> localhost:/data/fex on /nfs/localhost/fex type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
> 
> 

I think you should have done the btrfs filesystem and not nfs mount:

btrfs subvolume list -to /data/fex

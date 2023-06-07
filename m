Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066B7269FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjFGTku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFGTkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:40:49 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 12:40:47 PDT
Received: from syrinx.knorrie.org (syrinx.knorrie.org [IPv6:2001:888:2177::4d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A81FC3
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:40:47 -0700 (PDT)
Received: from [IPV6:4000:0:fb:a::15] (2a02-a213-2b81-f900-0000-0000-0000-0004.cable.dynamic.v6.ziggo.nl [IPv6:2a02:a213:2b81:f900::4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 3F0FC6151B6D5;
        Wed,  7 Jun 2023 21:32:14 +0200 (CEST)
Message-ID: <a2a492ee-baa5-6881-e9ec-85ca2e611879@knorrie.org>
Date:   Wed, 7 Jun 2023 21:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: How to find/reclaim missing space in volume
Content-Language: en-US
To:     Marc MERLIN <marc@merlins.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
 <20230606164139.GK105809@merlins.org> <20230606232558.00583826@nvm>
 <543d7cf5-96c1-a947-6106-250527b4b830@gmx.com>
 <20230607191719.GA12693@merlins.org>
From:   Hans van Kranenburg <hans@knorrie.org>
In-Reply-To: <20230607191719.GA12693@merlins.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 6/7/23 21:17, Marc MERLIN wrote:
> On Wed, Jun 07, 2023 at 10:12:30AM +0800, Qu Wenruo wrote:
>> For the ghost subvolumes, it can be confirmed with "btrfs ins dump-tree
>> -t root", then looking for ROOT_ITEMs with "refs 0".
>>
>> I'm not sure if it is the case.
>>
>> Another possible cause is extent bookends, this needs something like
>> btrfs quota to confirm, and not much we can do if there are snapshots.
>> (If no snapshots, it's possible to defrag and free up such bookend extents).
> 
> unfortunately the system rebooted overnight, so I lost the state where
> sync was hung.
> On the plus side, this seems to have fixed the issue:

Just a random hint... One possible situation in which a deleted
subvolume can't be freed up for real yet, is when there is a process
that still has an open file in it.

> sauron:/mnt/btrfs_pool2# btrfs fi usage -T .
> Overall:
>     Device size:		   1.04TiB
>     Device allocated:		 857.02GiB
>     Device unallocated:		 210.73GiB
>     Device missing:		     0.00B
>     Used:			 589.30GiB
>     Free (estimated):		 470.78GiB	(min: 365.42GiB)
>     Data ratio:			      1.00
>     Metadata ratio:		      2.00
>     Global reserve:		 512.00MiB	(used: 0.00B)
> 
>                      Data      Metadata System               
> Id Path              single    DUP      DUP       Unallocated
> -- ----------------- --------- -------- --------- -----------
>  1 /dev/mapper/pool2 845.00GiB 12.00GiB  16.00MiB   210.73GiB
> -- ----------------- --------- -------- --------- -----------
>    Total             845.00GiB  6.00GiB   8.00MiB   210.73GiB
>    Used              584.95GiB  2.18GiB 112.00KiB            
> sauron:/mnt/btrfs_pool2# df -h .
> Filesystem         Size  Used Avail Use% Mounted on
> /dev/mapper/pool2  1.1T  590G  471G  56% /mnt/btrfs_pool2
> 
> I know it's hard to say after the fact, but have you seen issues where snapshot delete
> space cleanup would get stuck and 
> btrfs subvolume sync `pwd`
> would hang forever (until reboot) ?

Hans


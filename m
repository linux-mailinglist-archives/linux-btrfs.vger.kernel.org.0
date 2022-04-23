Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339B250CCAA
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiDWRoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiDWRoh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 13:44:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50471C82C7
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 10:41:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ECD423200D60;
        Sat, 23 Apr 2022 13:41:35 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Sat, 23 Apr 2022 13:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1650735695; x=1650822095; bh=VlC3qe3DL9
        ZrJah186hjkejplZMQyw6msEP4Fi/aS9U=; b=U/DUZh1B3DBT6dS7XoFlM/E6Ne
        oMVu8ZOpd3XK6Mm6+m57MwmcfmqBY8ltr5X2zYFtw0FmFUaYTxcJWa99XPpBfvbV
        3ZaxWrjKcwLMbR+DWhIDlZBNa0Z8w7NO3mQ6E2yByAYyaqc3g4KrkrLY510+/zen
        7zVwBzsg2dKZVZiRepK6hHN89I6B/Kcq7EZv3xDPXMDSO/uC9gCHdoqjEvMncjMp
        hs8CG4r2VeNtrkrOTUxlz8McdPMk1rBAky+1KJb4VOwtW+Mwdqqzn6m0o7ZUHSKm
        IrAaQ9p4M2Mp1XJ0FoYDQvQgYPSC8E0xWLbSWvjkJPWRgBdykSYwTQ9v/y7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650735695; x=
        1650822095; bh=VlC3qe3DL9ZrJah186hjkejplZMQyw6msEP4Fi/aS9U=; b=Z
        E/wiPRzntM55FO7GSmZWeWOrBuHAmbAt2lyMHKXQWWzd86brq7bAHJ6PjknM6c2I
        MQaE1bU9I+BjLBTviaRBI5extfPqyhcQ38GtAm2w07CBN2hs6TvB+xCyVMbqn0xr
        Tf9VAPEdvTNguMqHYo/aXaSbvrpNcBedbRY+9FiqKRMOyTf53ZOVBOMhzs/0VM9M
        SjB5Qm7QSsVHmNFYGDnYAo1ZXISkpkUilR7M37mUjWSPlQW2pVrp2vi1zCdoAGnE
        e1dft6lGg/kYZq7Drly2Mn/YB3eZhX3YSfOE1U3BgZGQPJ8Su5BQNfBnJU/ppRgQ
        MJsbmCZONeCmwazh9tRCA==
X-ME-Sender: <xms:TzpkYrWDPdjC3taHX1mc_imZmcTHBpx3S2uZ9JpDWwN7q03CVtAKnQ>
    <xme:TzpkYjnOV__h3Cn5fJoPPS9vAeKgGbo645vfyQrjCkP-auAQ0RJR1BEegVdWvMPVp
    6tkr5mBCFbsPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpeflrghtuceosghtrhhfshesjhgrthdrfhgrshhtmhgrihhl
    rdgtohhmqeenucggtffrrghtthgvrhhnpeeutdeikeehgfdulefgkeeileehffeiieekle
    duvdeukeetfeevfffggffggfevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsthhrfhhssehjrghtrdhfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:TzpkYnZclh0wP2T-feiuElFlNSKUULv_kuanl7lRMQYX9JElobGPaw>
    <xmx:TzpkYmXOwoWAKfRFIQOTjiA5IOzYJFXxc-BNasL8RWwv3gzDv4qxZw>
    <xmx:TzpkYlljwBB_K9wFI3ffvek06YIFOwWzV3KOAnpnllgMj5MKkA4dXQ>
    <xmx:TzpkYjQvaBgy78LRZjZJhxRy22Z3RW43YZtgCszvxuyE2FINnCT1hg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34476AC0E98; Sat, 23 Apr 2022 13:41:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <a03acb5f-02dc-491b-b44d-62a59246c4f7@beta.fastmail.com>
In-Reply-To: <fe391705-79d2-a365-27ca-fc52b260fcbf@gmx.com>
References: <a41c8f80-78de-49d3-a34f-2cd4109d20a0@beta.fastmail.com>
 <fe391705-79d2-a365-27ca-fc52b260fcbf@gmx.com>
Date:   Sat, 23 Apr 2022 10:40:28 -0700
From:   Jat <btrfs@jat.fastmail.com>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check fail
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks very much, Qu!
I attempted your advise, but was only partially successful.

> Recommended to go v2 cache.
Done, no problem.

> just go copy the files to other locations and remove the old file
This is where I had trouble.
I tried on just one file to start:
/mnt/@_190127freshinstall/var/log/journal/b0eb202aa367415fb973e99ecd54889e/user-1000.journal

I made a copy, deleted the original, and then renamed back to original:
cp user-1000.journal user-1000.journal.temp2
rm user-1000.journal
mv user-1000.journal.temp2 user-1000.journal

But afterward I got the same error, just different inode:
Pre: root 267 inode 249749 errors 1040, bad file extent, some csum missing
Post: root 267 inode 249772 errors 1040, bad file extent, some csum missing

What have I done wrong?

Thanks again for your help!

Regards,
Jat


----- Original message -----
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jat <btrfs@jat.fastmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check fail
Date: Friday, April 22, 2022 9:53 PM



On 2022/4/23 11:56, Jat wrote:
> Hello,
> I am trying to resize a partition offline, but it fails the check.
> The output of running btrfs check manually is below, can you please advise me how to resolve the issues?
>
> Here is the output from btrfs check:
> sudo btrfs check /dev/sda7
> Opening filesystem to check...
> Checking filesystem on /dev/sda7
> UUID: 4599055f-785a-4843-9f59-5b04e84fea1a
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated

Recommended to go v2 cache.

You can just mount it with space_cache=v2.

> [4/7] checking fs roots
> root 267 inode 249749 errors 1040, bad file extent, some csum missing
> root 268 inode 466 errors 1040, bad file extent, some csum missing
> root 308 inode 249749 errors 1040, bad file extent, some csum missing
> root 313 inode 466 errors 1040, bad file extent, some csum missing

Please run "btrfs check --mode=lowmem" to provide a more readable output.

There are several different reasons to cause the "bad file extent".

 From inline extents for non-zero offset, to compressed file extents for
NODATASUM inodes.

The later case can explain all your problems in one go, and can be
caused by older kernels.

If that's the case, you can just go copy the files to other locations
and remove the old file, and call it a day.

Thanks,
Qu

> ERROR: errors found in fs roots
> found 103264391173 bytes used, error(s) found
> total csum bytes: 93365076
> total tree bytes: 2113994752
> total fs tree bytes: 1825112064
> total extent tree bytes: 144097280
> btree space waste bytes: 432782214
> file data blocks allocated: 352758886400
>   referenced 178094907392
>
>
> Here is the requested info from Live boot environment for offline partition sizing & btrfs check...
> uname -a
> Linux manjaro 5.15.32-1-MANJARO #1 SMP PREEMPT Mon Mar 28 09:16:36 UTC 2022 x86_64 GNU/Linux
>
> dmesg > dmesg.log
> [Sorry, didn't capture this after running the check in live boot environment. Will capture as needed next time along with recommendation]
>
>
> Here is the requested info from within mounted environment...
> uname -a
> Linux manjaro-desktop 5.17.1-3-MANJARO #1 SMP PREEMPT Thu Mar 31 12:27:24 UTC 2022 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.16.2
>
> sudo btrfs fi show
> Label: 'manjaro-kde'  uuid: 4599055f-785a-4843-9f59-5b04e84fea1a
>          Total devices 1 FS bytes used 96.19GiB
>          devid    1 size 226.34GiB used 226.34GiB path /dev/sda7
>
> btrfs fi df /
> Data, single: total=220.33GiB, used=94.92GiB
> System, single: total=4.00MiB, used=48.00KiB
> Metadata, single: total=6.01GiB, used=1.97GiB
> GlobalReserve, single: total=275.20MiB, used=0.00B
>
>
> Thank you,
> Jat

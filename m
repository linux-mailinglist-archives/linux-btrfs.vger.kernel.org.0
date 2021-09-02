Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B393FE668
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 02:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbhIBAQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 20:16:44 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37163 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243351AbhIBAQm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 20:16:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CED5A3200A17;
        Wed,  1 Sep 2021 20:15:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 20:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=p
        kl5jr33CHl0Yp0ybS9PzOM32p/nLaGN95BaPBPfezM=; b=gGNosxEgwaTcxJAVT
        Xrd7Jvg3ohX9lGMUnyetQ/htNPZzDGVH8yyJP0nb/TNoAGc2BeA2z8OErmo7S6H6
        R+7vErOd1mTNHuW0NzR6EnMlwB9J7TOHCuR+XwTIwjjvqJxWI+LlTwBRdCZZkhFn
        2njd4UWxUA/m/+Fm5Ck2gCueFzHqOi4ZgCHmr8vkujXTJcHEDY3OKTK0KP92BQNx
        Kk7kG50i/M2QaT0Bb7vjj2jcGi3PFVxlOOzcgWKaDrmdn4w6HjQhqjz9BcUdTnNK
        pPpWAJ+w8tmmTPWwgS1tgNHK6t3bKN6+CnvL+ZrhLRQ6cVMEXRGxFjXru6ozIxtK
        pQFlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pkl5jr33CHl0Yp0ybS9PzOM32p/nLaGN95BaPBPfe
        zM=; b=bp7e1iWNIFxGwUgRZtZWyTEeYKgOd3Cp6qQ5igC6QZTJ5C6ogDO0BgsIA
        76dVcvtGXBZdzyRzWDDWWWcyeM/xEUCReqL1FTq0YPAM2ywrAJQYimpaRPipz0uI
        kOzytSO2KDZ8/ocoPLxKvCDT+NssZSRGPfmFC7G5Ju5TVMeEkKy9hLugrnpm8NmV
        NN66hyvJBY168OPGr5+HfRWbGjbbXV21zOC0jGRj6bCZt2dYszjL08PwpYZf814k
        z3Tb6WHspyo470yuciFx+MhzYp1nsaUpum2TSq2a/Du4Wt++2dlHHYa52qbkPC1o
        Z8ogLtmrVfY5TRno5NZcfMsTwXqCg==
X-ME-Sender: <xms:rhcwYR01I6PMUHGbKGXOkzH9G3t4w7Ge8rQGycl3DPzTwYB6ugGawA>
    <xme:rhcwYYHHZ3x29PxghxORnzNLGBB0rMnoi8Jpwaz7ns07HLgczSr8fS8moB1meNES1
    KwP76JLqf24aGHRxA>
X-ME-Received: <xmr:rhcwYR4wuvWs1pLRKuXRzoOYz1mLytwKlUQdSAXLSH3I52S81EGXL6bgpy92R7aL9tvB3Ag1rEU9qA2yOEhekL7Qdhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheethfeiteduleeggeevffdvheeuffejueegtdfftdekffdvjeeitdfh
    udffheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdr
    tghomh
X-ME-Proxy: <xmx:rhcwYe3cDIxeBWwjc9EhSC7RnND8D7rkvNdVmBusJt-En6ZIW7kL4Q>
    <xmx:rhcwYUHDtpx__nNGlbqNOLTL_Rf1xgkba_Qahdj_jbMfwG6P6E2qXg>
    <xmx:rhcwYf8kEMwxOP1lc0h26bP3UOkzA0Qn-UjXIWYbxKtRxBs631Jw8g>
    <xmx:rxcwYfPyhQ_GeL71f5Vp000rqT12I89H9LfEdkSa0_n7pQv1biQ-hw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 20:15:42 -0400 (EDT)
Subject: Re: how to replace a failed drive?
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <da5c047c-971d-7dff-3bce-397d0432d49c@georgianit.com>
Date:   Wed, 1 Sep 2021 20:15:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-09-01 6:07 p.m., Tomasz Chmielewski wrote:
> I'm trying to follow
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
> to replace a failed drive. But it seems to be written by a person who
> never attempted to replace a failed drive in btrfs filesystem, and who
> never used mdadm RAID (to see how good RAID experience should look like).
> 
> What I have:
> 
> - RAID-10 over 4 devices (/dev/sd[a-d]2)
> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating system
> - it was replaced using hot-swapping - new drive registered itself as
> /dev/sde
> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of other
> btrfs devices
> - because I couldn't remove the faulty device (it wouldn't go below my
> current number of devices) I've added the new device to btrfs filesystem:
> 
> btrfs device add /dev/sde2 /data/lxd
> 
> 
> Now, I wonder, how can I remove the disk which crashed?
> 
> # btrfs device delete /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2
> 
> 
> # btrfs device remove /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2
> 
> 
> # btrfs filesystem show /data/lxd
> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>         Total devices 5 FS bytes used 2.84TiB
>         devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
>         devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
>         devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
>         devid    6 size 1.73TiB used 0.00B path /dev/sde2
>         *** Some devices missing
> 
> 
> And, a gem:
> 
> # btrfs device delete missing /data/lxd
> ERROR: error removing device 'missing': no missing devices found to remove
> 
> 
> So according to "btrfs filesystem show /data/lxd" device is missing, but
> according to "btrfs device delete missing /data/lxd" - no device is
> missing. So confusing!
> 
> 
> At this point, btrfs keeps producing massive amounts of logs -
> gigabytes, like:
> 
> [39894585.659909] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298373, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660096] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298374, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660288] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298375, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660478] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298376, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660667] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298377, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660861] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298378, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.661105] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298379, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.661298] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298380, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.747082] BTRFS warning (device sda2): lost page write due to IO
> error on /dev/sdb2
> [39894585.747214] BTRFS error (device sda2): error writing primary super
> block to device 5
> 
> 
> 
> This is REALLY, REALLY very bad RAID experience.
> 
> How to recover at this point?
> 
> 
> Tomasz Chmielewski


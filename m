Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4476F44FBE3
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhKNV4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 16:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhKNV4P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 16:56:15 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2BC061746
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Nov 2021 13:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l02guJL90WThJT8ikfudCTxNiWGTU1y4vAS/6PYbR30=; b=Q5OCJBWTCCL17uRh822DGaifp+
        FdAKB656WyBQx/jm9RnBde3CsDeM4zrts2xRE5Wp4gOUcAwkxZabowpPH5uGruYSZEu7bQvr8Y/ps
        ZA+j0MaJPC1EjDG7La640ysJpIhjf/nGTmmYPcLbV17u9Z2XpStoLAPErBXs7o4adtCdH/wNAbHCk
        xPvLrOwRR1vQw7nld8/BBfCkDFLfJRRHPOoDPGFy6zbR0UjNno+VB9vKJMJgBjYYYlR7X8Vr3A5Jz
        v9TNahtcXuFo1TU0NYnnR+dM44mRm99Y9oGnHiYQMU1w/RGozvHU11Drk1h9QALWWStmZKDTQKUgP
        9w2rvx+Q==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:5154 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1mmNR5-0005nq-54; Sun, 14 Nov 2021 22:53:15 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Failed drive in RAID-6
To:     Pascal <comfreak89@googlemail.com>, linux-btrfs@vger.kernel.org
References: <CADSoW+KdEuw7qd=dfvL-nCWF_AECVfY3oY5UGzdhm1=uvjA6JA@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <123daa93-9354-4df2-8c6b-be403e6ce8bc@dirtcellar.net>
Date:   Sun, 14 Nov 2021 22:53:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.9.1
MIME-Version: 1.0
In-Reply-To: <CADSoW+KdEuw7qd=dfvL-nCWF_AECVfY3oY5UGzdhm1=uvjA6JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pascal wrote:
> Hi,
> 
> I have a failed drive in my RAID-6 with Metadata C3.
> 
> I am able to mount the filesytem via mount -o degraded /dev/sda /mnt/data/.
> 
> How can I remove the disk from the filesystem? The failed disk is a 8TB drive.
> 
> Do I have to replace it with a new one (only smaller size available)?
> I would like just to remove the drive - I should have plenty of free
> space available, even when the drive is missing afterwards.
> 

No you do not have to replace the drive. And if you do, you can use a 
smaller drive. Note that BTRFS "RAID" is close, but not really RAID in 
the traditional sense. You might as well call it BTRFS-RAID, Fred or 
Barney because it is NOT your off the shelve RAID implementation.

https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices

By the way , I am just a regular BTRFS user, so be warned. Do not 
blindly follow my advice - i have not toyed around with raid5/6 in 
years. (I suggest waiting for a follow up response if you can). However, 
you remove missing devices with:
btrfs device delete missing /mnt/data
(I think you have to physically remove the device for that to work as 
you expect.)

It is very annoying that btrfs does not show WHICH devices are missing, 
but if you know that only one drives is faulty it should be straight 
forward.

After that I would have have run a scrub to ensure that all is good.

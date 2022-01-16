Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8D48FA72
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 04:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiAPDR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 22:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiAPDR4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 22:17:56 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A2C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 19:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20220106; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IuuxInaiTAwtPYh7JZhd+nJtGRMyI+OjeMNPSkpWIZ8=; b=I8AE2xxs1Mv6bOSTj+ojBAdcGq
        3MZryfqd6/kpJ1N2Nr881Z/70Y7r0uwZPJU4fmkBvOBmvES2qWq8YrGzqnNnQt6gQ48ebCoxt1M4O
        dOLQhmtyISXSF5rrSring/UQgt8BdAsJHfyNK92KC6PU6jY2p9Aa61Qh8/ZT9BbcYhtxojlfTUvj3
        Uc41YAIr1nr9t9p0jD53YwTjuP3NjwtQkPeigoD6XKsLPaWfvRqP6M8qawUjgW+6tQ6jgzig1kbQL
        VWJW+ATSkeTETImxZ5eDxqr92qUJs+XORAmjkhgLT5PAtjhp8069/NLYefQLNdrvxgxaFNyPo+YuX
        ocAhbtmg==;
Received: from [50.46.16.53] (helo=stgulik)
        by ravenhurst.kallisti.us with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ross@kallisti.us>)
        id 1n8w3G-00FpEf-47; Sat, 15 Jan 2022 22:17:54 -0500
Date:   Sat, 15 Jan 2022 19:17:49 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: unable to remove device due to enospc
Message-ID: <20220116031749.mkfl62ri3hoct4oq@stgulik>
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
 <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 15, 2022 at 05:39:12PM -0700, Chris Murphy wrote:
> On Tue, Jan 11, 2022 at 12:41 AM Ross Vandegrift <ross@kallisti.us> wrote:
> >
> > Unallocated:
> >    /dev/mapper/backup      7.24TiB
> >    /dev/mapper/backup_a    2.55TiB
> >    /dev/mapper/backup_b    2.55TiB
> 
> You might be running into this bug I mentioned today in another
> thread. It's an overcommit related bug where the initial overcommit is
> based on a single device's unallocated space, in this case the 7T
> device - but then later logic results in ENOSPC because there aren't
> two devices that can handle that amount of overcommit. If you  can
> remove /dev/mapper/backup, leaving just _a and _b with equal
> unallocated, then try to reproduce. If you can't, you've likely hit
> the bug I'm thinking of. If you still can, then you're hitting
> something different.

I know I can't remove /dev/mapper/backup - I'm trying to do that anyhow, it
fails with enospc.

> However, since these unallocated values are orders of magnitude bigger
> than discussed in the other thread, and orders of magnitude more space
> than is needed to successfully create new chunks on multiple devices -
> I'm not sure. Also I'm not sure without going through the change log
> for 5.15 and 5.16 if this is fixed in one of those so the easiest
> thing to do is try and reproduce it with 5.16. If ENOSPC happens, then
> try to remove the device with 7T unallocated.

I'll build 5.16 and see if it helps.

Thanks,
Ross

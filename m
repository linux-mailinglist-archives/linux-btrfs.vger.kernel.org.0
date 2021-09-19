Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F3410DB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 00:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhISWwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 18:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhISWw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 18:52:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C351C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Sep 2021 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e29zNS38fx9puq7EAsBlNc3ENUJvT6u0VadH7PjvozQ=; b=uEv5igbzjzBu44axXbKd8niIjD
        1Gst9wGzMQWl74EwbQLDjbabDUHDODotYO9flrpGyT1syzVXce3hwZRooUChFVNOL0jIK7rZoH19z
        ASMGNS2w80IM/ukk5gYEW2gC/5EFcBbDgOBp3gH2Yo0+4nv3TRZfo4q95tZ5k8e9WWs/uLQUVyvzV
        ya/PQzywZ8PU/91q00I5PvsbB7KElFCIzY8arVMue+SBdrPvDLM24/cg/1LgL8zd+kiTHE2LgipxU
        lAETo9tXXfSNeTAsQMUsi8PJso+DNIMZgQ/7riJumPTHRJuqoiv+BNacYnxOyc8rt4JaI/D+yi3KZ
        lrbLHZ8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54656)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mS5eD-00019r-5H; Sun, 19 Sep 2021 23:50:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mS5eC-0001hL-7b; Sun, 19 Sep 2021 23:50:56 +0100
Date:   Sun, 19 Sep 2021 23:50:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
Message-ID: <YUe+0GEN608bRcmq@shell.armlinux.org.uk>
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
 <b4f6ec59-daa8-d4bd-d6b9-25d854eb70c3@gmx.com>
 <YUe94+ksRJrkqp16@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUe94+ksRJrkqp16@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 19, 2021 at 11:46:59PM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 20, 2021 at 06:44:58AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2021/9/20 06:40, Russell King (Oracle) wrote:
> > > Debian gcc 10.2.1 complains thusly:
> > > 
> > > fs/btrfs/tree-checker.c:1071:9: warning: missing braces
> > > around initializer [-Wmissing-braces]
> > >    struct btrfs_root_item ri = { 0 };
> > >           ^
> > > fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]
> > > 
> > > Fix it by removing the unnecessary '0' initialiser, leaving the
> > > braces.
> > 
> > This should be a compiler bug.
> > 
> > = { 0 }; is completely fine here, in fact = { }; would be more problematic.
> > 
> > What's the compiler version? I haven't hit such problem for GCC 11.1.0
> > nor clang 12.0.1.
> 
> I just realised that it's not the compiler I thought it was - It's
> GCC 4.9.4 used on 32-bit ARM.

Okay, ignore this - the warning exists with 5.14, where 4.9.4 is still
a valid compiler, but no longer with 5.15-rc.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

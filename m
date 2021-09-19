Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98836410DAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhISWsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhISWsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 18:48:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6FC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Sep 2021 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PyKDva89oSByhOo2ejjW6bBb4CZ0VKA1HYvHyZy47GU=; b=axmlBkpgJrQMCi7Te6aIggMmBQ
        vHNMXzd2TukNEEgpIJeijvmOmAqPeWDsFb5XbJxVwqsqSdFJVWoKR8KZTUOLE0wCZdPlRHVHHoL2q
        yfQwUirZI9pKpq79TB5lbRjFDJIg3wGVNDc5NlXCrhgp4iSMPhTzFoEvQPHCbKcf11j/AbA44j/ck
        oOu/Bw6Ocf+mvdBp4U6vScQXEIsm2HqvWr1YyQauViWNRdKG02fJz3xlgc/NSNhpeFlVQfNp/bafl
        idjeBJl4BBzUYdQS5UIqhGdu7akP2uSObTcljPQiqtJrGPEZQAWKBm3ezVfgwPBUHr468FofOGi50
        YgeDQN7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54652)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mS5aP-00019J-Hn; Sun, 19 Sep 2021 23:47:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mS5aN-0001h7-Bd; Sun, 19 Sep 2021 23:46:59 +0100
Date:   Sun, 19 Sep 2021 23:46:59 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
Message-ID: <YUe94+ksRJrkqp16@shell.armlinux.org.uk>
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
 <b4f6ec59-daa8-d4bd-d6b9-25d854eb70c3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f6ec59-daa8-d4bd-d6b9-25d854eb70c3@gmx.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 20, 2021 at 06:44:58AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/20 06:40, Russell King (Oracle) wrote:
> > Debian gcc 10.2.1 complains thusly:
> > 
> > fs/btrfs/tree-checker.c:1071:9: warning: missing braces
> > around initializer [-Wmissing-braces]
> >    struct btrfs_root_item ri = { 0 };
> >           ^
> > fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]
> > 
> > Fix it by removing the unnecessary '0' initialiser, leaving the
> > braces.
> 
> This should be a compiler bug.
> 
> = { 0 }; is completely fine here, in fact = { }; would be more problematic.
> 
> What's the compiler version? I haven't hit such problem for GCC 11.1.0
> nor clang 12.0.1.

I just realised that it's not the compiler I thought it was - It's
GCC 4.9.4 used on 32-bit ARM.

= { }; is not a problem for that version of GCC. Why do you think it's
problematic?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

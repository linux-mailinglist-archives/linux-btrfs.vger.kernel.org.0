Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC544667E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhKEPyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKEPyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 11:54:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204ECC061714;
        Fri,  5 Nov 2021 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MKzW+y8/toY5aTgeRpyBkAHc164CakPhMDjCICRZweY=; b=TujMWVudyAD1m/c4sanrWJYWqC
        xxwIFOvV8+xOtkidg5npDcV7MJFmfc+xxFZoplxk4TUPuq/P9LChJwl+WgeI2b4so6JdhglG5igbg
        4rFwhAIFUkgVMqniTOsn18qcQU3gEYbaFz/fXltWgc5hiY6PVpwWs/mJ4IhY2yGWeeoLmdN/Uraw+
        PuXTWkymPz+xbFFzK3Kgv1IjzT2W6N+JZVawpJXUxmStlMMQP8zJbszhAZy26u5bwb0m0CS509q4G
        Z5V9lki9Y/vMcMyld3NooMYG82xqCdiMdfx72u+L2za5mv3+NDfrehaTWf9AEQVd8kS7dNuASV4xn
        o+vVZUzg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj1V8-00BpHT-TI; Fri, 05 Nov 2021 15:51:34 +0000
Date:   Fri, 5 Nov 2021 08:51:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] common/btrfs: source module file
Message-ID: <YYVTBjLTywOHJCoo@bombadil.infradead.org>
References: <20211104203958.2371523-1-mcgrof@kernel.org>
 <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 11:04:46AM +0000, Filipe Manana wrote:
> On Thu, Nov 4, 2021 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > btrfs/249 fails with:
> >
> > QA output created by 249
> > ./common/btrfs: line 425: _require_loadable_fs_module: command not found
> > ./common/btrfs: line 432: _reload_fs_module: command not found
> > ERROR: not a btrfs filesystem: /media/scratch
> >
> > Fix this by sourcing common/module in the btrfs common file.
> 
> I'm not sure why you get such a failure. Without the relevant
> btrfs-progs and btrfs kernel patches, I don't get that error:

Are you using a latest fstests?

> Maybe Anand, who authored the test, may have an idea.
> We do have many other tests that call
> _require_btrfs_forget_or_module_loadable(), btrfs/124, 125, 163, 164,
> etc. Does it happen with those as well?

If that was not an issue before, maybe it is because of
commit b47ea0c6973 ("common/module: use patient module removal").

> Also, in the future please CC linux-btrfs for changes related to btrfs tests.

Will do, thanks!

 Luis

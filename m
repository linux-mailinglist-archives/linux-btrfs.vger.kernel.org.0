Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE55446683
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhKEP5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKEP5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 11:57:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC6C061714;
        Fri,  5 Nov 2021 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=c36ccFL5BvFS11HqnMjwBSO+YWZFdo7su1NfSDI4HKY=; b=TybsAk7o6faxnAVlSTRTS/PKJv
        VUO0/4xZY8Hk+xpYoc2EpuTiu/JfVDsgdGY+YPhWAkbJG/Q8xnVkse+6WH2y3P+hy8j2Ym/NeCEAV
        BEW3Eqv4YwlpgOpcymHX7AtCUgXf7krofT77UJToHTZyAh8xoZAWnopaUx2pMndeaGt5PyTT5NQkR
        xwTxR5Oyqjtzp+dyidJL6tI50743CF9o8VdMDvxPEuh9lU/cJcnCrHdyESL7fHJcg9DhvhJjDbPXP
        2AQreetwC13fi8VSC9taDLJ/BX/dkuG4OISMfWd9RNEEnpYsMDcMoYcMJxSJ/O/ViCOSE1ieIZ30o
        fqHyC03g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj1Xq-00BqI2-G3; Fri, 05 Nov 2021 15:54:22 +0000
Date:   Fri, 5 Nov 2021 08:54:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fdmanana@gmail.com, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] common/btrfs: source module file
Message-ID: <YYVTrl88M1c9bgnm@bombadil.infradead.org>
References: <20211104203958.2371523-1-mcgrof@kernel.org>
 <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
 <87935890-a607-0d14-0a6f-a16b7fa84988@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87935890-a607-0d14-0a6f-a16b7fa84988@suse.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 01:32:11PM +0200, Nikolay Borisov wrote:
> 
> 
> On 5.11.21 г. 13:04, Filipe Manana wrote:
> > On Thu, Nov 4, 2021 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >> btrfs/249 fails with:
> >>
> >> QA output created by 249
> >> ./common/btrfs: line 425: _require_loadable_fs_module: command not found
> >> ./common/btrfs: line 432: _reload_fs_module: command not found
> >> ERROR: not a btrfs filesystem: /media/scratch
> >>
> >> Fix this by sourcing common/module in the btrfs common file.
> > 
> > I'm not sure why you get such a failure. Without the relevant
> > btrfs-progs and btrfs kernel patches, I don't get that error:
> 
> I checked all these tests and btrfs/248 and btrfs/249 do not import
> common/module whilst the others do it so this might be one of the reason.

Odd btrfs/248 runs fine here.

> IMO it would be cleaner to source it in common/btrfs to remove the
> duplication.

Sure that works with me. Will send a v2.

  Luis

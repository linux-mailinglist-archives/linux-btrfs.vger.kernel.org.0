Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04D102B7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfKSSFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 13:05:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:44964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfKSSFv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 13:05:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D6F3B37C;
        Tue, 19 Nov 2019 18:05:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 486A9DA783; Tue, 19 Nov 2019 19:05:51 +0100 (CET)
Date:   Tue, 19 Nov 2019 19:05:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print procentage of used space
Message-ID: <20191119180550.GY3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stanislaw Gruszka <sgruszka@redhat.com>,
        linux-btrfs@vger.kernel.org
References: <1567070045-10592-1-git-send-email-sgruszka@redhat.com>
 <20190902183919.GZ2752@twin.jikos.cz>
 <20190903082322.GA3298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903082322.GA3298@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

sorry, I lost track of this patch.

On Tue, Sep 03, 2019 at 10:23:23AM +0200, Stanislaw Gruszka wrote:
> On Mon, Sep 02, 2019 at 08:39:19PM +0200, David Sterba wrote:
> > On Thu, Aug 29, 2019 at 11:14:05AM +0200, Stanislaw Gruszka wrote:
> > > This patch adds -p option for 'fi df' and 'fi show' commands to print
> > > procentate of used space. Output with the option will look like on
> > > example below:
> > > 
> > > Data, single: total=43.99GiB, used=37.25GiB (84.7%)
> > > System, single: total=4.00MiB, used=12.00KiB (0.3%)
> > > Metadata, single: total=1.01GiB, used=511.23MiB (49.5%)
> > > GlobalReserve, single: total=92.50MiB, used=0.00B (0.0%)
> > > 
> > > I considered to change the prints by default without extra option,
> > > but not sure if that would not break existing scripts that could parse
> > > the output.
> > 
> > Would it be sufficient for your usecase to print the % values in the
> > 'btrfs fi usage' command?
> >
> > After the summary, the's listing of the chunks with the same values and
> > slightly different format:
> > 
> >   Data,single: Size:296.00GiB, Used:166.99GiB
> > 
> >   Metadata,single: Size:5.00GiB, Used:2.74GiB
> > 
> >   System,single: Size:32.00MiB, Used:48.00KiB
> > 
> > 
> > For reference, this is from 'fi df':
> > 
> >   Data, single: total=296.00GiB, used=166.99GiB
> >   System, single: total=32.00MiB, used=48.00KiB
> >   Metadata, single: total=5.00GiB, used=2.74GiB
> >   GlobalReserve, single: total=368.48MiB, used=0.00B
> > 
> > I'd rather not extend the output of 'fi df' as this was supposed to be a
> > debugging tool and 'fi usage' is gives better and more complete
> > overview, so the % seem more logical to be put there.
> 
> It would be sufficient for me to print percentage in 'fi usage' command.
> I assume without extra -p option, just change the default output ?

Yes, it will print the percentage by default, like this:

Data,single: Size:339.00GiB, Used:172.05GiB (50.75%)

Metadata,single: Size:7.00GiB, Used:3.41GiB (48.70%)

System,single: Size:32.00MiB, Used:64.00KiB (0.20%)

> What you think about adding percentage option to 'fi show'? It's not
> super needed, but I somehow got use to have that information from
> standard df tool.

For the 'fi show' output it looks a bit risky to add the number there. I
know the output is parsed by scripts so this can break things. OTOH
somethimes we need to do such things so it is possible to enhance the
output. I'd rather group that with other changes so for now I'll apply
only the 'fi us' part.

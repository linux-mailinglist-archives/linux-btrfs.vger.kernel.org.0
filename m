Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7582E03B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbfJVMTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:19:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388392AbfJVMTS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:19:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E401B296;
        Tue, 22 Oct 2019 12:19:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D11C3DA733; Tue, 22 Oct 2019 14:19:29 +0200 (CEST)
Date:   Tue, 22 Oct 2019 14:19:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs-progs: warn users about the possible
 dangers of check --repair
Message-ID: <20191022121929.GU3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191018111604.16463-1-jthumshirn@suse.de>
 <20191021152241.GN3001@twin.jikos.cz>
 <45385205-4b42-b89b-4c6f-581064c5f08c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45385205-4b42-b89b-4c6f-581064c5f08c@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 09:33:06AM +0200, Johannes Thumshirn wrote:
> On 21/10/2019 17:22, David Sterba wrote:
> > --force was added for a different reason, to allow check on a mounted
> > filesystem. I don't think that combining --repair and --force just to
> > allow repair is a good idea. There's a 'dangerous repair' mode for eg.
> > xfs that allows to do live surgery on a mounted filesytem (followed by
> > immediate reboot). We want to be able to do that eventually.
> > 
> > I understand where the motivation comes from, let me have a second
> > thought on that.
> 
> So how about adding a '--yes' or '--accept', '--dangerous',
> '--allow-dangeruos' parameter instead of force to skip the warning?
> 
> My vote would go for '--allow-dangerous'.

So, I agree with the above. The dangerous repair should be something
almost nobody does or should do, so a very long option name is just
fine. This leaves -f for --repair to skip the warning. We now have:

* btrfs check - read-only by default, no changes

* btrfs check --read-only - same as above, explicit about RO

* btrfs check --repair - warning with a timeout, then repair

* btrfs check --repair -f - no warning (or the warning could be still
                            printed but without timeout)

I'd rather avoid options that would be confusing to what are they
referring to. So '--yes' it's like don't ask questions before repairing,
that's what e2fsck does but that's different from the initial warning.
And so on.

The dangerous repair would need a full set of the options, so

* btrfs --repair -f --allow-dangerous

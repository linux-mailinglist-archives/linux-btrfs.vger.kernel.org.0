Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD5FE400
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfKORbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 12:31:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:51686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbfKORbg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 12:31:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8C27698AB;
        Fri, 15 Nov 2019 17:31:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9BFE7DA818; Fri, 15 Nov 2019 18:31:37 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:31:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/22] btrfs: only keep track of data extents for async
 discard
Message-ID: <20191115173137.GC3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1571865774.git.dennis@kernel.org>
 <28b5064229e24388600f6f776621c6443c3e92b7.1571865775.git.dennis@kernel.org>
 <20191108194650.tcr5gsfl6vrh7riu@macbook-pro-91.dhcp.thefacebook.com>
 <20191108201458.GA51086@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108201458.GA51086@dennisz-mbp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 08, 2019 at 03:14:58PM -0500, Dennis Zhou wrote:
> On Fri, Nov 08, 2019 at 02:46:51PM -0500, Josef Bacik wrote:
> > On Wed, Oct 23, 2019 at 06:53:12PM -0400, Dennis Zhou wrote:
> > > As mentioned earlier, discarding data can be done either by issuing an
> > > explicit discard or implicitly by reusing the LBA. Metadata chunks see
> > > much more frequent reuse due to well it being metadata. So instead of
> > > explicitly discarding metadata blocks, just leave them be and let the
> > > latter implicit discarding be done for them.
> > > 
> > 
> > Hmm now that I look at this, it seems like we won't even discard empty metadata
> > block groups now, right?  Or am I missing something?  Thanks,
> > 
> 
> Empty block groups go through btrfs_add_to_discard_unused_list() which
> skips that check. So metadata blocks will be discarded here from
> btrfs_discard_queue_work() which should be called from
> __btrfs_add_free_space().
> 
> We should just skip discarding metadata blocks while they are being
> used.

I believe discarding metadata blocks while in use is called corruption :)
But I understand what you mean.

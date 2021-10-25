Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873FD439DB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhJYRjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 13:39:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhJYRjH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 13:39:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C713F21940;
        Mon, 25 Oct 2021 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635183403;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfeSWmt4EpGlTRtOS1UkMXwZFFu/6//qjWmf2qr0ZnQ=;
        b=GnGwxoKyTHDK1H3f/u8LSDfu1/vlDucA2VmLVkOlmugzxuXOz+fhfgIZJRbqqLAoT6t3Rg
        QgfVZ7yrXc75LXjf5AdJmGgWc/2VBhF6QrAgGw+XUTxca/Goi4a2/3R8Zz/Pk+avfD53Hx
        ZM98CKl93QMM32WuZqPZ1mUlaWCFGaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635183403;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfeSWmt4EpGlTRtOS1UkMXwZFFu/6//qjWmf2qr0ZnQ=;
        b=TTSqVQ3TzhhiCiGIzaQ8afTVa8uN7FodLj4+NHi67cPDSrZ2rDFejo+P/wAGDb1talhNvQ
        z1EiPOnD9Oaj1KDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BEDACA3B87;
        Mon, 25 Oct 2021 17:36:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DB3B1DA7A9; Mon, 25 Oct 2021 19:36:12 +0200 (CEST)
Date:   Mon, 25 Oct 2021 19:36:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] fs: export an inode_update_time helper
Message-ID: <20211025173612.GS20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1634231213.git.josef@toxicpanda.com>
 <32a87813b58c1ddc3ae4d769cd2b667901621f6a.1634231213.git.josef@toxicpanda.com>
 <20211021163817.GH20319@twin.jikos.cz>
 <20211025074509.GA10347@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025074509.GA10347@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 09:45:09AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 21, 2021 at 06:38:17PM +0200, David Sterba wrote:
> > On Thu, Oct 14, 2021 at 01:11:00PM -0400, Josef Bacik wrote:
> > > If you already have an inode and need to update the time on the inode
> > > there is no way to do this properly.  Export this helper to allow file
> > > systems to update time on the inode so the appropriate handler is
> > > called, either ->update_time or generic_update_time.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > I'd like to get ack from Christoph, though it's a simple change it's
> > still in another subsystem.
> 
> Not a big fan, but compared to the other options it seems like the
> least bad option.

Thanks, given that it fixes the time update problem and is otherwise
quite unintrusive it should be ok.

> That being said I'm not the VFS maintainer anyway.

Well yeah, but you reviewed or was involved in some other similar
changes, so I take it as a confirmation that we're not abusing some VFS
internal.  But I'm adding Al Viro to CC anyway.

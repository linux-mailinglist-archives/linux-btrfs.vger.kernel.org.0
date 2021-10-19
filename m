Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6A433665
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJSM4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 08:56:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbhJSM4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 08:56:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B830D21986;
        Tue, 19 Oct 2021 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634648067;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iA25VrBPG7QuKxB8Rkv3Voa3l948VNTutFnqzfBMo0U=;
        b=hUoI69gGaljc21yZ3G7javNFbkUrEnWSJjuxhFvP+GhzV8IdnmZv+3xXh9WeKytzMDBH+t
        zdDxlOud9hHjXBRy5qf0JgGdCcdLfsdAZVnOjLecwTHHZrsPNu5QIOsAtp67HJsdvRIMF2
        a/KyZH5Ed97T5weCA47gB4QVVDJA6Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634648067;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iA25VrBPG7QuKxB8Rkv3Voa3l948VNTutFnqzfBMo0U=;
        b=12qssCQQANwnvtLbScW4AvA4pcr8biQUhTzORcQUHdB7Il7nFW6SlI/q4h/iugP5kItDYe
        OKqnruSj6hBUZeBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AEBF8A3B85;
        Tue, 19 Oct 2021 12:54:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FEC5DA7A3; Tue, 19 Oct 2021 14:54:00 +0200 (CEST)
Date:   Tue, 19 Oct 2021 14:53:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs-progs: send protocol v2 stub, UTIMES2, OTIME
Message-ID: <20211019125359.GR30611@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
References: <20211018144109.18442-1-dsterba@suse.com>
 <20211018144717.20275-1-dsterba@suse.com>
 <YW3qStSa9LiaankG@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3qStSa9LiaankG@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 02:42:34PM -0700, Omar Sandoval wrote:
> On Mon, Oct 18, 2021 at 04:47:17PM +0200, David Sterba wrote:
> > +	int ret;
> > +	struct btrfs_receive *rctx = user;
> > +	char full_path[PATH_MAX];
> > +
> > +	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
> > +	if (ret < 0) {
> > +		error("otime: path invalid: %s", path);
> > +		goto out;
> > +	}
> > +
> > +	if (bconf.verbose >= 3) {
> > +		char ot_str[128];
> > +
> > +		if (sprintf_timespec(ot, ot_str, sizeof(ot_str) - 1) < 0)
> > +			goto out;
> > +		fprintf(stderr, "otime %s\n", ot_str);
> > +	}
> > +
> > +out:
> > +	return 0;
> > +}
> 
> Are you planning to do anything with otime (e.g., storing it in an
> xattr) in the future?

At this point I don't have further plan to use the value on the receive
side, there's no standard way to track otime outside of the inode. This
is up to the application, it can be stored in a xattr or just
cross-referenced with some other data.

I don't remember if there was a specific request for the otime in the
protocol, but for completeness of the information it makes sense to
transfer it to the receiving side.

> >  static const char * const cmd_send_usage[] = {
> >  	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
> >  	"Send the subvolume(s) to stdout.",
> > @@ -447,6 +483,7 @@ static const char * const cmd_send_usage[] = {
> >  	"                 does not contain any file data and thus cannot be used",
> >  	"                 to transfer changes. This mode is faster and useful to",
> >  	"                 show the differences in metadata.",
> > +	"--proto N        request maximum protocol version N (default: highest supported by running kernel)",
> 
> Can we default to version 1 and provide a way to opt in to the latest
> version? I'm concerned with a kernel upgrade suddenly creating a send
> stream that the receiving side can't handle. Making this opt-in rather
> than opt-out seems safer.

Default to v1 is safe, but what's your idea when to change it?

The send/receive usecase has 4 moving parts, kernel/send, progs/send,
progs/receive, kernel/receive. On different hosts and both parts
happening at potentially different times. Getting out of that with sane
defaults will be fun.

I agree that bumping the default any time kernel with new protocol
version support can break things quite easily, so that's against the
usability principles.

As the default is in progs it's a bit more flexible as it does not
require kernel update/reboot. The maximum supported value is known and
the 'default' value 0 for proto version allows that in a way that does
not require updating scripts.

So for first public release, I'll keep the default 1. Changes in the
default version can follow a similar way like mkfs, ie. when there's a
sufficient support in stable kernels. We'll probably also gather some
feedback over time so can decide accordingly.

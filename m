Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CDA433816
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJSONg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSONg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 10:13:36 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB0C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:11:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c28so20423qtv.11
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5bo76pP60D+uvqx/TOBYCFtrhY4+k19c9Vh8zHW0K8=;
        b=eKMdQW8n+YiYAfvvH3ybHxwiIjtuu7UNDc78osF132dzCWbBec4jGsyAGO+r2zvhDM
         XuR+m7Nz2+AXgXinYSXb/vqeOPIGeuazpWEZU1FIG0VLLPwvszZvSCWQfJPOTZo57FEB
         VvrA5RtK7ULd6hI3BMy3C43JrpGJjrF6Rwb7TZksyl20RZnplUDSiSZYpQb6w5BFjKcH
         wLRhuOrG5PXDnjrA/KBbXkOa3+zH6utakgBW3jkeNDoLnp5Cq23NaTrNe5ZtMtuLwkm9
         rRKsK/LPk448Ka8R3JBx2eH7Sxk4wONAEdD2P/eUENAssvNkThJW76niIlpg22DdSgVp
         q34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5bo76pP60D+uvqx/TOBYCFtrhY4+k19c9Vh8zHW0K8=;
        b=JPmhiasoklKJ89ZLKDy9mSfZ9Qb9p93CjRVXWDeuKhB7BP1autQNxvpNn7HcX8O/i7
         8YbpFFOLEuo2b6M3UzHbxZ8dIg9ukO0n3Ay7/qm8HztKYrm0tktybisOZQWV92nA2qyT
         OhWZ3hdpPHNx1oetISQKx7Yduz+67A59ZhryENxiCgh46odV+4PxahPtdP3mgqsrjHJB
         1WqxtQAE/aYz/hBn5KBAcjCEOhmRJQ1LxsuVhS5AwunoftrE1WiDvVmAiIPMb15FL0L+
         Anzx/dPvvtQd9J/PzFkaGFRTMmVxA/bw9vbEAfInrwno3j/HdrOyvERpy9Hz7kOQoHnT
         LdjA==
X-Gm-Message-State: AOAM532BRFKmumI60NxNgxx5zShzjW/irKJ6ofaE2MwOmzlT9aQL53Ww
        exzzAY+GpHS7WsGJuKzI9j9FwA==
X-Google-Smtp-Source: ABdhPJzBv/8BhaseJ3xUqs/zJMdK1wHWXMRNWAST7Vt7KLUZEa13kG/DrxgYcxXQVo4QZjr1pz0E0A==
X-Received: by 2002:ac8:5a07:: with SMTP id n7mr154095qta.304.1634652682411;
        Tue, 19 Oct 2021 07:11:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z13sm7543747qtq.30.2021.10.19.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:11:21 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:11:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs-progs: send protocol v2 stub, UTIMES2, OTIME
Message-ID: <YW7SB0jGRb+HbdnM@localhost.localdomain>
References: <20211018144109.18442-1-dsterba@suse.com>
 <20211018144717.20275-1-dsterba@suse.com>
 <YW3qStSa9LiaankG@relinquished.localdomain>
 <20211019125359.GR30611@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019125359.GR30611@suse.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 02:53:59PM +0200, David Sterba wrote:
> On Mon, Oct 18, 2021 at 02:42:34PM -0700, Omar Sandoval wrote:
> > On Mon, Oct 18, 2021 at 04:47:17PM +0200, David Sterba wrote:
> > > +	int ret;
> > > +	struct btrfs_receive *rctx = user;
> > > +	char full_path[PATH_MAX];
> > > +
> > > +	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
> > > +	if (ret < 0) {
> > > +		error("otime: path invalid: %s", path);
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (bconf.verbose >= 3) {
> > > +		char ot_str[128];
> > > +
> > > +		if (sprintf_timespec(ot, ot_str, sizeof(ot_str) - 1) < 0)
> > > +			goto out;
> > > +		fprintf(stderr, "otime %s\n", ot_str);
> > > +	}
> > > +
> > > +out:
> > > +	return 0;
> > > +}
> > 
> > Are you planning to do anything with otime (e.g., storing it in an
> > xattr) in the future?
> 
> At this point I don't have further plan to use the value on the receive
> side, there's no standard way to track otime outside of the inode. This
> is up to the application, it can be stored in a xattr or just
> cross-referenced with some other data.
> 
> I don't remember if there was a specific request for the otime in the
> protocol, but for completeness of the information it makes sense to
> transfer it to the receiving side.
> 
> > >  static const char * const cmd_send_usage[] = {
> > >  	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
> > >  	"Send the subvolume(s) to stdout.",
> > > @@ -447,6 +483,7 @@ static const char * const cmd_send_usage[] = {
> > >  	"                 does not contain any file data and thus cannot be used",
> > >  	"                 to transfer changes. This mode is faster and useful to",
> > >  	"                 show the differences in metadata.",
> > > +	"--proto N        request maximum protocol version N (default: highest supported by running kernel)",
> > 
> > Can we default to version 1 and provide a way to opt in to the latest
> > version? I'm concerned with a kernel upgrade suddenly creating a send
> > stream that the receiving side can't handle. Making this opt-in rather
> > than opt-out seems safer.
> 
> Default to v1 is safe, but what's your idea when to change it?
> 
> The send/receive usecase has 4 moving parts, kernel/send, progs/send,
> progs/receive, kernel/receive. On different hosts and both parts
> happening at potentially different times. Getting out of that with sane
> defaults will be fun.
> 
> I agree that bumping the default any time kernel with new protocol
> version support can break things quite easily, so that's against the
> usability principles.
> 
> As the default is in progs it's a bit more flexible as it does not
> require kernel update/reboot. The maximum supported value is known and
> the 'default' value 0 for proto version allows that in a way that does
> not require updating scripts.
> 
> So for first public release, I'll keep the default 1. Changes in the
> default version can follow a similar way like mkfs, ie. when there's a
> sufficient support in stable kernels. We'll probably also gather some
> feedback over time so can decide accordingly.

It's waaaaaaay easier to go "oh shit, I need a new btrfs-progs" than "oh shit, I
need a new kernel."  I think that having the kernel generate new send streams is
reasonable, because distro's are more likely to lag behind on kernels than
userspace.  If we have users on the cutting edge they're likely to be on the
cutting edge in both cases.  And if they get a sendstream that doesn't apply we
have a nice (at least I hope) message that says "this send stream is too new,
try a newer btrfs-progs", so it's an easy remedy.  Thanks,

Josef

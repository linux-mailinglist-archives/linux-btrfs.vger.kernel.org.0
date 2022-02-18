Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543744BBD9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiBRQf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 11:35:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiBRQf3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 11:35:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF99271E22
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 08:35:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F276E219A8;
        Fri, 18 Feb 2022 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645202111;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T81hcEhYTYtid0cvUwo+wQ1uCZQBU3bA/QRhrewuuTk=;
        b=uD8FT22OWYq5GujUe4NMVrs5lI2d3cKHO/PhSgVMamsP7UBt9qOWfzosGwoQ65byPlZMDI
        h17VpqrjQs/XE/Lm2lTtj3wBYN0kZ1XRUMi4Vr5gd0KSZFAW9nAFXtrj+9LLAY2MRyD2ju
        yO0Uy1iqENdKXqEBbME8klenAbazP6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645202111;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T81hcEhYTYtid0cvUwo+wQ1uCZQBU3bA/QRhrewuuTk=;
        b=1RuYa99MQ0FRapZVEZh8Tu8k7eKvW+RzhY6B9h/tbEbvFaoMFzPZui6k4MT4Klk2y9CEeF
        Gl53mDbq2qUKNJBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EC686A3B81;
        Fri, 18 Feb 2022 16:35:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C8AFDA829; Fri, 18 Feb 2022 17:31:25 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:31:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/8] btrfs: handle csum lookup errors properly on reads
Message-ID: <20220218163125.GZ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645196493.git.josef@toxicpanda.com>
 <5b9da7cdf4f3bb6edbf6e52313f8451be10f56a6.1645196493.git.josef@toxicpanda.com>
 <20220218161706.GY12643@twin.jikos.cz>
 <Yg/JIVB6vhUZJzGa@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg/JIVB6vhUZJzGa@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 11:28:17AM -0500, Josef Bacik wrote:
> On Fri, Feb 18, 2022 at 05:17:06PM +0100, David Sterba wrote:
> > On Fri, Feb 18, 2022 at 10:03:23AM -0500, Josef Bacik wrote:
> > > +		/*
> > > +		 * We didn't find a csum for this range.  We need to make sure
> > > +		 * we complain loudly about this, because we are not NODATASUM.
> > > +		 *
> > > +		 * However for the DATA_RELOC inode we could potentially be
> > > +		 * relocating data extents for a NODATASUM inode, so the inode
> > > +		 * itself won't be marked with NODATASUM, but the extent we're
> > > +		 * copying is in fact NODATASUM.  If we don't find a csum we
> > > +		 * assume this is the case.
> > > +		 *
> > > +		 * TODO: make the relocation code look up the owning inode and
> > > +		 * see if it's marked as NODATASUM and set EXTENT_NODATASUM
> > > +		 * there, that way if there's corruption and there isn't a
> > > +		 * checksum when we want it we can fail here rather than later.
> > 
> > Please don't add TODOs to the code, that's the best place to forget
> > about them, we've had some unfixed for years.
> 
> Do we want to just make a GH issue for it?  If you want to yank that bit out I'm
> fine with it.  Thanks,

I've moved part of the comment and to changelog as a note so it's not
completely lost, an issue makes sense too.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7D557DB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiFWOYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiFWOYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 10:24:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E03616B
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 07:24:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 302B021C91;
        Thu, 23 Jun 2022 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655994273;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ni+jYak3WmqjyGZ9o/qKdAjdV/DYdbMtAamrdb+ju6M=;
        b=b5xPBxytRD7/vgDWT9LJb/Kva/hy0fdTvhZe2MzOYDLv+u6UTGZRKrRXkNm5rhfy4/howj
        noyq5p1uzFZrav3rRc/1Rh0kmdDtjNRheAy/DJ2m4Wj+glsn0k4RfhcSdZEcIATZnfF9Yq
        tTAe++3PglCOBf8U2TQpTP0MaieQhos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655994273;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ni+jYak3WmqjyGZ9o/qKdAjdV/DYdbMtAamrdb+ju6M=;
        b=+TgZkKgEngj97JOvUURUcBoC+qE8nTLKTmPlRNnPwJiMl6oW5a54ox/AV5VDfpxq75qWEg
        wLL0UZtn0zjFzyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F00CB133A6;
        Thu, 23 Jun 2022 14:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jJqkOaB3tGIcSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Jun 2022 14:24:32 +0000
Date:   Thu, 23 Jun 2022 16:19:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove skinny extent verbose message
Message-ID: <20220623141954.GP20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
 <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 23, 2022 at 04:22:27PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/6/23 16:08, Nikolay Borisov wrote:
> > Skinny extents have been a default mkfs feature since version 3.18 i
> > (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
> > make skinny-metadata default") ). It really doesn't bring any value to
> > users to simply remove it.
> >
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Looks fine to me.
> 
> But this means we need to define the level of (in)compat flags we want
> to show in the dmesg.

Yes and we haven't done that so far so we should have some guidelines.
> 
> By default, we have the following lines:
> 
>   BTRFS info (device loop0): flagging fs with big metadata feature
>   BTRFS info (device loop0): using free space tree
>   BTRFS info (device loop0): has skinny extents
>   BTRFS info (device loop0): enabling ssd optimizations
>   BTRFS info (device loop0): checking UUID tree
> 
> For "big metadata" it's even less meaningful, and it doesn't even have
> sysfs entry for it.

There's an entry in the global features but 'big_metadata' does not
appear in the per-filesystem directory.

> For "free space tree" it may be helpful, but if one is really concerning
> about the cache version we're using, it's better to go sysfs other than
> checking the kernel dmesg.

The logged messages are a bit different as they could be stored and then
used for analysis. For new features it makes more sense to log them, I
think eg. the free space tree messages have been useful when debugging
the online conversion that took a few patches to get right.

> For "SSD", it's a good thing to output.

Agreed.

> For "UUID" tree, it's definitely not useful, even for developers.

Agreed.

> For skinny metadata it's the one you're cleaning.

Though I've sent patch to make it only debug I agree that this has
little value and don't object to removing it completely.

> So I guess you can clean up more unnecessary mount messages then?

The criteria I'd use for adding/removing the messages are vaguely like
that:

- does the user want to know a particular feature is in use? this is
  namely when we're introducing something and want to verify what's
  happening

- can the option have an impact on the filesystem behaviour?  eg. like
  ssd, but we tend to log almost all mount options already

- if there's a value for developer, the level should be debug, otherwise
  info

- remove messages if a feature is on by default for a long time and does
  not bring any other value, eg. the mixed_backref, big_metadata or
  skinny extents;
  the respective sysfs files may need to stay as they could be used for
  runtime detection even after a long time, eg. in some testsuite
  collecting testcases over time but likely not updating them, removal
  should be done on case-by-case basis

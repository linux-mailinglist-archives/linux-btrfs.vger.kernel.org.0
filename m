Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D27D59E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbjJXRpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 13:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjJXRpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 13:45:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94240D7A
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 10:45:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5D31FE9B;
        Tue, 24 Oct 2023 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698169501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqYrOxfd9CvROvL5eaFchN82xE/2xuth+GYVBnvoKZc=;
        b=jbcjIBbjjVwvA4tjFthud3ba3xmX4L6up+CQ1MiGtz4usBQI3J9QmUrIvDeNHnXAK0/EyT
        CY20PnpnVPV+KBUVNbj+97Uwku9YKon5qSqSnO8szYxcSmIEPbcgDO2tnlvulqhP66bpIA
        qcXHa7WdCgWmYcZE0PbBvRVSQX4NTlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698169501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqYrOxfd9CvROvL5eaFchN82xE/2xuth+GYVBnvoKZc=;
        b=ZDkHkEQ32OlctKJTdVrPh3XdrDUMs7NaPkLADjrVUoQvbWbesI/hdC31/eQDDLec8tVb37
        KQmDKXIAZNSObdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CA5C1391C;
        Tue, 24 Oct 2023 17:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4mPXAZ0COGXhEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 17:45:01 +0000
Date:   Tue, 24 Oct 2023 19:38:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
Message-ID: <20231024173806.GR26353@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
 <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
 <20231017231128.GA26353@twin.jikos.cz>
 <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 18, 2023 at 10:20:57AM +1030, Qu Wenruo wrote:
> >>> We're moving towards a world where kernel-shared will be an exact-ish copy of
> >>> the kernel code.  Please put helpers like this in common/, I did this for
> >>> several of the extent tree related helpers we need for fsck, this is a good fit
> >>> for that.  Thanks,
> >>
> >> Sure, and this also reminds me to copy whatever we can from kernel.
> > 
> > I do syncs from kernel before a release but all the low hanging fruit is
> > probably gone so it needs targeted updates.
> 
> For the immediate target it's btrfs_inode and involved VFS structures 
> for inodes/dir entries.
> 
> In progs we don't have a structure to locate a unique inode (need both 
> rootid and ino number), nor to do any path resolution.
> 
> This makes it almost impossible to proper sync the code.
> 
> But introduce btrfs_inode to btrfs-progs would also be a little 
> overkilled, as we don't have that many users.
> (Only the new --rootdir with --subvol combination).

I have an idea for using this functionality, but you may not like it -
we could implement FUSE. The missing code is exactly about inodes, path
resolution and subvolumes. You have the other project, with a different
license, although there's a lot shared code. You can keep it so u-boot
can do the sync and keep the read-only support. I'd like to have full
read-write support with subvolumes and devices (if there's ioctl pass
through), but it's not urgent. Having the basic inode/path support would
be good for mkfs even in a smaller scope.

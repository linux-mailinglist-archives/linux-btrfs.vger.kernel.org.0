Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF566E7E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAQUnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 15:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjAQUlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 15:41:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6247EC7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 11:23:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E09D61FFAF;
        Tue, 17 Jan 2023 19:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673983388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xf1IA1V7FqB2D0a4ZIsqXzvUsjVz5OazIpbkcIM7fus=;
        b=piBdRpXHN9dm+7kSsRMlvRnB4ZGTUPYYZ6xDD7SEt9T9H9N2WjMKxw7U4pjqAX9BoBDyLz
        pgIcrItv4R5KjsqqRie+ddOwHiloxyaOOYs/2HNL0qk1i3MIhfsO/MHjPp1JxrngY3REdP
        NrVuh2IgsucUnj8/07BjjMW0z691QuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673983388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xf1IA1V7FqB2D0a4ZIsqXzvUsjVz5OazIpbkcIM7fus=;
        b=qghoZ9ZWELfHj0j6i/6IoNKZZniWjlIWRfGsWkQl5xvEYyK0aVrDE7KPxX9LjI0IxGfcHo
        T912MxTMBrlZUFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBE8D1390C;
        Tue, 17 Jan 2023 19:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p9wQLZz1xmOUQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Jan 2023 19:23:08 +0000
Date:   Tue, 17 Jan 2023 20:17:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: keep sysfs features in tandem with runtime
 features change
Message-ID: <20230117191730.GD11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
 <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 11, 2023 at 03:05:45PM +0800, Qu Wenruo wrote:
> On 2023/1/11 13:40, Anand Jain wrote:
> > When we change runtime features, the sysfs under
> > 	/sys/fs/btrfs/<uuid>/features
> > render stale.
> > 
> > For example: (before)
> > 
> >   $ btrfs filesystem df /btrfs
> >   Data, single: total=8.00MiB, used=0.00B
> >   System, DUP: total=8.00MiB, used=16.00KiB
> >   Metadata, DUP: total=51.19MiB, used=128.00KiB
> >   global reserve, single: total=3.50MiB, used=0.00B
> > 
> >   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
> >   extended_iref free_space_tree no_holes skinny_metadata
> > 
> > Use balance to convert from single/dup to RAID5 profile.
> > 
> >   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
> > 
> > Still, sysfs is unaware of raid5.
> > 
> >   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
> >   extended_iref free_space_tree no_holes skinny_metadata
> > 
> > Which doesn't match superblock
> > 
> >   $ btrfs in dump-super /dev/loop0
> > 
> >   incompat_flags 0x3e1
> >   ( MIXED_BACKREF |
> >   BIG_METADATA |
> >   EXTENDED_IREF |
> >   RAID56 |
> >   SKINNY_METADATA |
> >   NO_HOLES )
> > 
> > Require mount-recycle as a workaround.
> > 
> > Fix this by laying out all attributes on the sysfs at mount time. However,
> > return 0 or 1 when read, for used or unused, respectively.
> > 
> > For example: (after)
> > 
> >   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
> >   block_group_tree compress_zstd extended_iref free_space_tree mixed_groups raid1c34 skinny_metadata zoned
> > compress_lzo default_subvol extent_tree_v2 metadata_uuid no_holes raid56 verity
> > 
> >   $ cat /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
> >   0
> > 
> >   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
> > 
> >   $ cat /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
> >   1
> 
> Oh, I found this very confusing.
> 
> Previously features/ directory just shows what we have (either in kernel 
> support or the specified fs), which is very straightforward.
> 
> Changing it to 0/1 is way less easy to understand, and can be considered 
> as big behavior change.

Yes, the sysfs files are considered an ABI though we can do changes that
are not backward compatible. The semantics of the features file is that
if it exists then it's also in the filesystem and tests depend on that.

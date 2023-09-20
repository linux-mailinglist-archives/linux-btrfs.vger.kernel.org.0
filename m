Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17397A8970
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjITQ3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjITQ3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 12:29:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CBDE;
        Wed, 20 Sep 2023 09:29:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2A732005F;
        Wed, 20 Sep 2023 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695227382;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTCb7o7s6ZlZM8q9ihkFCFZRPR9gfoRPeSaA6vmFKn8=;
        b=cTsocrCr9Wjmyx9sNKQwV+x/sZ1RdCuFSot3d+YnPXjD4XQYDGMtzH9cVKceoKtJdvokp3
        wF9OYjq511x4XFlh0hA0pKOAyn3cnAj5ODIbS4cNLZQrmi4x/a2i/gR+CLQD8vPgLWUrnx
        d1gGMIEQAdtLOkzrayig8hVLH/D0ShI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695227382;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTCb7o7s6ZlZM8q9ihkFCFZRPR9gfoRPeSaA6vmFKn8=;
        b=PZwpqsBHHl7YZyVnpv05r3w8X0zLjHY/22+Y7GA/z7RJgMadd/rm4245Mro5oulLZmWiRH
        bH0juO6TABinuYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56C671333E;
        Wed, 20 Sep 2023 16:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q4lZFPYdC2WTZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 16:29:42 +0000
Date:   Wed, 20 Sep 2023 18:23:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/11] btrfs: introduce RAID stripe tree
Message-ID: <20230920162308.GE2268@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914182534.GD20408@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914182534.GD20408@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 08:25:34PM +0200, David Sterba wrote:
> On Thu, Sep 14, 2023 at 09:06:55AM -0700, Johannes Thumshirn wrote:
> > Updates of the raid-stripe-tree are done at ordered extent write time to safe
> > on bandwidth while for reading we do the stripe-tree lookup on bio mapping
> > time, i.e. when the logical to physical translation happens for regular btrfs
> > RAID as well.
> > 
> > The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
> > it's contents are the respective physical device id and position.
> > 
> > For an example 1M write (split into 126K segments due to zone-append)
> > rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
> > wrote 1048576/1048576 bytes at offset 0
> > 1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)
> > 
> > The tree will look as follows (both 128k buffered writes to a ZNS drive):
> > 
> > RAID0 case:
> > bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
> > btrfs-progs v6.3
> > raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
> > leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
> > leaf 805535744 flags 0x1(WRITTEN) backref revision 1
> > checksum stored 2d2d2262
> > checksum calced 2d2d2262
> > fs uuid ab05cfc6-9859-404e-970d-3999b1cb5438
> > chunk uuid c9470ba2-49ac-4d46-8856-438a18e6bd23
> >         item 0 key (1073741824 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 56
> >                         encoding: RAID0
> >                         stripe 0 devid 1 offset 805306368 length 131072
> >                         stripe 1 devid 2 offset 536870912 length 131072
> > total bytes 42949672960
> > bytes used 294912
> > uuid ab05cfc6-9859-404e-970d-3999b1cb5438
> > 
> > RAID1 case:
> > bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
> > btrfs-progs v6.3
> > raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
> > leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
> > leaf 805535744 flags 0x1(WRITTEN) backref revision 1
> > checksum stored 56199539
> > checksum calced 56199539
> > fs uuid 9e693a37-fbd1-4891-aed2-e7fe64605045
> > chunk uuid 691874fc-1b9c-469b-bd7f-05e0e6ba88c4
> >         item 0 key (939524096 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 56
> >                         encoding: RAID1
> >                         stripe 0 devid 1 offset 939524096 length 65536
> >                         stripe 1 devid 2 offset 536870912 length 65536
> > total bytes 42949672960
> > bytes used 294912
> > uuid 9e693a37-fbd1-4891-aed2-e7fe64605045
> > 
> > A design document can be found here:
> > https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true
> 
> Please also turn it to developer documentation file (in
> btrfs-progs/Documentation/dev), it can follow the same structure.
> 
> > 
> > The user-space part of this series can be found here:
> > https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thumshirn@wdc.com
> > 
> > Changes to v8:
> > - Changed tracepoints according to David's comments
> > - Mark on-disk structures as packed
> > - Got rid of __DECLARE_FLEX_ARRAY
> > - Rebase onto misc-next
> > - Split out helpers for new btrfs_load_block_group_zone_info RAID cases
> > - Constify declarations where possible
> > - Initialise variables before use
> > - Lower scope of variables
> > - Remove btrfs_stripe_root() helper
> > - Pick different BTRFS_RAID_STRIPE_KEY constant
> > - Reorder on-disk encoding types to match the raid_index
> > - And possibly more, please git range-diff the versions
> > - Link to v8: https://lore.kernel.org/r/20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com
> 
> v9 will be added as topic branch to for-next, I did several style
> changes so please send any updates as incrementals if needed.

Moved to misc-next. I'll do a minor release of btrfs-progs soon so we
get the tool support for testing.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCA7A0CB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbjINSZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjINSZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 14:25:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8090D1FD7;
        Thu, 14 Sep 2023 11:25:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3ECE31F74A;
        Thu, 14 Sep 2023 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694715937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEppc6r1PcjpW6nK40c3JixDt+9V9j2BhP6BX+ws15s=;
        b=fphcYmr+TIz8swRi5INYpv6MQDGtRy6H046QwCH65Zklz3kRSgvpgzHJuFNFkuOaVUXMsu
        GWm74NeWntyve5PbhluG/35zWnEVQBuPN62ZLllXVj0N5ipvTVpeQwOWc8u0whlQnlaq5p
        GEoZgCdCdfa4ZapW9lfax0h6RTsoDkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694715937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEppc6r1PcjpW6nK40c3JixDt+9V9j2BhP6BX+ws15s=;
        b=++3uf7H3w1ABt0dgcwrDx+dg4N6CS3N+dpbWMCZyXMTZ5Dy7R+iUTnmZHOYWLLDycS3+Mm
        VrVEF6WNoXLlOFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CE3E139DB;
        Thu, 14 Sep 2023 18:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wmGLAiFQA2XWZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Sep 2023 18:25:37 +0000
Date:   Thu, 14 Sep 2023 20:25:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/11] btrfs: introduce RAID stripe tree
Message-ID: <20230914182534.GD20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 09:06:55AM -0700, Johannes Thumshirn wrote:
> Updates of the raid-stripe-tree are done at ordered extent write time to safe
> on bandwidth while for reading we do the stripe-tree lookup on bio mapping
> time, i.e. when the logical to physical translation happens for regular btrfs
> RAID as well.
> 
> The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
> it's contents are the respective physical device id and position.
> 
> For an example 1M write (split into 126K segments due to zone-append)
> rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)
> 
> The tree will look as follows (both 128k buffered writes to a ZNS drive):
> 
> RAID0 case:
> bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
> btrfs-progs v6.3
> raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
> leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
> leaf 805535744 flags 0x1(WRITTEN) backref revision 1
> checksum stored 2d2d2262
> checksum calced 2d2d2262
> fs uuid ab05cfc6-9859-404e-970d-3999b1cb5438
> chunk uuid c9470ba2-49ac-4d46-8856-438a18e6bd23
>         item 0 key (1073741824 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 56
>                         encoding: RAID0
>                         stripe 0 devid 1 offset 805306368 length 131072
>                         stripe 1 devid 2 offset 536870912 length 131072
> total bytes 42949672960
> bytes used 294912
> uuid ab05cfc6-9859-404e-970d-3999b1cb5438
> 
> RAID1 case:
> bash-5.2# btrfs inspect-internal dump-tree -t raid_stripe /dev/nvme0n1
> btrfs-progs v6.3
> raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0) 
> leaf 805535744 items 1 free space 16218 generation 8 owner RAID_STRIPE_TREE
> leaf 805535744 flags 0x1(WRITTEN) backref revision 1
> checksum stored 56199539
> checksum calced 56199539
> fs uuid 9e693a37-fbd1-4891-aed2-e7fe64605045
> chunk uuid 691874fc-1b9c-469b-bd7f-05e0e6ba88c4
>         item 0 key (939524096 RAID_STRIPE_KEY 131072) itemoff 16243 itemsize 56
>                         encoding: RAID1
>                         stripe 0 devid 1 offset 939524096 length 65536
>                         stripe 1 devid 2 offset 536870912 length 65536
> total bytes 42949672960
> bytes used 294912
> uuid 9e693a37-fbd1-4891-aed2-e7fe64605045
> 
> A design document can be found here:
> https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true

Please also turn it to developer documentation file (in
btrfs-progs/Documentation/dev), it can follow the same structure.

> 
> The user-space part of this series can be found here:
> https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thumshirn@wdc.com
> 
> Changes to v8:
> - Changed tracepoints according to David's comments
> - Mark on-disk structures as packed
> - Got rid of __DECLARE_FLEX_ARRAY
> - Rebase onto misc-next
> - Split out helpers for new btrfs_load_block_group_zone_info RAID cases
> - Constify declarations where possible
> - Initialise variables before use
> - Lower scope of variables
> - Remove btrfs_stripe_root() helper
> - Pick different BTRFS_RAID_STRIPE_KEY constant
> - Reorder on-disk encoding types to match the raid_index
> - And possibly more, please git range-diff the versions
> - Link to v8: https://lore.kernel.org/r/20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com

v9 will be added as topic branch to for-next, I did several style
changes so please send any updates as incrementals if needed.

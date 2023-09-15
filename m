Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6877A1BB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjIOKFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjIOKFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:05:17 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27522D6B
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 03:03:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7135:da8b:ba1d:1a7c])
        by andre.telenet-ops.be with bizsmtp
        id mA3P2A00J3q21w701A3P7m; Fri, 15 Sep 2023 12:03:25 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh5fX-003lP0-Gz;
        Fri, 15 Sep 2023 12:03:23 +0200
Date:   Fri, 15 Sep 2023 12:03:23 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Sterba <dsterba@suse.cz>
cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/11] btrfs: add support for inserting raid stripe
 extents
In-Reply-To: <20230914180701.GB20408@twin.jikos.cz>
Message-ID: <dd759994-678f-1d2c-a33e-6320b8ac4c6c@linux-m68k.org>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com> <20230914-raid-stripe-tree-v9-3-15d423829637@wdc.com> <20230914180701.GB20408@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 	Hi David,

On Thu, 14 Sep 2023, David Sterba wrote:
> On Thu, Sep 14, 2023 at 09:06:58AM -0700, Johannes Thumshirn wrote:
>> Add support for inserting stripe extents into the raid stripe tree on
>> completion of every write that needs an extra logical-to-physical
>> translation when using RAID.
>>
>> Inserting the stripe extents happens after the data I/O has completed,
>> this is done to a) support zone-append and b) rule out the possibility of
>> a RAID-write-hole.
>>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

>> --- /dev/null
>> +++ b/fs/btrfs/raid-stripe-tree.c
>> +static int btrfs_insert_striped_mirrored_raid_extents(
>> +				      struct btrfs_trans_handle *trans,
>> +				      struct btrfs_ordered_extent *ordered,
>> +				      u64 map_type)
>> +{
>> +	struct btrfs_io_context *bioc;
>> +	struct btrfs_io_context *rbioc;
>> +	const int nstripes = list_count_nodes(&ordered->bioc_list);
>> +	const int index = btrfs_bg_flags_to_raid_index(map_type);
>> +	const int substripes = btrfs_raid_array[index].sub_stripes;
>> +	const int max_stripes =
>> +		trans->fs_info->fs_devices->rw_devices / substripes;
>
> This will probably warn due to u64/u32 division.

Worse, it causes link failures in linux-next, as e.g. reported by
noreply@ellerman.id.au:

     ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!

So despite being aware of the issue, you still queued it?

The use of "int" for almost all variables is also a red flag:
   - list_count_nodes() returns size_t,
   - btrfs_bg_flags_to_raid_index() returns an enum.
   - btrfs_raid_array[index].sub_stripes is u8,
   - The result of the division may not fit in 32-bit.

Thanks for fixing, soon! ;-)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E237A54E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjIRVOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIRVOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 17:14:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D68E;
        Mon, 18 Sep 2023 14:14:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19DB8201A0;
        Mon, 18 Sep 2023 21:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695071640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrpqbn94qrHbMWgNN2ODyApxX7NqGyF5+moOSHczVzA=;
        b=KqwwjDGAmNJ72Ig3oJrCZBlB9wzQp+N3koXbywbdF8svkDn616/aRrLav+f6Ehmv/FvHDb
        rsY1BlAfdH99jB/m//5NL20eNlun7L+cWI/7Y95HPIru/fAweGAdm9OxZ5xQi9O8XWgUUP
        8likAlHvDhRD2AvCWL+LUtrit9IlJpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695071640;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrpqbn94qrHbMWgNN2ODyApxX7NqGyF5+moOSHczVzA=;
        b=QRH9LWxrohfAxdYvToH5FR+1MwA2R7jQ1pVAxmvYXh4VkXaFMtrVVionfrQyb2qLMOnEVT
        xyHgo/aqkCIhSaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA04913480;
        Mon, 18 Sep 2023 21:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FHjYK5e9CGUwdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 21:13:59 +0000
Date:   Mon, 18 Sep 2023 23:07:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Message-ID: <20230918210724.GM2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
 <20230918162448.GI2747@suse.cz>
 <CAMuHMdV_rxSsyURvy_57JX2W1ias0_fuMTE6MpNs7qWaCqibkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV_rxSsyURvy_57JX2W1ias0_fuMTE6MpNs7qWaCqibkQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 08:31:19PM +0200, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Mon, Sep 18, 2023 at 6:31 PM David Sterba <dsterba@suse.cz> wrote:
> > On Mon, Sep 18, 2023 at 03:03:10PM +0000, Johannes Thumshirn wrote:
> > > On 18.09.23 16:19, Geert Uytterhoeven wrote:
> > > > Hi Johannes,
> > > >
> > > > On Mon, Sep 18, 2023 at 4:14 PM Johannes Thumshirn
> > > > <johannes.thumshirn@wdc.com> wrote:
> > > >> Fix modpost error due to 64bit division on 32bit systems in
> > > >> btrfs_insert_striped_mirrored_raid_extents.
> > > >>
> > > >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > >> --- a/fs/btrfs/raid-stripe-tree.c
> > > >> +++ b/fs/btrfs/raid-stripe-tree.c
> > > >> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_extents(
> > > >>   {
> > > >>          struct btrfs_io_context *bioc;
> > > >>          struct btrfs_io_context *rbioc;
> > > >> -       const int nstripes = list_count_nodes(&ordered->bioc_list);
> > > >> -       const int index = btrfs_bg_flags_to_raid_index(map_type);
> > > >> -       const int substripes = btrfs_raid_array[index].sub_stripes;
> > > >> -       const int max_stripes = trans->fs_info->fs_devices->rw_devices / substripes;
> > > >> +       const size_t nstripes = list_count_nodes(&ordered->bioc_list);
> > > >> +       const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
> > > >> +       const u8 substripes = btrfs_raid_array[index].sub_stripes;
> > > >> +       const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices, substripes);
> > > >
> > > > What if the quotient does not fit in a signed 32-bit value?
> > >
> > > Then you've bought a lot of HDDs ;-)
> > >
> > > Jokes aside, yes this is theoretically correct. Dave can you fix
> > > max_stripes up to be u64 when applying?
> >
> > I think we can keep it int, or unsigned int if needed, we can't hit such
> > huge values for rw_devices. The 'theoretically' would fit for a machine
> > with infinite resources, otherwise the maximum number of devices I'd
> > expect is a few thousand.
> 
> rw_devices and various other *_devices are u64.
> Is there a good reason they are that big?

Many members' types of the on-disk structures are generous and u64 was
the default choice, in many cases practically meaning "you don't have to
care about it for the whole fileystem lifetime" or when u32 would be
close to some potentially reachable value (like 4GiB chunks). You could
find examples where u64 is too much but it's not a big deal for data
stored once and over time I don't remember that we'd have to regret that
some struct member is not big enough.

> With the fs fuzzing threads in mind, is any validation done on their values?

I think the superblock is the most fuzzed structure of btrfs and we do a
lot of direct validation,

https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/btrfs/disk-io.c#n2299

regarding the number of devices there's a warning when the value is
larger than "1<<31"

https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/btrfs/disk-io.c#n2433

The rw_devices are counting how many devices are actually found (i.e.
represented by a block device) and compared against the value stored in
the super block.

The u64 is also convenient for calculations where a e.g. a type counting
zones was u32 because it's a sane type but then we need to convert it to
bytes the shift overflows, we had such bugs.  Fortunatelly the sector_t
is u64 for a long time but it was also source of subtle errors when
converting to bytes.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE57A661F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjISOE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Sep 2023 10:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjISOEy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Sep 2023 10:04:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442F83;
        Tue, 19 Sep 2023 07:04:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 078F31FF1F;
        Tue, 19 Sep 2023 14:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695132287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/Q5PWifz4L+U7lvQD7OTExB3tkW0piz1J3T5yg4+RA=;
        b=QzFjOF5bfCS9bvkLIuGN+jfUzvcoEc7qo+d4w+iz7BG0pKLlOtrqk5ZE2Be95idVDpXwou
        tIxm+AAGU7tODbc1QlBnaFBzCxFVc6DyLCtkFKZqn3SKKiT2Fs2xaBh6w988XUoHSiNR4k
        VKLcFmmTtTY0sHmwdZR+yNZRRgmig9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695132287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/Q5PWifz4L+U7lvQD7OTExB3tkW0piz1J3T5yg4+RA=;
        b=7dIODHM8tb0hLyKYkxtTcfp3yTg6/G2EwZtbL9LQviXX2QouzF83AgC68zuuq3pVoXU1w8
        DnmMdX4ub9PBhgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCEB0134F3;
        Tue, 19 Sep 2023 14:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PipJLX6qCWW8SQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Sep 2023 14:04:46 +0000
Date:   Tue, 19 Sep 2023 15:58:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Message-ID: <20230919135810.GT2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
 <20230918162448.GI2747@suse.cz>
 <a0a5c7a3-4e55-4490-a2f9-fae2b0247829@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0a5c7a3-4e55-4490-a2f9-fae2b0247829@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 19, 2023 at 10:07:00AM +0930, Qu Wenruo wrote:
> On 2023/9/19 01:54, David Sterba wrote:
> > On Mon, Sep 18, 2023 at 03:03:10PM +0000, Johannes Thumshirn wrote:
> >> On 18.09.23 16:19, Geert Uytterhoeven wrote:
> >>> Hi Johannes,
> >>>
> >>> On Mon, Sep 18, 2023 at 4:14 PM Johannes Thumshirn
> >>> <johannes.thumshirn@wdc.com> wrote:
> >>>> Fix modpost error due to 64bit division on 32bit systems in
> >>>> btrfs_insert_striped_mirrored_raid_extents.
> >>>>
> >>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- a/fs/btrfs/raid-stripe-tree.c
> >>>> +++ b/fs/btrfs/raid-stripe-tree.c
> >>>> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_extents(
> >>>>    {
> >>>>           struct btrfs_io_context *bioc;
> >>>>           struct btrfs_io_context *rbioc;
> >>>> -       const int nstripes = list_count_nodes(&ordered->bioc_list);
> >>>> -       const int index = btrfs_bg_flags_to_raid_index(map_type);
> >>>> -       const int substripes = btrfs_raid_array[index].sub_stripes;
> >>>> -       const int max_stripes = trans->fs_info->fs_devices->rw_devices / substripes;
> >>>> +       const size_t nstripes = list_count_nodes(&ordered->bioc_list);
> >>>> +       const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
> >>>> +       const u8 substripes = btrfs_raid_array[index].sub_stripes;
> >>>> +       const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices, substripes);
> >>>
> >>> What if the quotient does not fit in a signed 32-bit value?
> >>
> >> Then you've bought a lot of HDDs ;-)
> >>
> >> Jokes aside, yes this is theoretically correct. Dave can you fix
> >> max_stripes up to be u64 when applying?
> >
> > I think we can keep it int, or unsigned int if needed, we can't hit such
> > huge values for rw_devices. The 'theoretically' would fit for a machine
> > with infinite resources, otherwise the maximum number of devices I'd
> > expect is a few thousand.
> 
> In fact, we already have an check in btrfs_validate_super(), if the
> num_devices is over 1<<31, we would reject the fs.

No, it's just a warning in that case.

> I think we should be safe to further reduce the threshold.
> 
> U16_MAX sounds a valid and sane value to me.
> If no rejection I can send out a patch for this.
> 
> And later change internal rw_devices/num_devices to u16.

U16 does not make sense here, it's not a native int type on many
architectures and generates awkward assembly code. We use it in
justified cases where it's saving space in structures that are allocated
thousand times. The arbitrary limit 65536 is probably sane but not
much different than 1<<31, practically not hit and was useful to
note fuzzed superblocks.

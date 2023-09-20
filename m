Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64887A8899
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjITPkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjITPkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 11:40:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA309D9;
        Wed, 20 Sep 2023 08:40:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8093122008;
        Wed, 20 Sep 2023 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695224437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGHbOYY7FsnjaS3nEMPoYfjC2fCOhS5YY3UGPdYWWqA=;
        b=eUEUXDPJpfeyk0v2ba1gL0uQKM+jaVmIO63x8U5ylhQzfXlh8sClPT8caUaVp1Okm1lvDH
        vkSmEXH5KFJtIEIx5rkx3XuwqyJRvNxg5RHjnl+ynx4ocAGvtvLd7bIi9mQqVlzBub0ivQ
        XKWoywhL5PGOnZrOHiQu3M8EEHa9P6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695224437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGHbOYY7FsnjaS3nEMPoYfjC2fCOhS5YY3UGPdYWWqA=;
        b=f87QlHrOYk6ACyn7nYXDy+EjkZ/aqwGw6soUlxxliaVK2q1+VSJYLg0A7BWUvXuhR2zpl3
        gypAKvtw9+KA7uBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37275132C7;
        Wed, 20 Sep 2023 15:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id waTIDHUSC2XXTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Sep 2023 15:40:37 +0000
Date:   Wed, 20 Sep 2023 17:34:03 +0200
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
Message-ID: <20230920153403.GD2268@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
 <20230918162448.GI2747@suse.cz>
 <a0a5c7a3-4e55-4490-a2f9-fae2b0247829@gmx.com>
 <20230919135810.GT2747@twin.jikos.cz>
 <a364f344-b718-48ff-9e2a-484c5ded6e7f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a364f344-b718-48ff-9e2a-484c5ded6e7f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 20, 2023 at 07:20:49AM +0930, Qu Wenruo wrote:
> >>>>> What if the quotient does not fit in a signed 32-bit value?
> >>>>
> >>>> Then you've bought a lot of HDDs ;-)
> >>>>
> >>>> Jokes aside, yes this is theoretically correct. Dave can you fix
> >>>> max_stripes up to be u64 when applying?
> >>>
> >>> I think we can keep it int, or unsigned int if needed, we can't hit such
> >>> huge values for rw_devices. The 'theoretically' would fit for a machine
> >>> with infinite resources, otherwise the maximum number of devices I'd
> >>> expect is a few thousand.
> >>
> >> In fact, we already have an check in btrfs_validate_super(), if the
> >> num_devices is over 1<<31, we would reject the fs.
> >
> > No, it's just a warning in that case.
> 
> We can make it a proper reject.
> 
> >
> >> I think we should be safe to further reduce the threshold.
> >>
> >> U16_MAX sounds a valid and sane value to me.
> >> If no rejection I can send out a patch for this.
> >>
> >> And later change internal rw_devices/num_devices to u16.
> >
> > U16 does not make sense here, it's not a native int type on many
> > architectures and generates awkward assembly code. We use it in
> > justified cases where it's saving space in structures that are allocated
> > thousand times. The arbitrary limit 65536 is probably sane but not
> > much different than 1<<31, practically not hit and was useful to
> > note fuzzed superblocks.
> 
> OK, we can make it unsigned int (mostly u32) for fs_info::*_devices, but
> still do extra limits on things like device add to limit it to U16_MAX.
> 
> Would this be a better solution?
> At least it would still half the width while keep it native to most (if
> not all) archs.

I don't see much point changing it from u64, it copies the on-disk type,
we validate the value on input, then use it as an int type. There are
not even theoretical problems stemming from the type width. With the
validations in place we don't need to add any artificial limits to the
number of devices, like we don't add such limitations elsewhere if not
necessary.

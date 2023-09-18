Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B681A7A4F43
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIRQhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjIRQgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 12:36:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5935BB1;
        Mon, 18 Sep 2023 09:31:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD0921E9F;
        Mon, 18 Sep 2023 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695054684;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKKkFp5ehkDbafP9C6xC6+RnxQLBq56KlrfWbgn4bDc=;
        b=tDvhyJuRfPgtwJ5cySbTm2NKjjLgu6TBS2xtOvRpKQLIPFPZti4DA9Y+PJBv8Tj2otuMS5
        x+YAmvtGYMmGSUx4iOpmAQAUHkPO5D6r3bN2dnr+HSf429pLyShuPBf8Jhvq5wnFHpLsCk
        DZldf6REW2y/HbQ7tdbSmHU6VZamGmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695054684;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKKkFp5ehkDbafP9C6xC6+RnxQLBq56KlrfWbgn4bDc=;
        b=RR/l4CyGLrE/f12m1t3yPOG+q1Fkz6r6UJ6/406poOPtdoW6hld9gGCFQ+ENPp4kO6IfJu
        xdtl/hUDnbI4MBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 685C013480;
        Mon, 18 Sep 2023 16:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pd9uGFx7CGXffAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 16:31:24 +0000
Date:   Mon, 18 Sep 2023 18:24:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in
 btrfs_insert_striped_mirrored_raid_extents
Message-ID: <20230918162448.GI2747@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com>
 <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 03:03:10PM +0000, Johannes Thumshirn wrote:
> On 18.09.23 16:19, Geert Uytterhoeven wrote:
> > Hi Johannes,
> > 
> > On Mon, Sep 18, 2023 at 4:14 PM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >> Fix modpost error due to 64bit division on 32bit systems in
> >> btrfs_insert_striped_mirrored_raid_extents.
> >>
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Thanks for your patch!
> > 
> >> --- a/fs/btrfs/raid-stripe-tree.c
> >> +++ b/fs/btrfs/raid-stripe-tree.c
> >> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_extents(
> >>   {
> >>          struct btrfs_io_context *bioc;
> >>          struct btrfs_io_context *rbioc;
> >> -       const int nstripes = list_count_nodes(&ordered->bioc_list);
> >> -       const int index = btrfs_bg_flags_to_raid_index(map_type);
> >> -       const int substripes = btrfs_raid_array[index].sub_stripes;
> >> -       const int max_stripes = trans->fs_info->fs_devices->rw_devices / substripes;
> >> +       const size_t nstripes = list_count_nodes(&ordered->bioc_list);
> >> +       const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
> >> +       const u8 substripes = btrfs_raid_array[index].sub_stripes;
> >> +       const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices, substripes);
> > 
> > What if the quotient does not fit in a signed 32-bit value?
> 
> Then you've bought a lot of HDDs ;-)
> 
> Jokes aside, yes this is theoretically correct. Dave can you fix 
> max_stripes up to be u64 when applying?

I think we can keep it int, or unsigned int if needed, we can't hit such
huge values for rw_devices. The 'theoretically' would fit for a machine
with infinite resources, otherwise the maximum number of devices I'd
expect is a few thousand.

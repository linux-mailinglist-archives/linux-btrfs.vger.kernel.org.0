Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B914508BF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 17:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379937AbiDTPXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379871AbiDTPXW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 11:23:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4C45534
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:20:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95C2D1F380;
        Wed, 20 Apr 2022 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650468035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uy9hNJPAcYVI7uXTWoivL14e5mZGhGqZ+XP/ZJLjoXI=;
        b=YdLnFhFCmHTBZzCOGconvERmV8N7G5St6MFwnh7344I2TgGC00IMM4X0uD1eF/Abo4x8BU
        3YzhsvDekaKMS/k1jVUS9TAPCatflhIjnBgU6ypTcvhBU3MHxSQLbA/F2n7OfnxqhFGZFM
        NiIzbS1hLG/u44V44K2Ugkub60bVuYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650468035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uy9hNJPAcYVI7uXTWoivL14e5mZGhGqZ+XP/ZJLjoXI=;
        b=lDwx0jvuTnRWva1t6+o9jCV+4qQgY8av4lSjeTJdqUFHzF4nnuj432T+I56TmzjjjHb+h1
        HGuLb7slXCJMnKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E4AB13AD5;
        Wed, 20 Apr 2022 15:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9/wgGsMkYGK5MQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 15:20:35 +0000
Date:   Wed, 20 Apr 2022 17:16:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Message-ID: <20220420151631.GF1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1650441750.git.wqu@suse.com>
 <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
 <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e57d9b3e-94fc-a20f-ff92-ccf19c0b035b@gmx.com>
 <PH0PR04MB741682A87F86554F81F5AE839BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741682A87F86554F81F5AE839BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 08:41:13AM +0000, Johannes Thumshirn wrote:
> On 20/04/2022 10:38, Qu Wenruo wrote:
> >>> 1. Make sure RAID0 is always the lowest bit in PROFILE_MASK
> >>>     This is done by finding the first (least significant) bit set of
> >>>     RAID0 and PROFILE_MASK & ~RAID0.
> >>>
> >>> 2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK
> >>
> >> TBH I think this change obscures the code more than it improves it.
> >>
> > Right, that kinda makes sense.
> > 
> > Will update the patchset to remove that line if needed.
> 
> I think the whole patch makes the code harder to follow. As of now you can
> just look it up, now you have to look how the calculation is done etc.

I think the index is the least useful information about the profiles,
it's there just that we have a sequence representing the profile flags
that's usable for arrays, like the space infos. The on-disk definition
is the bit and that's the source, how exactly it's converted to the
index is IMHO just a detail.

> If you want to get rid of the branches (which I still don't see a reason for)
> have you considered creating a lookup table?

It's yet another place that keeps the mapping of the values open coded.

Possibly if we would want to take it farther, a single definition of the
index enums could be like

#define	DEFINE_RAID_INDEX(profile)				\
	BTRFS_RAID_##profile   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_##profile)

and then used like

enum raid_types {
	DEFINE_RAID_INDEX(RAID0),
	DEFINE_RAID_INDEX(RAID10),
	...
};

But that's obscuring what exactly does it define and we do use the plain
indexes like BTRFS_RAID_DUP in several places. It's sometimes annoying
that ctags don't locate all the setget helpers because of all the
BTRFS_SETGET_FUNCS macros.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5A5F7C21
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJGRRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGRRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:17:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC49D019F
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:17:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C271521977;
        Fri,  7 Oct 2022 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665163056;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHy44hgmP6Rm6fHmVEWDlHlhgJPVEWOhH3WRF6SKiII=;
        b=jZ0l5CR8xn9lv26Z+RYLbCF6woNfhi0ko9HInR8FR8n+taeu6nLx4epVgtT3zhrxq/3/4K
        1+6cEBEgCM3A4o4BspupMSWKDXp9asAZdp/5goar+1yn0qEhwQc7akYfmzF2jDWNBvNPoT
        6W/KWwlgabajlx5B8tUOvwav9LDqU1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665163056;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHy44hgmP6Rm6fHmVEWDlHlhgJPVEWOhH3WRF6SKiII=;
        b=Qn4YKAYJ7qaFE2B0Bi7KeFBtv7u7EBJGsZ5H7fb5ADrKmvf/3l96OUJc8kKu32h0We1l2o
        auDKg+tObbxUqiDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BA5413A9A;
        Fri,  7 Oct 2022 17:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2y7kJDBfQGPGVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:17:36 +0000
Date:   Fri, 7 Oct 2022 19:17:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 08/17] btrfs: move discard stat defs to free-space-cache.h
Message-ID: <20221007171733.GY13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
 <PH0PR04MB74164DAAE2A3DC28E67FA92D9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74164DAAE2A3DC28E67FA92D9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 02:18:40PM +0000, Johannes Thumshirn wrote:
> On 14.09.22 17:07, Josef Bacik wrote:
> >  
> > +/*
> > + * Deltas are an effective way to populate global statistics.  Give macro names
> > + * to make it clear what we're doing.  An example is discard_extents in
> > + * btrfs_free_space_ctl.
> > + */
> > +#define BTRFS_STAT_NR_ENTRIES	2
> > +#define BTRFS_STAT_CURR		0
> > +#define BTRFS_STAT_PREV		1
> 
> I get this is a plain code movement patch, but can we please get
> enum {
> 	BTRFS_STAT_CURR,
> 	BTRFS_STAT_PREV,
> 	BTRFS_STAT_NR_ENTRIES
> };

There are still some defines that could be enums so let's do that
separately and in one go.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA756AB1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiGGS5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiGGS46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 14:56:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1B2B630
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 11:56:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A13FE1FAD8;
        Thu,  7 Jul 2022 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657220216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjKgD5TybIcXItGapc44VXynad0yKlz+1eLmsqBTjXM=;
        b=IKWI8hiK7NorHO1I7X0oSj6YFvc26UXzYju7YTekM8QiS0+bE2vUjjBCgWOTIgqJ2Xjn9Q
        qHnjpwtDSFs+JeyhdgIuBoFekl4Xs4l7mUBPpEPzmjmh8qYwBGBXBwPX2I7RkS84jVAa6D
        /ZOGQElFNPgb+Q3Y1PXEU4Ify0RZF3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657220216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjKgD5TybIcXItGapc44VXynad0yKlz+1eLmsqBTjXM=;
        b=EDiRQdN5fge58Xa+4mgOZ03d/2fScaVAkiOvlFCKPYqITVJT6FgJ+9S1zkVz7TjAx992kQ
        N4TbZOxEOPkoXbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DF8113461;
        Thu,  7 Jul 2022 18:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nt/HGXgsx2KWHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 18:56:56 +0000
Date:   Thu, 7 Jul 2022 20:52:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: use u8 type for btrfs_block_rsv::type
Message-ID: <20220707185209.GO15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1656079178.git.dsterba@suse.com>
 <2ff62613189d8f58f8da90a1558ad5726172057b.1656079178.git.dsterba@suse.com>
 <PH0PR04MB74165896B1D1967356A84A7A9BB99@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220627164018.GZ20633@twin.jikos.cz>
 <PH0PR04MB74165A85F6DAD1C596F1F61C9BB89@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74165A85F6DAD1C596F1F61C9BB89@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 28, 2022 at 07:15:14AM +0000, Johannes Thumshirn wrote:
> On 27.06.22 18:45, David Sterba wrote:
> > On Mon, Jun 27, 2022 at 06:51:30AM +0000, Johannes Thumshirn wrote:
> >> On 24.06.22 16:15, David Sterba wrote:
> >>> diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
> >>> index 0702d4087ff6..bb449c75ee4c 100644
> >>> --- a/fs/btrfs/block-rsv.h
> >>> +++ b/fs/btrfs/block-rsv.h
> >>> @@ -27,7 +27,8 @@ struct btrfs_block_rsv {
> >>>  	spinlock_t lock;
> >>>  	bool full;
> >>>  	bool failfast;
> >>> -	unsigned short type;
> >>> +	/* Block reserve type, one of BTRFS_BLOCK_RSV_* */
> >>> +	u8 type;
> >>>  
> >>
> >> Is there any reason to not use the enum?
> > 
> > Enum would be 'int', 4 bytes to the space optimization would be
> > lost. Enum types can be shortened as
> > 
> > 	enum btrfs_reserve type:8
> > 
> > but I'm not sure it's an improvement.
> > 
> 
> Using an enum would give some type safety (I think -Wenum-compare is 
> on by default in the kernel). Packing that enum would give us the 1 byte
> size you're looking for.

Yeah I'll go with the named enum and :8 in the structure.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D27554C4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357636AbiFVOML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357211AbiFVOMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 10:12:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF9838D84
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 07:12:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89D261FD06;
        Wed, 22 Jun 2022 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655907128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iohvcaDwZtgkqJB5cR75lM0/fVrgNZ0qy74Rx3cpx1c=;
        b=rQLmedMHLKCTb0Y5K3Vu8R6eMtfYoJQTHB/ExwhsvpmV9pYJmq+Op2u4AmnX5KdmgX9jYC
        MslnqltxMMr7u/gW3p+hBtLcq+KmLSboS75kQCnzKcB8edlYygGs0Eys+u71WsgInwqiBQ
        Nt4D68OUGLjzadsTw2QRfezMAiCgJ2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655907128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iohvcaDwZtgkqJB5cR75lM0/fVrgNZ0qy74Rx3cpx1c=;
        b=RG/BcZKRmt/IVylxt6jpY5DXntaL13fGt1AHAltlS+DgCE38N6GxhAInWaZHLY9Z+uMxrP
        aZ/oiwNL5TU3yXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40A3113A5D;
        Wed, 22 Jun 2022 14:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5CfKDjgjs2K+TAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 14:12:08 +0000
Date:   Wed, 22 Jun 2022 16:07:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/10] btrfs: remove a bunch of pointles stripe_len
 arguments
Message-ID: <20220622140730.GI20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-2-hch@lst.de>
 <20220620171608.GU20633@twin.jikos.cz>
 <20220620173834.GA23580@lst.de>
 <20220622041915.GA21099@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041915.GA21099@lst.de>
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

On Wed, Jun 22, 2022 at 06:19:15AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 07:38:34PM +0200, Christoph Hellwig wrote:
> > > I'd rather keep it there so it gets used eventually, we have ongoing
> > > work to fix the corner cases of raid56 so removing and adding it back
> > > causes churn, but I'll give it another thought.
> > 
> > Well, right now it is very much dead code and complicates a lot
> > of the argument passing as well as bloating the code size.
> > 
> > IFF the superblock member were to be actually used in the future,
> > it would make sense to expose it in the btrfs_fs_info and use that
> > instead of the constant, but still skip all the argument passing.
> > 
> > hch@brick:~/work/linux$ size btrfs.o.*
> >    text	   data	    bss	    dec	    hex	filename
> > 1502453	 125590	  28776	1656819	 1947f3	btrfs.o.new
> > 1502599	 125590	  28776	1656965	 194885	btrfs.o.old
> 
> So I guess this wasn't convincing enough. My plan B would be the fs_info
> member.  The related member seems to be the sectorsize field in the super
> block, which is checked if it is a power of two but otherwise completely
> ignored.  The fs_info has a stripe_size member that is initialized to the
> sectorsize after reading the super_block but then also mostly ignored.
> 
> So this is a ll a bit of a mess unfortunately :(

Hold on, it would be better to remove the code, as Qu also noted it's
not used consistently everywhere. My initial objection is more of a
general direction of such changes, but cleaning up the raid56 code to
the level of current functionality should work.

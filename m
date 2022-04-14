Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B6501899
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiDNQPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347775AbiDNQKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 12:10:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADE972BD
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 08:55:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52B711F747;
        Thu, 14 Apr 2022 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649951758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYEZXHyeYBkWoyOc/t9WWfggc+uhrsVA5pvc9mRKRB0=;
        b=ZCStPdAYNlWuwb7zOYfsIwYyugYcPuAOZ4HFGMVC15e49ycYVKejdhIIYTm9yTbqeYGzjM
        ThV3G6XNmLURDUhMvYoJETPM0ERa5YdgUzy6xbP7Ygvn4Ji5E/+iLT1NNMtLHR80T8laJ/
        /2pRDYlGL1TDuoJATEjgG+myGB0Pysg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649951758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYEZXHyeYBkWoyOc/t9WWfggc+uhrsVA5pvc9mRKRB0=;
        b=7RQHGyD0FtytaVAY4QNTiwxgGBLoOiwPhQ/dIL7fgYWr43WggexqcALyPvmGSx3AUimeCe
        as2qc4t0k0TJmEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A666132C0;
        Thu, 14 Apr 2022 15:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6sTgCA5EWGI9fAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Apr 2022 15:55:58 +0000
Date:   Thu, 14 Apr 2022 17:51:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Message-ID: <20220414155150.GQ15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
 <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
 <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
 <dce41e95-a11f-3897-bd51-51a10c0da799@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dce41e95-a11f-3897-bd51-51a10c0da799@gmx.com>
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

On Thu, Apr 14, 2022 at 06:59:58PM +0800, Qu Wenruo wrote:
> >> to see what's wrong.
> > 
> > It's a rebase error.
> > 
> > At least one patch has incorrect diff snippet.
> > 
> > For the patch "btrfs: raid56: introduce btrfs_raid_bio::stripe_sectors":
> > 
> > For alloc_rbio(), in my branch and patch (v2) submitted to the mailing 
> > list:
> > 
> > @@ -978,6 +1014,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct 
> > btrfs_fs_info *fs_info,
> >          rbio = kzalloc(sizeof(*rbio) +
> >                         sizeof(*rbio->stripe_pages) * num_pages +
> >                         sizeof(*rbio->bio_pages) * num_pages +
> > +                      sizeof(*rbio->stripe_sectors) * num_sectors +
> 
> The more I check this part of the existing code, the worse it looks to me.
> 
> We're really dancing on the edge, it's just a problem of time for us to 
> get a cut.
> 
> Shouldn't we go the regular way, kzalloc the structure only, then alloc 
> needed pages/bitmaps?

Yeah I agree that this has become unwieldy with the definitions and
calculations. One thing to consider is the real memory footprint and the
overhead of one kmalloc vs several kmalloc of smaller memory chunks.
Both have pros and cons but if there is no real effect then we may have
better code with the separate allocations.

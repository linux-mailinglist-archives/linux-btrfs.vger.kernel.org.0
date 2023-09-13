Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5492A79EE25
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjIMQVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIMQVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 12:21:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17390
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 09:20:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A39921836;
        Wed, 13 Sep 2023 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694622055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6jcOt5mGBmR/eXYW7sDA4C6gBB+viOZ76nu0LenSng=;
        b=Wjd8R/z7UeHI6c/PNdR9hCBa4YIBiR6ZdOG1Ct+LL/ruQhu8jXLLlV0DTe1NksOKw9mP9Z
        XeqEwW/CveTA5joaPEu9xUotX1qN6Rgo2fak5AQOkYNqvowrugawg4eDq89UVisQE10FnO
        GjTNg0SFQ9T9ic4nHTI1w65igy3hXdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694622055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6jcOt5mGBmR/eXYW7sDA4C6gBB+viOZ76nu0LenSng=;
        b=jJYr2U64buvCne781QbumU3qJvDjXw+X+Bzxcfh+3KE+NykWM/OSolJpySIx0OgWt8oa9M
        6ygg4JB0yOE8f3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 009DD13582;
        Wed, 13 Sep 2023 16:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Og7QOmbhAWWSGgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 16:20:54 +0000
Date:   Wed, 13 Sep 2023 18:20:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: split btrfs_load_block_group_zone_info
Message-ID: <20230913162053.GO20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230605085108.580976-1-hch@lst.de>
 <20230720133252.GA14895@lst.de>
 <bb0d98e5-49f3-43df-824b-3600b920fa7a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0d98e5-49f3-43df-824b-3600b920fa7a@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 12, 2023 at 02:07:40PM +0000, Johannes Thumshirn wrote:
> On 20.07.23 15:33, Christoph Hellwig wrote:
> > Hi Dave,
> > 
> > can you take a look at this series?  It's been out for almost 7
> > weeks and collected a few review. The patches still apply fine to the
> > latest misc-next branch.
> > 
> 
> The series still applies just fine (just verified with 'b4 shazam') and 
> builds nicely.
> 
> Can we please get this merged? That'll unclutter 
> btrfs_load_block_group_zone_info a lot.

Added to misc-next, thanks.

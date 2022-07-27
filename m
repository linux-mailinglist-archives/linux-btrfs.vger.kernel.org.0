Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF613582937
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiG0PBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiG0PBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 11:01:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD6946D9D
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 08:01:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D63938132;
        Wed, 27 Jul 2022 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658934099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4fiCz3rQjNbcxA/lynmRUSd4WqyysJqdJ8J5tEjAKI=;
        b=HNFEGN+12q+mD3L/kh7cKU9jEfExhE+Up8i4U47/egobzZ6H8TGly2gtATaNaJVznNFnIB
        A8bdk9QTqaWx1DZOPo5C8Svn1QR/N2IvriLLx8HBf7/rwwxiPEEPzk+sBJZZn/B9i+jTMZ
        WfteO/l8lbEt42hsMoNsJQabO7nQLtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658934099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4fiCz3rQjNbcxA/lynmRUSd4WqyysJqdJ8J5tEjAKI=;
        b=41d+td7GOUdTbz7jt/1lgvsXn8lWoXRelbJTb6IwEjNW9zetxFQ20YMPSO2PGuY7yamJ6v
        JH8lew8rsFCb/ABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08DA113A8E;
        Wed, 27 Jul 2022 15:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uvg0AVNT4WIgZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 15:01:39 +0000
Date:   Wed, 27 Jul 2022 16:56:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: Using async discard by default with SSDs?
Message-ID: <20220727145640.GS13489@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz>
 <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
 <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 10:50:01AM -0400, Chris Murphy wrote:
> On Tue, Jul 26, 2022, at 6:10 PM, Chris Murphy wrote:
> > On Tue, Jul 26, 2022, at 5:36 PM, David Sterba wrote:
> >> What is quickly here?
> >
> > Seconds, less than a minute, all the blocks pointed to by backup roots 
> > are empty (zeros).
> >
> >  The default timeout is set to 2 minutes and that's
> >> what I've seen when testing that on a fresh filesystem. 
> >
> > Ok I'll retest with 5.19 series. The last time I tested time to drive 
> > gc backup rootswas circa 5.8.
> 
> With 5.19, backup roots remain available for a surprisingly long time,
> definitely more than 2 minutes. It's not an exhaustive test, just a
> dozen samples over a half hour, but I never once saw zeros returned.
> Two out of those dozen, I saw the block already overwritten with a
> leaf of a newer generation and a completely different owner (e.g. csum
> tree written at the block address for the backup tree root)  - which
> would make that backup root useless.
> 
> What is a likely target kernel version to make discard=async the
> default? The merge window for 5.20 closes August 14. Is 5.21 a
> practical target?

The changes for the next merge window are supposed to be done a week or
two before it opens, but as this is a simple change I think I can
squeeze it in.

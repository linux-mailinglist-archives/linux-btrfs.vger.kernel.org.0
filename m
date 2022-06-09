Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160B25457AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiFIW7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFIW7M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 18:59:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEC37C5D2
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 15:59:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BA4D1FF04;
        Thu,  9 Jun 2022 22:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654815549;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pUJpDt7nJYvArTc3m2KXz+OTT8sEXjTRkkazxg8yHsk=;
        b=0xkSmaCU5INBsT1Qdu4Bt+3z7TA4GAK1XBOtZpkX8Qyn/jx2U3E9z9onb4yZyfqZ9uXyCy
        M5gc33vhbdAJG4gXpd1wKD3cGK4bUzusRPdxs/gLThB3nA8LuR3mqE5z4DtCTtPRqw68rr
        O1SRh7I1u1pwnABePxJ/MlpFXEgMhr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654815549;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pUJpDt7nJYvArTc3m2KXz+OTT8sEXjTRkkazxg8yHsk=;
        b=W0TG79cZ2y64/4CzJTGg6awFnkzhXxBoyQhNS9szDumZnKwmkPMqLvlT8S8t69k0AdbK+a
        6HMn7+Cn0hMW/mCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55DFF13456;
        Thu,  9 Jun 2022 22:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L37xEz17omLqIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Jun 2022 22:59:09 +0000
Date:   Fri, 10 Jun 2022 00:54:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <20220609225438.GW20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
 <YqJfYzwVZlITeED0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqJfYzwVZlITeED0@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 09, 2022 at 10:00:19PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 09, 2022 at 06:46:29PM +0200, David Sterba wrote:
> > Currently the super block page is from the mapping of the block device,
> > this is result of direct conversion from the previous buffer_head to bio
> > API.  We don't use the page cache or the mapping anywhere else, the page
> > is a temporary space for the associated bio.
> > 
> > Allocate pages for all super block copies at device allocation time,
> > also to avoid any later allocation problems when writing the super
> > block. This simplifies the page reference tracking, but the page lock is
> > still used as waiting mechanism for the write and write error is tracked
> > in the page.
> > 
> > As there is a separate page for each super block copy all can be
> > submitted in parallel, as before.
> 
> Why not submit the same page to all IOs?  Something like this

The byte offset and thus checksum is different in each super block copy,
so we can't use the same page.

In write_dev_supers:

- for each super block copy i
  - bytenr_orig = btrfs_sb_offset(i);
  - btrfs_set_super_bytenr(sb, bytenr_orig);
    - ie write the offset into the sb structure
  - memcpy sb -> page to write
  - calculate checksum
  - write page

Also you've removed too much code, for example the whole loop over all
devices in write_all_supers, but that's not important given the above.

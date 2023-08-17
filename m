Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC557801A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 01:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356062AbjHQXXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356080AbjHQXWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 19:22:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E635AD
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 16:22:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6E8521850;
        Thu, 17 Aug 2023 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692314566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFTi9gj/iPy3bzD0dcYfRDajspiAkRoRORlN1SNMcH4=;
        b=qBm6g6Mr7/C5IVGf+fPOxj+FlJOsDksqQPpYNRrCvLA0jNunA/1XbAR0RnDR+ytAihcIJd
        RF+S21CUzefAxt6tHbNBZy9HiM8Ubu0ZcyhWR5V18fhGsX70VYkjKaMHXpDl1B+P4ylgEu
        vg/cJ0eXThkvqgEk/m+0tUe5AOUI0FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692314566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RFTi9gj/iPy3bzD0dcYfRDajspiAkRoRORlN1SNMcH4=;
        b=xybzkxUfnSHvNj7+FwzNXZQQ6Dt5WNT7msvaz2Z1iGBCuL9maxI1sjW9rNJKvR22779/yB
        Z5FmIt46CSXHXbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC6491358B;
        Thu, 17 Aug 2023 23:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HUAkLcar3mRxKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 23:22:46 +0000
Date:   Fri, 18 Aug 2023 01:16:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search
 for striped profiles
Message-ID: <20230817231617.GY2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
 <20230817114747.GI2420@twin.jikos.cz>
 <a2c464a4-68cc-4e3d-a5f1-07f7727ef983@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c464a4-68cc-4e3d-a5f1-07f7727ef983@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 18, 2023 at 07:08:56AM +0800, Qu Wenruo wrote:
> On 2023/8/17 19:47, David Sterba wrote:
> > On Tue, Aug 15, 2023 at 07:07:19PM +0800, Qu Wenruo wrote:
> >>
> >> Fixes: 8557635ed2b0 ("btrfs: scrub: introduce dedicated helper to scrub simple-stripe based range")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Fix a u64/u32 division not using the div_u64() helper
> >>
> >> - Slightly change the advancement of logical/physical for RAID0 and
> >>    RAID56
> >>    Now logical/physical is always increased first, this removes one
> >>    if () branch.
> >>
> >> This patch is based on the scrub_testing branch (which is misc-next +
> >> scrub performance fixes).
> >>
> >> Thus there would be quite some conflicts for stable branches and would
> >> need manual backport.
> > 
> > Added to misc-next, thanks.
> 
> BTW, did you hit any compiling errors on 32bits systems?
> 
> Some bots reported linkage error due to div_u64(), but I see the same 
> div_u64() calls inside scrub.c thus I'm not sure what's really going on 
> here.

I did a build test now and it's clean. The bots sometimes lag behind
either git trees or mailinglist.

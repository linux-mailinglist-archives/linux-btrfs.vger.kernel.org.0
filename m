Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786D7BFE65
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjJJNti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjJJNth (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 09:49:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B691
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 06:49:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A562621883;
        Tue, 10 Oct 2023 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696945774;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2qv4XJhlNecCvg0cEatpZgAToBBFEZU8e45DsZgn6k=;
        b=KulYYqrFI94DaKaVGr4idCFnPrElfyLdu3lSwTaM8IFZAeimSHCePUJDAJJ/X8Qg/0TM6u
        cYF5m/5dr9MRirZmyUvvYvkPoLcgnh5uWSq85P3rHahbJLIkFTbJTiOkGrB+gjkB62YXiv
        MNpr6Xjw5M1tcQVFR+pZj2Qq6C5USOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696945774;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2qv4XJhlNecCvg0cEatpZgAToBBFEZU8e45DsZgn6k=;
        b=Bi+xfJLrEBcnAzaIo7zA8nwZuipdJJDOZsUwYuLx+KmsTJMjqy75zD9qTV+sfO8nYXSC+4
        l6hXiuIJsTnlkZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CBDB1358F;
        Tue, 10 Oct 2023 13:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sKrOGW5WJWX4cgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Oct 2023 13:49:34 +0000
Date:   Tue, 10 Oct 2023 15:42:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: perform stripe tree lookup for scrub
Message-ID: <20231010134248.GC2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
 <cdfbc6c3-d43e-456f-9616-441c3b50a1dd@suse.com>
 <77b7ae4f-d353-46ee-9b35-f7eb64bba110@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b7ae4f-d353-46ee-9b35-f7eb64bba110@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 10, 2023 at 08:37:10AM +0000, Johannes Thumshirn wrote:
> On 09.10.23 22:48, Qu Wenruo wrote:
> > 
> > 
> > On 2023/10/10 02:30, Johannes Thumshirn wrote:
> >> In case we're scrubbing a filesystem which uses the RAID stripe tree for
> >> multi-device logical to physical address translation, perform an extra
> >> block mapping step to get the real on0disk stripe length from the stripe
> >> tree when scrubbing the sectors.
> >>
> >> This prevents a double completion of the btrfs_bio caused by splitting the
> >> underlying bio and ultimately a use-after-free.
> > 
> > My concern is still the same, why we hit double endio calls in the first
> > place?
> > 
> > In the bio layer, if the bbio->inode is NULL, the real endio would only
> > be called when all the split bios finished, thus it doesn't seem to
> > cause double endio calls.
> > 
> > Mind to explain it more?
> 
> 
> Hmm indeed you're right. The patch probably only masks the UAF. On the 
> other hand, there's no point in submitting a bio for a range that needs 
> to be split, if we can avoid it.
> 
> Regarding the UAF, the KASAN report points to an object allocated by 
> btrfs_bio_alloc() in scrub_submit_extent_sector_read(), so it's the bbio.
> 
> Let me check if changing bbio->pending_ios from atomic_t to refcount_t 
> does give some hints here.
> 
> Still I think the patch is still useful regardless of the UAF.

I had merged the fixup yesterday before Qu replied, as I read it's not
entirely wrong as the RST is improved incrementally but please let me
know if you'd like to revert this change.

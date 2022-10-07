Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BD5F7C2B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGRXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGRXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 13:23:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14955D73C7
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 10:23:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1C051F8C0;
        Fri,  7 Oct 2022 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665163392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMWpjFzPrgC9u+6TkYPgSDPROcqXnxhydq+BUEKsbFk=;
        b=b92+0s+yLQq49beDvozSsSiNBESq1+K4dz5WzP83i+7nIZjvx571SDKH3eFA9m7WcqGpdD
        D2nBVk7kxofjbs+/KMfRaLTrq8hEhYaOi7dA61e4JiR2YUZCpI8sWTeJeD2HCufMkA0ym7
        wUbHqX16z7WZUBT9eKbtqCZTOimFlmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665163392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMWpjFzPrgC9u+6TkYPgSDPROcqXnxhydq+BUEKsbFk=;
        b=2ets5O+5F3CZfkYtmYx++xI1OBS06tiN/ptXh6RU9ev/Em7SNZsytn9oH4UQpD018skhRP
        IFvwUOepH23jUADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 940E113A9A;
        Fri,  7 Oct 2022 17:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tjguI4BgQGOVWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 17:23:12 +0000
Date:   Fri, 7 Oct 2022 19:23:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 09/17] btrfs: move btrfs_chunk_item_size out of ctree.h
Message-ID: <20221007172309.GZ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663167823.git.josef@toxicpanda.com>
 <3744e0ae6f8087daa9608174aeee00c53732f8bb.1663167823.git.josef@toxicpanda.com>
 <57b9689a-0b5a-e819-305b-4f41feaa6985@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b9689a-0b5a-e819-305b-4f41feaa6985@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 05:14:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/14 23:06, Josef Bacik wrote:
> > This is more of a volumes related helper, additionally it has a BUG_ON()
> > which isn't defined in the related header.  Move the code to volumes.c,
> > change the BUG_ON() to an ASSERT(), and move the prototype to volumes.h.
> 
> Again a very small function, can it be inlined instead?

I agree, such simple helpers it makes sense. The reason here is the
BUG_ON/ASSERT that's now definied in ctree.h so that would require some
more shuffling.

The assert makes some sense but in many cases the value is validated
before use so we might safely drop it.

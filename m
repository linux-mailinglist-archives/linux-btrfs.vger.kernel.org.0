Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3E59C0C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiHVNli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 09:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiHVNlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 09:41:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D6192A6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 06:41:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EA401F9D5;
        Mon, 22 Aug 2022 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661175695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNU/Md29St9FUMYYKd20UotroZel3CcPlLF4y16J03o=;
        b=2WHkqqWjUtD0DmeR1C0ieq8uXUq9q3gZMpGtmQMIB2KraACs+UFNlFxI2KUHDCzFeYtkBP
        dI2aNUSNzNBA8e3g95SJeQLlxrPMGfBRC6hbLvnJaQJv918idabqCT14NTB/FmqhXoNVix
        SU+N3k69IOBH9JXonpTBN3AYVtLAVvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661175695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNU/Md29St9FUMYYKd20UotroZel3CcPlLF4y16J03o=;
        b=RxoyJSnL3MuGNj797JPVaXgzi23s0j/xdFEcebjVpP2btkVkQZ/ZxfLgDixjxqoiVDajYx
        FdI1F3uhHv2TJmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE41713523;
        Mon, 22 Aug 2022 13:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2TglNI6HA2MRaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 13:41:34 +0000
Date:   Mon, 22 Aug 2022 15:36:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: fix filesystem corruption caused by space
 cache race
Message-ID: <20220822133621.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1660690698.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660690698.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 04:12:14PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> We recently deployed space_cache v2 on a large set of machines to do
> some performance comparisons and found a nasty filesystem corruption bug
> that was introduced by the fsync transaction optimization in 5.12. It's
> much more likely to affect space_cache=v2 and nospace_cache, but since
> space_cache=v1 effectively falls back to nospace_cache if there is a
> free space inode generation mismatch, space_cache=v1 could also
> theoretically be affected. discard/discard=sync also makes the bug much
> easier to hit by making the race window larger.
> 
> Patch 1 is the fix itself with a lot more details. Patch 2 is a followup
> cleanup.
> 
> I'm still working on a reproducer, but I wanted to get this fix out
> ASAP.
> 
> Thanks!
> 
> Omar Sandoval (2):
>   btrfs: fix space cache corruption and potential double allocations
>   btrfs: get rid of block group caching progress logic

Added to misc-next, thanks. A backport for 5.15 would be needed, the
patch does not apply cleanly.

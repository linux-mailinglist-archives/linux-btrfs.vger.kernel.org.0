Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCB5982F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiHRMNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiHRMNN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 08:13:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDFBB24A5
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 05:13:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EC973EEA9;
        Thu, 18 Aug 2022 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660824789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=esNB3ThwjNr9ANBFacF2t/3f0LEOpnn49s5rFBETPyo=;
        b=ePPtWXPmuqqxTMiOtBIkd81W832a6KOTLovB12nyZw6Fn5v7v7Fsm135CG2svNaZAAR/j0
        H42aw/zx5Uyt2oJ2BXIcTifGOEDeLom0NFhDlR+QOaBX/fzdriVwFOjd3w7o9HZPfTIw42
        Xj+DuvrBkWz+9d5ac2l9Ecf/S9lsis4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660824789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=esNB3ThwjNr9ANBFacF2t/3f0LEOpnn49s5rFBETPyo=;
        b=Eoz0kRPg6KkOqYF9vhbU0IG+iu40k/KMXwJqiWoLQoZgHgVxdI04KneIbWMtTbYYeQmCjh
        VnOJQ9pkPBGiMUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 043F0139B7;
        Thu, 18 Aug 2022 12:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7wUMANUs/mKtPgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 18 Aug 2022 12:13:08 +0000
Date:   Thu, 18 Aug 2022 14:07:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove impossible sanity checks
Message-ID: <20220818120757.GG13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <85c8bd723773791d0b74028488a821b42d83d48f.1660111131.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c8bd723773791d0b74028488a821b42d83d48f.1660111131.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 10, 2022 at 01:58:57PM +0800, Qu Wenruo wrote:
> There are several sanity checks which are no longer possible to trigger
> inside btrfs_scrub_dev().
> 
> Since we have mount time check against super block nodesize/sectorsize,
> and our fixed macro is hardcoded to handle even the worst combination.
> 
> Thus those sanity checks are no longer needed, can be easily removed.
> 
> But this patch still uses some ASSERT()s as a safe net just in case we
> change some features in the future to trigger those impossible
> combinations.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

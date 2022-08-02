Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1355880E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiHBRTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiHBRTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 13:19:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A5339BB0
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 10:19:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19EBA37CD1;
        Tue,  2 Aug 2022 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659460783;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/SoeHRj0F8+Ep1XSPqE9aTvKHVUgZtdy6YO061dcwQ=;
        b=EeMVVVeIbbH+1WJacEcb2z9hlXeKHyIUdG8jVX4+9S0b4ec/8UGIYzMW0XcM15pfKFOjZ/
        6bu0y4AqegWsLrhctzfL2BSLRqBe945mhXemf/wc12nMQxargHW/Qg7PSsougnEZOuTYc+
        N0HhhmBbku3B+4uBOJxKIidwW0NHcSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659460783;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/SoeHRj0F8+Ep1XSPqE9aTvKHVUgZtdy6YO061dcwQ=;
        b=ZW0OhLW697wqCiIiCyishrYI26pKyIBWOS+kbJRlkinnncYu5NNjYfVF2wrM9liQZLip4b
        g2GRug4J0E20iLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F064413A8E;
        Tue,  2 Aug 2022 17:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BD+oOa5c6WLCPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 17:19:42 +0000
Date:   Tue, 2 Aug 2022 19:14:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: dump extra info if one free space cache has more
 bitmaps than it should
Message-ID: <20220802171441.GT13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <8148a70ba12d1a0da36f0834fc2a92d4742820b7.1659317748.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8148a70ba12d1a0da36f0834fc2a92d4742820b7.1659317748.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 01, 2022 at 09:35:57AM +0800, Qu Wenruo wrote:
> There is an internal report on hitting the following ASSERT() in
> recalculate_thresholds():
> 
>  	ASSERT(ctl->total_bitmaps <= max_bitmaps);
> 
> Above @max_bitmaps is calculated using the following variables:
> 
> - bytes_per_bg
>   8 * 4096 * 4096 (128M) for x86_64/x86.
> 
> - block_group->length
>   The length of the block group.
> 
> @max_bitmaps is the rounded up value of block_group->length / 128M.
> 
> Normally one free space cache should not have more bitmaps than above
> value, but when it happens the ASSERT() can be triggered if
> CONFIG_BTRFS_ASSERT is also enabled.
> 
> But the ASSERT() itself won't provide enough info to know which is going
> wrong.
> Is the bg too small thus it only allows one bitmap?
> Or is there something else wrong?
> 
> So although I haven't found extra reports or crash dump to do further
> investigation, add the extra info to make it more helpful to debug.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

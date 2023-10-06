Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F07BBBEF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJFPm1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjJFPm0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 11:42:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABB9E
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 08:42:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C998A1F896;
        Fri,  6 Oct 2023 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696606943;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eiUrQCg9PF20ouAawQ9EuVc/6nXU4n8DSnHLdK0pJiw=;
        b=2wTZcPWyEm3MCh3dUz5vJcodMkWmoB1e8HPxaxFhhF/7x4Pv83P32e+pRQrVl7hjM3FPVh
        SvVTCfK/ATV6yqFKfxTlA7l7Dxm4HjZ/9/TYAmz+S1s1S+vSKtNGgMvJAP3V0GIoLZUdop
        o4DoBm+32DalrVtw836nGL50NaZU31A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696606943;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eiUrQCg9PF20ouAawQ9EuVc/6nXU4n8DSnHLdK0pJiw=;
        b=qfI5xvFXEBKmwznRQdJuLpRUJG9MIfvzyqufkEHNBUWKFYl61d0iZclg7t9jlYvKaDpoR1
        pLLIRwVzENuouhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2BF113A2E;
        Fri,  6 Oct 2023 15:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N2b0Jt8qIGUHBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 15:42:23 +0000
Date:   Fri, 6 Oct 2023 17:35:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: properly reserve metadata space for bgt
 conversion
Message-ID: <20231006153540.GK28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6c556ce0456303fb8ec23a454c3b5e18b874ae91.1696291742.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c556ce0456303fb8ec23a454c3b5e18b874ae91.1696291742.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 03, 2023 at 10:39:18AM +1030, Qu Wenruo wrote:
> There is a bug report that btrfstune failed to convert to block group
> tree.
> The bug report shows some very weird call trace, mostly fail at free
> space tree code.

If you mention a bug report please either add a link or describe the key
details of the report.

> One of the concern is the failed conversion may be caused by exhausted
> metadata space.
> In that case, we're doing quite some metadata operations (one
> transaction to convert 64 block groups in one go).
> 
> But for each transaction we have only reserved the metadata for one
> block group conversion (1 block for extent tree and 1 block for block
> group tree, this excludes free space and extent tree operations, as they
> should go global rsv).
> 
> Although we're not 100% sure about the failed conversion, at least we
> should handle the metadata reservation correctly, by properly reserve
> the needed space for the batch, and reduce the batch size just in case
> there isn't much metadata space left.

This is probably reasonable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

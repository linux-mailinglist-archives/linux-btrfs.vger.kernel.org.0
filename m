Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097AA7A2274
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjIOPda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjIOPd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 11:33:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4110E
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 08:33:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D74B1FD6E;
        Fri, 15 Sep 2023 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694792001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZL/ZI+IkrLfujs/5j7BgLAAESP9SEnREZ57umC4SCfU=;
        b=FJq2tiD/XXQN+10xvq7EdvQIy1+grLISC8txYDjLANwxXToxrDkIECJ5dEaHZYEv9xn3a5
        Zsk2JJ6+yojUmyn1lV/wN36lIa9ej/WKkjE6vmSPgMTHQRM9SmesPQLWtk+IN3k6OexwRy
        2vk5tDkyIM7mM9ShzXCaye4OkJsEyyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694792001;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZL/ZI+IkrLfujs/5j7BgLAAESP9SEnREZ57umC4SCfU=;
        b=XENZ1Chmpz/rwCRq1oOJ4m5vXKjhihoq3GsX//7NcmLLJK3BMIj3TRr45mwdSkKmcIOqjT
        8N3Ld0RHM2bIy1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54A381358A;
        Fri, 15 Sep 2023 15:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I6sRE0F5BGX2HgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 15:33:21 +0000
Date:   Fri, 15 Sep 2023 17:26:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove stale comment from btrfs_free_extent()
Message-ID: <20230915152647.GF2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <61aee02e43101491f4e83144fd58833f04848e16.1694790065.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61aee02e43101491f4e83144fd58833f04848e16.1694790065.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 04:02:56PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A comment at btrfs_free_extent() mentions the call to btrfs_pin_extent()
> unlocks the pinned mutex, however that mutex is long gone, it was removed
> in 2009 by commit 04018de5d41e ("Btrfs: kill the pinned_mutex"). So just
> delete the comment.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

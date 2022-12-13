Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B343264BC52
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiLMSr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiLMSry (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:47:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A86218A
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:47:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61F3F22BFB;
        Tue, 13 Dec 2022 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670957271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpK9ZMhGBIVpO/mUVWLC242mVxmA85f1Q9E/ykMiLX8=;
        b=kcKS8KkSPSO6HlZ3NRbJx3fOghrDDSIHH3hw1iVzauEeRri6TCTvBlOqrvBTrBq6SPTtcw
        X5yfoDfNlOeH+QAwoFHvqDmgiba9QD0Fn4cQzfTU7ffCNvsX+36kQSkMjBoVxFG0ZKTjiD
        aL9DP2dD1kgwSwGtTclxz8Ndc3Kyvds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670957271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpK9ZMhGBIVpO/mUVWLC242mVxmA85f1Q9E/ykMiLX8=;
        b=dOQRQYcyY07J3Tp8Ntv2ONTeGRy9c15fGJRTpPHrzPosq/urYDY1jm31UM0MCGyxyuMtoN
        gyTKHUDgyJ3zJQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E0FB138F9;
        Tue, 13 Dec 2022 18:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L9arDdfImGOwfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Dec 2022 18:47:51 +0000
Date:   Tue, 13 Dec 2022 19:47:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix leak of fs devices after removing btrfs module
Message-ID: <20221213184709.GG5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <914f0ef27d40e6bac9b63f27c40357e7dcdc1bb0.1670928105.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914f0ef27d40e6bac9b63f27c40357e7dcdc1bb0.1670928105.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 10:42:26AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When removing the btrfs module we are not calling btrfs_cleanup_fs_uuids()
> which results in leaking btrfs_fs_devices structures and other resources.
> This is a regression recently introduced by a refactoring of the module
> initialization and exit sequence, which simply removed the call to
> btrfs_cleanup_fs_uuids() in the exit path, resulting in the leaks.
> 
> So fix this by calling btrfs_cleanup_fs_uuids() at exit_btrfs_fs().
> 
> Fixes: 5565b8e0adcd ("btrfs: make module init/exit match their sequence")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

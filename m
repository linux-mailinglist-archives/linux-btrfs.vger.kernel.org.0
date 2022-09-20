Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34605BE5BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiITM1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiITM1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 08:27:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86BA53021
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 05:27:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6838A1F37C;
        Tue, 20 Sep 2022 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663676838;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4eb7mm6FWrWuMF/Niv7FAoUZMUT4w31bWebxrAcUa0=;
        b=dXW89pdtKhfB0Og6y/IFR+LdRi+as+KfKOnoKHJ7tqFnSRJOwSC4ucDYbVNBtHyre3zWea
        0vF4vYS2JgmIS2nd3hBRjvKi9ysZav4/1xAS3pC41tt5OY8LSCujTN3w7Eo1Y63ptVAy5Y
        Unjc8vmGeyTqgK8sDg1zYptaMzrwuJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663676838;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4eb7mm6FWrWuMF/Niv7FAoUZMUT4w31bWebxrAcUa0=;
        b=JRztux+H6Ua/gyDbHqdC0SxYMTue7LgUyQgezGfR1PkkeduD5Uzlqy+z0h28XOlKYEtXX2
        t3HhWULx3HMp9BBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48A4E13ABB;
        Tue, 20 Sep 2022 12:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBWFEKaxKWPMVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Sep 2022 12:27:18 +0000
Date:   Tue, 20 Sep 2022 14:21:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 05/15] btrfs: remove temporary btrfs_map_token
 declaration in ctree.h
Message-ID: <20220920122147.GX32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663196541.git.josef@toxicpanda.com>
 <cada813eb22ef6d856d17c15d4e4e5d883b38bc8.1663196541.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cada813eb22ef6d856d17c15d4e4e5d883b38bc8.1663196541.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 07:04:41PM -0400, Josef Bacik wrote:
> This was added while I was moving this code to its new home, it can be
> removed now.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 36a473f05831..a790c58b4c73 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -46,8 +46,6 @@ struct btrfs_ref;
>  struct btrfs_bio;
>  struct btrfs_ioctl_encoded_io_args;
>  
> -struct btrfs_map_token;

This patch was not applied as this line is not in current misc-next and
it probably depends on some other patchset.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3C573875
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiGMOLI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiGMOIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 10:08:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1575FA7
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:08:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47FAF33E08;
        Wed, 13 Jul 2022 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657721317;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COMZRmjtgEfs/6HH6q7YPzvcfDpJprGuVmJOOVK0c4g=;
        b=bZHUfWZX0FBnrlvdPSPzrCFsEvupQ5M3tV83o53TweO2PdGde2PcJkpR9YN01MfBYpiAFA
        1pCLOFfkr3dZjKeAplkIMO+JhbS+wGibWaGtp3QRZLYZIjt/ND4/q/a6dZkx+kxZvb8iLS
        mK2smeatZBeztbuOgGwe2Y+5LJr7Hb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657721317;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COMZRmjtgEfs/6HH6q7YPzvcfDpJprGuVmJOOVK0c4g=;
        b=wwZYlsesMCwAnO+I8GI9t7n8fFLp9GxjTAZETXVkAM84nvujeIpuzft6UoGDvb/vWjpFqG
        SByBOCJAxIVul+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C14513AAD;
        Wed, 13 Jul 2022 14:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qr7BCeXRzmJsVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Jul 2022 14:08:37 +0000
Date:   Wed, 13 Jul 2022 16:03:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify error handling in btrfs_lookup_dentry
Message-ID: <20220713140347.GG15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220711151618.2518485-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711151618.2518485-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 11, 2022 at 06:16:18PM +0300, Nikolay Borisov wrote:
> In btrfs_lookup_dentry releasing the reference of the sub_root and the
> running orphan cleanup should only happen if the dentry found actually
> represents a subvolume. This can only be true in the 'else' branch as
> otherwise either fixup_tree_root_location returned an ENOENT error, in
> which case sub_root wouldn't have been changed or if we got a different
> errno this means btrfs_get_fs_root couldn't have executed successfully
> again meaning sub_root will equal to root. So simplify all the branches
> by moving the code into the 'else'.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

There have been some suggestions how to improve the code, please resend
so we all have the same version to look at, thanks.

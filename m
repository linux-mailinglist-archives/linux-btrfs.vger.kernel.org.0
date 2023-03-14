Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87C6B9D9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCNRzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCNRzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 13:55:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9058276B4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 10:55:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45D0121AB2;
        Tue, 14 Mar 2023 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678816516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62QnF4KYJQfR2lQfdgpl8bkK7cIu3UEtkXg8qgdtkZk=;
        b=A5D0+BoQT07ksRTEXhZIh1M2pmROqupTbHbt9yrWiw6cC+DZHVkw4oKiDW250DEj1nvBDP
        61OF0OCmehS6UwmfEUuizaSNMymchr6pUkaLWJDA3Lc5zm/EyzzYXqYP6hscJal4IVn42x
        INFTb0smEFI9q1byG6vsvZregKlPGyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678816516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62QnF4KYJQfR2lQfdgpl8bkK7cIu3UEtkXg8qgdtkZk=;
        b=gIro6Y6M/nNeqtMwNuxlJZ+Y30rVkfJ31uA4yU8+7zr2+E/AX5ajNJbGdENd2eqrFZ7ykR
        DeNTF0NW/F2BZrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1412913A1B;
        Tue, 14 Mar 2023 17:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X+LcAwS1EGTUFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Mar 2023 17:55:16 +0000
Date:   Tue, 14 Mar 2023 18:49:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix btrfs_can_activate_zone() to support
 DUP profile
Message-ID: <20230314174909.GP10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b0e431dcee052cd66decba8a4484d28055d5d843.1678692557.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e431dcee052cd66decba8a4484d28055d5d843.1678692557.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 13, 2023 at 04:29:49PM +0900, Naohiro Aota wrote:
> btrfs_can_activate_zone() returns true if at least one device has one zone
> available for activation. This is OK for the single profile, but not OK for
> DUP profile. We need two zones to create a DUP block group. Fix it buy
> properly handle the case with the profile flags.
> 
> Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups")
> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/zoned.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f3fcc3e09550..f7397680cde9 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2099,11 +2099,21 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
>  		if (!device->bdev)
>  			continue;
>  
> -		if (!zinfo->max_active_zones ||
> -		    atomic_read(&zinfo->active_zones_left)) {
> +		if (!zinfo->max_active_zones) {
>  			ret = true;
>  			break;
>  		}
> +
> +		switch (flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> +		case 0: /* single */
> +			ret = atomic_read(&zinfo->active_zones_left) >= 1;

With ( ) around the expression it's more obvious that it's not a simple
assignment:

			ret = (atomic_read(&zinfo->active_zones_left) >= 1);

Updated in the commit.

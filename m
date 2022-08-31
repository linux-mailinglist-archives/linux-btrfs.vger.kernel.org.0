Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DBD5A80C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHaO6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiHaO5z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 10:57:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C09D91EA
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 07:57:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4E2021B77;
        Wed, 31 Aug 2022 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661957835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJ/kNiyjYB9f44RDuyDKmLRBILlfaTV5gS4BFiVSThk=;
        b=C3x2MKZ/QNqgQJM8nwCUkkurT1qKcr2RrPhYR1vpfmQZadVfTqtKWfukxD2PtRvVaNeOns
        rGBKTOY8K+XqGJWCiW3vATFtkshiJAgC4tWpiW+0UG6SqZ3S7gj/kf6jsX+ibpd30DAjv9
        ihqs40hbPVlSqO2y7rT98T2W0gpj528=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661957835;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJ/kNiyjYB9f44RDuyDKmLRBILlfaTV5gS4BFiVSThk=;
        b=9QcTBf8nw96oAowxGJois1TKCr3RkB8y2Zs93snHbedDAZYWE6PPxmTzb28jx4LPcO7tqr
        mE1wUr8EJD6T7pBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9362D13A7C;
        Wed, 31 Aug 2022 14:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X2D3Ist2D2OCYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 14:57:15 +0000
Date:   Wed, 31 Aug 2022 16:51:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@libero.it>
Subject: Re: [PATCH v3] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
Message-ID: <20220831145156.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@libero.it>
References: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a051edb23223036ebe21a01dd5d9ab63e54cc9.1661343122.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 24, 2022 at 08:16:22PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> There is an incident report that, one user hibernated the system, with
> one btrfs on removable device still mounted.
> 
> Then by some incident, the btrfs got mounted and modified by another
> system/OS, then back to the hibernated system.
> 
> After resuming from the hibernation, new write happened into the victim btrfs.
> 
> Now the fs is completely broken, since the underlying btrfs is no longer
> the same one before the hibernation, and the user lost their data due to
> various transid mismatch.
> 
> [REPRODUCER]
> We can emulate the situation using the following small script:
> 
>  truncate -s 1G $dev
>  mkfs.btrfs -f $dev
>  mount $dev $mnt
>  fsstress -w -d $mnt -n 500
>  sync
>  xfs_freeze -f $mnt
>  cp $dev $dev.backup
> 
>  # There is no way to mount the same cloned fs on the same system,
>  # as the conflicting fsid will be rejected by btrfs.
>  # Thus here we have to wipe the fs using a different btrfs.
>  mkfs.btrfs -f $dev.backup
> 
>  dd if=$dev.backup of=$dev bs=1M
>  xfs_freeze -u $mnt
>  fsstress -w -d $mnt -n 20
>  umount $mnt
>  btrfs check $dev
> 
> The final fsck will fail due to some tree blocks has incorrect fsid.
> 
> This is enough to emulate the problem hit by the unfortunate user.
> 
> [ENHANCEMENT]
> Although such case should not be that common, it can still happen from
> time to time.
> 
> >From the view of btrfs, we can detect any unexpected super block change,
> and if there is any unexpected change, we just mark the fs read-only, and
> thaw the fs.
> 
> By this we can limit the damage to minimal, and I hope no one would lose
> their data by this anymore.
> 
> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
> Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Use invalidate_inode_pages2_range() to avoid tricky page alignment
>   Previously I use truncate_inode_pages_range() with page aligned range.
>   But this can be confusing since truncate_inode_pages_ragen() can
>   fill unaligned range with zero. (thus I intentionally align the
>   range).
> 
>   Since we're only interesting dropping the page cache, use
>   invalidate_inode_pages2_range() should be better.
> 
> - Export btrfs_validate_super() to do full super block check at thaw
>   time
>   This brings all the checks, and since freeze/thaw should be a cold
>   path, the extra check shouldn't bother us much.
> 
> - Add an extra comment on why we don't need to hold device_list_mutex.

And the superblock checksum verification? It makes sense to validate the
individual sb items but after the checksum.

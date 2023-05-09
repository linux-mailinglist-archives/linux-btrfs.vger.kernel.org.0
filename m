Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616B96FD2B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjEIWdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjEIWdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:33:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF19B30C6
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 15:33:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D45021B37;
        Tue,  9 May 2023 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683671582;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8lf+M7VvDuyjwg4Vqi5WmTMYlz1McZxkujc/ejwInk=;
        b=ZtEmyhJEFERsn2e1P4SBpdTUkJPMO8qYpHbY//vQEw3HDBB1kWMEZi5nig8Pirn0rR/tn5
        Xl0rhmDDjDnUOvIMnGDr1fya2NkeoU4dQZbod5NHZVoM89lGy4VQ4pEuF8nSoGrENaGbSk
        B4XL5YAKmPZuW/pz+EmThvLGQxrXPY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683671582;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8lf+M7VvDuyjwg4Vqi5WmTMYlz1McZxkujc/ejwInk=;
        b=8/RMFppebngMH6dZYfL8ZC4kGXZRBuOvDVRZjpdN2UIvYecTFOeJT5JZpGVA4grqWSDz5+
        Fd4BEALJOuAa/MDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A51B13581;
        Tue,  9 May 2023 22:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AUAGER7KWmTqdAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:33:02 +0000
Date:   Wed, 10 May 2023 00:27:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix full zone SB reading on ZNS
Message-ID: <20230509222702.GI32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1932c39db3905ca491009e9956afe511d7b4767c.1683656399.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1932c39db3905ca491009e9956afe511d7b4767c.1683656399.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 06:29:15PM +0000, Naohiro Aota wrote:
> When both of the superblock zones are full, we need to check which
> superblock is newer. The calculation of last superblock position is wrong
> as it does not consider zone_capacity. Fix it.
> 
> Fixes: 9658b72ef300 ("btrfs: zoned: locate superblock position using zone capacity")
> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/zoned.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index e3fe02aae641..cd1fee22998c 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -122,10 +122,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>  		int i;
>  
>  		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> -			u64 bytenr;
> -
> -			bytenr = ((zones[i].start + zones[i].len)
> -				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
> +			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
> +			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
> +				BTRFS_SUPER_INFO_SIZE;

I did a quick grep for 'zone.*len' as a wide search for potential
candidates of the same pattern but haven't spotted anything obvious.
With the ZNS support it may be useful to have a helper to read the zone
end in case the real blocks need to be considered, like here.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3370E76C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 23:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbjEWVhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 17:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjEWVhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 17:37:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BA119
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 14:37:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6305B1FD79;
        Tue, 23 May 2023 21:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684877869;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNU9Izf64Je3RrH+WoOHg5visH9fSgipoz1ym6oZrJk=;
        b=z+EoSyzLW0xecQ0LqsB1Ky4eGNeHmPjKwtSYXSA4sQRqQWXAY09jffdi66rktDg4ds97Fu
        ap+WElG27Afh0ZSri3MeG5UPAz3SQZtCnVlGJ1jMzILTjpEmeAgGMKrcdTxFE2BAJiKygn
        Av7ZUU+yqZzYpezsmDtG4SE1GPNs8So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684877869;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNU9Izf64Je3RrH+WoOHg5visH9fSgipoz1ym6oZrJk=;
        b=4+FVEZYu19VagVlHheOrRRtv9tkJE6F0MwKKhJGk4h9UeYSwYLfr9TFygfXJg2hTZp9vkC
        4c6Su2e5U6a+EHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37DB713588;
        Tue, 23 May 2023 21:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VgYuDC0ybWTcCgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 21:37:49 +0000
Date:   Tue, 23 May 2023 23:31:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate
 fsid_change
Message-ID: <20230523213142.GF32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684826246.git.anand.jain@oracle.com>
 <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
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

On Tue, May 23, 2023 at 06:03:15PM +0800, Anand Jain wrote:
> By relocating the bool fsid_change near other bool declarations in the
> struct btrfs_fs_devices, approximately 6 bytes is saved.
> 
>    before: 512 bytes
>    after: 496 bytes
> 
> Furthermore, adding comments.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5cbbee32748c..a9a86c9220b3 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -281,7 +281,6 @@ enum btrfs_read_policy {
>  struct btrfs_fs_devices {
>  	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>  	u8 metadata_uuid[BTRFS_FSID_SIZE];
> -	bool fsid_change;
>  	struct list_head fs_list;
>  
>  	/*
> @@ -337,17 +336,24 @@ struct btrfs_fs_devices {
>  	struct list_head alloc_list;
>  
>  	struct list_head seed_list;
> -	bool seeding;
>  
> +	/* count fs-devices opened */
>  	int opened;
>  
> -	/* set when we find or add a device that doesn't have the
> +	/*
> +	 * set when we find or add a device that doesn't have the
>  	 * nonrot flag set

Please reformat comments so they follow the most up to date style, which
is to be a full sentence (with "." at the end) and if it fits on one
line then it's the /* text */ otherwise multiline /* ... */.

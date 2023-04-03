Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA436D50B6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjDCSfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjDCSfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 14:35:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2081B8
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 11:35:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10CF7200FA;
        Mon,  3 Apr 2023 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680546928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J+vSfQanHamceF0Dfk7zWYMmHfYmn1qqT3eSyJ2HM7k=;
        b=h88m+F0b4lLaPCl7OEMs2BL9lmzFVuuUvZZ5ftCDYymumW2XCII4TZiJeZrhRt5Mj6bMZd
        X8Ri00c5E2PAK2gEX4qpgKPa9u+R4YoMGcVAMqcDNW2soKSFFgb8Io5fOB4o5RnCbffLsK
        OX8gTpQ1rLyw9JqWAnfn7rTOHXN9FiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680546928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J+vSfQanHamceF0Dfk7zWYMmHfYmn1qqT3eSyJ2HM7k=;
        b=mOVt8NaayuMDEz1L751yTCbFc0yAVsYm0OSPpQUO0TmvAEcEliDMkE4uf8WSfWPo1ElEFJ
        qUb2Z6upzz4q7AAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D584F13416;
        Mon,  3 Apr 2023 18:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C3hTM28cK2QNIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 03 Apr 2023 18:35:27 +0000
Date:   Mon, 3 Apr 2023 20:35:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: fix fast csum detection
Message-ID: <20230403183526.GC19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230329001308.1275299-1-hch@lst.de>
 <20230329001308.1275299-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329001308.1275299-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 29, 2023 at 09:13:05AM +0900, Christoph Hellwig wrote:
> The BTRFS_FS_CSUM_IMPL_FAST flag is current set whenever a non-generic
> crc32c is detected, which is the incorrect check if the file system uses
> a different checksumming algorithm.  Refactor the code to only checks
> this if crc32 is actually used.  Note that in an ideal world the
> information if an algorithm is hardware accelerated or not should be
> provided by the crypto API instead, but that's left for another day.

https://lore.kernel.org/linux-crypto/20190514213409.GA115510@gmail.com/
I got pointed to the driver name, the priority that would say if the
implementation is accelerated is not exported to the API. This would be
cleaner but for a simple 'is/is-not' I think it's sufficient.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/disk-io.c | 18 +++++++++++++++++-
>  fs/btrfs/super.c   |  2 --
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3f57c41f41bf5f..ec765d6bc53673 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -154,6 +154,21 @@ static bool btrfs_supported_super_csum(u16 csum_type)
>  	}
>  }
>  
> +/*
> + * Check if the CSUM implementation is a fast accelerated one.
> + * As-is this is a bit of a hack and should be replaced once the
> + * csum implementations provide that information themselves.
> + */
> +static bool btrfs_csum_is_fast(u16 csum_type)
> +{
> +	switch (csum_type) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +		return !strstr(crc32c_impl(), "generic");

This would check the internal shash (lib/libcrc32c.c) not the one we
allocate for btrfs in btrfs_init_csum_hash. Though they both should be
equivalent as libcrc32c does some tricks to lookup the fastest
implementation but theoretically may not find the fast one, while mount
could.

> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * Return 0 if the superblock checksum type matches the checksum value of that
>   * algorithm. Pass the raw disk superblock data.
> @@ -3373,7 +3388,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		btrfs_release_disk_super(disk_super);
>  		goto fail_alloc;
>  	}
> -
> +	if (btrfs_csum_is_fast(csum_type))
> +		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);

This ^^^

>  	fs_info->csum_size = btrfs_super_csum_size(disk_super);
>  
>  	ret = btrfs_init_csum_hash(fs_info, csum_type);

should be moved after the initialization btrfs_init_csum_hash so it
would also detect accelerated implementation of other hashes.

> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d8885966e801cd..e94a4cd06607e1 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1517,8 +1517,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
>  					s->s_id);
>  		btrfs_sb(s)->bdev_holder = fs_type;
> -		if (!strstr(crc32c_impl(), "generic"))
> -			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
>  		error = btrfs_fill_super(s, fs_devices, data);
>  	}
>  	if (!error)
> -- 
> 2.39.2

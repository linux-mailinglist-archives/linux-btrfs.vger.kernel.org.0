Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D16BD3F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjCPPhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCPPhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 11:37:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED4166E1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:34:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D24221A36;
        Thu, 16 Mar 2023 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678980802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/OPAM7oxewr2rmuXTL1Aik+BcZJXluZfHkh1zgCPxpE=;
        b=fG4rqRIAqY+uetaRziIyCUSngTk54ricAfKYYn+b4xxd5T5Esqb8m7eYee0m98Te7V3LZB
        sSt7vq8IuS0f9T3vBSvFhPmn+9VeiR4QF1bEXlpgoo3aM5k8KwsyO43BNSFq+t6OagYCTO
        FbQUQYiOqIjlgtZJhtY2fGDLGbsq5Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678980802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/OPAM7oxewr2rmuXTL1Aik+BcZJXluZfHkh1zgCPxpE=;
        b=PfonKJxD2UNfDyUitD+nmb2qsHzHr+hZEgdGGLJpsZn/ExQKvsLR4+AeXB8e6Bjgs6B7lP
        1uhwco/JDicMTJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A61F613A2F;
        Thu, 16 Mar 2023 15:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +pOfJ8E2E2QnDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Mar 2023 15:33:21 +0000
Date:   Thu, 16 Mar 2023 16:27:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs-progs: sync ioctl from kernel
Message-ID: <20230316152714.GZ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676115988.git.wqu@suse.com>
 <3b6d9333e90103336e49e0b6a52118617928e3e4.1676115988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6d9333e90103336e49e0b6a52118617928e3e4.1676115988.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 11, 2023 at 07:50:31PM +0800, Qu Wenruo wrote:
> This sync is mostly for the new member, btrfs_ioctl_dev_info_args::fsid.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  ioctl.h          | 13 ++++++++++++-
>  libbtrfs/ioctl.h | 13 ++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/ioctl.h b/ioctl.h
> index 1af16db13241..034f38dd702a 100644
> --- a/ioctl.h
> +++ b/ioctl.h
> @@ -214,7 +214,18 @@ struct btrfs_ioctl_dev_info_args {
>  	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
>  	__u64 bytes_used;			/* out */
>  	__u64 total_bytes;			/* out */
> -	__u64 unused[379];			/* pad to 4k */
> +	/*
> +	 * Optional, out.
> +	 *
> +	 * Showing the fsid of the device, allowing user space
> +	 * to check if this device is a seed one.
> +	 *
> +	 * Introduced in v6.4, thus user space still needs to
> +	 * check if kernel changed this value.
> +	 * Older kernel will not touch the values here.
> +	 */
> +	__u8 fsid[BTRFS_UUID_SIZE];
> +	__u64 unused[377];			/* pad to 4k */
>  	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
>  };
>  BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
> diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
> index f19695e30a63..0b19efde4915 100644
> --- a/libbtrfs/ioctl.h
> +++ b/libbtrfs/ioctl.h
> @@ -215,7 +215,18 @@ struct btrfs_ioctl_dev_info_args {
>  	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
>  	__u64 bytes_used;			/* out */
>  	__u64 total_bytes;			/* out */
> -	__u64 unused[379];			/* pad to 4k */
> +	/*
> +	 * Optional, out.
> +	 *
> +	 * Showing the fsid of the device, allowing user space
> +	 * to check if this device is a seed one.
> +	 *
> +	 * Introduced in v6.4, thus user space still needs to
> +	 * check if kernel changed this value.
> +	 * Older kernel will not touch the values here.
> +	 */
> +	__u8 fsid[BTRFS_UUID_SIZE];
> +	__u64 unused[377];			/* pad to 4k */

Please don't change libbtrfs interface, it's supposed to be frozen and
not changed anymore. The libbtrfsutil/btrfs.h should be changed instead.

>  	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
>  };
>  BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
> -- 
> 2.39.1

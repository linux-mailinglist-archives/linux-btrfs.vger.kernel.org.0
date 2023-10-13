Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A390E7C8995
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjJMQCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjJMQCo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 12:02:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE073BD
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 09:02:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5055521A15;
        Fri, 13 Oct 2023 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697212961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdctSqwb267kNsJf1XaVL0+OJbmTWk3h90JMH9zBexo=;
        b=T2uyF53fGZ7AXHYxuglWU7HvjryWDR0k9pu3bOfyzPyjTphRnyf1Ya7CYsnBEoGPgbyGu/
        9XAYfYo+LsIDhcuxmANUNChqv/qEN9aBAGN/9gaysVu05qCfQzk/Fsrf0sHDX4uHsgm3gP
        fF6BNcOEk37g5mBgV+IektfQMhJMmQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697212961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdctSqwb267kNsJf1XaVL0+OJbmTWk3h90JMH9zBexo=;
        b=JvWcPMUlvoOybN19DxAdLjvGH01WuJRnaIrCLfEKUkH7Z31KwyuOMNOY/B3O5MVRIw4KiB
        Okn5zV46eWWi4MDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2940B1358F;
        Fri, 13 Oct 2023 16:02:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id krbuCCFqKWXzXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 16:02:41 +0000
Date:   Fri, 13 Oct 2023 17:55:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs-progs: mkfs/rootdir: copy missing
 attributes for the rootdir inode
Message-ID: <20231013155553.GQ2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697057301.git.wqu@suse.com>
 <d33e5e10e92a0c8c2a82005eba1da47927bf286a.1697057301.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d33e5e10e92a0c8c2a82005eba1da47927bf286a.1697057301.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[36.41%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 07:19:25AM +1030, Qu Wenruo wrote:
> [BUG]
> When using "mkfs.btrfs" with "--rootdir" option, the top level inode
> (rootdir) will not get the same xattr from the source dir:
> 
>   mkdir -p source_dir/
>   touch source_dir/file
>   setfattr -n user.rootdir_xattr source_dir/
>   setfattr -n user.regular_xattr source_dir/file
>   mkfs.btrfs -f --rootdir source_dir $dev
>   mount $dev $mnt
>   getfattr $mnt
>   # Nothing <<<
>   getfattr $mnt/file
>   # file: $mnt/file
>   user.regular_xattr <<<
> 
> [CAUSE]
> In function traverse_directory(), we only call add_xattr_item() for all
> the child inodes, not really for the rootdir inode itself, leading to
> the missing xattr items.
> 
> Not only xattr, in fact we also miss the uid/gid/timestamps/mode for the
> rootdir inode.
> 
> [FIX]
> Extract a dedicated function, copy_rootdir_inode(), to handle every
> needed attributes for the rootdir inode, including:
> 
> - xattr
> - uid
> - gid
> - mode
> - timestamps
> 
> Issue: #688
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  mkfs/rootdir.c | 88 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 21 deletions(-)
> 
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index a413a31eb2d6..24e26cdf50e0 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -429,6 +429,69 @@ end:
>  	return ret;
>  }
>  
> +static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
> +			      struct btrfs_root *root, const char *dir_name)
> +{
> +	u64 root_dir_inode_size;
> +	struct btrfs_inode_item *inode_item;
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct stat st;
> +	int ret;
> +
> +	ret = stat(dir_name, &st);

According to the v3 changelog this should be lstat(), right?

> +	if (ret < 0) {
> +		ret = -errno;
> +		error("lstat failed for direcotry %s: $m", dir_name);
                       ^^^^^

like here.

> +		return ret;
> +	}

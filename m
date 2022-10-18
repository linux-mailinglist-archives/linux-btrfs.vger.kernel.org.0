Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A191E602CF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJRN2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJRN2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:28:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA545F7D
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:28:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B11FA1FE5B;
        Tue, 18 Oct 2022 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666099700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3LXYkGSfggutAQsrpeh3yPSup7dyZHG9ZqF6YUDq0M=;
        b=itkJOmHKkNQRarsEK9A3yTw/YRIu49g+oEAQT0UPzTXzgNgqacC+FQDRBgcvPjrbcSuI/X
        Je2+Eig+wxMYm0XzzstA0VdllXBlW4aru8FuZdePGgtMvBSwcJGX8iJzh1Va31bePZNU4T
        /BRqD+vR8yuahxwrEBpnAG4cNtVHQYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666099700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3LXYkGSfggutAQsrpeh3yPSup7dyZHG9ZqF6YUDq0M=;
        b=p5FR2VO+/b510wcH0e1iv8I8DNWJSanbSp45lshhdHUI4pI6LA7aYcbT3Sb2ShJiiNHQ+k
        yyOZl/yRAxx2bVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8916B139D2;
        Tue, 18 Oct 2022 13:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eX3WHvSpTmMvHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 13:28:20 +0000
Date:   Tue, 18 Oct 2022 15:28:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make thawn time super block check to also verify
 checksum
Message-ID: <20221018132810.GV13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b5eb3e1c071c9bd79dab0bb9883ad86843e00051.1666058154.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5eb3e1c071c9bd79dab0bb9883ad86843e00051.1666058154.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 18, 2022 at 09:56:38AM +0800, Qu Wenruo wrote:
> Previous commit a05d3c915314 ("btrfs: check superblock to ensure the fs
> was not modified at thaw time") only checks the content of the super
> block, but it doesn't really check if the on-disk super block has a
> matching checksum.
> 
> This patch will add the checksum verification to thawn time superblock
> verification.
> 
> This involves the following extra changes:
> 
> - Export btrfs_check_super_csum()
>   As we need to call it in super.c.
> 
> - Change the argument list of btrfs_check_super_csum()
>   Instead of passing a char *, directly pass struct btrfs_super_block *
>   pointer.
> 
> - Verify that our csum type didn't change before checking the csum
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks. Can you please also send a test case?

> ---
>  fs/btrfs/disk-io.c | 10 ++++------
>  fs/btrfs/disk-io.h |  2 ++
>  fs/btrfs/super.c   | 16 ++++++++++++++++
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9f526841c68b..5bf373f606e0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -166,11 +166,9 @@ static bool btrfs_supported_super_csum(u16 csum_type)
>   * Return 0 if the superblock checksum type matches the checksum value of that
>   * algorithm. Pass the raw disk superblock data.
>   */
> -static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
> -				  char *raw_disk_sb)
> +int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
> +			   struct btrfs_super_block *disk_sb)

			   const

>  {
> -	struct btrfs_super_block *disk_sb =
> -		(struct btrfs_super_block *)raw_disk_sb;
>  	char result[BTRFS_CSUM_SIZE];
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  
> @@ -181,7 +179,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>  	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space is
>  	 * filled with zeros and is included in the checksum.
>  	 */
> -	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
> +	crypto_shash_digest(shash, (u8 *)disk_sb + BTRFS_CSUM_SIZE,

				   (const u8 *)

>  			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
>  
>  	if (memcmp(disk_sb->csum, result, fs_info->csum_size))

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB17249EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjFFROg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjFFROf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 13:14:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267118E
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 10:14:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96883218F4;
        Tue,  6 Jun 2023 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686071671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9mDiqSKRA7elIlwr0fVXA+jM8SHBMUPWvPI1zFCT4A=;
        b=cJ7UGVrBPLFQOIqDWL/pMQpWLx7+rTjfWtljTx/5zTLughfRpKfD8D+T4E+/P6yVgDlUPd
        T/0JnoN4PFdVVG01Y6bzOeLB1XOrH1G76Gxl/fXe3wMlBbB+xhtlvZudxfGSK1auBTcONe
        bkRkhYmmhZj6WN0FN+ne2ypJkqVQRog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686071671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9mDiqSKRA7elIlwr0fVXA+jM8SHBMUPWvPI1zFCT4A=;
        b=UlsbVG/R21V77xOMz/POir8B7yP3tIyaFurP/SbGue4jzOTO0qtavTuQGagiNVrscNrD6r
        VSxUzRHnS5bbtODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DC3A13519;
        Tue,  6 Jun 2023 17:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IYl+GXdpf2QGVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 17:14:31 +0000
Date:   Tue, 6 Jun 2023 19:08:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: factor out a btrfs_inode_is_nodatasum helper
Message-ID: <20230606170816.GL25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230605084519.580346-1-hch@lst.de>
 <20230605084519.580346-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605084519.580346-2-hch@lst.de>
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

On Mon, Jun 05, 2023 at 10:45:18AM +0200, Christoph Hellwig wrote:
> Split out a helper to check if an inode needs nodatasum treatment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c         | 3 +--
>  fs/btrfs/btrfs_inode.h | 7 +++++++
>  fs/btrfs/file-item.c   | 3 +--
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index c9b4aa339b4b07..627d06fbb4c425 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -659,8 +659,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  		 * Csum items for reloc roots have already been cloned at this
>  		 * point, so they are handled as part of the no-checksum case.
>  		 */
> -		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
> -		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
> +		if (inode && !btrfs_inode_is_nodatasum(inode) &&
>  		    !btrfs_is_data_reloc_root(inode->root)) {
>  			if (should_async_write(bbio) &&
>  			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 8abf96cfea8fae..713439d62adda3 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -535,4 +535,11 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode, const u64 add_bytes,
>  			      const u64 del_bytes);
>  void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
>  
> +static inline bool btrfs_inode_is_nodatasum(struct btrfs_inode *inode)
> +{
> +	return (inode->flags & BTRFS_INODE_NODATASUM) ||
> +		test_bit(BTRFS_FS_STATE_NO_CSUMS,
> +			 &inode->root->fs_info->fs_state);

This mixes inode and filesystem but the function only talks about an
inode. Also BTRFS_FS_STATE_NO_CSUMS is an exceptional state, more like a
rescue state to allow accessing filesytem with broken checksums and it
is supposed to stand out in the conditions, not be hidden in a helper.

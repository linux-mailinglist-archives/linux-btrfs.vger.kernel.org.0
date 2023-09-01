Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2478FB9E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 12:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjIAKMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIAKMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 06:12:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2817D1B2
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 03:12:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D69081F459;
        Fri,  1 Sep 2023 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693563165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axXQKqywXfmB/oGpFYFb3aj4Ad7OxCHacXwMDgC58PI=;
        b=MtlmrdoT3/hizS3uPHmUL5fFZPmCjXlKielACAGJkxxsrqPP7dNQtceL0tuK52UBuhJ/Yk
        DwAePHPfeLjRRVUXU/FaoWHDryXBDG7xQh1FiaA+DTGWu6Ckubkr7VlJr3XA1+Vm7PUTLi
        qLc9ZK6z9HI8f+FdoG+m7QhQ8zGjn8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693563165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axXQKqywXfmB/oGpFYFb3aj4Ad7OxCHacXwMDgC58PI=;
        b=vL768TJTbt55AOMg0Z0tsiLdOJaO4UffNqEQO0xXTXk/g2xZfbmb197EU3CuB8qUfZJOL7
        TKosZJ/dAqrGc9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A95961358B;
        Fri,  1 Sep 2023 10:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ryQ1KB258WQEWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 01 Sep 2023 10:12:45 +0000
Date:   Fri, 1 Sep 2023 12:06:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: libbtrfs: fix API compatibility change
Message-ID: <20230901100608.GJ14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4d54ca8fb8605704260aad205acd6185fe73fb49.1693561063.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d54ca8fb8605704260aad205acd6185fe73fb49.1693561063.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 01, 2023 at 05:37:44PM +0800, Qu Wenruo wrote:
> In commit 83ab92512e79 ("libbtrfs: remove the support for fs without
> uuid tree"), the change to libbtrfs leads to an incompatible API change.
> 
> It's mostly in the subvol_info structure, that with the removed rb_node
> structures, the subvol_info can no longer be compatible to older
> versions due to the changed offset of the new members.
> 
> Fix it by adding back the old rb_node members mostly as a place holder.

Thanks but I'd rather do a revert of the patch that caused the breakage.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  libbtrfs/send-utils.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/libbtrfs/send-utils.h b/libbtrfs/send-utils.h
> index be6f91b1d7bb..02f519c84804 100644
> --- a/libbtrfs/send-utils.h
> +++ b/libbtrfs/send-utils.h
> @@ -43,6 +43,14 @@ enum subvol_search_type {
>  };
>  
>  struct subvol_info {
> +	/*
> +	 * Those members are not longre utilized, but still need to be there
> +	 * for API compatibility.
> +	 */
> +	struct rb_node rb_root_id_node;
> +	struct rb_node rb_local_node;
> +	struct rb_node rb_received_node;
> +	struct rb_node rb_path_node;
>  
>  	u64 root_id;
>  	u8 uuid[BTRFS_UUID_SIZE];
> @@ -58,6 +66,14 @@ struct subvol_info {
>  
>  struct subvol_uuid_search {
>  	int mnt_fd;
> +
> +	/* The following members are deprecated. */
> +	int __uuid_tree_existed;
> +
> +	struct rb_root __root_id_subvols;

As pointed out in our bugzilla you've added "__" which is not 1:1 to the
original and could cause further problems.

> +	struct rb_root __local_subvols;
> +	struct rb_root __received_subvols;
> +	struct rb_root __path_subvols;
>  };
>  
>  int subvol_uuid_search_init(int mnt_fd, struct subvol_uuid_search *s);
> -- 
> 2.41.0

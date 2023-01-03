Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020C465C362
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjACP4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 10:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjACP43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 10:56:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E034360C8
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 07:56:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 906CB33749;
        Tue,  3 Jan 2023 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672761387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gOd9qXS4hX97zRW1zHNUf2/nVUH3bUAXuDirikuYVY=;
        b=R+oAs2oDVItMxdk4TJZJxd7QWygRyK+PZHofPwEYDGvqOcFeQnkaDOuiBYyNYhlJ9YViZb
        qiRj8dvY+1hAQ8oIlX0YgZRhuphb4KYlAlIHShp77f7gj7ngozMM9a8a0tuGd52Rr5zPWu
        GAgEQchh2uUFoClg9LATTfiL4FMyIvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672761387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gOd9qXS4hX97zRW1zHNUf2/nVUH3bUAXuDirikuYVY=;
        b=Vst8vCFEvji8nKMj09YS/OkASa4Mm5jbb+URfdrghTEOLHxXZrn4Zhv+a3AWn5yDF6tY88
        ejDD+wmlbYcbcmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DBB81390C;
        Tue,  3 Jan 2023 15:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GV8LFitQtGP1egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Jan 2023 15:56:27 +0000
Date:   Tue, 3 Jan 2023 16:50:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Siddhartha Menon <siddharthamenon@outlook.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH 1/2] Check return value of unpin_exten_cache
Message-ID: <20230103155056.GQ11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <PAXP193MB2089D736D647D6D2CEF4D6E1A7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
 <PAXP193MB2089D68F6B6E11464FB202FFA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXP193MB2089D68F6B6E11464FB202FFA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 31, 2022 at 06:47:48PM +0000, Siddhartha Menon wrote:
> Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8bcad9940154..cb95d47e4d02 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3331,7 +3331,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  						ordered_extent->disk_num_bytes);
>  		}
>  	}
> -	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
> +	ret = unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
>  			   ordered_extent->num_bytes, trans->transid);

This is right but the errors need to be propagated upwards in the call
chain and the call graph starting from that function must handle that
properly, which is not true due to unhandled em =
lookup_extent_mapping() error.

Also please don't forget to write changelogs, this is not a trivial
change where the subject would be sufficient.

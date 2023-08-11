Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6614B77933A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjHKPeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjHKPeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:34:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F5530CB
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:34:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E81521888;
        Fri, 11 Aug 2023 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691768039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgP5wPLQTtiZCRznzVh/G7/uGFD7bHBwQyKA15XOaYQ=;
        b=mVmDJx1NenTr2zdg5T7Xl7+yb3ixRn/QvtLbk+ARvxsBUQiGKn6yK27ZqEu9FShtbX3hnL
        Hj/sWsH//WmXSArqI3EWHcePNKQ7GDsbwCVIxginoZXFYblp5dMH2ZpurcNl2j7Wldtm74
        AwaqIm9AKXC8yVfURjR43QO+3eeTllI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691768039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgP5wPLQTtiZCRznzVh/G7/uGFD7bHBwQyKA15XOaYQ=;
        b=1KmgiveM/nEgTNEwarKX1r8Bk/lulAACWpgVvig+deTjgzt2Q9P1SyJ9RkaUmaWWQ6ACZy
        Xyfngm+UwM1aSECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE64A13592;
        Fri, 11 Aug 2023 15:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 56dnOeZU1mSFNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:33:58 +0000
Date:   Fri, 11 Aug 2023 17:27:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/7] btrfs: fix fsid in btrfs_validate_super
Message-ID: <20230811152733.GR2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690792823.git.anand.jain@oracle.com>
 <19310b1aee2625da1a90f59c03a8b78fbe21e8f3.1690792823.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19310b1aee2625da1a90f59c03a8b78fbe21e8f3.1690792823.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 07:16:34PM +0800, Anand Jain wrote:
> The function btrfs_validate_super() should verify the fsid in the provided
> superblock argument. Because, all its callers expects it to do that.
> 
> Such as in the following stack:
> 
>    write_all_supers()
>        sb = fs_info->super_for_commit;
>        btrfs_validate_write_super(.., sb)
>          btrfs_validate_super(.., sb, ..)
> 
>    scrub_one_super()
> 	btrfs_validate_super(.., sb, ..)
> 
> And
>    check_dev_super()
> 	btrfs_validate_super(.., sb, ..)
> 
> However, it currently verifies the fs_info::super_copy::fsid instead,
> which does not help.
> 
> Fix this using the correct fsid in the superblock argument.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/disk-io.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b4495d4c1533..f2279eb93370 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2373,11 +2373,10 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>  		ret = -EINVAL;
>  	}
>  
> -	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
> -		   BTRFS_FSID_SIZE)) {
> +	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {

For memcpy and strcpy please compare it against 0 so it follows the
semantics of "is equal" or "is not equal".

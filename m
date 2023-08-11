Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B41779380
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjHKPtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjHKPtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:49:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295D726BC
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:49:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D72832186C;
        Fri, 11 Aug 2023 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691768945;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2ZHc7U/A7574890jH7oQRwHlN0g7hysUKr+TPURPoA=;
        b=zfLDsqD6jsDxGDidUEPEO3XbQHEhz4y8/fR39XbrEhAYJh94qXlciIKiHZxrHPTvIYHnIQ
        a6Za1jvNvBbj5uKjScSa1cYriA7lfyR7faGdehwSZ2p6toqZOI7tjYaXCvtavWNmdV/lnl
        8z7cfoIUGj0vlwdZO+uXFeaInGFZayI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691768945;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2ZHc7U/A7574890jH7oQRwHlN0g7hysUKr+TPURPoA=;
        b=J/LIHKRize2A/UGlX6N/kavxbwJXHpdMzfv+Z3R/JVOpjE9hUNAD281D/k1TbhdCHFTlHK
        u1CXRf62Na+CvxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B279213592;
        Fri, 11 Aug 2023 15:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 94S2KnFY1mRMOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:49:05 +0000
Date:   Fri, 11 Aug 2023 17:42:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/7] btrfs: use btrfs_sb_metadata_uuid_or_null
Message-ID: <20230811154240.GT2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690792823.git.anand.jain@oracle.com>
 <69a45acb12680df22a7c7052e788450e7f780d91.1690792823.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a45acb12680df22a7c7052e788450e7f780d91.1690792823.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 07:16:38PM +0800, Anand Jain wrote:
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 661dc69543eb..316839d2aecc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -821,7 +821,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  
>  	if (!fs_devices) {
>  		fs_devices = alloc_fs_devices(disk_super->fsid,
> -				has_metadata_uuid ? disk_super->metadata_uuid : NULL);
> +				btrfs_sb_metadata_uuid_or_null(disk_super));

This is the only place that passes a non-NULL pointer to
alloc_fs_devices, so it might be better to drop the 2nd argument
completely and just set the metadata_uuid here, which is basically
copying fsid to metadata_uuid.

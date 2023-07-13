Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB7752A98
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGMSzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGMSzM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:55:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF72230D0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:54:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89C3D22120;
        Thu, 13 Jul 2023 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689274479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFx5otbQZgPMy3HLXbqvYo4T/QeaAfqcsBtgi0ZY0Qs=;
        b=o4FE8J95vj7iGQhzVlHSqFVyKWXiSoojliXodq2Am2Gu2T1VgX+kVP8JGNig2rOlp3y/83
        41NcHEOJ0eguBHbOfFHD6GEdTEzMoNdy+DYkoyn8J3l4YIHIvRuXN93GNnQRaG1+AIRzPp
        pykl09pIDL3rK6N2t8D+LNL4hQBMNjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689274479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFx5otbQZgPMy3HLXbqvYo4T/QeaAfqcsBtgi0ZY0Qs=;
        b=hsPw5pvZgvXRDhvgV5D41SaFujI4prg4smtWek6MA/dn6BHKuke7cmg6i/xmvZ/lQaxfxn
        orN189VXQWAHFOBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6400B133D6;
        Thu, 13 Jul 2023 18:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TOuYF29IsGQFBgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 18:54:39 +0000
Date:   Thu, 13 Jul 2023 20:48:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/11] btrfs-progs: call warn() for missing device
Message-ID: <20230713184802.GC30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688724045.git.anand.jain@oracle.com>
 <e4e0299f46b9b4715039cd74f90944d9357446af.1688724045.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e0299f46b9b4715039cd74f90944d9357446af.1688724045.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 07, 2023 at 11:52:32PM +0800, Anand Jain wrote:
> When we add a struct btrfs_device for the missing device, announce a
> warning indicating that a device is missing.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  kernel-shared/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index 92282524867d..d20cb3177a34 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -2252,6 +2252,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
>  
>  	device = btrfs_find_device(fs_info, devid, dev_uuid, fs_uuid);
>  	if (!device) {
> +		warning("device id %llu is missing", devid);

read_one_dev() is a low level helper that should not print any messages,
the calling context is not known. If you really want to print such
message then please move it to the appropriate caller.

>  		device = kzalloc(sizeof(*device), GFP_NOFS);
>  		if (!device)
>  			return -ENOMEM;
> -- 
> 2.39.3

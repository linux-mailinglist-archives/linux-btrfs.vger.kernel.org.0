Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F486526DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiLTTRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTTRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 14:17:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D5FE1A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:17:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22B456029A;
        Tue, 20 Dec 2022 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671563849;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHrlbZbAHx6HgiASBDYpw/iDxLRufFQU7asxqAEWK3M=;
        b=pn/XCSg76MsSHQppOLN/VMlHqKubJTEHSHwthyRvXCV9S13zi81VmXpA526UMgn5fRzk+V
        hxnDHEkUxOjMtIy8S0a63q3aQc8GzapASJ9A8HK9GGOz68Yx3T+O4MFUG6GxIv1u3QGY/S
        G1ZxEf3ff2YNBefh4GcK8/94Icnz+Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671563849;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHrlbZbAHx6HgiASBDYpw/iDxLRufFQU7asxqAEWK3M=;
        b=hNTtSe7DRqrRwoFUZKSeHLR1UbHQodx0A23AXzv5Hsz5MlXbQ7Onr+fCleQ3uor+HKfIRQ
        /ziCgl4wsS0hZ+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 064B413254;
        Tue, 20 Dec 2022 19:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GAe1AEkKomPmOQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 19:17:29 +0000
Date:   Tue, 20 Dec 2022 20:16:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/8] btrfs: fix uninit warning from get_inode_gen usage
Message-ID: <20221220191643.GQ10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <aa2e624f5626b37a267ea123baf7db2d76be41ee.1671221596.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2e624f5626b37a267ea123baf7db2d76be41ee.1671221596.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:15:53PM -0500, Josef Bacik wrote:
> Anybody that calls get_inode_gen() can have an uninitialized gen if
> there's an error.  This isn't a big deal because all the users just exit
> if they get an error, however it makes -Wmaybe-uninitialized complain,
> so fix this up to always init the passed in gen, this quiets all of the
> uninitialized warnings in send.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/send.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 67f7c698ade3..25a235179edb 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -955,14 +955,12 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
>  static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
>  {
>  	int ret;
> -	struct btrfs_inode_info info;
> +	struct btrfs_inode_info info = {};

The { 0 } initializer should be used.

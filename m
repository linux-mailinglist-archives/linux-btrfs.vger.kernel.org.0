Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB51588C8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiHCNAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHCNAS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 09:00:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4163EE
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 06:00:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DA1134818;
        Wed,  3 Aug 2022 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659531616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZVxHF+By363mS3faOVNXvMdagTbQGoZcaJ9wTpk08U=;
        b=a2AXbj9MNOI+Cd9uqTfDYaVoyrgPZH/Cy8nn7yy3iD1m5Z4Kg0izO4UDmiTG5/xpqsaZc+
        EPqcqD2lRAeULICZchhT9Kf2oU4rAhN3tbrQ53jFqDlbTkhdr/i8jwsSDTThbXxpjhPccQ
        S2xBdq5e+LkSH5qsiWHoclmLBbzpvuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659531616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZVxHF+By363mS3faOVNXvMdagTbQGoZcaJ9wTpk08U=;
        b=oTMusNaRr0EDN92LdsQrDGSUqUj10Dmu31uZJ0jmge5sBLqcZwATQFsBpFJnmXen2C4nd/
        DBVvQkmZ9N6wcBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 170C913AE7;
        Wed,  3 Aug 2022 13:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F2nABGBx6mJNcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 13:00:16 +0000
Date:   Wed, 3 Aug 2022 14:55:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: scrub: try to fix super block errors
Message-ID: <20220803125513.GC13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <9f95c1c4437371d8ad1b51042e5dc82a5e42449f.1659423009.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f95c1c4437371d8ad1b51042e5dc82a5e42449f.1659423009.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 02:53:03PM +0800, Qu Wenruo wrote:
> @@ -4231,6 +4248,26 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>  	scrub_workers_put(fs_info);
>  	scrub_put_ctx(sctx);
>  
> +	/*
> +	 * We found some super block errors before, now try to force a
> +	 * transaction commit, as all scrub has finished, we're safe to
> +	 * commit a transaction.
> +	 */

Scrub can be started in read-only mode, which is basicaly report-only
mode, so forcing the transaction commit should be also skipped. It would
fail with -EROFS right at the beginning of transaction start.

> +	if (need_commit) {
> +		struct btrfs_trans_handle *trans;
> +
> +		trans = btrfs_start_transaction(fs_info->tree_root, 0);
> +		if (IS_ERR(trans)) {
> +			ret = PTR_ERR(trans);
> +			btrfs_err(fs_info,
> +	"scrub: failed to start transaction to fix super block errors: %d", ret);
> +			return ret;
> +		}
> +		ret = btrfs_commit_transaction(trans);
> +		if (ret < 0)
> +			btrfs_err(fs_info,
> +	"scrub: failed to commit transaction to fix super block errors: %d", ret);
> +	}
>  	return ret;
>  out:
>  	scrub_workers_put(fs_info);

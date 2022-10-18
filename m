Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFE602D55
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJRNsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiJRNsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:48:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE08CE985
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:48:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 920DA2078D;
        Tue, 18 Oct 2022 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666100892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xeo1aTcFzUisbCIZXw5XwUXPhBvArUH8Xfbmzsoaio=;
        b=DQ8fQaqtr3F/tY1h4+XQ5nYLJCiaJZS2nuXUqAb15Qxa9Z/H+2CEua9IaUg+IIDAxfTWLh
        qQi5Y2PUnBGsalfcEMWjzdBGYQadxoF8RAFfBHNgRVogLBEnAoMo8hzUf9tp0hlcZmk/Kv
        eRXII27sInIF8bnTOoNPbqoxyoFUFcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666100892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xeo1aTcFzUisbCIZXw5XwUXPhBvArUH8Xfbmzsoaio=;
        b=WLK8L5aCjXywqU/fyQ3/ma9dusokBr9CyYKGdH5dG/8/yW/0nVJZATNyVlB8DQKNCeVfdH
        jTTatxtyn/3vtWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7619E13480;
        Tue, 18 Oct 2022 13:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PWzkG5yuTmPtJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 13:48:12 +0000
Date:   Tue, 18 Oct 2022 15:48:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: send: sync splice buf size with kernel when
 proto 2
Message-ID: <20221018134802.GX13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221017035231.51112-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017035231.51112-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 11:52:31AM +0800, Wang Yugui wrote:
> When 'btrfs send --proto 2', the max buffer in kernel is changed from
> BTRFS_SEND_BUF_SIZE_V1(SZ_64K) to (SZ_16K + BTRFS_MAX_COMPRESSED).
> 
> The performance is improved when we use the same buf size in btrfs-progs.
> without this patch: 57.96s
> with this patch: 48.44s
> 
> bigger buf size(SZ_512K) is tested too. but it help 'btrfs send --proto 2' /
> 'btrfs send --proto 1' just little. so we will not use bigger buffer.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Added to devel, thanks.

>  cmds/send.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/send.c b/cmds/send.c
> index ec61aaf4..d18a31a1 100644
> --- a/cmds/send.c
> +++ b/cmds/send.c
> @@ -37,7 +37,10 @@
>  #include "cmds/commands.h"
>  #include "ioctl.h"
>  
> -#define SEND_BUFFER_SIZE	SZ_64K
> +#define BTRFS_SEND_BUF_SIZE_V1	(SZ_64K)
> +#define BTRFS_MAX_COMPRESSED	(SZ_128K)
> +#define BTRFS_SEND_BUF_SIZE_V2	(SZ_16K + BTRFS_MAX_COMPRESSED)

Such define is missing from kernel, right? It's hidden in
btrfs_ioctl_send as

sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE);

would be nice to have that as a separate define.

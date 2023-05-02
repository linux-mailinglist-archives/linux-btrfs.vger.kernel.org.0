Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C46F4C51
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEBVli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 17:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEBVlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 17:41:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4691724
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 14:41:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E12B321E30;
        Tue,  2 May 2023 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683063694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tu+YvBzPYcQMCiDKr9Y3FJyQiQA2mL3Xk+5tnImKbKY=;
        b=Bj3x9CZ6ljip2PeCwZ1kqSaGqMsIV3gg0bNryCz4XuiiVITe9MDZOTb9MFa8ezjognhrJF
        G2+zYr5iJRUNNOeUyEWd3jfrt1kA3A49CRWEhA+2RgeePeaDxRq789DJacCSW2PM6nm/tT
        nn++McnZJhF9FkzXlp+7qjPAOVO82lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683063694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tu+YvBzPYcQMCiDKr9Y3FJyQiQA2mL3Xk+5tnImKbKY=;
        b=ENXIth5zI4tWYNfBAoecWXnyaJGCcq+1o6y0aW9WfxGgCsLRFaMk4fwmMXIBl06MStsOxZ
        i1AD0kDeLve+97Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5F48139C3;
        Tue,  2 May 2023 21:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YKSeK46DUWQBUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 21:41:34 +0000
Date:   Tue, 2 May 2023 23:35:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs-progs: add struct va_format support to our
 btrfs_no_printk helper
Message-ID: <20230502213539.GS8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938911.git.josef@toxicpanda.com>
 <4e645609d525e855ca2a0b87d23c5fc2d1329d54.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e645609d525e855ca2a0b87d23c5fc2d1329d54.1681938911.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 19, 2023 at 05:17:15PM -0400, Josef Bacik wrote:
> We use the struct va_format to do nested printk's internally with our
> message handling.  Add the appropriate user space code to make this work
> properly so when we start copying this code into btrfs-progs we get the
> proper messages.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  common/messages.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/common/messages.c b/common/messages.c
> index 8bcfcc6a..aff5ce48 100644
> --- a/common/messages.c
> +++ b/common/messages.c
> @@ -16,6 +16,7 @@
>  
>  #include <stdio.h>
>  #include <stdarg.h>
> +#include <printf.h>

This header is not available on musl libc

    [CC]     common/messages.o
common/messages.c:19:10: fatal error: printf.h: No such file or directory
   19 | #include <printf.h>
      |          ^~~~~~~~~~

but for sake of merging all the patches I'll leave it temporarily broken. We
can either insert a fixup patch or update this one with some stub/ifdef once we
figure it out.

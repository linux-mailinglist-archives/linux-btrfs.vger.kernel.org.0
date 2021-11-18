Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA6455DEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 15:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhKRO1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 09:27:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhKRO1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 09:27:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 142E81FD29;
        Thu, 18 Nov 2021 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637245444;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EciOffUzbYRyjMJZ/argM22ifIKkuf/6Kbuv4hDU2SA=;
        b=QY0ySPFWxFlcemEW+zgNvSTs45Mz34rv1DdrBHGnG9SSeIpfydSEAbuA0FKHZJkZ99hYrn
        X1pkEkCwxuGsD4McKhwVueZwopTdGXsfYC5ICUMcaWDNRusvDfspZCDVLzBRO3uuYNPKyd
        5gvMLlRuZuObT8rTPZPZVgPHMHnha+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637245444;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EciOffUzbYRyjMJZ/argM22ifIKkuf/6Kbuv4hDU2SA=;
        b=C1U/XjsSHEO3svJZRvywVjIHP+S5k7c1KFNBWEoKHicYUOgAgG6gg26DD9tpv3qgVgrcb7
        qtv4FjJLPT4RF4AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0ADD2A3B84;
        Thu, 18 Nov 2021 14:24:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A10E3DA735; Thu, 18 Nov 2021 15:23:59 +0100 (CET)
Date:   Thu, 18 Nov 2021 15:23:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 12/17] btrfs: send: fix maximum command numbering
Message-ID: <20211118142359.GE28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:22PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
> version plus 1, but as written this creates gaps in the number space.
> The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> 23 and 24 are valid commands.

The MAX definitions have the __ prefix so they're private and not meant
to be used as proper commands, so nothing should suggest there are any
commands with numbers 23 to 25 in the example.

> Instead, let's explicitly set BTRFS_SEND_C_MAX_V* to the maximum command
> number. This requires repeating the command name, but it has a clearer
> meaning and avoids gaps. It also doesn't require updating
> __BTRFS_SEND_C_MAX for every new version.

It's probably a matter of taste, I'd intentionally avoid the pattern
above, ie. repeating the previous command to define max.

> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -316,8 +316,8 @@ __maybe_unused
>  static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
>  {
>  	switch (sctx->proto) {
> -	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> -	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> +	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
> +	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;

This seems to be the only practical difference, < or <= .

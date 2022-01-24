Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E320F4983F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbiAXP7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 10:59:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiAXP7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 10:59:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7CE1D21122;
        Mon, 24 Jan 2022 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643039958;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/3UaX1VkfGEe60XOuSLE3XExjT/DbgpwKFlkXfidUw=;
        b=PDphEGoP40aL1osyHIq5FmnTqfzm0Cyek7BWh6v7nhDiHNuIWHt2RWtw0lcTLbR6UY0Kxa
        DKlnzbRBn03GmR3yCzssk3taLWkDf8ymRSWZzdbn1WkSD0mV2Q5srDTqKEmMhoLPOt/4aM
        zRPL0F5ZsjvY4XKkiGC70CSOlQyKDkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643039958;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/3UaX1VkfGEe60XOuSLE3XExjT/DbgpwKFlkXfidUw=;
        b=9gJ0oC6HCPNlAY+hwMXfLednKa9N8xpJResHKuoMvjxXoBvKpJIEAJkbnn7p4bnD+HNSVn
        rCq+TSsUPKrfq+BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 727DCA3B84;
        Mon, 24 Jan 2022 15:59:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 93539DA7A3; Mon, 24 Jan 2022 16:58:38 +0100 (CET)
Date:   Mon, 24 Jan 2022 16:58:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: fix typo in btrfs-balance(8)
Message-ID: <20220124155838.GY14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Alyssa Ross <hi@alyssa.is>,
        linux-btrfs@vger.kernel.org
References: <20220122232833.304515-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122232833.304515-1-hi@alyssa.is>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 22, 2022 at 11:28:33PM +0000, Alyssa Ross wrote:
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  Documentation/btrfs-balance.asciidoc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/btrfs-balance.asciidoc b/Documentation/btrfs-balance.asciidoc
> index feccea48..e7620cca 100644
> --- a/Documentation/btrfs-balance.asciidoc
> +++ b/Documentation/btrfs-balance.asciidoc
> @@ -27,7 +27,8 @@ is temporarily stored as an internal state and will be resumed upon mount,
>  unless the mount option 'skip_balance' is specified.
>  
>  WARNING: running balance without filters will take a lot of time as it basically
> -move data/metadata from the whol filesystem and needs to update all block pointers.
> +move data/metadata from the whole filesystem and needs to update all block
> +pointers.

Thanks for the fix, it's been already fixed during the conversion from
asciidoc to RST
(https://github.com/kdave/btrfs-progs/blame/devel/Documentation/btrfs-balance.rst#L36)

The .asciidoc files still exist in the master branch but have been
removed in devel, there might be some duplication until the next major
release.

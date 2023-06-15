Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66CD73141B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbjFOJgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343830AbjFOJff (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 05:35:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8B530D4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 02:35:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 790621FDF6;
        Thu, 15 Jun 2023 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686821704;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ntVrkTVQ6MyeTTLtxF3kCtPMZquHdab6dr9eCn2iD4=;
        b=bWkjvZaC/RAdDpVRfwWToC5QWkRLRsQrHk6VA8ceMdEQKlf2WwkMG9Pv+S3zS8Iv0zome4
        MwuPyt+70FPcEsN8zsJQSVegZQqHwwo9sVFZWFHzufW/guNsea0EwF2PKj5PxBJswEKSz0
        dhLOFqIajbJvdqxqE6l/BqxyJwflK2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686821704;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ntVrkTVQ6MyeTTLtxF3kCtPMZquHdab6dr9eCn2iD4=;
        b=XYv8/v+fHmMk5lEjTsG4+0TwyVBMkUXuEK1BB1K5UFnf9dGHnE3Bwkhd0RdGKxsy6vabKr
        YeibI6V3Q3zyLRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62CEB13A47;
        Thu, 15 Jun 2023 09:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PG+CF0jbimRiVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 15 Jun 2023 09:35:04 +0000
Date:   Thu, 15 Jun 2023 11:28:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix accessors for big endian systems
Message-ID: <20230615092844.GT13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 06:23:43PM +0800, Qu Wenruo wrote:
> --- a/kernel-shared/accessors.h
> +++ b/kernel-shared/accessors.h
> @@ -7,6 +7,8 @@
>  #define _static_assert(expr)   _Static_assert(expr, #expr)
>  #endif
>  
> +#include <bits/endian.h>

Files from bits/ should not be included directly and it's
glibc-specific, also breaks build on musl. Fixed.

I'm going to enable quick build tests for pull request, right now the
tests are ran once I push devel which usually happens after I reply with
the 'applied' mail. The test results can be found at
https://github.com/kdave/btrfs-progs/actions .

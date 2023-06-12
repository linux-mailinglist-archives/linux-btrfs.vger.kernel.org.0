Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4572D353
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjFLVbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjFLVaz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 17:30:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08E98
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 14:30:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3BBE2265D;
        Mon, 12 Jun 2023 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686605452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcCW9qBklEO3KGcCeThRHXmV6I5tQDumT9b75WwkpMw=;
        b=ZScEfj6U+YptXaCDxU/EBQkG0tnD+gFw+BhaEmkaySMKmg/S/DBgCjZrduHhXIHvL/GZQR
        u97RFya0r7gNUHAEA+uKoei+eIAFj9vd4UYzohYTSeo8dOnWvU9PLKci7OXSl7ljjoLlfv
        2QXcmACjPgfX8G+h2xJfsN471GiMjtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686605452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcCW9qBklEO3KGcCeThRHXmV6I5tQDumT9b75WwkpMw=;
        b=S9KeRCEqlhhtXYANX5AG4c0G+ffO1RIKyHlL1hsDjx9LurCgVeo1ir0TwehPyomXVIIe56
        RBF6lbzP0fwfhyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83E6E1357F;
        Mon, 12 Jun 2023 21:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UT1NH4yOh2Q0SAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 21:30:52 +0000
Date:   Mon, 12 Jun 2023 23:24:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, fdmanana@suse.com
Subject: Re: [PATCH] Btrfs: can_nocow_file_extent should pass down
 args->strict from callers
Message-ID: <20230612212433.GF13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230609175341.1618652-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609175341.1618652-1-clm@fb.com>
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

On Fri, Jun 09, 2023 at 10:53:41AM -0700, Chris Mason wrote:
> 619104ba453ad0 changed our call to btrfs_cross_ref_exist() to always
> pass false for the 'strict' parameter.  We're passing this down through
> the stack so that we can do a full check for cross references during
> swapfile activation.
> 
> With strict always false, this test fails:
> 
> btrfs subvol create swappy
> chattr +C swappy
> fallocate -l1G swappy/swapfile
> chmod 600 swappy/swapfile
> mkswap swappy/swapfile
> 
> btrfs subvol snap swappy swapsnap
> btrfs subvol del -C swapsnap
> 
> btrfs fi sync /
> sync;sync;sync
> 
> swapon swappy/swapfile
> 
> The fix is to just use args->strict, and everyone except swapfile
> activation is passing false.
> 
> Fixes: 619104ba453ad0 ("btrfs: move common NOCOW checks against a file extent into a helper")
> Signed-off-by: Chris Mason <clm@fb.com>

Added to misc-next, thanks.

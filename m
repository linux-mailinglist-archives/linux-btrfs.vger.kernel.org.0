Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B066F0E5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 00:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjD0WlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 18:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjD0WlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 18:41:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C62D2103
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 15:40:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDDD421C99;
        Thu, 27 Apr 2023 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682635257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nF1y6bDPxmuY7adkgSsB6kSUIOVfmc4xiKXz2lps8GU=;
        b=Gx+IX4AJYfuoAt1fAhBryDQefs67QtWU8WvPzhPe3/U/NsmC6v5DtpNkPsXxn2S8IrziId
        NumvhiENKx0zTEaL15ZdW4LaZNlntURVnqXG6bX1wPqnQRIojIGkg8b10jPaHAgLc7RYro
        NwlR+JsvGlEmHqQeMwgF70apCoGV0Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682635257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nF1y6bDPxmuY7adkgSsB6kSUIOVfmc4xiKXz2lps8GU=;
        b=XCBQ3bKPSO3Q2qHjWZHY0NUldfSval9FW1w2GdcaQHuYiWyRNgmm36KCSGYcrSacESOiLo
        C6XgYPG4Q3lvY7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B02BD138F9;
        Thu, 27 Apr 2023 22:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yIQxKvn5SmR5ewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Apr 2023 22:40:57 +0000
Date:   Fri, 28 Apr 2023 00:40:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Naohiro Aota <naota@elisp.net>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: export bitmap_test_range_all_{set,zero}
Message-ID: <20230427224043.GF19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bab3ffe3255379a63b07c4c11ea1a52e1a904f68.1682062222.git.naohiro.aota@wdc.com>
 <19c1d144-3d37-0dc7-3b01-feafb135d1e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c1d144-3d37-0dc7-3b01-feafb135d1e7@kernel.org>
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

On Fri, Apr 21, 2023 at 04:49:06PM +0900, Damien Le Moal wrote:
> On 4/21/23 16:31, Naohiro Aota wrote:
> > From: Naohiro Aota <naohiro.aota@wdc.com>

> > +	found_zero = find_next_zero_bit(addr, start + nbits, start);
> > +	if (found_zero == start + nbits)
> > +		return true;
> > +	return false;
> 
> Why not:
> 
> 	return find_next_zero_bit(addr, start + nbits, start) == start + nbits;
> 
> Simpler...

Depends on local coding style habits, I find overloading line like that
less readable so I'll undo that change in the applied patche.

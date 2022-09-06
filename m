Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF75AF109
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIFQqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237126AbiIFQpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 12:45:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061506C12E
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 09:25:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B47AA3393E;
        Tue,  6 Sep 2022 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662481528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrRnt9OyLoI3SJDpoYXeUz5ZssJ2ytgC7qtYHqPLEmQ=;
        b=XBXaJAIhZNEFnFyZiFDq32UGf7sAm/Sv5nGjZZ4qeHwtVsY0TFulS9pDfK+xNol7GVX/NJ
        QHBEF8EXB1ZFfbWWhBYy26cNxx9O9EUxaAZAHR3zdhG+omam1vSr6Sw9w3XHxKmqFZs/Ax
        IakES0KsmFkN73ahAEGGp+eaclCIxUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662481528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrRnt9OyLoI3SJDpoYXeUz5ZssJ2ytgC7qtYHqPLEmQ=;
        b=S5d7NLsAk+FBYOxY1kPyhHAn77jG+9IYDAa/O/RKAA5xVWd1gUN7N1f3KW1X/wKdb+fAk6
        0HGmejQmNLZqlNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB2B13A19;
        Tue,  6 Sep 2022 16:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n2AiIXh0F2MGNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 16:25:28 +0000
Date:   Tue, 6 Sep 2022 18:20:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
Message-ID: <20220906162006.GS13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We often get reports of fiemap and hole/data seeking (lseek) being too slow
> on btrfs, or even unusable in some cases due to being extremely slow.
> 
> Some recent reports for fiemap:
> 
>     https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
>     https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> 
> For lseek (LSF/MM from 2017):
> 
>    https://lwn.net/Articles/718805/
> 
> Basically both are slow due to very high algorithmic complexity which
> scales badly with the number of extents in a file and the heigth of
> subvolume and extent b+trees.
> 
> Using Pavel's test case (first Link tag for fiemap), which uses files with
> many 4K extents and holes before and after each extent (kind of a worst
> case scenario), the speedup is of several orders of magnitude (for the 1G
> file, from ~225 seconds down to ~0.1 seconds).
> 
> Finally the new algorithm for fiemap also ends up solving a bug with the
> current algorithm. This happens because we are currently relying on extent
> maps to report extents, which can be merged, and this may cause us to
> report 2 different extents as a single one that is not shared but one of
> them is shared (or the other way around). More details on this on patches
> 9/10 and 10/10.
> 
> Patches 1/10 and 2/10 are for lseek, introducing some code that will later
> be used by fiemap too (patch 10/10). More details in the changelogs.

The speedup is unbelievable, thank you very much!

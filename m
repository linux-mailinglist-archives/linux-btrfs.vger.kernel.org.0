Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECB6A4DB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 23:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjB0WFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0WFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 17:05:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189B25970
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 14:05:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFC2221A31;
        Mon, 27 Feb 2023 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677535529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIHo5V/Onk0atwmjt4/G16o9lsdQl83g/UV82f21n/4=;
        b=whPh8fvk8g1WehsdzKzYwBVDj/ajOnZmxNXPsb//JCs+kQ7aF9PWtHUr75zjgde/Ao5EoH
        Nlggfxkk8oy8W5uFE0sNTsXsYExRjpS/bonu8aj2YNFKXul8cVutGHP44p9nHEzRjZGTJd
        ZT55WRHAvk+rXVmU3vBNsHaa9KnNPXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677535529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIHo5V/Onk0atwmjt4/G16o9lsdQl83g/UV82f21n/4=;
        b=U0FqydL3e6+KQAStCRaiAT4cM8bZ9+q4WTja6321F7mvsb0iSFepkdf515i25Qj/DQFQ83
        bTUiiOknw2YMEWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EFE213912;
        Mon, 27 Feb 2023 22:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tE3RJSkp/WPJSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 22:05:29 +0000
Date:   Mon, 27 Feb 2023 22:59:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <error27@gmail.com>
Cc:     fdmanana@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: drop extent map range more efficiently
Message-ID: <20230227215930.GM10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <Y/yipSVozUDEZKow@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/yipSVozUDEZKow@kili>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 03:31:33PM +0300, Dan Carpenter wrote:
> Hello Filipe Manana,
> 
> The patch db21370bffbc: "btrfs: drop extent map range more
> efficiently" from Sep 19, 2022, leads to the following Smatch static
> checker warning:
> 
> 	fs/btrfs/extent_map.c:767 btrfs_drop_extent_map_range()
> 	passing uninitialized variable 'flags'

Thanks for the report, fixed by the patch
https://lore.kernel.org/linux-btrfs/252e68aaa353859c8041305443a988866350cb3c.1677502380.git.fdmanana@suse.com/

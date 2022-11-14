Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EA628A9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 21:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiKNUjl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 15:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNUjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 15:39:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1EB07
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 12:39:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FE3233E4A;
        Mon, 14 Nov 2022 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668458378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TC05F4su99m9u35W0OytnV0dwmT9BgroG/VV4x5UhSk=;
        b=ryO+Pz7Dp7lb4eQD7gohvY22RkUNc3ia4IiIE5xrdvU5iRrX1vcfB6n2HGbc6y4mewur9a
        jMG+RUqczq9txXn9yMBMHJDqd144mUwgWL2s3gVEmGwXvfZndP2gudxZ2/fA4+ZYlX+20p
        EznOZ7j+RgamDedjyhg9bVrSGYxcjWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668458378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TC05F4su99m9u35W0OytnV0dwmT9BgroG/VV4x5UhSk=;
        b=FrKALnA5Rql8kOkZ5dsDLwzxHkaiNlnEaoW8mFYfFw4bG1NSYX5EDz5Cbz5veajYI49Oxc
        ja/768XTmqTfxSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 646F513A92;
        Mon, 14 Nov 2022 20:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1C2JF4qncmOwOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 20:39:38 +0000
Date:   Mon, 14 Nov 2022 21:39:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: handle raid56 properly
Message-ID: <20221114203912.GA5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668320935.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668320935.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 13, 2022 at 02:32:37PM +0800, Qu Wenruo wrote:
> There is a bug that "btrfs check" can fail to even open the filesystem.
> 
> The root cause is that raid56 read path doesn't even allow any missing
> device, which is pretty ironic.
> 
> This patchset will fix the raid56 read path, and slightly improve the
> raid56 handling (still not reaching the granularity of kernel yet).
> 
> And finally add a test case for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: properly handle degraded raid56 reads
>   btrfs-progs: fsck-tests: add test case for degraded raid5

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF22625CBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiKKORp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 09:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiKKOQ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 09:16:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F58A8DC
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 06:07:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F05B7201D1;
        Fri, 11 Nov 2022 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668175668;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beQBskqifGlbnR6JebrvytsRQwTgDP+2GxbbxYUfz90=;
        b=WX+gim5R8/6tGmgYl595c6/CJthS5s6jw5wXQc3PDO5w3+GapFMUdomxhV2nsnHPSe6yli
        4YNNf8Ge8vtx3dkGiXT9IwjQ+F1WYju4BolD4LT+v9rbDnaSZ6LeSWOvXHIE0jWdxq6O3+
        +ENRBIQ6ztf5pzjVZTXJaLNchGEol48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668175668;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beQBskqifGlbnR6JebrvytsRQwTgDP+2GxbbxYUfz90=;
        b=9g5Wy2jvBHJ/QJQahvIdyDMScRPfzuinhUQJmm909av0MYjdJ4wkmhEpHCcBAgFJoIQLbK
        XL2S0JB9AQ8E73Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D01FF13273;
        Fri, 11 Nov 2022 14:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vzbZMTRXbmNOBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 14:07:48 +0000
Date:   Fri, 11 Nov 2022 15:07:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: raid56: use atomic_dec_and_test() in end io
 functions
Message-ID: <20221111140724.GN5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221109233938.9969-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109233938.9969-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 10, 2022 at 07:39:38AM +0800, Qu Wenruo wrote:
> !!! DON'T MERGE AS IS !!!
> 
> The latest btrfs raid56 refactor is using atomic_dec() then
> unconditionally call wake_up() to let the main thread to check if all
> the IO is done.
> 
> But atomic_dec() itself is not fully ordered, thus it can have an
> impact on the lifespan of the rbio, which causes use-after-free and
> crash in the raid6 path.
> 
> Unfortunately I don't have a solid environment to reproduce the problem
> (even with KASAN enabled).
> My guess is, since I'm always using the latest hardware (days ago it's
> R9 5900X, now it's i7 13700K) they may have something a little more
> strict on the ordering.
> 
> So this patch is still just for David to verify the behavior, and if
> this one really solved the problem, it's better to be folded into
> "btrfs: raid56: switch recovery path to a single function" and
> "btrfs: raid56: introduce the a main entrance for rmw path".

Fixups folded, thanks. So far several runs have passed so I'll push it
to misc-next and we'll see if it reproduces on other machines.

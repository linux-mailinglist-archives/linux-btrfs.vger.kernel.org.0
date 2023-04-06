Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB46D9B5C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjDFO5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjDFO5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 10:57:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB5895
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 07:57:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B75C22764;
        Thu,  6 Apr 2023 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680793036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0hN0xWKSBw6fX97NNEhcwMFDXhy/mNZ0+hETIjLm1I=;
        b=cZFdHb/dQbZjHM5ZDzsT5LjkHwB0Ib8BC8uoS4/yphQDlHjp0lzTf/Hil15Xx4NVEBqQBh
        rUooIEWEWAElpji3tTcna+NPYmOl/RvYUf/SidYEMvDgPJ0e0HypNqjni/UGdRrL30l0Q4
        9U953E0kSimWM+MVfKzP35eLzJzdLDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680793036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0hN0xWKSBw6fX97NNEhcwMFDXhy/mNZ0+hETIjLm1I=;
        b=MP32lnCAdBHf7vKWqTnzZUsR8sybYnkqYhg4fFQb4gseDJYgZ/SXClCmZ2UtRnkwwZHmyI
        cq7yqFoAgo8/SLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F405E133E5;
        Thu,  6 Apr 2023 14:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ifHeOsvdLmQuPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 14:57:15 +0000
Date:   Thu, 6 Apr 2023 16:57:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs: adjust async discard tuning
Message-ID: <20230406145712.GR19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680723651.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680723651.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 12:43:57PM -0700, Boris Burkov wrote:
> Since discard=async became the implicit default in btrfs in the
> 6.2 kernel, there have been numerous complaints about discard being
> too spread out on workstation systems. This results in situations like
> a users drive not being idle for an unexpectedly long period of time.
> 
> This is caused by a relatively low default iops limit of 10, so this
> series raises the default limit to 1000 (1ms delay) and modifies a
> weird fallback behavior for limit=0 to be interpreted as unlimited.
> 
> Link: https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2182228
> Link: https://www.reddit.com/r/archlinux/comments/121htxn/btrfs_discard_storm_on_62x_kernel/
> 
> ---
> Changelog:
> v2: actually set the limit to 1k, not 10k.
> 
> Boris Burkov (2):
>   btrfs: set default discard iops_limit to 1000
>   btrfs: reinterpret async discard iops_limit=0 as no delay

Added to misc-next, thanks.

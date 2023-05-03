Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94416F59F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjECO04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjECO0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 10:26:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FF9B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 07:26:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1370A227DB;
        Wed,  3 May 2023 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbAxLbvC8P+WUV4ImW7tjkQ98nALF6oNWzTqw2zx8Es=;
        b=bZ+ZOO9tQ/yoEck2sPM+wd81nYw42A0nPtnGOVAb8Nk84plWSy+MMyS69X071hE0I0IjXP
        vhgrArdzr2qpc6VIPYxP6UUaLet5yFuK71NFtHVJJiHlcxiTr5KLrbWoest324u3BpiO01
        i7w8jUaZBuD0wJ4qtXiu3lJusOs1L6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbAxLbvC8P+WUV4ImW7tjkQ98nALF6oNWzTqw2zx8Es=;
        b=/WHd+IZdrw83V41x0KyhPE4cvyNDkQsuWJoD1mIxyNQfvIlrbvggK1h6cKYf15H6jgdCuF
        Mh0t3DTLpodpDWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E09B51331F;
        Wed,  3 May 2023 14:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VhgZNilvUmREQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 May 2023 14:26:49 +0000
Date:   Wed, 3 May 2023 16:20:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/26] btrfs-progs: sync ctree.c into btrfs-progs
Message-ID: <20230503142054.GC6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682799405.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 29, 2023 at 04:19:31PM -0400, Josef Bacik wrote:
> Hello,
> 
> This is a long series, and it depends on the following series
> 
>   btrfs-progs: prep work for syncing files into kernel-shared
>   btrfs-progs: sync basic code from the kernel
>   btrfs-progs: prep work for syncing ctree.c
>   btrfs-progs: more prep work for syncing ctree.c
>   
> This is even more more prep work for syncing ctree.c, and the last patch is the
> actual sync.  A lot of these prep patches are updating the callers to match the
> current calling conventions in the kernel to make the syncing straightforward.

Added to devel, thanks. The includes were out of order or without the
prefix and some forward declarations or kerncompat.h includes were
needed to make it compile in the end.

The remaining issues are basically all around messages. There are now
two messages.[ch] and the pV handling is in the userspace side while
only used by kernel. Musl does not have the user defined specifiers so
we'll need to add a workaround with an intermediate string.

Other build tests seem to pass so I'll take it as a base line for
further fixups. Some changes can be done as separate patches to avoid
cascading changes in other commits but at least the printf.h should be
done in place.

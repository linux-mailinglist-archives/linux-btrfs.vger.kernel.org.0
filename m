Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ACF5FB07F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJKKdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJKKdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 06:33:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C627F102
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 03:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1D2F21CD7;
        Tue, 11 Oct 2022 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665484413;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ol3VUm1amh1ukgvhCWyZfzK8rtpQ0dVxOag/Hm77gsw=;
        b=VEY+x+rWlTK3HmjDeuL0Jnvmh3dKcKEK8AfKbUq1d5MwaRTfG+2ZjxVf2viFiTYfVXTW9G
        0HlbRe9XrJueA0FbNLlRCBSrBouuk4CIgMISaFz8To9yKfhtT9nJ4/JwWUow8gLxHe3WXJ
        WlOs1F4erPNwLm33IZLGD+zeBxSf+Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665484413;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ol3VUm1amh1ukgvhCWyZfzK8rtpQ0dVxOag/Hm77gsw=;
        b=KSwu/604KbKY2IeIBoT75gC/faQVic/mq6KzASbfNF4a8SqE+QEEdGkEgD7qj5F0kfltdu
        lRzH0kBWYJBsSoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 598F9139ED;
        Tue, 11 Oct 2022 10:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m7DKFH1GRWPGGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 10:33:33 +0000
Date:   Tue, 11 Oct 2022 12:33:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 08/16] btrfs: move incompat and compat flag helpers to
 fs.c
Message-ID: <20221011103327.GM13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <3aeef7d866611a84296b74ff0ee7938351c58d88.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aeef7d866611a84296b74ff0ee7938351c58d88.1663175597.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:18:13PM -0400, Josef Bacik wrote:
> These helpers use functions not defined in fs.h, move them to fs.c to
> keep the header clean.

This is one of the examples where functions are switched from inline to
out-of-line, so I'll reply for all of them.

> +bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
> +{
> +	struct btrfs_super_block *disk_super;
> +	disk_super = fs_info->super_copy;
> +	return !!(btrfs_super_incompat_flags(disk_super) & flag);
> +}

This needs a separate function and unlike for the inline it needs a
call which has some impact on the instruction flow. This should be
evaluated if the un-inlined function is on a hot path or not.

In this case I think the incompat bits should be inline as it's in many
places part of switching access to some structures or lookup.

At minimum some numbers and assembly examination should be done before
ding that. The header cleanup part is nice but if the changes have
performance implications it's suddenly not so easy.

I'll do some analysis to get an idea how bad/good it is.

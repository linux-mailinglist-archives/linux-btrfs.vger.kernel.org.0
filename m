Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49298792781
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbjIEQC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354826AbjIEOp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 10:45:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56711197
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 07:45:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 176A71FE6C;
        Tue,  5 Sep 2023 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693925125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRmFRBBjiymADHuC158loV+BM7nlgrm8e2wfNXA74Lk=;
        b=n19MV11jxDbg72js+uGhkeNYpDWDU6NgTIjnhKOuGuhJUSGs+ovlOqfizZSJ7Jz7Gd/Z6g
        xesqAwq+xwvYYGFYjH1bYs6V5UR1pEEkFzbQKHTwrOGXr9AFxk3zHFhkshWElI+w5pfY+/
        tNt6+bqTZZo2k7nKj8Yoiv8qvrroGS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693925125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRmFRBBjiymADHuC158loV+BM7nlgrm8e2wfNXA74Lk=;
        b=wlPszRjrMLgiRpBlbI4Tkb1fFtYrr62MXK+c0qFqOpw2HUgHdPUPZnRsj3kURx4nVNaxTF
        chIMQ6sRd51SuXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF39013911;
        Tue,  5 Sep 2023 14:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TbStNQQ/92RyYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 14:45:24 +0000
Date:   Tue, 5 Sep 2023 16:38:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/12] btrfs: ctree.[ch] cleanups
Message-ID: <20230905143845.GC14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692994620.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 04:19:18PM -0400, Josef Bacik wrote:
> v1->v2:
> - added "btrfs: include linux/security.h in super.c" to deal with a compile
>   error after removing it from ctree.h in certain configs.
> 
> --- Original email ---
> Hello,
> 
> While refreshing my ctree sync patches for btrfs-progs I ran into some oddness
> around our crc32c related helpers that made the sync awkward.  This moves those
> helpers around to other locations to make it easier to sync ctree.c into
> btrfs-progs.
> 
> I also got a little distracted by the massive amount of includes we have in
> ctree.h, so I moved code around to trim this down to the bare minimum we need
> currently.
> 
> There's no functional change here, just moving things about and renaming things.
> Thanks,
> 
> Josef
> 
> 
> Josef Bacik (12):
>   btrfs: move btrfs_crc32c_final into free-space-cache.c
>   btrfs: remove btrfs_crc32c wrapper
>   btrfs: move btrfs_extref_hash into inode-item.h
>   btrfs: move btrfs_name_hash to dir-item.h
>   btrfs: include asm/unaligned.h in accessors.h
>   btrfs: include linux/crc32c in dir-item and inode-item
>   btrfs: include linux/iomap.h in file.c
>   btrfs: add fscrypt related dependencies to respective headers
>   btrfs: add btrfs_delayed_ref_head declaration to extent-tree.h
>   btrfs: include trace header in where necessary
>   btrfs: include linux/security.h in super.c
>   btrfs: remove extraneous includes from ctree.h

With patch 6 folded to 3 and 4 added to misc-next, thanks.

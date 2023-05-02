Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024656F4BB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEBVCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBVCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 17:02:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1101734
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 14:02:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43B2221DC0;
        Tue,  2 May 2023 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683061358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tO/h20az60V3khu9UupdiA7BfJcLoQk3XW2/Z+4eI5A=;
        b=YueHWwd/8wCfIASZKsUgUSuSqdjygNnVONqn/diiCzT8ZkoZ69ZEEsa0uhVNpoPbUWDBrK
        5/TOd5enfT3p3Wd12MbNvg1u7vFWEGH7tJfah7ie2LRYNhM05H0oZXLNK1hCSWRaNdFR9i
        Rc0pUNKFo7xGg9Uzj1O4wuRtbbqmu9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683061358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tO/h20az60V3khu9UupdiA7BfJcLoQk3XW2/Z+4eI5A=;
        b=WZAOexYdKDhAMO204bH0E1H+AA8dBBB7nijQRwlKkKywOA6WAEjp1eJtERHovay4iw/3q7
        Wmb5GWZhY/ajodBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26A32139C3;
        Tue,  2 May 2023 21:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id saCmCG56UWTaPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 21:02:38 +0000
Date:   Tue, 2 May 2023 22:56:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] btrfs-progs: prep work for syncing files into
 kernel-shared
Message-ID: <20230502205642.GO8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938648.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
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

On Wed, Apr 19, 2023 at 05:13:42PM -0400, Josef Bacik wrote:
> Hello,
> 
> These a variety of fixes, cleanups, and api changes to make it easier to sync
> recent kernel changes into btrfs-progs.  They're relatively straightforward, and
> have been run through the tests.  Thanks,
> 
> Josef
> 
> Josef Bacik (11):
>   btrfs-progs: fix kerncompat.h include ordering for libbtrfs
>   btrfs-progs: use $SUDO_HELPER in convert tests for temp files
>   btrfs-progs: re-add __init to include/kerncompat.h
>   btrfs-progs: introduce UASSERT() for purely userspace code
>   btrfs-progs: move BTRFS_DISABLE_BACKTRACE check in print_trace
>   btrfs-progs: remove the _on() related message helpers
>   btrfs-progs: consolidate the btrfs message helpers
>   btrfs-progs: rename the qgroup structs to match the kernel
>   btrfs-progs: remove fs_info argument from btrfs_check_* helpers
>   btrfs-progs: add a btrfs check helper for checking blocks
>   btrfs-progs: remove parent_key arg from btrfs_check_* helpers

Added to devel, with some minor adjustments, thanks.

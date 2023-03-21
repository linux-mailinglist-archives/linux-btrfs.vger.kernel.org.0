Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2FB6C27E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 03:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCUCMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 22:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUCMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 22:12:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976FE36090
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 19:12:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 380C61FD64;
        Tue, 21 Mar 2023 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679364738;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZ+XouVekPt4LszmVjzH6VyC/rwC6087nAFRBFS7BKQ=;
        b=WshU9O+KLoeopeo8B5IFXtxgz4bsWHr/tq1BSyoh+aCdBAEhiJPztQoXnAWCPqtpW+AN+s
        9m4FcsGrOUPNuB9XOniNLsuKLKHgJktAt92HU5PVQpxV4EmG48lmNp8Vjp25lQv544Jme6
        LCEZh76qs63SuQrjPLsRF5UlNd1rTmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679364738;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZ+XouVekPt4LszmVjzH6VyC/rwC6087nAFRBFS7BKQ=;
        b=AwiBEVxQAYAmLPCkfKfZ+qfGJGvOQ0ulMLT7NpYW8raJWJDWWXc432xp2nMvqiR4bR6KsP
        NKT9BY+ToKIImrDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D24E13451;
        Tue, 21 Mar 2023 02:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLcxAoISGWSXcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 02:12:18 +0000
Date:   Tue, 21 Mar 2023 03:06:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: misc: fix failure on misc/034
Message-ID: <20230321020608.GQ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230213054724.35714-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213054724.35714-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 01:47:24PM +0800, Qu Wenruo wrote:
> [BUG]
> Test case misc/034 can fail like this:
> 
>   ====== RUN CHECK mount /dev/loop16 /home/adam/btrfs-progs/tests/mnt
>   mount: /home/adam/btrfs-progs/tests/mnt: wrong fs type, bad option, bad superblock on /dev/loop16, missing codepage or helper program, or other error.
>          dmesg(1) may have more information after failed mount system call.
>   failed: mount /dev/loop16 /home/adam/btrfs-progs/tests/mnt
> 
> And the dmesg looks like this:
> 
>   loop16: detected capacity change from 0 to 1024000
>   loop17: detected capacity change from 0 to 1024000
>   BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 1 transid 6 /dev/loop16 scanned by mount (79348)
>   BTRFS info (device loop16): using crc32c (crc32c-intel) checksum algorithm
>   BTRFS info (device loop16): found metadata UUID change in progress flag, clearing
>   BTRFS info (device loop16): disk space caching is enabled
>   BTRFS error (device loop16): devid 2 uuid cde07de6-db7e-4b34-909e-d3db6e7c0b06 is missing
>   BTRFS error (device loop16): failed to read the system array: -2
>   BTRFS error (device loop16): open_ctree failed
> 
> [CAUSE]
> >From the dmesg, it shows that although both loopback devices are
> properly registered, only one is properly scanned by mount.
> 
> Thus the other device is missing, and without "-o degraded" the
> filesystem failed to be mounted.
> 
> [FIX]
> Before we mount the filesystem, also scan them in their passed in order
> to properly assemble the device list for mount.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

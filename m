Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A969F93A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBVQo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjBVQo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 11:44:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8737F1A
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 08:44:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EEFE33CEA;
        Wed, 22 Feb 2023 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677084292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWI6i3CAUmBge6yqkPs3AGcn/lgMWmYeKMFGD62xCpo=;
        b=Nsz9I7sZbyhuMVESiDr8UthRu35/1Cf+/w2K7HFH1gJ5cXqLFDTVLDzUffRpdiP19Tl6S/
        htZFd2t9WYljp1hYhWFavLs7sNXnWxHEeLQhajUQDuw0zN4bwnoTs7kE6oQCoqGo5C9SgF
        clpGnQlgq5eupEWhvXD90Os+so3cA9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677084292;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWI6i3CAUmBge6yqkPs3AGcn/lgMWmYeKMFGD62xCpo=;
        b=NJcC7nI3brROO7z+5yq/vCEjP8GAAuIEkkWey46KFxZzKTUTKRbHpEBGU1rrrPJl8EOLhc
        UoEPzyXS9BthL/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34557133E0;
        Wed, 22 Feb 2023 16:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e4OoC4RG9mOAVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Feb 2023 16:44:52 +0000
Date:   Wed, 22 Feb 2023 17:38:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Message-ID: <20230222163855.GU10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <20230222025918.GA1651385@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222025918.GA1651385@roeck-us.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 06:59:18PM -0800, Guenter Roeck wrote:
> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
> > We had a recent bug that would have been caught by a newer compiler with
> > -Wmaybe-uninitialized and would have saved us a month of failing tests
> > that I didn't have time to investigate.
> > 
> 
> Thanks to this patch, sparc64:allmodconfig and parisc:allmodconfig now
> fail to commpile with the following error when trying to build images
> with gcc 11.3.
> 
> Building sparc64:allmodconfig ... failed
> --------------
> Error log:
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> fs/btrfs/inode.c: In function 'btrfs_lookup_dentry':
> fs/btrfs/inode.c:5730:21: error: 'location.type' may be used uninitialized [-Werror=maybe-uninitialized]
>  5730 |         if (location.type == BTRFS_INODE_ITEM_KEY) {
>       |             ~~~~~~~~^~~~~
> fs/btrfs/inode.c:5719:26: note: 'location' declared here
>  5719 |         struct btrfs_key location;

Thanks for the report, Linus warned me that there might be some fallouts
and that the warning flag might need reverted. But before I do that I'd
like to try to understand why the warnings happen in a code where is no
reason for it.

I did a quick test on gcc 11.3 (on x86_64, not on sparc64 unlike you
report), and there is no warning

gcc (SUSE Linux) 11.3.1 20220721 [revision a55184ada8e2887ca94c0ab07027617885beafc9]
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  CC [M]  fs/btrfs/inode.o

I.e. it's the same version, different arch and likely not the same
config. In the function itself thre's a local variable passed by address
to a static function in the same file.

	struct btrfs_key location;
	...
	ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);

and there it's

	btrfs_dir_item_key_to_cpu(path->nodes[0], di, location);

which is a series of helpers to read some data and store that to the
strucutre. At some point there's a call to read_extent_buffer() that's
in a different file.

A local variable passed by address to external function is quite common
so I'd expect more warnings and I don't see what's different in this
case.

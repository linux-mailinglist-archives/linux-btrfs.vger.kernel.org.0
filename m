Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4066555155
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359355AbiFVQ3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359133AbiFVQ3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 12:29:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687BF2FFC3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:29:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 286C3219B3;
        Wed, 22 Jun 2022 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655915391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mqxtilw8OTPOiF3Z07j3LuPWxQEQF/crdpE6q1/m0Nc=;
        b=2heXhctTVG2gluK2rsFhF+ej74K59cGuca05LlaiUKq+tH4UpweO5rNMsQ0hTVmGusASkL
        0NxGXIUwPtX7OZCuD4lfMQbYP9Dk16wqovsKTgyJFHqRwePJu3m8xB38dPj2XCmdMFRAfG
        crncxxkYGlFBqkKA9ITiLLA+CT7VAdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655915391;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mqxtilw8OTPOiF3Z07j3LuPWxQEQF/crdpE6q1/m0Nc=;
        b=S2ipX5/TeTdkzut+94/uGOfm73EoO5KQxYu+e0Xk6B20cTaIo1GKQYxd51YqucyZgjIFY9
        A0/ZFWS6B15FxcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF75913A5D;
        Wed, 22 Jun 2022 16:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3OuCOX5Ds2ITFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Jun 2022 16:29:50 +0000
Date:   Wed, 22 Jun 2022 18:25:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/2] btrfs: Expose commit stats through sysfs
Message-ID: <20220622162513.GM20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220621225918.4114998-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621225918.4114998-1-iangelak@fb.com>
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

On Tue, Jun 21, 2022 at 03:59:17PM -0700, Ioannis Angelakopoulos wrote:
> With this patch series we add the capability to btrfs to expose some
> commit stats through sysfs that might be useful for performance monitoring
> and debugging purposes.
> 
> Specifically, through sysfs we expose the following data:
>   1) A counter for the commits that occurred so far.
>   2) The duration in ms of the last commit.
>   3) The maximum commit duration in ms seen so far.
>   4) The total duration in ms of the commits seen so far.
> 
> The user also has the capability to reset the maximum commit duration
> back to zero, again through sysfs.
> 
> Changes from v3:
> 
> 1) Fixed a mistake when using div_u64 that would break the kernel build
> 
> Changes from v2:
> 
> 1) Only the maximum duration can now be zeroed out through sysfs to
> prevent loss of data if multiple threads try to reset the commit stats
> simultaneously
> 2) Removed the lock that protected the concurrent resetting and updating
> of the commit stats, since only the maximum commit duration can be
> cleared out now (any races can be ignored for this stat).
> 3) Added div_u64 when converting from ns to ms, to also support 32-bit
> 4) Made the output from sysfs easier to use with "grep"
> 
> Changes from v1:
> 
> 1) Edited out unnecessary comments
> 2) Made the memory allocation of "btrfs_commit_stats" under "fs_info" in
> fs/btrfs/ctree.h static instead of dynamic
> 3) Transferred the conversion from ns to ms at the point where commit
> stats get printed in sysfs, for better precision
> 4) Changed the lock that protects the update of the commit stats from
> "trans_lock" to "super_lock"
> 5) Changed the printing of the commits stats in sysfs to conform with
> the sysfs output
> 
> Ioannis Angelakopoulos (2):
>   btrfs: Add the capability of getting commit stats
>   btrfs: Expose the commit stats through sysfs

Added to misc-next, with some minor fixups, thanks.

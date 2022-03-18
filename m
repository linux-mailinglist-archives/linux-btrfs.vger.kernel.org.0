Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1744DE161
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Mar 2022 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiCRSwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Mar 2022 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCRSwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Mar 2022 14:52:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCFE304AEB
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Mar 2022 11:51:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5BFE210FD;
        Fri, 18 Mar 2022 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647629469;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vdbas/R1Q8KHMZ/3t9o1gglU36CevcdnZEu0FuxtszM=;
        b=TcNOObn25qr2GntX3CY6AusXLEGeyx2fPEd1ud8TYvWvQOEypgqVlvG1vdp3gj/PtJGP0w
        t2KBQdlCNWWEjF4VGXe9rUnQ5GMr6A+pj/4bZrXWaj9fLnZtnf1cCLfZFXFC+kSgiGplZX
        R8A6t05uB+HXIDU5Yu6jGvJ1eky6yX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647629469;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vdbas/R1Q8KHMZ/3t9o1gglU36CevcdnZEu0FuxtszM=;
        b=zuCYjWONezE4Zihaqeiq+JNHuRurO50IkjCGkSDTC/uqa2q6VRpZqDjiNjfb3NEqVZZTKW
        eLTSQJsskALBO6Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CC06DA3B83;
        Fri, 18 Mar 2022 18:51:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 64513DA7E1; Fri, 18 Mar 2022 19:47:09 +0100 (CET)
Date:   Fri, 18 Mar 2022 19:47:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: [PATCH] btrfs: check/qgroup: fix two error messages used in
 qgroup verification
Message-ID: <20220318184709.GG12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
References: <59b4af870c15cbd7e05d05d41312e5eb54632632.1647497564.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b4af870c15cbd7e05d05d41312e5eb54632632.1647497564.git.wqu@suse.com>
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

On Thu, Mar 17, 2022 at 02:12:50PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a weird error message when running btrfs check on a specific
> immage:
> 
>  [7/7] checking quota groups
>  ERROR: out of memory
>  ERROR: Loading qgroups from disk: -2
>  ERROR: failed to check quota groups
> 
> [CAUSE]
> The "Out of memory" one is in load_quota_info(), which is output in two
> cases:
> 
> - No memory can be allocated for btrfs_qgroup_list
>   AKA, real -ENOMEM.
> 
> - No qgroup can be found for either the child or the parent qgroup
>   This returnes -ENOENT.
> 
> Obvious the image has hit -ENOENT case, but the error message is fixed
> to ENOMEM case.
> 
> [FIX]
> Fix it by using %m to output the real reason of failure.
> 
> Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
> Link: https://forums.opensuse.org/showthread.php/567851-btrfs-fails-to-load-qgroups-from-disk-with-error-2-(out-of-memory)
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850570E767
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjEWVfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjEWVfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 17:35:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37AFA
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 14:35:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEA4C1FDFA;
        Tue, 23 May 2023 21:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684877716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2quEbqLN3iO4v2hJ+F/f8OeTdKfzlSxnvfj+IU/rNCE=;
        b=NXRa0M1WXoJ4lkdUZ6th/o/It2XELOsO8s1p+/0FkyWJkmpKjk+V1uvUjQkJBv2vXwuj8A
        ANeOxKe149lJFnCzd1Sb7LV9kiCXl72A37jj5KfhjYrlyc5scdEFGvTNJQ/avisz+cXQTm
        UMXT5rXXHBYxUDlaxlzVr2bFJ2tCsBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684877716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2quEbqLN3iO4v2hJ+F/f8OeTdKfzlSxnvfj+IU/rNCE=;
        b=I4FNoFJ/kexXiw2kJ41TQNEw1iP1+SG03axMGmvEZDb6ymdy4zCuk2NJTX9yY/KV5A6zUV
        Qt3PBinfCs65HgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D942B13588;
        Tue, 23 May 2023 21:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M6NXNJQxbWQ8CgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 21:35:16 +0000
Date:   Tue, 23 May 2023 23:29:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 9/9] btrfs: fix source code style in find_fsid
Message-ID: <20230523212909.GE32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684826246.git.anand.jain@oracle.com>
 <cf801647e5f9dde29711a97453ff73641adec787.1684826247.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf801647e5f9dde29711a97453ff73641adec787.1684826247.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 06:03:25PM +0800, Anand Jain wrote:
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 730fc723524e..db46df2f8fb2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -443,8 +443,8 @@ static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
>  	return true;
>  }
>  
> -static noinline struct btrfs_fs_devices *find_fsid(
> -		const u8 *fsid, const u8 *metadata_fsid)
> +static noinline struct btrfs_fs_devices *find_fsid(const u8 *fsid,
> +						   const u8 *metadata_fsid)

We have lots of mixed coding styles, patches that change just one place
are not so useful, it's better to fix coding style when the code is
changed. If there's some consistent anti-pattern it might be worth
fixing separately but function argument indentation is in the category
of harmless but unfortunately vastly inconsistent.

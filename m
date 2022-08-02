Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E723588128
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiHBRis (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiHBRir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 13:38:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46D4AD48
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 10:38:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5601E37F56;
        Tue,  2 Aug 2022 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659461924;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IL7Zb5tWP3T49oTGd1kAF+8XxRM5KkxCHkGc8VqzoE=;
        b=ux55SCWYKJw1JEMfR4bjkMF8NO+76Bwiv80N07cYVE2bhKiuF7BXGrrTVxPHSRClnfC1+q
        5G70YVwFZYXmg82PASaymrUB1s5y4cEY1tGnXmdNIMm8GUMsg6kkr2D3gfxgSWxs9EQCyE
        J12NCJ1BdQYdrd4fHLdmElbDlG9uatE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659461924;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IL7Zb5tWP3T49oTGd1kAF+8XxRM5KkxCHkGc8VqzoE=;
        b=iVi0YDlL3SCtiHsBRDHkU3+WQT4Sy0Mgn3kyoqAjSaUTQLXTl0B8LCmmi0/o+Yy0iQWSIm
        NhBYtMMEgzfm4uBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25AA01345B;
        Tue,  2 Aug 2022 17:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eiksCCRh6WI4QwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 17:38:44 +0000
Date:   Tue, 2 Aug 2022 19:33:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/7] btrfs: Add macros for annotating wait events with
 lockdep
Message-ID: <20220802173342.GV13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220725221150.3959022-1-iangelak@fb.com>
 <20220725221150.3959022-2-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725221150.3959022-2-iangelak@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 25, 2022 at 03:11:46PM -0700, Ioannis Angelakopoulos wrote:
> Introduce four macros that are used to annotate wait events in btrfs code
> with lockdep; 1) the btrfs_lockdep_init_map, 2) the btrfs_lockdep_acquire,
> 3) the btrfs_lockdep_release, and 4) the btrfs_might_wait_for_event macros.
> 
> The btrfs_lockdep_init_map macro is used to initialize a lockdep map.
> 
> The btrfs_lockdep_<acquire,release> macros are used by threads to take the
> lockdep map as readers (shared lock) and release it, respectively.
> 
> The btrfs_might_wait_for_event macro is used by threads to take the
> lockdep map as writers (exclusive lock) and release it.
> 
> In general, the lockdep annotation for wait events works as follows:
> 
> The condition for a wait event can be modified and signaled at the same
> time by multiple threads. These threads hold the lockdep map as readers
> when they enter a context in which blocking would prevent signaling the
> condition. Frequently, this occurs when a thread violates a condition
> (lockdep map acquire), before restoring it and signaling it at a later
> point (lockdep map release).
> 
> The threads that block on the wait event take the lockdep map as writers
> (exclusive lock). These threads have to block until all the threads that
> hold the lockdep map as readers signal the condition for the wait event and
> release the lockdep map.
> 
> The lockdep annotation is used to warn about potential deadlock scenarios
> that involve the threads that modify and signal the wait event condition
> and threads that block on the wait event. A simple example is illustrated
> below:
> 
> Without lockdep:
> 
> TA                                        TB
> cond = false
>                                           lock(A)
>                                           wait_event(w, cond)
>                                           unlock(A)
> lock(A)
> cond = true
> signal(w)
> unlock(A)
> 
> With lockdep:
> 
> TA                                        TB
> rwsem_acquire_read(lockdep_map)
> cond = false
>                                           lock(A)
>                                           rwsem_acquire(lockdep_map)
>                                           rwsem_release(lockdep_map)
>                                           wait_event(w, cond)
>                                           unlock(A)
> lock(A)
> cond = true
> signal(w)
> unlock(A)
> rwsem_release(lockdep_map)
> 
> In the second case, with the lockdep annotation, lockdep would warn about
> an ABBA deadlock, while the first case would just deadlock at some point.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>  fs/btrfs/ctree.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db85b9dc7ed..f2169d01c66e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1175,6 +1175,51 @@ enum {
>  	BTRFS_ROOT_UNFINISHED_DROP,
>  };
>  
> +/*
> + * Lockdep annotation for wait events.
> + *
> + * @b: The struct where the lockdep map is defined
> + * @lock: The lockdep map corresponding to a wait event
> + *
> + * This macro is used to annotate a wait event. In this case a thread acquires
> + * the lockdep map as writer (exclusive lock) because it has to block until all
> + * the threads that hold the lock as readers signal the condition for the wait
> + * event and release their locks.
> + */
> +#define btrfs_might_wait_for_event(b, lock)					\

Please don't use sinle letter varaibles or macro parameters, I've
renamed it to 'owner' in all macros.

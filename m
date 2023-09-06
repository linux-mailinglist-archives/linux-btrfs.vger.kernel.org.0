Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C885A794101
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjIFQCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjIFQC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:02:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA11981
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:02:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C1D2222F9;
        Wed,  6 Sep 2023 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694016142;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hauOLiLXbd7nlV2SYHRTXu2/6N3d6+mP0xjrj8WZLYY=;
        b=fzYKdjp7VJzBeS9HPpHK6pqXp6V/uvcycOvD6eE/p26hl07o31s8cOi+R/ndilPewniR2p
        EsQQ+uQXxrUnkQ/MC+Is0FJxYHISq2D154Poq6M0w5WRLS90tqfarHIELuAtEAfkMTmJ0v
        WGEQsk8vT1QrCw3xSnqRKgHj+3nGv80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694016142;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hauOLiLXbd7nlV2SYHRTXu2/6N3d6+mP0xjrj8WZLYY=;
        b=ez6Epjdlkvmqbv9XhJoZHTdsUa1Ex7MAWdNZivitKhJl2V4lbuxFcThUrPE9gjMw3ga2Ax
        W+f9RaSlkXH3VFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C3951333E;
        Wed,  6 Sep 2023 16:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id huIFCo6i+GSjcwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 16:02:22 +0000
Date:   Wed, 6 Sep 2023 17:55:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/6] btrfs: qgroup: remove GFP_ATOMIC usage for ulist
Message-ID: <20230906155541.GL14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693613265.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693613265.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 02, 2023 at 08:13:51AM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v3:
> - Remove the no longer utilized memalloc_nofs_save() calls
> - Remove the "@" prefix of variables in the subject line
> - Rename iterator2 to nested_iterator and enhance the comments of it
> 
> v2:
> - Remove the final GFP_ATOMIC ulist usage
>   This is done by introducing a new list_head, btrfs_qgroup::iterator2,
>   allowing us to do nested iteration.
> 
>   This extra nested facility is needed as even if we move the qgroups
>   collection into one dedicated function, we're reusing the list for
>   iteration which can lead to unnecessary re-visit of the same qgroup.
> 
>   Thus we have to support one level of nested iteration.
> 
> - Add reviewed by tags from Boris
> 
> [REPO]
> https://github.com/adam900710/linux/tree/qgroup_mutex
> 
> Yep, the branch name shows my previous failed attempt to solve the
> problem.
> 
> [PROBLEM]
> There are quite some GFP_ATOMIC usage for btrfs qgroups, most of them
> are for ulists.
> 
> Those ulists are just used as a temporary memory to trace the involved
> qgroups.
> 
> [ENHANCEMENT]
> This patchset would address the problem by adding a new list_head called
> iterator for btrfs_qgroup.
> 
> And all call sites but one of ulist allocation can be migrated to use
> the new qgroup_iterator facility to iterate qgroups without any memory
> allocation.
> 
> There is a special call site in btrfs_qgroup_account_extent() that it
> wants to do nested qgroups iteration, thus a nested version is
> introduced for this particular call site.
> 
> And BTW since we can skip quite some memory allocation failure handling
> (since there is no memory allocation), we also save some lines of code.
> 
> Qu Wenruo (6):
>   btrfs: qgroup: iterate qgroups without memory allocation for
>     qgroup_reserve()
>   btrfs: qgroup: use qgroup_iterator facility for
>     btrfs_qgroup_free_refroot()
>   btrfs: qgroup: use qgroup_iterator facility for qgroup_convert_meta()
>   btrfs: qgroup: use qgroup_iterator facility for
>     __qgroup_excl_accounting()
>   btrfs: qgroup: use qgroup_iterator facility to replace tmp ulist of
>     qgroup_update_refcnt()
>   btrfs: qgroup: use qgroup_iterator_nested facility to replace qgroups
>     ulist of qgroup_update_refcnt()

Added to misc-next, with some minor fixups, thanks. Getting rid of the
allocations and error handling is great. I think qgroup_to_aux() is now
unused and maybe there's more related to the ulists that can be cleaned
up or removed.

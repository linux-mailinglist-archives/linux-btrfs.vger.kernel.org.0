Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C268479C055
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbjIKWAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbjIKR06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 13:26:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689A125
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:26:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CD5A2185A;
        Mon, 11 Sep 2023 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694453211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yj5x+95/bkjl9FEphu/zyzgq9rgQ33XBrAJiJ3VXrao=;
        b=h0s8dFPQtGn0OFQLjnct4YJhx4K+WxHAI+dTt7cbDTkJ78DeEAQugTMO+/8PqMYrgg3w9w
        TD5B7L2uIhzfvDhkKvBtPd/yLUA85M9yNF5+Ar1A84A9Nfxa/fTEZ5y211NkYBK5+eGH7D
        CQ90kiADyaAzqPYNL38zZPc2vsXJj8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694453211;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yj5x+95/bkjl9FEphu/zyzgq9rgQ33XBrAJiJ3VXrao=;
        b=kAS6CbqNyqRksGc6AO5lEQSBkr6UwK7JKZgxLz58ratGvL8XqWon+/CIybPqp3ACpuzobn
        a5a6IQ3273q/WeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08AFF139CC;
        Mon, 11 Sep 2023 17:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOoyAdtN/2QnJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 17:26:51 +0000
Date:   Mon, 11 Sep 2023 19:20:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/21] btrfs: updates to delayed refs accounting and
 space reservation
Message-ID: <20230911172016.GC3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 06:20:17PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are some fixes, improvements and cleanups around delayed refs.
> Mostly about space accouting and reservation and were motivated by a case
> hit by a SLE (SUSE Linux Enterprise) user where a filesystem became unmountable
> and unusable because it fails a RW mount with -ENOSPC when attempting to do
> any orphan cleanup. The problem was that the device had no available space
> for allocating new block groups and the available metadata space was about
> 1.5M, too little to commit any transaction, but enough to start a transaction,
> as during the transaction commit we need to COW more than we accounted for
> when starting the transaction (running delayed refs generates more delayed
> refs to update the extent tree for example). Starting any transaction there,
> either to do orphan cleanup, attempt to reclaim data block groups, unlink,
> etc, always failed during the transaction commit and result in transaction
> aborts.
> 
> We have some cases where we use and abuse of the global block reserve
> because we don't reserve enough space when starting a transaction or account
> delayed refs properly, and can therefore lead to exhaustion of metadata space
> in case we don't have more unallocated space to allocate a new metadata block
> group.
> 
> More details on the individual changelogs.
> 
> There are more cases that will be addressed later and depend on this patchset,
> but they'll be sent later and separately.
> 
> Filipe Manana (21):
>   btrfs: fix race when refilling delayed refs block reserve
>   btrfs: prevent transaction block reserve underflow when starting transaction
>   btrfs: pass a space_info argument to btrfs_reserve_metadata_bytes()
>   btrfs: remove unnecessary logic when running new delayed references
>   btrfs: remove the refcount warning/check at btrfs_put_delayed_ref()
>   btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
>   btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_ref()
>   btrfs: remove refs_to_add argument from __btrfs_inc_extent_ref()
>   btrfs: remove refs_to_drop argument from __btrfs_free_extent()
>   btrfs: initialize key where it's used when running delayed data ref
>   btrfs: remove pointless 'ref_root' variable from run_delayed_data_ref()
>   btrfs: log message if extent item not found when running delayed extent op
>   btrfs: use a single variable for return value at run_delayed_extent_op()
>   btrfs: use a single variable for return value at lookup_inline_extent_backref()
>   btrfs: return -EUCLEAN if extent item is missing when searching inline backref
>   btrfs: simplify check for extent item overrun at lookup_inline_extent_backref()
>   btrfs: allow to run delayed refs by bytes to be released instead of count
>   btrfs: reserve space for delayed refs on a per ref basis
>   btrfs: remove pointless initialization at btrfs_delayed_refs_rsv_release()
>   btrfs: stop doing excessive space reservation for csum deletion
>   btrfs: always reserve space for delayed refs when starting transaction

Added to misc-next, thanks.

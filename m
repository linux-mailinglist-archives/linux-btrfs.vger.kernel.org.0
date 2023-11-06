Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2935C7E2EE5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 22:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKFVVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 16:21:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A182AF
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 13:21:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13CE0225F8;
        Mon,  6 Nov 2023 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699305709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkiEQBF50uwh3jr0lvsLMByo7ez2KA2v9bD0Kzn+PMM=;
        b=q89zgI/TFsB0tZzvAfrYvQ2d3izBBbhKw7f20knZQBFWDOj8wCndmWZkvJkiA24aQuwwma
        6lKxXiQ5QUF0zJyh5DTwNdOGBHF54BLhd8ELDKBhzU1ZZy3pqcQ5dg4SX6C3XtTbluppoe
        iLEkEiQQ3/zoVErkxEv+cxArkH7F0RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699305709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkiEQBF50uwh3jr0lvsLMByo7ez2KA2v9bD0Kzn+PMM=;
        b=Qggc+ZUHJ8yxmo6auHGNqBs3s38V6EEh9JOxSOTupzufqgOg2FiLDpNd/kuzpfk1IN3Plf
        AAAVGBtPKGHvqwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3D65138F3;
        Mon,  6 Nov 2023 21:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VzTcNuxYSWUoQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Nov 2023 21:21:48 +0000
Date:   Mon, 6 Nov 2023 22:14:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix qgroup record leaks when using simple quotas
Message-ID: <20231106211447.GP11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2431d473c04bede4387c081007d532758fcd2f28.1699301753.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2431d473c04bede4387c081007d532758fcd2f28.1699301753.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 06, 2023 at 08:17:37PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using simple quotas we are not supposed to allocate qgroup records
> when adding delayed references. However we allocate them if either mode
> of quotas is enabled (the new simple one or the old one), but then we
> never free them because running the accounting, which frees the records,
> is only run when using the old quotas (at btrfs_qgroup_account_extents()),
> resulting in a memory leak of the records allocated when adding delayed
> references.
> 
> Fix this by allocating the records only if the old quotas mode is enabled.
> Also fix btrfs_qgroup_trace_extent_nolock() to return 1 if the old quotas
> mode is not enabled - meaning the caller has to free the record.
> 
> Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas")
> Reported-by: syzbot+d3ddc6dcc6386dea398b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000004769106097f9a34@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

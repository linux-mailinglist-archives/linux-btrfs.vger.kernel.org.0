Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D537B7BBA60
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjJFOf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJFOf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 10:35:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B53CA
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 07:35:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D73CD1F896;
        Fri,  6 Oct 2023 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696602952;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeB0SmHf5xxqC0L7Ojwgzas1ilX/ROAIfugbCKnNHwI=;
        b=UneBO1oU4cQa2SvkPpaR69KCpV3ILR6d1IwpWxUiiTRcRcCkkz8DwKR5CSQNNjVY53O1jF
        8Qw8abakp/G/aLIWrHz0WmP+fbP6AhvknGsb+Nb6Z1vJI+geLAk2d5VU9XIbxq8aQ5AVew
        BhOaYIf8UYnxPdiD//dEdVEg3t3A+xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696602952;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeB0SmHf5xxqC0L7Ojwgzas1ilX/ROAIfugbCKnNHwI=;
        b=1BvSl5+KcRtHoyuWEBYuTut2gLcuKle4qYD9IgDqJEOKvE8yTOnDKZHpJqEWOWt0CjS4ok
        Tis2Duz7wQGPVkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE02713586;
        Fri,  6 Oct 2023 14:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bKKLLUgbIGVqYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 14:35:52 +0000
Date:   Fri, 6 Oct 2023 16:29:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: fix some data races during fsync and cleanups
Message-ID: <20231006142909.GD28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696415673.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 04, 2023 at 11:38:47AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following remove some data races affecting mostly fsync. In general
> these are mostly harmless from a functional perspective, though there are
> a few cases that could cause some unexpected results but should be very
> rare to hit. There's also a couple cleanups here.
> More details on the changelogs.
> 
> Filipe Manana (6):
>   btrfs: add and use helpers for reading and writing last_log_commit
>   btrfs: add and use helpers for reading and writing log_transid
>   btrfs: add and use helpers for reading and writing fs_info->generation
>   btrfs: add and use helpers for reading and writing last_trans_committed
>   btrfs: remove pointless barrier from btrfs_sync_file()
>   btrfs: update comment for struct btrfs_inode::lock

Added to misc-next as the changes are straightforward, if there's any
fixup needed for the increments I'll do that in the commits after we
agree. Thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AC2724933
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjFFQch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 12:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjFFQcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 12:32:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99110D5
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 09:32:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54441219D6;
        Tue,  6 Jun 2023 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686069152;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBu+uLHeyJIvdh00qUD1wQbusOBSfKLxuXra/hoyc7E=;
        b=NlJZD43OUW/q/RfyQ7cE8mkYEz7YM+28+TfB8uWn63DC86vGZBjlQ1bMV6aPDF6H5adKWA
        BzZw00Arw7JNOHVk5qsHzrZq4lncLLVOI23EB5gsnpTCsU7j/np/NcJmI5oOjkTdS1nYRH
        bSVAvxT/5ljkUFzvLIT+zknYCbs65Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686069152;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBu+uLHeyJIvdh00qUD1wQbusOBSfKLxuXra/hoyc7E=;
        b=xMUEEwSjQgyTVTGg1uIvFLJF2F6MuhPrl/D8+NB3YSGruzYyfJgsWZ1nkjYDKK5YZWkR2J
        UCfboIEOINYZwwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36B1513519;
        Tue,  6 Jun 2023 16:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8qxlDKBff2TUPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 16:32:32 +0000
Date:   Tue, 6 Jun 2023 18:26:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update documentation for a block group's bg_list
 member
Message-ID: <20230606162616.GK25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <148d635697bfb4ac3f9010526a6d79b8ee34316d.1686061295.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148d635697bfb4ac3f9010526a6d79b8ee34316d.1686061295.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 03:26:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we are only documentating two uses of the bg_list member of a
> block group, but there two more:
> 
> 1) To track deleted block groups for discard purposes, introduced in
>    commit e33e17ee1098 ("btrfs: add missing discards when unpinning
>    extents with -o discard");
> 
> 2) To track block groups for automatic reclaim, introduced more recently
>    by commit 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> 
> So document those two other use cases.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20087B0946
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjI0PtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjI0Ps7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 11:48:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CD27C44
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 08:48:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8FD11F385;
        Wed, 27 Sep 2023 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695829711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dy2UnKHZ5XXXE4Km49F7fI7NvcVoKmIRQJXq0MNBkYc=;
        b=Un1b5yVOIli0clO5O2KLvvTZQOz1LvoesfCGiUJE2zMc6syteWoeJNam2yinBw2TkCI/SE
        cF7+GdCBqmVNf0t8ZRtYu0shzCH/kUy7x7bEbSDqC0urxpKcILSohiOUlkbw62pEMEL+Nx
        HrvWCV1BPw8l9PpSt4y3rmF2osRMfzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695829711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dy2UnKHZ5XXXE4Km49F7fI7NvcVoKmIRQJXq0MNBkYc=;
        b=6TbFQC+nUI40vGv6CtocTBJVxbeJM/JaNvinYu7T9whb/P3/Hf135ngOCAV7gQdnwXd9eA
        dbY+ZKsrOPcLXzBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A04EB13479;
        Wed, 27 Sep 2023 15:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ERZMJs9OFGWycwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Sep 2023 15:48:31 +0000
Date:   Wed, 27 Sep 2023 17:41:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: always print transaction aborted messages with an
 error level
Message-ID: <20230927154153.GZ13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <70f9a616df5b0f4268f309312d93d3a972fd9289.1695753057.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f9a616df5b0f4268f309312d93d3a972fd9289.1695753057.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 07:31:19PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit b7af0635c87f ("btrfs: print transaction aborted messages with an
> error level") changed the log level of transaction aborted messages from
> a debug level to an error level, so that such messages are always visible
> even on production systems where the log level is normally above the debug
> level (and also on some syzbot reports).
> 
> Later, commit fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to
> transaction.c") changed the log level back to debug level when the error
> number for a transaction abort should not have a stack trace printed.
> This happened for absolutely no reason.

That was mistake on my side while rebasing the patches that moved code,
thanks for noticing it.

> It's always useful to print
> transaction abort messages with an error level, regardless of whether
> the error number should cause a stack trace or not.
> 
> So change back the log level to error level.
> 
> Fixes: fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to transaction.c")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

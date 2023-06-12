Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30C72C865
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjFLO11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjFLO1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 10:27:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0491BE1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:25:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 351C9201D6;
        Mon, 12 Jun 2023 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686579900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YUHXdTQWPUsNeHjCVqVAXffhF54RfUhy/OhbXIIK9Q0=;
        b=WYqtF1rE1X4ZRa9NT9CoBTDU9g1MpyxTAftG3f5j+YMehd5NV4BhDNIKAMSKbZgj8Zv+dP
        fLQeQcVlZmdVZ9vjbBfnNxyg4vpCyjr04YpE9hwnrf2pAc6q5RNoHim5UAfytVbOc5PGf5
        yOs9vzMaOnX+1PdnoaUJ9mFfJVwid1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686579900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YUHXdTQWPUsNeHjCVqVAXffhF54RfUhy/OhbXIIK9Q0=;
        b=r2xIIDA9bHXOMtROYOqEbRaKdJ8EAiOg5rLR5qZirZ1ZjceGBTdkQHaRe+ut8l1Daw6eMm
        Gqmz6pVaFysDiBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 123881357F;
        Mon, 12 Jun 2023 14:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I619A7wqh2SOHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 14:25:00 +0000
Date:   Mon, 12 Jun 2023 16:18:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove
 btrfs_fs_info::scrub_wr_completion_workers
Message-ID: <20230612141841.GD13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6e0ace5a15c44d7264a2261597c66a975f214a21.1686554551.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0ace5a15c44d7264a2261597c66a975f214a21.1686554551.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 12, 2023 at 03:23:29PM +0800, Qu Wenruo wrote:
> Since the scrub rework introduced by commit 2af2aaf98205 ("btrfs:
> scrub: introduce structure for new BTRFS_STRIPE_LEN based interface")
> and later commits, scrub only needs one single workqueue,
> fs_info::scrub_worker.
> 
> That scrub_wr_completion_workers is initially to handle the delay work
> after write bios finished.
> But the new scrub code goes submit-and-wait for write bios, thus all the
> work are done inside the scrub_worker.
> 
> The last user of fs_info::scrub_wr_completion_workers is removed in
> commit 16f93993498b ("btrfs: scrub: remove the old writeback
> infrastructure"), so we can safely remove the workqueue.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

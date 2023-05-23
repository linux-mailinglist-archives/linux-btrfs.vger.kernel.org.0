Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1055D70E4E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjEWSvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjEWSvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 14:51:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87F91
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 11:51:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1B32229BC;
        Tue, 23 May 2023 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684867908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6OvnltIbVtlYqgmrT9t+UQksKo3tNq6WV6VvqS2rYI=;
        b=tbVfixpO0gYiVbuZjfomPNLZC9zWw7c5Qtqp/Jwbj3yU6PmMKv9XOjiNdlX3cBrtUiuYxE
        aiup3QJ2PJ7QopOLd62qjg2RVNtHqZYnJi1zjIz5KKMnF7c90jvriA+l/rGk+UOhOyCnN/
        7ZXH/rFdxrRiv0KQuDK61prbdjphlVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684867908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6OvnltIbVtlYqgmrT9t+UQksKo3tNq6WV6VvqS2rYI=;
        b=MR6ZiPK2Zb/qYtxN0fLn2zCz2/KbQpWyxtPjjReimVhFqdjuYAeGlg3+tb3/sZq7EBZ3XO
        +1Z9LkTDheusijBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B198313588;
        Tue, 23 May 2023 18:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IOy+KUQLbWRwUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 18:51:48 +0000
Date:   Tue, 23 May 2023 20:45:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 13/21] btrfs: don't use btrfs_bio_ctrl for extent buffer
 writing
Message-ID: <20230523184541.GZ32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503152441.1141019-14-hch@lst.de>
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

On Wed, May 03, 2023 at 05:24:33PM +0200, Christoph Hellwig wrote:
> The btrfs_bio_ctrl machinery is overkill for writing extent_buffers
> as we always operate on PAGE SIZE chunks (or one smaller one for the
> subpage case) that are contigous and are guaranteed to fit into a
> single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
> and btrfs_submit_bio calls.

submit_extent_page hasn't been open coded completely, there's still call
to wbc_account_cgroup_owner() but it's probably skipped for other
reasons as this is metadata inode.

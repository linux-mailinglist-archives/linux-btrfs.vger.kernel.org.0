Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88E69E2CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjBUO5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjBUO5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:57:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E332916A
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:57:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAE425C83C;
        Tue, 21 Feb 2023 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676991440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btSA7E+JzP9xuLix/BGrmcjZ2h+GsVic6+RnrKJLqho=;
        b=W+rnskiVK/aSztl4/vN19IrPmzzaLPudW6Wi7D+knuCmB7qocBgQk2snQNExWv8gxL9jc4
        o1UoDV5TQplCQRQUw/NscWseABNpMgCdjrlS+Q1wTBKjqy186ZvTOKajplui4Coy1sZ6OQ
        S4nKj+5NCfdoRPIPDRg6H9Lz4p6WRT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676991440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btSA7E+JzP9xuLix/BGrmcjZ2h+GsVic6+RnrKJLqho=;
        b=H9p7RWDFSrtox6Fp3rL8kUpf7l9F9BgLevVNgz43TsqitQSAOooqJ6d2oa39UjdQ82E3k7
        8uRRrlLiKv8KtiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E2AC13223;
        Tue, 21 Feb 2023 14:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iiE8GdDb9GORYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 14:57:20 +0000
Date:   Tue, 21 Feb 2023 15:51:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Message-ID: <20230221145124.GM10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230219181022.3499088-1-hch@lst.de>
 <20230220201905.GJ10580@twin.jikos.cz>
 <20230221142818.GA29949@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221142818.GA29949@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 03:28:18PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 20, 2023 at 09:19:05PM +0100, David Sterba wrote:
> > On Sun, Feb 19, 2023 at 07:10:22PM +0100, Christoph Hellwig wrote:
> > > Move the remaining code that deals with initializing the btree
> > > inode into btrfs_init_btree_inode instead of splitting it between
> > > that helpers and its only caller.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Added to misc-next, thanks.
> 
> Btw, in case you need to rebase again, the subject needs a
> 'inode' after 'btree'.

I see, fixed, thanks.

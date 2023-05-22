Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CCB70BCF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjEVMIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjEVMIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:08:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC615AC
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:08:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65ECF1FEB8;
        Mon, 22 May 2023 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684757303;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wT2cUu94a2ucoZZh0uohbe9WAzIDGIA0TkA47g5G+mg=;
        b=yoFPdo6HaYhK2vLdc1dJ2qu9ITuDe481rW5Pk5OyuiYIIHAyE9nvrcySFNVcvF+nxDCZ0P
        u/6NPl8c65BwKsVzx7N6VdONU6lfwFlS4NtUc9MV39OI3ODYhUK5OMFHuV5+qyFbFSdh/a
        pE2QXQdd95uRxqdYQdHvl0xYkGkMQJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684757303;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wT2cUu94a2ucoZZh0uohbe9WAzIDGIA0TkA47g5G+mg=;
        b=BhfV5+F3gFdOYp9mPptTh0Dvkm8ieLiTCOymXxujcSpK9lw+iyK66v3YOEvJzOuD6mcafv
        U3Oq19AqZkJ6SzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3856B13336;
        Mon, 22 May 2023 12:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /bjgDDdba2QmTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 12:08:23 +0000
Date:   Mon, 22 May 2023 14:02:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: trigger orphan inodes cleanup during sync
 ioctl
Message-ID: <20230522120217.GM32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <79d32abc0d6c1a3afcf9224bd44875f5594c80b6.1683848508.git.wqu@suse.com>
 <20230522114329.GK32559@twin.jikos.cz>
 <89804ef5-2dfc-ecb0-cc48-87bed8694e67@gmx.com>
 <20230522115332.GL32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522115332.GL32559@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 22, 2023 at 01:53:32PM +0200, David Sterba wrote:
> On Mon, May 22, 2023 at 07:51:17PM +0800, Qu Wenruo wrote:
> > On 2023/5/22 19:43, David Sterba wrote:
> > > On Fri, May 12, 2023 at 07:42:05AM +0800, Qu Wenruo wrote:
> > >> --- a/fs/btrfs/ioctl.c
> > >> +++ b/fs/btrfs/ioctl.c
> > >> @@ -3111,6 +3111,11 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
> > >>   {
> > >>   	struct btrfs_trans_handle *trans;
> > >>   	u64 transid;
> > >> +	int ret;
> > >> +
> > >> +	ret = btrfs_orphan_cleanup(root);
> > >> +	if (ret < 0)
> > >> +		return ret;
> > >
> > > I think this should not fail the whole sync ioctl, namely when it would
> > > not even try to start the transaction commit.
> > 
> > If the cleanup failed, it's mostly possible that the subvolume tree is
> > corrupted, and we would still abort transaction during that subvolume
> > tree operation.
> 
> Yes, and that's the right place to detect the error.

I've updated with

---
-       int ret;
 
-       ret = btrfs_orphan_cleanup(root);
-       if (ret < 0)
-               return ret;
+       /*
+        * Start orphan cleanup here for the given root in case it hasn't been
+        * started already by other means. Errors are handled in the other
+        * functions during transaction commit.
+        */
+       btrfs_orphan_cleanup(root);
---

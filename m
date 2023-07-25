Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13807624AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 23:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGYVnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYVnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 17:43:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B901FDD
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 14:43:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C8D121FA0;
        Tue, 25 Jul 2023 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690321399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSK/5IPDpsgkNA72Lqifi6d/lWeEbcyQamEk8tdhxmc=;
        b=gSyspF3n7kH93ERTue1phi8NVgYPsbVquXiN1au24gVozTiOlwbBQPnPGc895+Ri6NB+nW
        CzcWvgDqEQUMTDT2RUG/XSt0fYEC3+bkv+IbsKJBdWh/Dw8IvT9P+4yjfiDU5bVE1WpmZI
        8YXfQJ4G8tblli8wpe6kUhWdPHOYd+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690321399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSK/5IPDpsgkNA72Lqifi6d/lWeEbcyQamEk8tdhxmc=;
        b=WZsTKqe+LTG1SHpbML4fdida8iblI8j9sJHZWC6RQidkiSyI2w7FDw1qhOXy87cAwuYf+Z
        2C1DSjtkQGDIseCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6C1F13342;
        Tue, 25 Jul 2023 21:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pp9YM/ZBwGTLQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Jul 2023 21:43:18 +0000
Date:   Tue, 25 Jul 2023 23:36:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: consolidate the error handling in
 run_delalloc_nocow
Message-ID: <20230725213634.GI20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724142243.5742-1-hch@lst.de>
 <20230724142243.5742-4-hch@lst.de>
 <20230724182737.GA587411@zen>
 <20230724194844.GB30159@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724194844.GB30159@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 09:48:44PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 11:27:37AM -0700, Boris Burkov wrote:
> > > -		return -ENOMEM;
> > > -	}
> > > +	if (!path)
> > > +		goto error;
> > 
> > nit: I think it's nicer to do ret = -ENOMEM here rather than relying on
> > initializion. It makes it less likely for a different change to
> > accidentally disrupt the implicit assumption that ret == -ENOMEM.
> 
> I kinda like the early initialization version, but I can live with
> either variant.

We use the style where the ret is initialized to 0 and then either
there's a direct return of error code or 'ret = -ERROR' followed by a
goto. There are a few remaining to convert but please don't add new
ones.

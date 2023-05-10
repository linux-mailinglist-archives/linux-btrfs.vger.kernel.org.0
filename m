Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E46FDE63
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 15:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjEJNWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbjEJNWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 09:22:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E9D5BAC
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 06:22:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCBF21F45E;
        Wed, 10 May 2023 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683724969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBHJ0n78T+TD9YwJlJYsl20oLUj/Is2B9Izd7mz2A3k=;
        b=C1kgiWgjNPMf0nwJnhdaANLuUGrVhVLySd/pRKbttyGG9J6VG9YYfU2myf/QXBi0CUUH2d
        0kHjOYrFWqybp3Qa4gxRrmdd2J5EvUmLIswknPKVaeRFPW/h6ddWS/OHW11zKTJr3htsmv
        JtYa1qFcJr590NdRIE9frXuIFSlwRcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683724969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBHJ0n78T+TD9YwJlJYsl20oLUj/Is2B9Izd7mz2A3k=;
        b=H0GO+unC6741HDUYM0xIYUMtfMwHxgcRgnpDEOyk+F/eId/AQaOLER6s9jrqybEXjcFnyo
        kWZTnVAxbSg1OJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B608E13519;
        Wed, 10 May 2023 13:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tiMjK6maW2TNDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 13:22:49 +0000
Date:   Wed, 10 May 2023 15:16:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/21] btrfs: add a btrfs_finish_ordered_extent helper
Message-ID: <20230510131650.GQ32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-18-hch@lst.de>
 <c850eb49-2e63-ed20-c987-4ff5a406f851@wdc.com>
 <20230509131244.GA32049@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509131244.GA32049@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 03:12:44PM +0200, Christoph Hellwig wrote:
> On Tue, May 09, 2023 at 12:22:39AM +0000, Johannes Thumshirn wrote:
> > > +		  show_root_type(__entry->root_objectid),
> > > +		  __entry->ino, __entry->start,
> > > +		  __entry->len, __entry->uptodate)
> > > +);
> > 
> > Why can't we use the btrfs__ordered_extent event class here?
> 
> We could.  We'd lose the information on the range of the ordered_extent
> that actually is being completed.  If the maintainers are ok with not
> having that in the trace point we can drop the separate implementation.

I think it's good to have the range there, the parameters and info for
the trace point do not match the ordered extent class so it needs to be
a separate one.

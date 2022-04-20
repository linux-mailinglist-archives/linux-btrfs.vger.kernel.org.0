Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27A6509083
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381787AbiDTTff (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 15:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbiDTTfe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 15:35:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0A3A196
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 12:32:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2D361F385;
        Wed, 20 Apr 2022 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650483165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnXss0dA9ighV6LjF1pPAfyp9uPrmyPvqj9zCX7DQ9g=;
        b=UIOUrkOmSAmoaUxC+Yrme/4vYKJH4RynZ26IUmAmLekA8vaq++fDdHXxfcJl4QS7KqAVpn
        wEOwVPcjfnzEDoIuRoaVzOZ7rHb0sDfhgH0eKQr6rxjVOc5Z0awWJviXgJHmBM/ESFETo3
        PaTtYHW+Vkn5U5FdGRF14rQGG7zufYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650483165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnXss0dA9ighV6LjF1pPAfyp9uPrmyPvqj9zCX7DQ9g=;
        b=RqzDnykEMwklwVnD+vEBpVyxiLYzVh3ebCdnFlsV8mi+3/PMxlWMuIOzScasC8rNkiINux
        qZdc0PuLr4h6nhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A74FE13A30;
        Wed, 20 Apr 2022 19:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xqfUJ91fYGI9DgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 19:32:45 +0000
Date:   Wed, 20 Apr 2022 21:28:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: minor bio submission cleanups
Message-ID: <20220420192841.GI1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 15, 2022 at 04:33:23PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up a few loose ends in the btrfs bio submission path.
> 
> Diffstat:
>  compression.c |   11 +++++------
>  compression.h |    4 ++--
>  ctree.h       |    5 ++---
>  disk-io.c     |   26 ++++++++++----------------
>  disk-io.h     |    4 ++--
>  extent_io.c   |   39 +++++++++++++++++++++++++++++++++++----
>  extent_io.h   |   18 ++----------------
>  inode.c       |   49 ++++++++++---------------------------------------
>  8 files changed, 68 insertions(+), 88 deletions(-)

Added to misc-next, thanks.

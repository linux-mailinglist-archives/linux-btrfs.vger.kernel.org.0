Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016AC72C6D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjFLOD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjFLOD4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 10:03:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05D10C2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:03:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7D7522835;
        Mon, 12 Jun 2023 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686578633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L387rmMCmKfCJiPBRJUINZQXitJxtp8bB1yFvjy2qrc=;
        b=g4msD9QX0ghXVCJCF/SBdFa0kQ9R6ChQzppQa5CSlUP6pM0VyW7bgYfI4VdvTKAWKd5Ipt
        ESAucSpJvJ3MQ1/rB1Yu8PmAThXtZhIKCtkJ3nUGRDlJXRQ24f0+hKfYqzVOZ5E801QR4E
        oePo9vjAfCPXvFa8prYqXb9JD0UO4ZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686578633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L387rmMCmKfCJiPBRJUINZQXitJxtp8bB1yFvjy2qrc=;
        b=MNnraoDFxP+0TPP9qDKaU4ZxTTEXhRuXKXyLpbladN+SVGHzsDJELFT14uF7GX7pbRNh4D
        Jyz7lweucE/v5pDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9555B1357F;
        Mon, 12 Jun 2023 14:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PG+yI8klh2S8FAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 14:03:53 +0000
Date:   Mon, 12 Jun 2023 15:57:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: add an ordered_extent pointer to struct btrfs_bio v2
Message-ID: <20230612135735.GA13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
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

On Wed, May 31, 2023 at 09:53:53AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a pointer to the ordered_extent to struct btrfs_bio to
> reduce the repeated lookups in the rbtree.  For non-buffered I/Os the
> I/O will now never do a lookup of the ordered extent tree (other places
> like waiting for I/O still do).  For buffered I/O there is still a lookup
> as the writepages code is structured in a way that makes it impossible
> to just pass the ordered_extent down.  With some of the work from Goldwyn
> this should eventually become possible as well, though.
> 
> Changes since v1:
>  - rebased to the latest misc-next tree with the changes to not split
>    ordered extents for zoned writes
>  - rename is_data_bio to is_data_bbio
>  - add a new bbio_has_ordered_extent helper

For the record, this was added to misc-next last week, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD15533A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiFUNe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351903AbiFUNdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 09:33:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0026558
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 06:29:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AC911F917;
        Tue, 21 Jun 2022 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655818176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CfouJc0F2o07ELzdMnVvnBmoD+Kz6QjgXm6R1pcHL4=;
        b=uycpXtnRbfEIDj4nGX5u9AXbPhrufToHglfPQUWvHG2tCoeJUqlCkxLJf9H+cUsEjOx+vq
        QVSMKZyF7miP4cyPBcjdiOVj87OBhq6BHmWFgMtTW2Xjqs/1J+rasnUW6zyMjrzQkC0GDq
        6Eb6DZNV9p65Zv7Yo9i71jUydgwf8/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655818176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CfouJc0F2o07ELzdMnVvnBmoD+Kz6QjgXm6R1pcHL4=;
        b=vGwn1cjlw3W7elk7X89JWmj/6j09A4MdjqnewGiW1cw5unvbpKvkGOyQ0BEQ6lbuyvcw7B
        i//uuaxqUM1cYqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD56813A88;
        Tue, 21 Jun 2022 13:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PksWNb/HsWIGLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 13:29:35 +0000
Date:   Tue, 21 Jun 2022 15:24:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, willy@infradead.org, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <20220621132458.GX20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, willy@infradead.org, nborisov@suse.com
References: <20220609164629.30316-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
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

On Thu, Jun 09, 2022 at 06:46:29PM +0200, David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> API.  We don't use the page cache or the mapping anywhere else, the page
> is a temporary space for the associated bio.
> 
> Allocate pages for all super block copies at device allocation time,
> also to avoid any later allocation problems when writing the super
> block. This simplifies the page reference tracking, but the page lock is
> still used as waiting mechanism for the write and write error is tracked
> in the page.
> 
> As there is a separate page for each super block copy all can be
> submitted in parallel, as before.
> 
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> v2:
> 
> - allocate 3 pages per device to keep parallelism, otherwise the
>   submission would be serialized on the page lock

I'll continue with the super block write in the future, so far the patch
has uncovered several issues:

- preallocated page must be for each super block copy (offset, checksum)

- bio for each page can be preallocated too

- wait on super block page/bio should move from page lock (eg.
  completion)

- we want parallel submission due to performance reasons and impact on
  operations that may block on commit (fsync)

- using page cache vs direct write, read from user space may get stale
  data if super block write does not use page cache, there's also page
  cache read in kernel but that won't race with write

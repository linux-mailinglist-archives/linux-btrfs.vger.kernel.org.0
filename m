Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1A70E4E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjEWSta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjEWSt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 14:49:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D5D121
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 11:49:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 206FB22193;
        Tue, 23 May 2023 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684867764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rorngea/fVfRw01GjKR43Z1y1929jLUeEG/4Fr2guYY=;
        b=kcfnE02/59hwNvSG/dqa/Ba/GkixOi5+8Q2muRWNhVlTo8u7ozcggLsZfE16xCgpBqXz00
        npXinAMToaVuOF3iwJrlGuO8Zg9bd7SXq/15oZuSB2+aMA5Br9wc0oHF3NatifAEAYeGOW
        j19i5lAm+z6Y/zabwtqapHbRkuUxpc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684867764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rorngea/fVfRw01GjKR43Z1y1929jLUeEG/4Fr2guYY=;
        b=4bI/Bss7JXsbelmNo0JZA06CuW5lBGfFl7xW0SHYUgjj8dxCzkP8z6zuh4qKLupiF82r5q
        D86xGBdbtfZOk3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE99513588;
        Tue, 23 May 2023 18:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0BJyObMKbWRwUgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 18:49:23 +0000
Date:   Tue, 23 May 2023 20:43:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 10/21] btrfs: return bool from lock_extent_buffer_for_io
Message-ID: <20230523184317.GY32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503152441.1141019-11-hch@lst.de>
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

On Wed, May 03, 2023 at 05:24:30PM +0200, Christoph Hellwig wrote:
> lock_extent_buffer_for_io never returns a negative error value, so switch
> the return value to a simple bool.  Also remove the noinline_for_stack
> annotation given that nothing in lock_extent_buffer_for_io or its callers
> is particularly stack hungry.

AFAIK the reason for noinline_for_stack is not because of a function is
stack hungry but because we want to prevent inlining it so we can see it
on stack in case there's an implied waiting. This makes it easier to
debug when IO is stuck or there's some deadlock.

This is not consistent in btrfs code though, quick search shows lots of
historical noinline_for_stack everywhere without an obvious reason.

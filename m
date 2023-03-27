Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C226CABC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjC0RUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjC0RUr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 13:20:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794044A3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 10:20:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79FDB1FDBC;
        Mon, 27 Mar 2023 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679937641;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0344ePVi6nN5DPvTdclyPnhZf8dtQBtMyz9q8y6qNg=;
        b=cw3W8s5XfEa46KxUavYOOIF+J4i0pLZVctc1iaTWRmibuWa2QTcw0XGTIks0hk9cqrFILs
        n/jwGhXPrzTKQ4P//HORv640CvQ4F15g64sGwRYQ7ZcKh548fmvvG7eefGHaDsnChM2nI2
        H1mD3wf4gFgTUQB9srsTKU88x9Ixvmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679937641;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0344ePVi6nN5DPvTdclyPnhZf8dtQBtMyz9q8y6qNg=;
        b=Ez1khJbHzdwxOUwyTChYUEmhCHETceoJMjJ5xB6jbIuUdRIuWE6b+2062t3ibMvQ0fDKLx
        R0ZA3B9VMtKbRJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BD2213329;
        Mon, 27 Mar 2023 17:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jjvcFGnQIWTLagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Mar 2023 17:20:41 +0000
Date:   Mon, 27 Mar 2023 19:14:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: use test_and_clear_bit() in wait_dev_flush()
Message-ID: <20230327171427.GI10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679910087.git.anand.jain@oracle.com>
 <7baf74b071f9d9002d2543cfc4f86bd3ddf7127f.1679910088.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7baf74b071f9d9002d2543cfc4f86bd3ddf7127f.1679910088.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 27, 2023 at 05:53:10PM +0800, Anand Jain wrote:
> The function wait_dev_flush() tests for the BTRFS_DEV_STATE_FLUSH_SENT
> bit and then clears it separately. Instead, use test_and_clear_bit().

But why would we need to do it like that? The write and wait are
executed in one thread so we don't need atomic change to the status and
thus a separate set/test/clear bit are fine. If not, then please
explain. Thanks.

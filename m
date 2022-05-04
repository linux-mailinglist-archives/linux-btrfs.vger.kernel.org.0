Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5451A5DD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiEDQt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbiEDQt4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 12:49:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38426442
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 09:46:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9EF2C210E5;
        Wed,  4 May 2022 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651682778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+EJbp/Hxpfd10P4rniMKv+QfplaIKZYeqmRegf7F4U=;
        b=X0pQSzbLPZoaMI2mJcMHZ6hNKhmfx+HEzZIsJ2fJ6mwAz6BvTv8CdV77ZXBTTQd+Ewganh
        2UNXGgJI9JXkwrRKrgs+JhmkUFOywmJeaKUzl2DPQYbZkrZVH4BCPOtyqNVOod3gDZZQ2C
        A1b+TeRng/gLN+w7d4ivuv4FRJ2xcR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651682778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+EJbp/Hxpfd10P4rniMKv+QfplaIKZYeqmRegf7F4U=;
        b=ZfZ8gJz9ITAP1QXTu5jzU1fHU2FoDsw0cUZwLCr37vJbX8rsYCToMDVF0gRzasb+Gg4LiM
        jf9al2zYpY9ASeAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DEAA131BD;
        Wed,  4 May 2022 16:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 06HeHdqtcmJSUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 16:46:18 +0000
Date:   Wed, 4 May 2022 18:42:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220504164207.GS18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220503104443.24758-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503104443.24758-1-gniebler@suse.com>
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

On Tue, May 03, 2022 at 12:44:43PM +0200, Gabriel Niebler wrote:
> … rename it to simply fs_roots and adjust all usages of this object to use
> the XArray API, because it is notionally easier to use and understand, as
> it provides array semantics, and also takes care of locking for us,
> further simplifying the code.
> 
> Also do some refactoring, esp. where the API change requires largely
> rewriting some functions, anyway.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

Updated in misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1D5802A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiGYQ2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGYQ2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 12:28:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CB1C93D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 09:28:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B88DA34C35;
        Mon, 25 Jul 2022 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658766520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvPlMZWz+n1NXR7r8bUj8DxC5+5gIkp3ovhqHk613cc=;
        b=hc9ecgfe5Dms4a0o3qwzQeryScME1oqwrjqs4Drilp/g1QdGNp6s0qkWWLmeLz4DPPqo0U
        L4xwJY9iveOYzNSK/xZJwX5Hgyp6xsUAGRkc0s+JWy5A8sv5W79mEs0VxLzX9Cfe5RyW4m
        GKiwca9FK2BGIIk5Q7MH7Vrhe8Lq5Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658766520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvPlMZWz+n1NXR7r8bUj8DxC5+5gIkp3ovhqHk613cc=;
        b=pd5dm69RJ288IHk/EJ7Jl6abf0CCbDUYTTnONpEbG7fAd950E7Rc8qWiAXAvzNSITOaBrO
        MmIEPYmlnveWUHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA2513A8D;
        Mon, 25 Jul 2022 16:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k51HJbjE3mKeTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Jul 2022 16:28:40 +0000
Date:   Mon, 25 Jul 2022 18:23:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pierre Couderc <pierre@couderc.eu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Best way to programmatically send/receive ?
Message-ID: <20220725162343.GB13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pierre Couderc <pierre@couderc.eu>,
        linux-btrfs@vger.kernel.org
References: <4ade214c-db16-dd74-7118-8d0fa128ea52@couderc.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ade214c-db16-dd74-7118-8d0fa128ea52@couderc.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 23, 2022 at 08:22:48AM +0200, Pierre Couderc wrote:
> I am doing a utility to manage backup of btrfs subvolumes.
> 
> I need to save a subvolume using btrfs send/receive
> 
> 
> I use libbtrfsutils, which is very fine, but I have found no entry about 
> send/receive in it.

The send/receive support is lacking in libbtrfsutil.

> What is the best  way to do that in C/C++...?

Right now it's available in libbtrfs and an example implementation in
C/C++ is snapper. However, the libbtrfs library has several issues so
I'd rather not encourage new use. The interface is frozen and can be
considered stable, which also means that the v2 stream won't be ported
there.

The libbtrfs is a library done the wrong way, no clean namespace,
naming, GPL so libbtrfsutil is supposed to provide the proper interface.
But right now that's the plan.

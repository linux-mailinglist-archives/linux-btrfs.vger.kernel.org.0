Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D3965B3DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjABPJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjABPJ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 10:09:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183965D9;
        Mon,  2 Jan 2023 07:09:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 553EC33F33;
        Mon,  2 Jan 2023 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672672167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3inhzlJ1kphf30kGqcfB3IeR/M1SRIjMjaEh07PjDsE=;
        b=lc2pDCZ0pOsJyCrPuegIpMEZq1FrJnYzuZoN3UumC+vS2LYmG7eL2SYXE/U/FbdyQzu3g4
        kuzgWV/wrI9wUQeVs2vlJaDNN7eOS4MdQby1u1Q5gvexzLcHvEhVJMRcHIBSf369tcxiAk
        52y/Y4pHUm1CI8C0Uo63LJtOp9RAvi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672672167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3inhzlJ1kphf30kGqcfB3IeR/M1SRIjMjaEh07PjDsE=;
        b=aDx9VR4IWx22B+i33fm6Q9fPIjDxKlzTG89XqU1HA4LVMpV5Tw8fL1WbaSLGAdPsHANLYP
        XAZQlCdRb8FePACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 247A713427;
        Mon,  2 Jan 2023 15:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xbTgB6fzsmP6XwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 15:09:27 +0000
Date:   Mon, 2 Jan 2023 16:03:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     zys.zljxml@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH] brtfs: use PAGE_ALIGNED macro
Message-ID: <20230102150357.GF11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221228040447.3566246-1-zys.zljxml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228040447.3566246-1-zys.zljxml@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 28, 2022 at 12:04:47PM +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> The header file linux/mm.h provides the PAGE_ALIGNED macro to
> test whether an address is aligned to PAGE_SIZE. Use it instead
> of IS_ALIGNED.

There are about 8 such conversions in fs/btrfs/, please fix them all.
Thanks.

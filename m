Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3E9574DD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiGNMiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiGNMiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 08:38:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CD5C9CE;
        Thu, 14 Jul 2022 05:38:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A54E01F8FB;
        Thu, 14 Jul 2022 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657802288;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN/KMnzfK08k1zHwz3a76YlKl7qTFBSFPkaQtZzhBJo=;
        b=YV5Hx2NpBVlFYKIBvEqpgHXPQQwef9F25yCzKOdH0qA8OdWvRjPiFxnl++EZu9IXCFrg9O
        EMtEVZk2ClHOE8Kljugr8+FrFPvpKPTKZ7B8nLeVCp0QW5e4XBAwzRFfuB6WyT3Bf4Hc7G
        IQE9yM/CB4rhQSOEHqUONIATGKxyev0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657802288;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN/KMnzfK08k1zHwz3a76YlKl7qTFBSFPkaQtZzhBJo=;
        b=UoPb/YSnPgXbrGsO++XfxbnF53as2lYK0wlytATcczF6KFt5QYJm3TuyK8XOlfX8HaWsNk
        F5l7YY+nQokV2uAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52920133A6;
        Thu, 14 Jul 2022 12:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WawDEzAO0GKcfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Jul 2022 12:38:08 +0000
Date:   Thu, 14 Jul 2022 14:33:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Message-ID: <20220714123317.GI15169@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
 <20220714082519.A7C9.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714082519.A7C9.409509F4@e16-tech.com>
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

On Thu, Jul 14, 2022 at 08:25:20AM +0800, Wang Yugui wrote:
> Hi,
> 
> Compiler warning:
> 
> fs/btrfs/zstd.c:478:55: warning: passing argument 1 of ‘__kunmap_local’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   478 |                         kunmap_local(workspace->in_buf.src);
> ./include/linux/highmem-internal.h:284:24: note: in definition of macro ‘kunmap_local’
>   284 |         __kunmap_local(__addr);                                 \
>       |                        ^~~~~~
> ./include/linux/highmem-internal.h:200:41: note: expected ‘void *’ but argument is of type ‘const void *’
>   200 | static inline void __kunmap_local(void *addr)
>       |                                   ~~~~~~^~~~

This requires patch
https://lore.kernel.org/all/20220706111520.12858-2-fmdefrancesco@gmail.com/
that adds const to kmap/kunmap API.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408152AB9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352557AbiEQTKc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344856AbiEQTKZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 15:10:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867A13F3B
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:10:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 741991F932;
        Tue, 17 May 2022 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652814623;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7zJ5vaAHCNYVizPZeCc2bd75cAZ57p4vGO+dDh0uJo=;
        b=niCS+jTHu7fEXIRKXKw9hfaWU/jHjySZkvo3VYs98vzQNgtXtP26zSsIr//pe6Of+ApQ83
        HOoqZgmk1qdpD0VecG/UywUrIGNnZ9zb/HpIW2qgTxj7xSuOGkV9riktKTqueLbUJoZsW9
        MPaq/jm9TDWm0LAwUul5kENlEZDwbCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652814623;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7zJ5vaAHCNYVizPZeCc2bd75cAZ57p4vGO+dDh0uJo=;
        b=U6eNj3e1Kdxi1LmB3QuVwnxNCcNGj+mt9WG+C+vM4XIuRCt6tzqiETiaGaBkF8H2gDZABW
        Gc+dMFf0ioq5q8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B03D13305;
        Tue, 17 May 2022 19:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bVxXER/zg2JMUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 19:10:23 +0000
Date:   Tue, 17 May 2022 21:06:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert: initialize the target fs label
Message-ID: <20220517190604.GG18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <bde751b337d81bed2754ae69544fb7fd43d8191f.1652431869.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde751b337d81bed2754ae69544fb7fd43d8191f.1652431869.git.wqu@suse.com>
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

On Fri, May 13, 2022 at 04:51:10PM +0800, Qu Wenruo wrote:
> [BUG]
> When running some tests, I notice that my debug build of btrfs-convert
> is throwing out garbage for target fs label:
>   $ ./btrfs-convert  ~/test.img
>   btrfs-convert from btrfs-progs v5.17
> 
>   Source filesystem:
>     Type:           ext2
>     Label:
>     Blocksize:      4096
>     UUID:           29d159a8-cb46-41d3-8089-3c5c65e4afae
>   Target filesystem:
>     Label:          @pcwU	<<< Garbage here
>     Blocksize:      4096
>     Nodesize:       16384
>     UUID:           682bf5f2-8cb1-4390-b9ac-6883cd87ed39
>     Checksum:       crc32c
>   ...
> 
> [CAUSE]
> The fslabel[] array is just not initialized, thus it can contain
> garbage.
> 
> [FIX]
> Initialize fslabel[] array to all zero.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

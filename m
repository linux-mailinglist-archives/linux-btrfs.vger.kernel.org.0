Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E886E6FEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 01:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDRXZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDRXZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 19:25:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A58F7AA1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 16:25:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F1C9218D6;
        Tue, 18 Apr 2023 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681860306;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uQXZ+z18iKSoEZqV3eqwG6YctMZc08umtezGuAZzLs=;
        b=h7dvHCkVSXyhTG9BBh6+EEtK6H4wNVVeGQfkPcWC5i1GvXpJwrbq5Qpm3yyKGEByzG44qq
        /UEFxAZEJo5X7SKfyTauVAp79/cev9CS01EUgzavzMbmEkwfbO+rduyO+TWW2LtyLMwVYC
        BK5fLhiDdJKotX1/teIkA4ebAICv6+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681860306;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uQXZ+z18iKSoEZqV3eqwG6YctMZc08umtezGuAZzLs=;
        b=FvyxVvlkj4kJy/rVAwt8dkGOiiSXxgEAuULBVrl9wzhXWudD0uR8BWZgqZvGQclR5/11Zc
        DQu5FYdXzILTiBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 695C313581;
        Tue, 18 Apr 2023 23:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LGv1GNImP2R5YgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Apr 2023 23:25:06 +0000
Date:   Wed, 19 Apr 2023 01:24:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix bitops api misuse
Message-ID: <20230418232456.GT19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fc21b3d5ddf062b746bc55425672969f897d685d.1681801005.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc21b3d5ddf062b746bc55425672969f897d685d.1681801005.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 18, 2023 at 05:45:24PM +0900, Naohiro Aota wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> find_next_bit and find_next_zero_bit take @size as the second parameter and
> @offset as the third parameter. They are specified opposite in
> btrfs_ensure_empty_zones(). Thanks to the later loop, it never failed to
> detect the empty zones. Fix them and (maybe) return the result a bit
> faster.
> 
> Fixes: 1cd6121f2a38 ("btrfs: zoned: implement zoned chunk allocator")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 2b160fda7301..55bde1336d81 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1171,12 +1171,12 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>  		return -ERANGE;
>  
>  	/* All the zones are conventional */
> -	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> +	if (find_next_bit(zinfo->seq_zones, end, begin) == end)

End is defined as "end = (start + size) >> shift", and the 2nd parameter
of find_next_bit is supposed to be 'size'. Shouldn't it be "size >>
shift"?

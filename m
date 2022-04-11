Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991354FBF10
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbiDKO3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbiDKO3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:29:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D23BC16
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:27:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 46EED1F7AD;
        Mon, 11 Apr 2022 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649687224;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79IC81lK/uZYSoR7+p1nWKQc8qVv0MNc+KuoZ+1IlU4=;
        b=rbRQrmthPBoUGe3Y8Ww/2XCsSDAOX6norun5loRUlvb7ymoTHFkEmTX95JVSO2eQPUnyNT
        OAmoiJP/GYJIIA2eemwu3WS5SNEesTl7wjT2v8LdBYC3rDH6mpL3THwMkRxdyFx3K5XFA0
        IMwcMt00SQLvcjBSEYTjMNhcprzWQk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649687224;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79IC81lK/uZYSoR7+p1nWKQc8qVv0MNc+KuoZ+1IlU4=;
        b=IULvrTvJuMWD6mZPMSPSOU5p08tA2vMSjZs1NeQKg2TRXcco7D3IprYVgEbUPLI4LBPLWF
        2Dk4w8NPeLJ+y9DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 39600A3B83;
        Mon, 11 Apr 2022 14:27:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7471DA7DA; Mon, 11 Apr 2022 16:22:59 +0200 (CEST)
Date:   Mon, 11 Apr 2022 16:22:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Jayce Lin <jaycelin@synology.com>
Subject: Re: [PATCH] btrfs: do not allow compression on nocow files
Message-ID: <20220411142259.GL15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Chung-Chiang Cheng <cccheng@synology.com>, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Jayce Lin <jaycelin@synology.com>
References: <20220409043432.1244773-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409043432.1244773-1-cccheng@synology.com>
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

On Sat, Apr 09, 2022 at 12:34:32PM +0800, Chung-Chiang Cheng wrote:
> -static int prop_compression_validate(const char *value, size_t len)
> +static int prop_compression_validate(struct inode *inode, const char *value, size_t len)
>  {
>  	if (!value)
>  		return 0;
>  
> -	if (btrfs_compress_is_valid_type(value, len))
> -		return 0;
> -
>  	if ((len == 2 && strncmp("no", value, 2) == 0) ||
>  	    (len == 4 && strncmp("none", value, 4) == 0))
>  		return 0;
>  
> +	if (!inode || BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)
> +		return -EINVAL;

I think the nodatacow check should be the first one, before the
validation of value for "no" or "none", it's logically the same as the
btrfs_compress_is_valid_type.

Also, should there be a check for NODATASUM? The checks in the property
should do the same as the normal compression code, see eg.
inode_can_compress. It's an internal helper so it would be cleaner to
have it exported and reuse here instead of duplicatin the conditions.

For a minimal fix I'd be OK with the code duplication as this would need
to go to stable, so "fixes before cleanups".

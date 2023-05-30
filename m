Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2269A716041
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjE3Moa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 08:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjE3MoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 08:44:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4CD100
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 05:43:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71F3321A39;
        Tue, 30 May 2023 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685450601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dddf7hYYyx+npedzqTetH3KRG2gRmkPeJ6OWLTftk8E=;
        b=uxEGhGf/8gIgt4EPvcLQF0Q63C0smwiIPIGGEWFLDUzVFxc4QxHFD4MThb/mUOTD3h13JI
        nHfeDxYHsfjapkC861ClvU3TPBjX7LCvP9u1QkVCGhRmMK8fpVJuS78zLJeMPWlfMMJbYD
        VUivifITYTguLuCeVhv1XoAm+WZ2Vlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685450601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dddf7hYYyx+npedzqTetH3KRG2gRmkPeJ6OWLTftk8E=;
        b=i+PEOqCSfsq87BIG5ZXz8nrMnwLUMZ4QQ834FEiCkmvNFLKuo2eGXHN1tOBGv5lqTyEfKk
        HJrEQQZIWH1DFDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49E4A13478;
        Tue, 30 May 2023 12:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O//qEGnvdWS+JgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 12:43:21 +0000
Date:   Tue, 30 May 2023 14:37:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Message-ID: <20230530123710.GM575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
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

On Tue, May 30, 2023 at 06:15:11PM +0800, Anand Jain wrote:
> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
> print-tree.c, as it is currently missing in the dump-super output, which
> was too confusing.
> 
> Before:
> flags			0x1000000001
> 			( WRITTEN )
> 
> After:
> flags			0x1000000001
> 			( WRITTEN |
> 			  CHANGING_FSID_V2 )
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  kernel-shared/print-tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index aaaf58ae2e0f..623f192aaefc 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_array[] = {
>  	DEF_HEADER_FLAG_ENTRY(WRITTEN),
>  	DEF_HEADER_FLAG_ENTRY(RELOC),
>  	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
> +	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),

Should the flag be also added to BTRFS_SUPER_FLAG_SUPP? Currently all
the other SUPER_FLAGs are there.

>  	DEF_SUPER_FLAG_ENTRY(SEEDING),
>  	DEF_SUPER_FLAG_ENTRY(METADUMP),
>  	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
> -- 
> 2.31.1

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB453ED26
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiFFRoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiFFRod (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 13:44:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757D3207DE
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 10:44:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34C9421B7F;
        Mon,  6 Jun 2022 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654537471;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1Gywqov1DJjV30hqLPNW6N4pfrBUcgOz7NsaQC7GKI=;
        b=P+ntdKgKmFF5S3nnY/2qbm3hCTKYwTVSyQHWPLy+mr5aWVNDIZSzisoqexVCo4gWL/un2w
        6948kcOe8CMDRrPTZJT99mR1Hg8WhRiNW35sTTp5SGGU/mwH49uu1lAcSNE83Q4Yiopwj0
        ZU5BHtFaDeH6dYTQdeEWbzoZ0hZFLrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654537471;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1Gywqov1DJjV30hqLPNW6N4pfrBUcgOz7NsaQC7GKI=;
        b=5ZoeiBJzYdhrjCZl+gqlmwzcrbpaMNmW1KxKL/wx1mYy/MD6pbFCSutE0Z7lTPw7mhRfrh
        KimTW6KrLTIopsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D219139F5;
        Mon,  6 Jun 2022 17:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h/s8Av88nmI4IgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Jun 2022 17:44:31 +0000
Date:   Mon, 6 Jun 2022 19:40:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: zoned: prevent allocation from previous data
 relocation BG
Message-ID: <20220606174002.GD20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1654529962.git.naohiro.aota@wdc.com>
 <fd9c3af9cf148b18e6be8e301e1ff4414495d73e.1654529962.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9c3af9cf148b18e6be8e301e1ff4414495d73e.1654529962.git.naohiro.aota@wdc.com>
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

On Tue, Jun 07, 2022 at 12:59:20AM +0900, Naohiro Aota wrote:
> Fixes: c2707a255623 ("btrfs: zoned: add a dedicated data relocation block group")
> CC: stable@vger.kernel.org # 5.16+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.h |  1 +
>  fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
>  fs/btrfs/inode.c       |  2 ++
>  fs/btrfs/zoned.c       | 27 +++++++++++++++++++++++++++
>  fs/btrfs/zoned.h       |  5 +++++
>  5 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 3ac668ace50a..5787b3dd759c 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -104,6 +104,7 @@ struct btrfs_block_group {
>  	unsigned int relocating_repair:1;
>  	unsigned int chunk_item_inserted:1;
>  	unsigned int zone_is_active:1;
> +	unsigned int zoned_data_reloc_ongoing;

Probably jsut a typo, the variable is used only in logical conditions

	unsigned int zoned_data_reloc_ongoing:1;

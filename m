Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA175AD5BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiIEPG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiIEPGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 11:06:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEF93ECD2
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 08:06:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDB7E1F9ED;
        Mon,  5 Sep 2022 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662390409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgUDBhV/A7wIFLcHzn0noFo9mmnixBM9wJ9B1YGf/b0=;
        b=bpb+g7k9LY5WKwWMT8lDK4SI2vBbuGJnA/OvNazKr1POkI8zGWBGIyO/PPVuudAL9gMzIB
        KUFnVX23CocO4w/4YvtK/hrfQCWwmQIT/CPii7Sy6hCM+klmK0iLQpW8aDrzFsOL2H6ixv
        j1XChvkr7+eUxvamfdJzNiSUrzEW8R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662390409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgUDBhV/A7wIFLcHzn0noFo9mmnixBM9wJ9B1YGf/b0=;
        b=qndBfWnxIapNI8fR/Sm4R2B1ljY5Onc9exMEoFCGC/iLCZW/Y7FxV0z/QKFFmhrticgA8l
        cdpst3VTB6pK2vCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A859313A66;
        Mon,  5 Sep 2022 15:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xmYoKIkQFmN+TwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 15:06:49 +0000
Date:   Mon, 5 Sep 2022 17:01:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: separate BLOCK_GROUP_TREE compat RO flag
 from EXTENT_TREE_V2
Message-ID: <20220905150127.GG13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1660021230.git.wqu@suse.com>
 <5c396cb280e441bf37df48e05f406424859a03d3.1660021230.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c396cb280e441bf37df48e05f406424859a03d3.1660021230.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 01:02:18PM +0800, Qu Wenruo wrote:
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -290,6 +290,12 @@ struct btrfs_ioctl_fs_info_args {
>  #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
>  #define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
>  
> +/*
> + * Put all block group items into a dedicate block group tree, greatly
> + * reduce mount time for large fs.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 5)

Is there a reason to skip the bits 3 and 4? Ie. why isn't this (1 << 3) ?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D545AD896
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 19:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIERss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIERsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 13:48:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4F4D17E
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 10:48:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 017B21F889;
        Mon,  5 Sep 2022 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662400125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlK+iQaxGe1oFLPiaThM4K2tFTEVdL3CQ7BVUmhFEhY=;
        b=lALuLYSKsMIt+IlbFN+9DmxfsegEOBsWsP7S2ykayJQtbE7mmNQRQBjf1Fg9CfmzMYpkEW
        Y4uj3k4NlPdHAImOrHFAnZR98EbjWyP6w66o7jhFlXiukSa3vBXOuUoItbBXtAvsuM923I
        6+E8AsWseINRNormbqObindUJLpm0fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662400125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlK+iQaxGe1oFLPiaThM4K2tFTEVdL3CQ7BVUmhFEhY=;
        b=1jkdQNI2A7EFsXlyQvB6qVQc+CoZfQ/J/IBBk6RdmftvYvFW4GI4CUJqIdSLDMp5dslRHo
        1JH9L1sctwE48rAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC45A139C7;
        Mon,  5 Sep 2022 17:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UZ7uMHw2FmOtFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 17:48:44 +0000
Date:   Mon, 5 Sep 2022 19:43:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 3/5] btrfs: introduce
 BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
Message-ID: <20220905174322.GL13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1661302005.git.wqu@suse.com>
 <511e5eec2f5c3797b0981899b57cc4afa8d1102e.1661302005.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511e5eec2f5c3797b0981899b57cc4afa8d1102e.1661302005.git.wqu@suse.com>
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

On Wed, Aug 24, 2022 at 09:14:07AM +0800, Qu Wenruo wrote:
> Here we introduce a new runtime flag,
> BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN, which will inform qgroup rescan
> to cancel its work asynchronously.
> 
> This is to address the window when an operation makes qgroup numbers
> inconsistent (like qgroup inheriting) while a qgroup rescan is running.
> 
> In that case, qgroup inconsistent flag will be cleared when qgroup
> rescan finishes.
> But we changed the ownership of some extents, which means the rescan is
> already meaningless, and the qgroup inconsistent flag should not be
> cleared.
> 
> With the new flag, each time we set INCONSISTENT flag, we also set this
> new flag to inform any running qgroup rescan to exit immediately, and
> leaving the INCONSISTENT flag there.
> 
> The new runtime flag can only be cleared when a new rescan is started.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 46 +++++++++++++++++++++++++++++-----------------
>  fs/btrfs/qgroup.h |  2 ++
>  2 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index fc2ed19ced9b..1b416ac9c3ad 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -333,6 +333,14 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
>  }
>  #endif
>  
> +static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
> +{
> +	BUILD_BUG_ON(BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN &
> +		     BTRFS_QGROUP_STATUS_FLAGS_MASK);

Please use static_assert instead of BUILD_BUG_ON

> +	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
> +				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN);

There should be either a helper to drop the inconsistent flag again or
qgroup_mark_inconsistent can take a parameter to do so, there are
several instances where unsetting is open coded by the "&= ~" operation.

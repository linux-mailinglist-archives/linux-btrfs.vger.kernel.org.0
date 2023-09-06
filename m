Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C4979418B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbjIFQf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbjIFQf6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:35:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0BF10F7
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:35:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8CAC622418;
        Wed,  6 Sep 2023 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694018153;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8lwcNVOEIn770xVv4vcVpcywd4QU+6XKdG6JdKyNkA=;
        b=maa9fxHFO0lhfjq7UPa022pUHtTXUNtbdlK0rV2EeGxnAnbhBWFD7RZwkAfvQgPfmqXjkN
        c+55+XPor8Jq9Z/ITHyqMgkQmsgbco16EhVcQo2X1ChJtfoJZqw3V2YPABFwfPDLUFs7Iq
        uWM0bqi5rCUdcmKY5yH3F3spVFsctTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694018153;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8lwcNVOEIn770xVv4vcVpcywd4QU+6XKdG6JdKyNkA=;
        b=9vF2gZxVLawUZK7I4NwUE5MRZTqZf6GT6vu/Z5bXEK07YrXg95CmdPXA2aH5ibzYUHqV8/
        bcqIFnk94ls8N9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 635DC1346C;
        Wed,  6 Sep 2023 16:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ANqAF2mq+GRaBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 16:35:53 +0000
Date:   Wed, 6 Sep 2023 18:29:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
 GFP_ATOMIC usage
Message-ID: <20230906162913.GQ14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1299b13041aefa9f6fbe25cae6fe6d0fbe7d4bb3.1693309609.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299b13041aefa9f6fbe25cae6fe6d0fbe7d4bb3.1693309609.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 29, 2023 at 07:48:57PM +0800, Qu Wenruo wrote:
> Qgroup is the heaviest user of GFP_ATOMIC, but one call site does not
> really need GFP_ATOMIC, that is add_qgroup_rb().
> 
> That function only search the rb tree to find if we already have such
> tree.
> If there is no such tree, then it would try to allocate memory for it.
> 
> This means we can afford to pre-allocate such structure unconditionally,
> then free the memory if it's not needed.
> 
> Considering this function is not a hot path, only utilized by the
> following functions:
> 
> - btrfs_qgroup_inherit()
>   For "btrfs subvolume snapshot -i" option.
> 
> - btrfs_read_qgroup_config()
>   At mount time, and we're ensured there would be no existing rb tree
>   entry for each qgroup.
> 
> - btrfs_create_qgroup()
> 
> Thus we're completely safe to pre-allocate the extra memory for btrfs_qgroup
> structure, and reduce unnecessary GFP_ATOMIC usage.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

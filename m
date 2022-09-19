Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78FE5BD5F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 22:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiISU7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISU7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 16:59:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF211149
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 13:59:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 471CD21F0D;
        Mon, 19 Sep 2022 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663621182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ci05qs/Nu5VfeHTxv0cQJ7LRYsaIUdGew3TGD7I0v1Y=;
        b=s+CK/NIVWVFb2Y2VtIodINyWJ7GODR5xbQzXvYI8Rappuwp7UcZUVFrLk+5SXifkqajgeD
        LAjODzBsnjT8Ie8emgBiWeQP6aofmCgTnhOMkHdJDgGFxIEYqtentq6XaIgIaR1eurljS5
        rK8pTvizS+o55tGEz3I61SVnJYZnY7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663621182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ci05qs/Nu5VfeHTxv0cQJ7LRYsaIUdGew3TGD7I0v1Y=;
        b=F4u3c8Lb8kOFYaezhAckm2VN6HG1n1y61QqP7uTHaHWhdP21EAkkZI+iEbIE9EInUn6C6T
        bm5dluFcfDDTtrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26F6D13ABD;
        Mon, 19 Sep 2022 20:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lL6LCD7YKGNHdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Sep 2022 20:59:42 +0000
Date:   Mon, 19 Sep 2022 22:54:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 06/15] btrfs: move static_assert() for btrfs_super_block
 into fs.c
Message-ID: <20220919205411.GU32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663196541.git.josef@toxicpanda.com>
 <6b462dc4d7ceffe2ba9141f46bf28350be7c7f4a.1663196541.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b462dc4d7ceffe2ba9141f46bf28350be7c7f4a.1663196541.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 07:04:42PM -0400, Josef Bacik wrote:
> We shouldn't have static_assert()'s in header files in general,

Why? Since we have the _Static_assert support in all compilers we can do
the header compile-time checks.

> but
> especially since btrfs_super_block isn't defined in ctree.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h | 1 -
>  fs/btrfs/fs.c    | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a790c58b4c73..3cb4e0aca058 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -56,7 +56,6 @@ struct btrfs_ioctl_encoded_io_args;
>  
>  #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
>  #define BTRFS_SUPER_INFO_SIZE			4096
> -static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
>  
> +
> +static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);

This can be dropped as the same assert is right after the super block
definition and this is IMO the intended usage pattern. This catches any
accidental changes to the structure.

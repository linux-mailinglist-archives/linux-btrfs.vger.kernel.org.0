Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE76B2D10
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCISpL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCISpK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 13:45:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C9F9D1A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 10:45:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 883D520237;
        Thu,  9 Mar 2023 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678387507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+D5smdVj25ntzk6JR8HwV/i8cLqjgJweEF7+SXSo9Fo=;
        b=nad+pSImn1axztH8X4xRK1mWOsmXLpeA3FxHfz+oeZZDzVGCj9Km+7VnaY3HqKOIocWjZ3
        nyP5nZkkLaarc6iKag1ma/zgeTkziVnSrplYU8R54UFZ5pRV8r78O/DbRwpBRRvnWC3Ki2
        0Qup3oFo6KJ6l2MmldVKcWBtvuc0dDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678387507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+D5smdVj25ntzk6JR8HwV/i8cLqjgJweEF7+SXSo9Fo=;
        b=3O5rjxD2QB6DBjYXdpTysXMfoC4fGMpUE0KpfKlJbdWlvfWE6lO8gTIl1NBB6HBXfQQSlv
        K7y2mbq8uFcNpKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 606A41391B;
        Thu,  9 Mar 2023 18:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oLOzFjMpCmQlPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 18:45:07 +0000
Date:   Thu, 9 Mar 2023 19:39:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 6/6] btrfs-progs: allow zoned RAID
Message-ID: <20230309183903.GM10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230215143109.2721722-1-johannes.thumshirn@wdc.com>
 <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215143109.2721722-7-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 06:31:09AM -0800, Johannes Thumshirn wrote:
> Allow for RAID levels 0, 1 and 10 on zoned devices if the RAID stripe tree
> is used.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> +#if EXPERIMENTAL
> +	if (data) {
> +		if ((flags & BTRFS_BLOCK_GROUP_DUP) && rst)
> +			return true;
> +		/* Data RAID1 needs a raid-stripe-tree */
> +		if ((flags & BTRFS_BLOCK_GROUP_RAID1_MASK) && rst)
> +			return true;
> +		/* Data RAID0 needs a raid-stripe-tree */
> +		if ((flags & BTRFS_BLOCK_GROUP_RAID0) && rst)
> +			return true;
> +		/* Data RAID10 needs a raid-stripe-tree */
> +		if ((flags & BTRFS_BLOCK_GROUP_RAID10) && rst)
> +			return true;
> +	} else {
> +		/* We can support DUP on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_DUP)
> +			return true;
> +		/* We can support RAID1 on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_RAID1_MASK)
> +			return true;
> +		/* We can support RAID0 on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_RAID0)
> +			return true;
> +		/* We can support RAID10 on metadata/system */
> +		if (flags & BTRFS_BLOCK_GROUP_RAID10)
> +			return true;
> +	}

Please turn the above to a bitmask.

> +#else
>  	if (!data && (flags & BTRFS_BLOCK_GROUP_DUP))
>  		return true;
> +#endif
>  
>  	/* All other profiles are not supported yet */
>  	return false;

> +#if !defined(EXPERIMENTAL)

I've noticed that though it's not changed in this patch, such use of the
macro is wrong as EXPERIMENTAL is always defined and must be checked for
0 or 1.

>  		if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_RAID56) {
>  			error("cannot enable RAID5/6 in zoned mode");
>  			exit(1);
>  		}
> +#endif
>  	}

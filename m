Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EA574F24
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiGNN0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGNN0c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 09:26:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB21D42
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 06:26:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6ECA1FB26;
        Thu, 14 Jul 2022 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657805179;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1O7JiCd3mOlA/B2zETO5dKAlVnxvA0P+MaI9aj0H9+U=;
        b=14zUCpFo3KM05RNSr5NE1taj4Z+0h4mmoVuXEmN2maNpvT1x4wVA7xqY6jxvSc5uuJxRfk
        uu3HoqQiBOb5YJYqdJx0By3eobcD5EfoU7KNFuNhiY60f8TmUBg/YLvgI2y3qrJ1oUMQY9
        6g3Igsw/qvUR+WxMT1njLdZkNk/NYqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657805179;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1O7JiCd3mOlA/B2zETO5dKAlVnxvA0P+MaI9aj0H9+U=;
        b=IuGY2Pgw/qaLB5zO2bGku/0Bb9BMdyNNZNqBoyX+NUfhKYePJv1hp7ZpIC00cNXYjJcXaT
        gv30YKC1dcG2boCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8229C13A61;
        Thu, 14 Jul 2022 13:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 67zYHnsZ0GLMGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Jul 2022 13:26:19 +0000
Date:   Thu, 14 Jul 2022 15:21:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Message-ID: <20220714132129.GN15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708200829.3682503-2-iangelak@fb.com>
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

On Fri, Jul 08, 2022 at 01:08:30PM -0700, Ioannis Angelakopoulos wrote:
> @@ -2207,8 +2221,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  			ret = READ_ONCE(prev_trans->aborted);
>  
>  			btrfs_put_transaction(prev_trans);
> -			if (ret)
> +			if (ret) {
> +				btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  				goto cleanup_transaction;

Please move the call btrfs_lockdep_release to the cleanup block before
the cleanup_transaction label so it's not repeated everywhere.

> +			btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  			goto cleanup_transaction;

> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  		goto cleanup_transaction;

> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  		goto cleanup_transaction;

> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  		goto cleanup_transaction;

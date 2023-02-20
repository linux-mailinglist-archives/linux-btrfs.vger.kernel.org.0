Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5A69D588
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 22:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjBTVLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 16:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjBTVLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 16:11:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B31CAC8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 13:11:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C25A420BBF;
        Mon, 20 Feb 2023 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676927460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erbvAZalrXrmdqdoO/HtInpfKpJhgcTMQUmg6yq2D/8=;
        b=iJbV6sJmu26ZP4c85vEa1xcFL7KJhcmZmqDEl45CAb5F3a+8CQ//easO/nFknxzImcd0qw
        dbKrQEPE2MMcuuZ4VnRO/u3JhNfgVaUfT85aQJ67jxw7hBhDxBOUlVUio9lYltgmrt27d6
        qcHdJbAe2J0kVVaD3V5HD5F2dnIh/Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676927460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erbvAZalrXrmdqdoO/HtInpfKpJhgcTMQUmg6yq2D/8=;
        b=YD8hcxTURFsMhRZrtl4fyQR1+2P4vR7T+fioTOM0O61QtDLcHBuZ1jIa5BN2eIYudo5nkk
        8wRbXe6X9X8XjJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AEAC134BA;
        Mon, 20 Feb 2023 21:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IkvYJOTh82NTbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 21:11:00 +0000
Date:   Mon, 20 Feb 2023 22:05:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/6] btrfs: reduce div64 calls by limiting the number of
 stripes of a chunk to u32
Message-ID: <20230220210505.GK10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676611535.git.wqu@suse.com>
 <b478ecdd00a6f4d897e6b74cac6a01cd63a37356.1676611535.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b478ecdd00a6f4d897e6b74cac6a01cd63a37356.1676611535.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 17, 2023 at 01:36:59PM +0800, Qu Wenruo wrote:
> -	u64 stripe_nr;
> -	u64 stripe_nr_end;
> +	u32 stripe_nr;
> +	u32 stripe_nr_end;
> +	u32 stripe_cnt;
>  	u64 stripe_end_offset;
> -	u64 stripe_cnt;
>  	u64 stripe_offset;
>  	u32 stripe_index;
>  	u32 factor = 0;
>  	u32 sub_stripes = 0;
> -	u64 stripes_per_dev = 0;
> +	u32 stripes_per_dev = 0;
>  	u32 remaining_stripes = 0;
>  	u32 last_stripe = 0;
>  	int ret;
> @@ -6015,18 +6015,19 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>  		factor = map->num_stripes / sub_stripes;
>  		*num_stripes = min_t(u64, map->num_stripes,
>  				    sub_stripes * stripe_cnt);
> -		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
> +		stripe_index = stripe_nr % factor;
> +		stripe_nr /= factor;
>  		stripe_index *= sub_stripes;
> -		stripes_per_dev = div_u64_rem(stripe_cnt, factor,
> -					      &remaining_stripes);
> -		div_u64_rem(stripe_nr_end - 1, factor, &last_stripe);
> -		last_stripe *= sub_stripes;
> +
> +		remaining_stripes = stripe_cnt % factor;
> +		stripes_per_dev = stripe_cnt / factor;
> +		last_stripe = (stripe_nr_end - 1) % factor * sub_stripes;

Please add ( ) where the operator precedence is not obvious, there are
default C rules for that but for clarity I've added

		last_stripe = ((stripe_nr_end - 1) % factor) * sub_stripes;

* / and % are of same priority but it's not common to see
them in one expression.

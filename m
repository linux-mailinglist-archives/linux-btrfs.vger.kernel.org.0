Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1E533F80
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiEYOpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbiEYOpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 10:45:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC2AE273
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 07:45:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 297511F923;
        Wed, 25 May 2022 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653489933;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4YSG7mEYzH9GBX/GEZFCye0g562OZZqQDy/hVVAWFE=;
        b=OB2ve8ghxUouiZXqwGsa52Yg1AMKnR/J/VBZu6VkWBIcvX39xBXOHuuHuH0ziBB94nd5fe
        yFFzP1cPA62ywHF9BTQZPhikFMgPgkZu6uW1RwaBpQ4dhL+ZVZdCGMFoWCGXMlblrpkYMP
        qSCVVNsqn1ISY3h0fQn5f6GigpL5vTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653489933;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4YSG7mEYzH9GBX/GEZFCye0g562OZZqQDy/hVVAWFE=;
        b=vFgfD5B3dKTiW49qyBTi1iAzw84RGtFUy2gtueX7TSk7E5ZvLJUoeMzL9jQQqwiTomW55I
        bqSi+b2N2dSB2yCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3C5913487;
        Wed, 25 May 2022 14:45:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UdehNgxBjmLrdAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 May 2022 14:45:32 +0000
Date:   Wed, 25 May 2022 16:41:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     naohiro.aota@wdc.com, dsterba@suse.com, Johannes.Thumshirn@wdc.com,
        linux-btrfs@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v2] btrfs:zoned: fix comment description for
 sb_write_pointer logic
Message-ID: <20220525144110.GB22722@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pankaj Raghav <p.raghav@samsung.com>,
        naohiro.aota@wdc.com, dsterba@suse.com, Johannes.Thumshirn@wdc.com,
        linux-btrfs@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220517184533eucas1p289b49362dc7697534f7243115758951e@eucas1p2.samsung.com>
 <20220517184532.76400-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517184532.76400-1-p.raghav@samsung.com>
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

On Tue, May 17, 2022 at 08:45:32PM +0200, Pankaj Raghav wrote:
> - Empty[0] && In use[1] should be an invalid state instead of returning
>   zone 0 wp
> - Empty[0] && Full[1] should be returning zone 0 wp instead of zone 1 wp
> - In use[0] && Empty[1] should be returning zone 0 wp instead of being an
>   invalid state
> - In use[0] && Full[1] should be returning zone 0 wp instead of returning
>   zone 1 wp
> - Full[0] && Empty[1] should be returning zone 1 wp instead of returning
>   zone 0 wp
> - Full[0] && In use[1] should be returning zone 1 wp instead of returning
>   zone 0 wp
> 
> Fix the comments to represent the actual logic used for sb_write_pointer
> as indicated above.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.

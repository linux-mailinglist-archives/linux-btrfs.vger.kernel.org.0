Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79451A985
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 19:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355257AbiEDRRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359025AbiEDRQV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 13:16:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5568B1D8
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 10:00:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D16A4210E5;
        Wed,  4 May 2022 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651683610;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxY2OgL3XAPCmsFPupJeVPnSxdxiblyCHzgSZOxxMvU=;
        b=tI71lGMgowI6Ath6GVIdpTempUaVft2D7EtV5w4L6yFmYrGwNRbduKlWKsd5DJvv2MCtUJ
        jfQdfKQSfc1LLViQEJAdlK8NGwUhJmwAkr40squz9a4Zta6KdeXqXL6unMdVHW3+QxtJke
        6/eQRsPZdiZSaSKiotq5Dhz3DExr52k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651683610;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxY2OgL3XAPCmsFPupJeVPnSxdxiblyCHzgSZOxxMvU=;
        b=1HS44wgzPpsl0FKKafmfbdrprPLyDpTQch6FPWLyphcp+kfEvf63DnHKR2fL4fdT2almcB
        /LvSXN1XpnLmWIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B579F131BD;
        Wed,  4 May 2022 17:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GtpzKxqxcmLoVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 17:00:10 +0000
Date:   Wed, 4 May 2022 18:55:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: zoned: fix zone activation logic
Message-ID: <20220504165559.GT18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651611385.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651611385.git.naohiro.aota@wdc.com>
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

On Tue, May 03, 2022 at 02:10:03PM -0700, Naohiro Aota wrote:
> btrfs_zone_activate() "continue"s on seeing a devie without max_active_zone
> restriction, and it never set the block group as active if the block group
> does not contain a device with the restriction.
> 
> While it still return true and make the allocation works, it is confusing
> for other code and it is waste of time to iterate the loop every time
> btrfs_zone_activate() is called.
> 
> Also, there is a non-changing condition check in the loop.
> 
> Fix them with this series.
> 
> Naohiro Aota (2):
>   btrfs: zoned: move non-changing condition check out of the loop
>   btrfs: zoned: activate block group properly on unlimited active zone
>     device

There's a minor conflict with the other series fixing the zone finish
but this 2 patch series is a clear regression so I'll take it first for
rc, not sure about the other yet.

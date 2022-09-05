Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCB5AD41D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiIENf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 09:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiIENfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 09:35:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2474BA4C
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 06:35:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BBD1339E2;
        Mon,  5 Sep 2022 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662384918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyrXYG62GJ5cqXncB+6pDQtMQ11UjzeLI8rDD4J//Iw=;
        b=Kl1UguaFutzcpIhrDym/UOcRsgT99w1ryCCPeioEMMlBh24R455/0/e1CNySOoAryUuMxu
        tpi3qXPjephYuaJfELgmiYSg9QR1PBwnHXuiNIJnCk8EcpCyENkCXPlMKnfSozlqzfbd8C
        RLcyB3gRKTk6Xc4ozYSTjgyen2abYRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662384918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyrXYG62GJ5cqXncB+6pDQtMQ11UjzeLI8rDD4J//Iw=;
        b=UOK92OtVrZtCPGb0ukHJmz51w1bisn6GtZcl5EIwYojrgLuJMWT+u2hANSvc2QuiSu4Lio
        vcNL/FErn/ZwXJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24BA2139C7;
        Mon,  5 Sep 2022 13:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id opYPCBb7FWObIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 13:35:18 +0000
Date:   Mon, 5 Sep 2022 15:29:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: fix mounting with conventional zones
Message-ID: <20220905132956.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4c82ad00b9241a4c31ac153a3ca9c2c78fbcd551.1662381459.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c82ad00b9241a4c31ac153a3ca9c2c78fbcd551.1662381459.git.johannes.thumshirn@wdc.com>
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

On Mon, Sep 05, 2022 at 05:38:24AM -0700, Johannes Thumshirn wrote:
> Since commit 6a921de58992 ("btrfs: zoned: introduce
> space_info->active_total_bytes"), we're only counting the bytes of a
> block-group on an active zone as usable for metadata writes. But on a SMR
> drive, we don't have active zones and short circuit some of the logic.
> 
> This leads to an error on mount, because we cannot reserve space for
> metadata writes.
> 
> Fix this by also setting the BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE bit in the
> block-group's runtime flag if the zone is a conventional zone.
> 
> Fixes: 6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> * de-duplicate list handling code (Naohiro)

Replaced in misc-next, thanks.

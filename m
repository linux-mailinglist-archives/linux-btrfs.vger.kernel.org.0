Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265E5F7A35
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJGPD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJGPDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 11:03:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B117CDD8B1
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 08:03:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7AD471F8B8;
        Fri,  7 Oct 2022 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665155031;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6iNlbAEwVxeK4g/XabYg6LjCMcdJeLTSAc2HEKuXKo=;
        b=jcR+O7h+7NLCWFtIKsukk3skrQr374RuoDRkkm/kQlOWCTZhcArM0MfBd7QD2XGXUvBy7z
        biKwbiZB2tp2Da/gFNPHZz/nAR/S/bkmpPi3Z4MaflEKzmVSvCa6vWgPQj1SuRZE87BN6h
        xyIupVBqCEPmQtJghqxOvBfJprrnh3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665155031;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6iNlbAEwVxeK4g/XabYg6LjCMcdJeLTSAc2HEKuXKo=;
        b=U2jeFWGnE01HYasJcMggoWsJR9warjgr6GzJ5W/mTd4qeN50WFBqmGRfy3TDx2B8tZdpc8
        rHaUFaJBgis5KWDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 543C313A9A;
        Fri,  7 Oct 2022 15:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0++HE9c/QGP5IwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 15:03:51 +0000
Date:   Fri, 7 Oct 2022 17:03:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add missing path cache update during fiemap
Message-ID: <20221007150347.GQ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa8da9743ec75d4438f5de49051834337133da10.1664808830.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8da9743ec75d4438f5de49051834337133da10.1664808830.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 03, 2022 at 03:57:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When looking the stored result for a cached path node, if the stored
> result is valid and has a value of true, we must update all the nodes for
> all levels below it with a result of true as well. This is necessary when
> moving from one leaf in the fs tree to the next one, as well as when
> moving from a node at any level to the next node at the same level.
> 
> Currently this logic is missing as it was somehow forgotten by a recent
> patch with the subject: "btrfs: speedup checking for extent sharedness
> during fiemap".
> 
> This adds the missing logic, which is the counter part to what we do
> when adding a shared node to the cache at store_backref_shared_cache().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

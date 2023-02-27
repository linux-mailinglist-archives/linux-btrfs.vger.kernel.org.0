Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B316A4A6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjB0S70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 13:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjB0S7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 13:59:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844BD33B
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 10:59:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC3E1FD7A;
        Mon, 27 Feb 2023 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677524362;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBGVXnyFeKJ6kj42/FsvFVvFwJ+rruvGhJ1hxLPrQKc=;
        b=sMJxGCnYG0xw0V+30AX7+xhtNpPhZsTvXIoPila93YWJKdlNqAaqKa/5ecIsgFlsjtwdLE
        UtM0/bdbToLfuPZBp7XfADwFyV15v5v9XqsGVetQRGhJK2bXKrhlLmyb3u3bZcOSgZV2zG
        2sWwGSO7TxSDKYMpuwf7OsuFXbUS5us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677524362;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBGVXnyFeKJ6kj42/FsvFVvFwJ+rruvGhJ1hxLPrQKc=;
        b=cBcUgJhEC7PYdPc826BosQWqBpH28hM+OWhhPOdIk2Kz6/8etdLR+w7DAyzYXlE9fsqui0
        mFh427CHHOLxaECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A45113A43;
        Mon, 27 Feb 2023 18:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sSrPHIr9/GO2BwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 18:59:22 +0000
Date:   Mon, 27 Feb 2023 19:53:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: opencode btrfs_bin_search()
Message-ID: <20230227185323.GH10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230223201918.GZ10580@twin.jikos.cz>
 <10cb860e9a12aba47b67457f3a13a8a3166cb60e.1677207967.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10cb860e9a12aba47b67457f3a13a8a3166cb60e.1677207967.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 24, 2023 at 11:31:26AM +0800, Anand Jain wrote:
> btrfs_bin_search() is a simple wrapper that searches for the whole slots
> by calling btrfs_generic_bin_search() with the starting slot/first_slot
> preset to 0.
> 
> This simple wrapper can be opencoded.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: Title changed from (btrfs: make btrfs_bin_search a macro)
>     Opencode instead of macro-ing.
> 
>     Dave,
> 	I think opencode is what you meant in the review comments.
> 	If not, I didn't quite get what you implied.

Yes I meant open coding it as you did while keeping the btrfs_bin_search
name as it's shorter and 'generic' does not bring any value. Added to
misc-next, thansk.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525124D1DF1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 17:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbiCHQ4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 11:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348518AbiCHQ4V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 11:56:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A822517D3
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 08:55:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2447B1F37E;
        Tue,  8 Mar 2022 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646758522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tX1wYP7Ic/juhQyC2kE66pIIIz2hS7qwqTCTdSfQdbY=;
        b=ynUFZNBeofdxYVZt1pdpVLyhAMQBatzoFSV4UopQsJFmYiBUKSTjZ1f8eg4KtAg5Ot914Q
        vMGZnCejBQBZTHBrCcVluaEuj8bptiFtc2ZBG58DkU55in80E9xC6kNYawX7KTPc0QQmbs
        EOLXuLbfeP00KG7JfRMURRqCy/prRak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646758522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tX1wYP7Ic/juhQyC2kE66pIIIz2hS7qwqTCTdSfQdbY=;
        b=ADBsmzuh34uljejFxmcWeRAJQlWbHC3tOpYKlcmpBd/hh4VdKS3gyIZjV22BLlrnBYg5u6
        qM+vmajcHp/BX+Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1D5C0A3B8C;
        Tue,  8 Mar 2022 16:55:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1371DA823; Tue,  8 Mar 2022 17:51:26 +0100 (CET)
Date:   Tue, 8 Mar 2022 17:51:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/13] btrfs-progs: turn on more compiler warnings and
 use -Wall
Message-ID: <20220308165126.GO12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645568701.git.josef@toxicpanda.com>
 <2e052f1f853c09952ff44d250e78f64a3ba1471c.1645568701.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e052f1f853c09952ff44d250e78f64a3ba1471c.1645568701.git.josef@toxicpanda.com>
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

On Tue, Feb 22, 2022 at 05:26:11PM -0500, Josef Bacik wrote:
> In converting some of our helpers to take new args I would miss some
> locations because we don't stop on any warning, and I would miss the
> warning in the scrollback.  Fix this by stopping compiling on any error
> and turn on the fancy compiler checks.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index af4908f9..e0921ca3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -93,6 +93,9 @@ CFLAGS = $(SUBST_CFLAGS) \
>  	 -D_XOPEN_SOURCE=700  \
>  	 -fno-strict-aliasing \
>  	 -fPIC \
> +	 -Wall \
> +	 -Wunused-but-set-parameter \
> +	 -Werror \

That's in the default flags and based on the recent experience in kernel
defaulting to Werror it creates more problems than not. The build is
clean enough that new warnings are quite obvious and get fixed right
away.

You can always use the EXTRA_CFLAG=-Werror when developing or you can
also set CFLAGS=-Werror at configure time, as they get stored in the
generated Makefile.inc into SUBST_CFLAGS.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809616FE255
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjEJQYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 12:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjEJQXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 12:23:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3337EE6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 09:23:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED9131F461;
        Wed, 10 May 2023 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683735778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8uhybpQImMtYeCCIMorSH/wJKX9SfISzxtqX+8MzB8=;
        b=g/8VMIqLHDwMO37i01AjcaawXzAOAfk40g+RfzNhdjxF0nSTRmTx0UJ3kIjHUJTgQACysf
        15Phyu/wtLHygJQPhM910AVWOFOmQVez+cbdYa6V1bnzFVnjWxpBDglfwa9wm+hGfD0N7c
        BYhVPUz9GS25C3eoM9ixMPJYi4ZAFLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683735778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8uhybpQImMtYeCCIMorSH/wJKX9SfISzxtqX+8MzB8=;
        b=Ut5s3guRrXbSIGLTSXA/tPOnf9VPDb5/RnLDsQQkjZEPJXNLykWo6a103usE78vBp2RyvL
        ad/E1ZMeW4eKU9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4A57138E5;
        Wed, 10 May 2023 16:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PFSNLuLEW2RfbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 16:22:58 +0000
Date:   Wed, 10 May 2023 18:16:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix warning no previous prototype
Message-ID: <20230510161659.GR32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2505bcd57b2138163bd7540e3534edd403554751.1683724114.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2505bcd57b2138163bd7540e3534edd403554751.1683724114.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 10, 2023 at 10:01:10PM +0800, Anand Jain wrote:
> When compiling on a system with gcc 12.2.1, the following warning is
> generated. It can be fixed by adding a static storage class specifier.
> 
> cmds/inspect.c:733:5: warning: no previous prototype for ‘cmp_cse_devid_start’ [-Wmissing-prototypes]
>   733 | int cmp_cse_devid_start(const void *va, const void *vb)
>       |     ^~~~~~~~~~~~~~~~~~~
> cmds/inspect.c:754:5: warning: no previous prototype for ‘cmp_cse_devid_lstart’ [-Wmissing-prototypes]
>   754 | int cmp_cse_devid_lstart(const void *va, const void *vb)
>       |     ^~~~~~~~~~~~~~~~~~~~
> cmds/inspect.c:775:5: warning: no previous prototype for ‘print_list_chunks’ [-Wmissing-prototypes]
>   775 | int print_list_chunks(struct list_chunks_ctx *ctx, unsigned sort_mode,
>       |     ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43D27BE5CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377089AbjJIQCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377104AbjJIQCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 12:02:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA943CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 09:02:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9ECE421889;
        Mon,  9 Oct 2023 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696867369;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iorFMkpBW0jncF02vkhFuEmTESV7WW4kim8jJq4c1vQ=;
        b=d6vvHBWQQRc2BDOiRkztiZ8lVmjtfBRJn59xCUmzb7BuyigYjxS6XgxA7NPBNxFoBC/w65
        EVXPj2hWG0tpPIzK6s6TCQjuh7rGD6fU1nfAyQEpcf47kLIjlIBp1eiCLMYJytweS3n6QE
        kbqb3EkyfEOVOfuP4NTYRTmv4tHMr1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696867369;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iorFMkpBW0jncF02vkhFuEmTESV7WW4kim8jJq4c1vQ=;
        b=J4mM+spQEzJ/ThYAzXj/l5OuoD33Qun39rEZhtalE9ZFCkD9BhkFNhU3Aa8DS9GT/p03Vr
        oMCl4nDo674osiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8796913586;
        Mon,  9 Oct 2023 16:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9bVUICkkJGX+QwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 16:02:49 +0000
Date:   Mon, 9 Oct 2023 17:56:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: qgroup: check null in comparing paths
Message-ID: <20231009155604.GT28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231008091717.27049-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008091717.27049-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 08, 2023 at 09:17:17AM +0000, Sidong Yang wrote:
> This patch fixes a bug that could occur when comparing paths in showing
> qgroups list. Old code doesn't check it and the bug occur when there is
> stale qgroup its path is null. This patch checkes whether it is null and
> return without comparing paths.
> 
> Issue: #687
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to devel, thanks. I've also added the test case.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C755B0CC1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 20:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIGS5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIGS5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 14:57:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F78981E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 11:57:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F39F520705;
        Wed,  7 Sep 2022 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662577025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anTN96MZgDI8G2xmifl9xyX2278is9kEbklByftrzAI=;
        b=ZXEoM3u0BCd5yNlKT0WEMpuiAAfiSI0PYhFVSwF+rjYXDH9D+V2Yo7a07sCwFjLBKwPycL
        KMJ0c12oxi3xtFqgD1JJvZ881RfhIm+U/WCUQOkPl5+dHxJ4nyA8zdAbmeHKMnBJLOBB92
        xkmvuKx9P9qU1bWEP6u+cjKR2iiwEh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662577025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anTN96MZgDI8G2xmifl9xyX2278is9kEbklByftrzAI=;
        b=8Jp44RV5UpyWxXLg04gz7IXIDbJhOVqVKs/JesnlOnOE1RDEErfaUuGK6gMHApJu6fS2NR
        xTpSknwkMBza82Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F7A13486;
        Wed,  7 Sep 2022 18:57:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7fXMMoDpGGN1JgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 18:57:04 +0000
Date:   Wed, 7 Sep 2022 20:51:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/31] btrfs: cleanup clean_io_failure
Message-ID: <20220907185141.GD32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
 <7d5c4a3ca2ceb19fb3c84d5f3e716828cae0fb86.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5c4a3ca2ceb19fb3c84d5f3e716828cae0fb86.1662149276.git.josef@toxicpanda.com>
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

On Fri, Sep 02, 2022 at 04:16:06PM -0400, Josef Bacik wrote:
> This is exported, so rename it to btrfs_clean_io_failure.  Additionally
> we are passing in the io tree's and such from the inode, so instead of
> doing all that simply pass in the inode itself and get all the
> components we need directly inside of btrfs_clean_io_failure.

The 'cleanup function' is usually very unspecific as subject, but we
have patches like that that do several cleanups inside the function.
Something like "export and rename ...", or "simplify parameters of ..."
when it's not purely exporting.

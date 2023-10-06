Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C227BBCE8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjJFQkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjJFQkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 12:40:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265AAD
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 09:40:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 387181F896;
        Fri,  6 Oct 2023 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696610415;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07ys8pFhqcIiqJPRuzopwJxTASGZ6DVDCC9HxutmsYk=;
        b=AF67h+HMO4WxjvmMu/1iYKgnPGv1loo0dTQm6xbM51rhr0xQPmUF9UtZN85s/xN5Ya2ryr
        +51TdIqS5LI7jiATAxqcGu0sFadszoowpfVfOuLho6lvO+lcfpeLAN0hEiAvhFBb96LRf/
        qmK060/mRbUAQfuaw2tGa7leL2JqoM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696610415;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07ys8pFhqcIiqJPRuzopwJxTASGZ6DVDCC9HxutmsYk=;
        b=QL/s3DO4sD77Kn1XqUCqrOREVoaPDGqn292UHlwVvLHkR88Ms3nIqlu9/GdLUHCmlKOLzR
        1U3c6Pdjc6nPaYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22CF413586;
        Fri,  6 Oct 2023 16:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id duvTB284IGUPIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 16:40:15 +0000
Date:   Fri, 6 Oct 2023 18:33:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: fix all -Wshadow warnings and enable
 -Wshadow for default builds
Message-ID: <20231006163331.GM28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694428549.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694428549.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 08:10:31PM +0930, Qu Wenruo wrote:
> Recently David fixes quite some errno usage in kernel code, to avoid
> overwriting user space @errno variable.
> 
> This inspired me that, those problems can be detected by -Wshadow, thus
> let's enable -Wshadow for default builds.
> 
> The biggest cause of -Wshadow warnings is min()/max() which all uses the
> same __x and __y.
> To fix that, pull the kernel version with the usage of __UNIQUE_ID() to
> address the problem.
> 
> The remaining ones are mostly bad namings and harmless, but there is
> still some bad ones, detailed in the 2nd patch.
> 
> Tested with both GCC 13.2.1 and Clang 16.0.6, the first one is fully
> clean, the latter one has some unrelated warnings, but no -Wshadow
> warnings.
> 
> Qu Wenruo (3):
>   btrfs-progs: pull in the full max/min/clamp implementation from kernel
>   btrfs-progs: fix all variable shadowing
>   btrfs-progs: enable -Wshadow for default build

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D296F1CD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjD1Qsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjD1Qsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 12:48:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A661BE1;
        Fri, 28 Apr 2023 09:48:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03EF121FB4;
        Fri, 28 Apr 2023 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682700517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tngpUDPMQfGCjxTKv0sEq0MFmNbqAJhRrLS5s+lT6O4=;
        b=Tw4UHBbQZ2zMcSOg+v8srXKPQEwdyW2MlWpeM3FcV0IPvIhWmkbQz98A9JMapoGypmLm5M
        OV0R/85M3JAdBS8BTCw/FKZ+Gs3zs3wTS+MmTQxBYf/CyUq/KVzt+tbVz/U5o4JdagEfkO
        XUwtrXG+wOjnbOmkOtx8h/nDFiL4EUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682700517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tngpUDPMQfGCjxTKv0sEq0MFmNbqAJhRrLS5s+lT6O4=;
        b=oopQ+DcgY/wscz4Tsx8z9PTKSxKihdm0yQwR3Dyi8KEVtGLgJc7H2DvZTJCNSxYEI6qkk0
        ZH8ffFY8aoqLVABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFA861390E;
        Fri, 28 Apr 2023 16:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mAnIMeT4S2SUBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 16:48:36 +0000
Date:   Fri, 28 Apr 2023 18:42:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCR0LXQu9C+0LLQsA==?= 
        <abelova@astralinux.ru>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] btrfs: parent bytenr must be aligned to sector size
Message-ID: <20230428164243.GC2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230426115323.9455-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426115323.9455-1-abelova@astralinux.ru>
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

On Wed, Apr 26, 2023 at 02:53:23PM +0300, Анастасия Белова wrote:
> From: Anastasia Belova <abelova@astralinux.ru>
> 
> Change nodesize to sectorsize in alignment check
> in print_extent_item. Change requirement in comment.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: ea57788eb76d ("btrfs: require only sector size alignment for parent eb bytenr")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571814E9F39
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiC1S5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiC1S5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 14:57:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85749E0BD
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 11:55:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17F2E21116;
        Mon, 28 Mar 2022 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648493719;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+RxtHzRovuriRYl1TI4n2fuoT0vY2MkJS+lVjzir2YY=;
        b=gYG/hnJzLLoFuRdwuDY4qpiAEvWksuOVA2bKMka04wFHbykdVZx2gn3XzK8et4yxDpj5sm
        cUFU+O0SD6Oa3YJ9NUKKxKbM5GM394wU+cVKI2aWqj6k8ARQ/dZlrbBtHfRICB/drFzJxs
        uwkd1iQbZeqjKKRfYw4ecD5fqQYFQpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648493719;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+RxtHzRovuriRYl1TI4n2fuoT0vY2MkJS+lVjzir2YY=;
        b=Nef4O3KgesUTRQvkhOGiw99hYUdZntYubiM/DOgsv2BmjY2LDKd5jQkKlyiTg2vhIUt4y4
        ed5RZm2hAb2yryCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0E200A3B83;
        Mon, 28 Mar 2022 18:55:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0EC53DA7F3; Mon, 28 Mar 2022 20:51:21 +0200 (CEST)
Date:   Mon, 28 Mar 2022 20:51:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Message-ID: <20220328185121.GQ2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
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

On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
> The original code is not really setting the memory to 0x00 but 0x01.
> 
> To prevent such problem from happening, use memzero_page() instead.

This should at least mention we think that setting it to 0 is right, as
you call it wrong but give no hint why it's thought to be wrong.

> Since we're here, also make @len const since it's just sectorsize.

Please don't do that, adding const is fine when the line gets touched
but otherwise adding it to an unrelated fix is not what I want to
encourage.

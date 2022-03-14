Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF34D861C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 14:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbiCNNlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiCNNlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 09:41:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBC344F2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 06:40:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2A9C41F383;
        Mon, 14 Mar 2022 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647265201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYzGsFJC0enUxSlv9uqjYQgRbc88FThdDSM54ud5nIk=;
        b=HklvAJQBYsMiN5/c3ABTkMHSGIBQSDkYD3Y2Dm+qvK0CSwX3AdyMFJf1wOsssX8AmxDsZX
        MMOZZf1H5tyJ80he4yds0GObjWrizwGNpZpvQ+JSP+20vAUw77hzvcf/QG7G+KghwSHF7o
        t04AbKsSrj75J6EbqFwuUtsTDyqHjTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647265201;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYzGsFJC0enUxSlv9uqjYQgRbc88FThdDSM54ud5nIk=;
        b=Sz2bTxPklVWoudbT1CVq+Nlkji62N9t/dpWGCahSaPTmzi9om0x4u/m3g8ki2OcnH6hy3n
        +JMxyMPWUQlS98BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1FB94A3B81;
        Mon, 14 Mar 2022 13:40:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E958CDA7E1; Mon, 14 Mar 2022 14:36:02 +0100 (CET)
Date:   Mon, 14 Mar 2022 14:36:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: scrub: big renaming to address the page
 and sector difference
Message-ID: <20220314133602.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1647161284.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647161284.git.wqu@suse.com>
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

On Sun, Mar 13, 2022 at 06:39:59PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rebased to misc-next directly, before scrub entrance refactor
>   As this patchset is safer than entrance refactor.
> 
>   Minor conflicts due to scrub_remap() renaming.
> 
> v3:
> - Get rid of the name "ssector", using "sector" directly.
>   Previously we use names like "spage" to avoid confusion between MM
>   layer page, and scrub page.
>   But now since we rename it to scrub sector, and there is no naming
>   conflicts, we are safe to use "sector" directly, without the eye
>   hurting "ss".
> 
> - Use names like "sectors" to replace "pagev"
>   Which is more close to our latest naming schema.
> 
> - Update involved comments to use latest style
> 
> - Use bitshift to convert from sectors to bytes

With minor fixups added to misc-next, thanks.

I've seen some multiplications by sectorsize that's a local variable,
this could be also switched to use the bitshift.

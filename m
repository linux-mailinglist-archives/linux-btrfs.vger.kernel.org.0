Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358776F0D21
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 22:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjD0U3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjD0U3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 16:29:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1F2120
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 13:29:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A1841FEA9;
        Thu, 27 Apr 2023 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682627371;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGKfqTEZR9EFTXkuXlYoKZO1ZehrVZ/zdMyETI2ckAM=;
        b=H/HQBEUNDQEI7Otmh1OLTKC3/9vC+M4oZm3wlQtORP94Ww5zIFk0H5sG7dCgoFLRwtRbaR
        eAlZLA3sxiY6lTHEh9aaiP4U46TVupg8CbFxOSldl+53EAMTOw+OtTrokwMZH5uJ4krx/t
        G8z9APp7W9dPRS4feSGy1GIR9rXDHDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682627371;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGKfqTEZR9EFTXkuXlYoKZO1ZehrVZ/zdMyETI2ckAM=;
        b=VKACgCykH/CCgwEOWB8NuvmYsUsNXd2vrKlrbtcxloBfSD0gUnRBXjHvdg6QRuHRT35LhT
        UvFT2p5XspX2BhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B6AD138F9;
        Thu, 27 Apr 2023 20:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ux1RGSvbSmRZRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Apr 2023 20:29:31 +0000
Date:   Thu, 27 Apr 2023 22:29:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.3
Message-ID: <20230427202917.GE19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230427131044.6804-1-dsterba@suse.com>
 <CAEg-Je_KLtoX3HdfOtUdd3aHqSPYL+T5MFsjPAiqotcoVpUKXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_KLtoX3HdfOtUdd3aHqSPYL+T5MFsjPAiqotcoVpUKXA@mail.gmail.com>
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

On Thu, Apr 27, 2023 at 03:44:10PM -0400, Neal Gompa wrote:
> On Thu, Apr 27, 2023 at 9:26 AM David Sterba <dsterba@suse.com> wrote:
> > Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> > Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> 
> It seems like my patch to default to 4k pages[1] was missed for this
> release, despite having three reviewed-by tags.

I'm aware of the patch, changes like that need more than just three
reviews. Switching to sectorsize different than page size affects
kernels/arches that are configured like that, which is now namely arm64
but power8/9 is still around and I've checked only a few main distros.

The testing coverage of the subpage code is very low on arm64 due to
slow hardware some of us have and upstream support of the boards is
lagging behind. First we need enough testing coverage for functionality
and then at least some basic performance results. Anand sent some
benchmarks which is good, but still not sufficient.

The situation with hardware may change soon so this is a start of the
evaluation.

> Can we get this pulled in for the next release then? And I guess the
> patch will need to be updated to say 6.4 instead of 6.3...

Changing defaults can take time and I can't promise any specific version
for that. We had a change in 5.15, it's better to pack more changes in
defaults to limit number of configuration so if there's next round the
4K will be among considered options. Until then we need to raise the
confidence that this will not cause problems.

There's a tracking issue for that with the points above
https://github.com/kdave/btrfs-progs/issues/604 .

What we can do now is to add a warning or reminder that on a host with
64K pages the portability may be limited and that this should be
reconsidered, with examples where this applies etc.

And once the change to 4k is done, backward compatibility would be
possibly kept by adding 'page' as a special keyword for sectorsize.

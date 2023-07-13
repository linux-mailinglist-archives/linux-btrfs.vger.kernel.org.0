Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA2752A49
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGMS0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMS0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 14:26:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A12D46
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 11:26:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1FE12215A;
        Thu, 13 Jul 2023 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689272758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuOW23/MXlwb6S+xlq0XFLamlIBdIP+YAWSHgcwJpfA=;
        b=fZ4TglQxQ281kI90mLu4viejSABDp3Sbt4vQjVmgFhUyJ3+TU9C6unez1hIY00PYosfG+5
        wBOh0HNFOqtVVy/aFE8zYzSp3IQCboVR5dG6a/zLcEJ25toaJK09I+Gyslj9zthwyo6OMS
        ZogooiqkEnPWHKFakOXyANgdSFv+cRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689272758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuOW23/MXlwb6S+xlq0XFLamlIBdIP+YAWSHgcwJpfA=;
        b=UH8GhGUoWBymSydGQaRGTeEz9AvDDvhQd3PaGy/2PWIsJkqaAOFqaK9ymyE4dhIBBz6lhR
        7ojL+mbxQYrDYiBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B525A13489;
        Thu, 13 Jul 2023 18:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jit1K7ZBsGSfeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 18:25:58 +0000
Date:   Thu, 13 Jul 2023 20:19:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Message-ID: <20230713181922.GY30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688658745.git.josef@toxicpanda.com>
 <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
 <ZKf5IjoGAAdkrz1I@infradead.org>
 <wbsmajimcou2ow6s4rtzeopwvd5dhku7hcdvm2u3doy6lagvev@3kga7xlvxn5t>
 <ZKuW7IkT9wtgJXQw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKuW7IkT9wtgJXQw@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 09, 2023 at 10:28:12PM -0700, hch@infradead.org wrote:
> On Mon, Jul 10, 2023 at 12:57:52AM +0000, Naohiro Aota wrote:
> > It depends on what we consider the "minimal" is.
> 
> I think minimal means a file system that can actually be be continuously
> used.
> 
> > Even with the 5 zones (2
> > SBs + 1 per BG type), we can start writing to the file-system.
> > 
> > If you need to run a relocation, one more block group for it is needed.
> > 
> > The fsync block group might be optional because if the fsync node
> > allocation failed, it should fall back to the full sync. It will kill the
> > performance but still works...
> > 
> > If we say it is the "minimal" that we can infinitely write and delete a
> > file without ENOSPC, we need one (or two, depending on the metadata
> > profile) more BGs per META/SYSTEM.
> 
> Based on my above sentence we then need:
> 
>  2 zones for the primary superblock
> 
> metadata replication factor * (
>   2 zones for the system block group
>   2 zone for a metadata block group
>   2 zone for the tree log)
> 
> 
> data replication factor * (
>  1 zone for a data block group
>  1 zone for a relocation block group
> )

I think the relocation should be taken separately, there can be only one
relocation process running per block group type, ie. data/metadata and
the replication depends on the respective factor. Otherwise yeah the
formula for minimal number of zones needs to take into account the
replication and all the normal usage case. In total this is still a low
number, say always below 20 with currently supported profiles. Devices
typically have more and for emulated ones we should scale the size or
zone size properly.

Setting up devices with small number of spare zones is also interesting,
or with small zones that will trigger the reclaim more often.

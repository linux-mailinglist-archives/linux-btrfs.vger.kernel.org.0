Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6850B4BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Apr 2022 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446238AbiDVKOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 06:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbiDVKOU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 06:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB96362
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 03:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE9CBB82BB6
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 10:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21802C385A0;
        Fri, 22 Apr 2022 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650622285;
        bh=kRxAWbARN7CAhGXFEExgW2m2+FmfUAuaWy089TtR0vc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=n6PZnE9r5+Lg5cQncrxIvXVrGadqRFBx4X/6LTjZCs6biRYont++RwOzYbUh+oohM
         JQO+FrkxawTgrMVTkAkrb03CdOMhVgol5EamNxKHZQzDC9x1+vyR5ahtFAmSx2F1MV
         c8pvPP/JJ5QiBesxwCY4HJDgJa6rfvslOnBILdkS2/c3xSGUP+doHghusp/gXvvOPQ
         5TxyY1ZrqLcWJyaDYXo05U4XP5G68psAWAsrN/KhRSXi+vPliD44Ufa8lYt290aCi0
         fAyhUfPfIXs3i1nM7ZDNHVemRc1+FQkdcOS4B4UQog3Znkptp70IljLbn/kzEWQ61p
         DZjgJT29HqDQQ==
Date:   Fri, 22 Apr 2022 11:11:22 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Improve error reporting in
 lookup_inline_extent_backref
Message-ID: <YmJ/SlbQJJrS1ars@debian9.Home>
References: <20220420115401.186147-1-nborisov@suse.com>
 <20220420145203.GE1513@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420145203.GE1513@twin.jikos.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 04:52:04PM +0200, David Sterba wrote:
> On Wed, Apr 20, 2022 at 02:54:00PM +0300, Nikolay Borisov wrote:
> > When iterating the backrefs in an extent item if the ptr to the
> > 'current' backref record goes beyond the extent item a warning is
> > generated and -ENOENT is returned. However what's more appropriate to
> > debug such cases would be to return EUCLEAN and also print the in-memory
> > state of the offending leaf.

How does printing only the leaf helps debugging anything?

You get the leaf dumped, but how do you know what you should be looking for?
Which key in the leaf, and for which inline backref are we searching for?

Dumping the leaf alone is not really useful, unless we also mention what we
are searching for...

So this should print as well:

1) The key, which tells us which key to look at, the extent's bytenr, type
   and size or owner;

2) The type of reference we are looking for, stored in the variable 'want';

3) The values of the variables 'root_objectid', 'parent' and 'offset'.
   These are used to search for the backreference we want, once we find
   one with the type we want.

Thanks.

> 
> Agreed, EUCLEAN makese sense. Added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB154A7760
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 18:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiBBR6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 12:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiBBR6h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 12:58:37 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B61C061714
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Feb 2022 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20220106; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KEWbvRJTLlbCES7ebuAhKIVtrA9iVQLi88Ds/7au4qA=; b=hnkPOMQSNH/x1pN36+U44HVtnU
        EI0JWg3LmEZedk9Z3J/WW8TY9ltZJNFDTU5hCYsMD9cgXA5m32Rt3K1b1dfpqxuZxcVjbRUjH1Sg4
        adYfssh/yjb3BwyV6OI8eImuc+ZoLT+0IwvYUI72NAtp8UWut6y0bOerY2HNjGlKVz2UOSjdSfqiy
        P1mG4I87HdN1IR9u4xq/W8t3ocvQ0UmU4hQWdcb+WByizjKgRNp1Bm0Ysspddmv46CHOZfNKPw48A
        X28u2jgT9OXOogI3nL4F4yOaNtKjpjqvMGtpOOfc2/F/uKBcBtcHcsPQe+cYit0xRT9nuZCH7NhKR
        xyrz0awQ==;
Received: from [50.46.16.53] (helo=vanvanmojo.kallisti.us)
        by ravenhurst.kallisti.us with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ross@kallisti.us>)
        id 1nFJtq-00DJIH-TN; Wed, 02 Feb 2022 12:58:35 -0500
Date:   Wed, 2 Feb 2022 09:58:30 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: unable to remove device due to enospc
Message-ID: <20220202175830.gk2pxilyjkzduami@vanvanmojo.kallisti.us>
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
 <Yfq917NcKDq+yiKW@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfq917NcKDq+yiKW@hungrycats.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 12:22:31PM -0500, Zygo Blaxell wrote:
> > [200706.753360] BTRFS error (device dm-16): allocation failed flags 17, wanted 1769996288
> 
> That allocation size is larger than a raid1 or single block group, so I
> wouldn't expect it to ever succeed.  The question now is where did that
> allocation request come from?  Do you have files with huge prealloc
> extents in them?  Is the filesystem more than about 6 years old, when
> kernels would allow extents to be excessively large?

Yes that's it - this filesystem is old, at least six years.

> Grab the python-btrfs package and run
> 'show_block_group_data_extent_filenames.py' on the failing block group to
> see what files are there.  Look for files with extents longer than the
> maximum size of 128MB.  You should be able to copy the offending files
> and delete the originals (make sure to get all the snapshots if any),
> then relocation can proceed normally since newly created extents will
> respect modern extent length limits.

I gave that a quick run, and almost immediately found some:
  extent vaddr 408978194432 length 150994944 refs 2 gen 0 flags DATA
  extent vaddr 407552131072 length 469762048 refs 2 gen 0 flags DATA
  extent vaddr 403861143552 length 622972928 refs 2 gen 0 flags DATA
  extent vaddr 408156110848 length 818302976 refs 2 gen 0 flags DATA
  extent vaddr 406126067712 length 1283457024 refs 2 gen 0 flags DATA
  extent vaddr 404490289152 length 1350565888 refs 2 gen 0 flags DATA

Based on your explanation, it looks like I should be able to clean this
up.  Thanks very much!

> I don't know if btrfs check will notice this, but it shouldn't.

Yep, you're right.


Thanks again,
Ross

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348066E57B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDRDIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 23:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDRDIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 23:08:17 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF3558D
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 20:08:15 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 248D6C01E; Tue, 18 Apr 2023 05:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681787294; bh=1jnmkmiPRvuI137ZzGmRuKEQ+tmvNbffiBIgaQh7fqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i15bFGS6uEWWgjdHESHUnuNX5eNv2TB0tALVyb4qAeZSA7AMZeeyZTNmfAZ0i6i61
         HqIL23iPd804R9vJwKVH3xvdGp86jKjiQXyT03AYyjJ35g5ICct6EjS3IguqNOBP2a
         CNhvwAWlrFMW2HA2bed2Bfto6qBN4nNb9fmEe01Yvm238W/YJUfMVc7TT6bWfCW50g
         aD6imGJVSC1RQm3L1wg/U5DxnxlzOQFvnnZjkHBiAC7VeWWsE4FBd6NTK8z2Ji7RRr
         AD71zfN+JIKmQr0wI4lyrKsoIp0F/9P0bdvroc3dKBjNUdkPHM8tvC4qWklOVfCD26
         qRZNqdQQyM04g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 730B1C009;
        Tue, 18 Apr 2023 05:08:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681787293; bh=1jnmkmiPRvuI137ZzGmRuKEQ+tmvNbffiBIgaQh7fqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plZ2rjKkLTQwbv4eSfVuFATqT+6H5cl9qlPSKMZdlxA2zE+9FigyCj0TGcK/Nyn6X
         UyCeGXHGcV2be6u14iIpBGrd4lUl4zVUGkek+OuuR2qla9Op+Ay3zJ4bTFf7boJCt4
         0PGZim3iLDSv7ThuLHursyjky2QSd0QgXnaT43LDq20L8VuKwXNvLAicogVA8JVU0r
         YCfUPgxU+FHDEvCyK7vZnLhK8pEWwHusdhqr+MGvdW6L+kg6SCMW1XRoZ15aFwc5xW
         oyo4cZxNILiHRx/A3Mlb1+TONEGAzPzIGhjyU/ZiRHYilbjbcyRJ2nldmBLVoZBl/R
         gt8elshG0dPyw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b35e6c5a;
        Tue, 18 Apr 2023 03:08:08 +0000 (UTC)
Date:   Tue, 18 Apr 2023 12:07:53 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
Message-ID: <ZD4Jiagu0sWIPZDa@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
 <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
 <ZD4DV49fqKmPjMjU@codewreck.org>
 <fca50995-0745-4374-a64a-40378ea95262@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fca50995-0745-4374-a64a-40378ea95262@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote on Tue, Apr 18, 2023 at 10:53:41AM +0800:
> > I have a feeling the loop could just be updated to go to the end
> > `while (cur < end)` as it doesn't seem to care about the end
> > alignment... Should I update v2 to do that instead?
> 
> Yeah, it would be very awesome if you can remove the tailing part
> completely.

Ok, will give it a try.
I'll want to test this a bit so might take a day or two as I have other
work to finish first.

> > This made me look at the "Read out the leading unaligned part" initial
> > part, and its check only looks at the sector size but it probably has
> > the same problem -- we want to make sure we read any leftover from a
> > previous extent e.g. this file:
> 
> If you're talking about the same problem mentioned in patch 1, then yes, any
> read in the middle of an extent would cause problems.

No, was just thinking the leading part being a separate loop doesn't
seem to make sense either as the code shouldn't care about sector size
alignemnt but about full extents.
If the main loop handles everything correctly then the leading if can
also be removed along with "read_and_truncate_page" that would no longer
be used.

I'll give this a try as well and report back.

> No matter if it's aligned or not, as btrfs would convert any unaligned part
> into aligned read.

Yes I don't see where it would fail (except that my board does crash),
I guess that at this point I should spend some time building a qemu
u-boot and hooking up gdb will be faster..

> My initial plan is to merge the tailing part into the aligned loop, but
> since you're already working in this part, feel free to do it.

Yes, sure -- removing the if is easy, I'd just rather not make it fail
for someone else :)

-- 
Dominique Martinet | Asmadeus

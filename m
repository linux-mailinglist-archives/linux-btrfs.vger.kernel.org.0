Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D56E5873
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 07:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDRFRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 01:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDRFRv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 01:17:51 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6E35BE
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 22:17:49 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 08A58C01B; Tue, 18 Apr 2023 07:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681795068; bh=Ll7vrWHPGhV4iCKnaSu9wq9bgBBNAUSK7/7GVdVe4FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydmv8KMLuTPo48Tr5yg53+bUT2pGOW/4FOmjPZEiaZ9Dmw5vsOzF9CXp0tW+XC3M4
         OMbqNm/GFtMkVtwcnduIovwUv3n1PS1NAeN2jGHs1YoicofXsTCilJzq1JXuFNgrBr
         KZN4BmupJ5MNiQQQarVrfMnIby2u1MQer8O2kui0qWZxFT1NwRcDZ2eogyUZx59TVo
         18sKrr1Kw1+OaY6N6J9mA0jNog9Ietm+MCfJ1RI6QkZkLsYamRC0x0fuRVL/u8WEN8
         6J1Cp3XAyu0UyEcGZM3qH9pqcJxX5TPPIICtq+Yd1NPqsKQ9lfLl1x4Ql3KEL/B0jU
         CARw7Y9U573GQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 68338C009;
        Tue, 18 Apr 2023 07:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681795066; bh=Ll7vrWHPGhV4iCKnaSu9wq9bgBBNAUSK7/7GVdVe4FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrJHcHCMeE6bzGVpqaOyLcPboSpCZI+S9JOKMjhbvSkvUCENcVw9+c3WVOCgsXVUM
         mkv/5hw3Ay4Yq/u8u5dcN/EUzdeUNpT4S6geZdCqoARJvsbXwGBX6L5l07qihf5ds8
         5nO0UUGyRb7nNWzaVtgeshC74OJyAP2YqKvXZXP1m44/L5tvF37/Ih78hJDTN+GXzW
         FyZVWXNHvOW7+sllmKnJpEML/Uqr+C9Jo+qEz+1BkqSP1B8fPLihUXqdKgJztmAzVm
         MgY93Lbrz8S1k21mfu8N6Qq8Zc8Ok/ZMUzWkzAlczk3II6DHdA4wl3vfypdB5nZ+PD
         nL+H44gHweHsQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id bfb086f3;
        Tue, 18 Apr 2023 05:17:41 +0000 (UTC)
Date:   Tue, 18 Apr 2023 14:17:26 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
Message-ID: <ZD4n5piHQlPDod3D@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
 <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
 <ZD4DV49fqKmPjMjU@codewreck.org>
 <fca50995-0745-4374-a64a-40378ea95262@gmx.com>
 <ZD4Jiagu0sWIPZDa@codewreck.org>
 <58fdd612-d2ac-1a77-25e5-59e8f7b668a2@gmx.com>
 <ZD4UP8oqlU0sP6Tt@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZD4UP8oqlU0sP6Tt@codewreck.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dominique Martinet wrote on Tue, Apr 18, 2023 at 12:53:35PM +0900:
> Ok, there is one exception for inline extents apparently.. But I'm not
> still not convinced the `aligned_start != file_offset` check is enough
> for that either; I'd say it's unlikely but the inline part can be
> compressed, so we could have a file which has > 4k (sectorsize) of
> expanded data, so a read from the 4k offset would skip the special
> handling and fail (reading the whole extent in dest)

(Wasn't able to create such a file, I assume that means the uncompressed
data must fits in a page -- if we deal with arm machines with 16k or 64k
page size that'll probably change things again but I'll just pretend
sector size will magically match in this case..)

> Even if that's not possible, reading just the first 10 bytes of an
> inline extent will be aligned and go through the main loop which just
> reads the whole extent, so it'll need the same handling as the regular
> btrfs_read_extent_reg handling at which point it might just as well
> handle start offset too.

Question regarding inline extent: the main loop goes straight out after
reading an inline extent, assuming it is always alone (or last) -- is
that correct?
By playing with `filefrag -v` I could sometimes see files that
temporarily have inline + a delalloc extent, but wasn't able to make a
file that kept the inline extent after appending more data, so I guess
it is also sane enough... Just making it continue and letting the loop
end seems just as simple now there is no trailing if, but if inline
extents cannot be mixed I'll be happy to keep it going out.


back to btrfs_read_extent_reg:
merging the tail back into the main loop breaks the first assert
(IS_ALIGNED(len, fs_info->sectorsize) in particular).
The old loop invocation made sure it was aligned and
read_and_truncate_page used to take care of calling it with a bigger
buffer when it was not.

I was only looking at the compressed path and that does not care about
'len' alignment because it makes an intermediate copy for decompression,
but the BTRFS_COMPRESS_NONE's read_extent_data might care?
I didn't see anything that actually requires alignment there (len in
particular should be ok, but even offset->logical seems to properly be
used as "being part of a range" in lookups so alignment doesn't actually
matter), but if this isn't tested I can understand wanting to be more
careful there.

Ok so this is rightfully less obvious than I had first assumed -- sorry
for rushing in. Let's do baby steps:
- I'll resend just the first patch shortly, it's a real fix and I'll be
using it right away.
- I'll double check 'len' doesn't need to be aligned in
btrfs_read_extent_reg and just rework the main loop to allow removing
the tail exception, that'll avoid a double read in many cases and I
think it's worth doing.
Might take a bit more time as I want to finish some other work, let's
say a few days.
- That leaves the two issues I brought up with the main loop:
 * inline case ignoring end; this is minor enough but easy to fix
 * btrfs_read_extent_reg() assuming start of extent in its length
 agument; I believe it'll be easier to stop trying to set a upper limit
 in the main loop and just have btrfs_read_extent_reg() do it itself, we
 can use its return value to know how much was actually read.
 (Probably just substract offset - key.offset to extent_num_bytes to
 have a new cap, but I still don't understand btrfs_file_extent_offset()
 in all of this as it's always 0 when I looked)
Will try to do that over the next few weeks, but if you want to look at
it feel free to do this before me.
- At this point it might be worth considering removing the initial check
as that also makes an extra small read in the unaligned case, but it's
not a bug and can wait.


What do you think?
-- 
Dominique Martinet | Asmadeus

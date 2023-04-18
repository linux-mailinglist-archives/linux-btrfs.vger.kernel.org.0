Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99E6E57ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDRDyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 23:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDRDx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 23:53:58 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D423C24
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 20:53:57 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0F1F5C009; Tue, 18 Apr 2023 05:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681790036; bh=Db8qm9pRqZtyNTRYll629dy2U2gd2KOs98jRHg4BZxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0GOh8Qk9XYSxahmiTGG4mTwbb2LJF6DB7kaZmYzfyAiQA+uxF9gILItJ0nWVdDoK
         GMaOwKsnm27Ukf85L0/x5jwc2PpBZhXZ55LD91VstY6h1b7yql7UC9TUzsvMFEblYZ
         s8hWgeanWVfmclGXQvshzXP1CkSdQPKibsnebKjdCCIjnhYnqonKlRa1ic21NKie1j
         OGmzmkidwFbwG55NflZiPcEFikJlGjC9S96PH+o5WWTGsWi6N2nqmQeaY480uTPR08
         clFmIuQV1N2XhKq5fki+0Jib2tsfY8A7c4xCfSWAsdntXzLk7q3O8neKgw7d+TcUai
         ZEv+MT+5mephA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4EFC6C009;
        Tue, 18 Apr 2023 05:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681790035; bh=Db8qm9pRqZtyNTRYll629dy2U2gd2KOs98jRHg4BZxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wz2wIcfHQgI4z0viA/zIeRkNUE1RioyfUaylDtBHkemCXrTHgAa5VvB3++Fnv0vJC
         vYbM2yV0zDtng5V70D9fnGBZmN7d+8jYe5v9c9TFCka7CglFuU3uwZ0yOdVM+wbLKu
         6L/aV2mtrJ9nBMV/ZQGL+tFdGskYqVmrDddsQh2RJEiogiVYWFxwvLWGpWECu70whu
         4FY+d8ILanbcE9ceZLWC7MAjCc2vHF5qN/xZ6qP9gFdm7Y8Ve7WDXu+B+ozILsPSP3
         EAMQ1O53yvUILnE79yoR7vuTbEcB07ToFniDj8jJR+g9vJCTC1KownlkIYxNYJmmC4
         Bvzq29o9INUtQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 747d48f9;
        Tue, 18 Apr 2023 03:53:50 +0000 (UTC)
Date:   Tue, 18 Apr 2023 12:53:35 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
Message-ID: <ZD4UP8oqlU0sP6Tt@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
 <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
 <ZD4DV49fqKmPjMjU@codewreck.org>
 <fca50995-0745-4374-a64a-40378ea95262@gmx.com>
 <ZD4Jiagu0sWIPZDa@codewreck.org>
 <58fdd612-d2ac-1a77-25e5-59e8f7b668a2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58fdd612-d2ac-1a77-25e5-59e8f7b668a2@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote on Tue, Apr 18, 2023 at 11:21:00AM +0800:
> > No, was just thinking the leading part being a separate loop doesn't
> > seem to make sense either as the code shouldn't care about sector size
> > alignemnt but about full extents.
> 
> The main concern related to the leading unaligned part is, we need to skip
> something unaligned from the beginning , while all other situations never
> need to skip such case (they at most skip the tailing part).

Ok, there is one exception for inline extents apparently.. But I'm not
still not convinced the `aligned_start != file_offset` check is enough
for that either; I'd say it's unlikely but the inline part can be
compressed, so we could have a file which has > 4k (sectorsize) of
expanded data, so a read from the 4k offset would skip the special
handling and fail (reading the whole extent in dest)

Even if that's not possible, reading just the first 10 bytes of an
inline extent will be aligned and go through the main loop which just
reads the whole extent, so it'll need the same handling as the regular
btrfs_read_extent_reg handling at which point it might just as well
handle start offset too.


That aside taking the loop in order:
- lookup_data_extent doesn't care (used in heading/tail)
- skipping holes don't care as they explicitely put cursor at start of
next extent (or bail out if nothing next)
- inline needs fixing anyway as said above
- PREALLOC or nothing on disk also goes straight to next and is ok
- ah, I see what you meant now, we need to substract the current
position within the extent to extent_num_bytes...
That's also already a problem, though; to take the same example:
0                 8k           16k
[extent1          | extent2 ... ]
reading from 4k onwards will try to read
min(extent_num_bytes, end-cur) = min(8k, 12k) = 8k
from the 4k offset which goes over the end of the extent.

That could actually be my resets from the previous mail.


So either the first check should just lookup the extent and check that
extent start matches current offset instead of checking for sectorsize
alignment, or we can just fix the loop and remove the first if.

-- 
Dominique Martinet | Asmadeus

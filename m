Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC136E5792
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDRClx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRClw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:41:52 -0400
X-Greylist: delayed 5035 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 19:41:50 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D482D40E6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:41:50 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 657B3C01B; Tue, 18 Apr 2023 04:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681785709; bh=KddbRCzfq6VIU/ykR2SKbAHvO6vb0GTeFRqjvXUtYrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtKi0OBM1tNvni3DrLXriJpg7pQQ9FEaW8rqX0Vpa+J7HBsDBUOCJBeAWnCGOZvoL
         t6oHnux/EYeSIXj/cTad3DIeOpsiwJhY+DOjTRiUIkWaZPIc8vqTT1U/8PiIMX6MYV
         SKUiBuxhuLYKiCRlG6OZgu8gJ7ZQ2LXjvg6mdCQMaE+WxMpqmrDirhHNFYd06QzU+i
         XTY4MLP9x1fZgsB/l4cySWAv+0BF7A7u7E1VRoY4KZ07wUFJP0+mlJuLPYLrUP0qPB
         Eun8nnpLSbflsOkJd48+2jy560Lv7NqUwDpGE3/lWJQtYT1C5dfqj7KDuJysbmTCx+
         wBpDV0NfJbWIA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id AB5C2C009;
        Tue, 18 Apr 2023 04:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681785708; bh=KddbRCzfq6VIU/ykR2SKbAHvO6vb0GTeFRqjvXUtYrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBqGqTT9wIaSiAl/XLBrtAj/7NApgPm098Y9FkIpBlR6/DAdVAK+UqQj6ZML6B/Fs
         TKR7J1g/fQul53+w1IW0Wn37W8x2DumlqPdyoktSuPvmbw9exdnUfT5Q/HTieIoW92
         XSNA5ngB0X9GpkmUVwRiyS4VQtUubt/daPQm+xXrcXyhrU3EKzpq6ZHnsLMMHozhTM
         gJmFbqM/Q0HBA0tkrG0c4LxjU9odoOMmdSJyBWCuq8TxHdfCfiISyelExdt1HlAtDH
         J8qIXYAAst+ExAn3hK3EKA1/H/QIQOCb5BSDaZp4dnTyPCuQmBbpppMa5zF8A78Pi6
         x27TgniLir89g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f593bbb0;
        Tue, 18 Apr 2023 02:41:43 +0000 (UTC)
Date:   Tue, 18 Apr 2023 11:41:27 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
Message-ID: <ZD4DV49fqKmPjMjU@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
 <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c82ddd9-0e3d-4213-5cd3-af7ad69ebe48@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo wrote on Tue, Apr 18, 2023 at 10:02:00AM +0800:
> >   	/* Read the tailing unaligned part*/
> 
> Can we remove this part completely?
> 
> IIRC if we read until the target end, the unaligned end part can be
> completely removed then.

The "Read the aligned part" loop stops at aligned_end:
> while (cur < aligned_end)

So it should be possible that the last aligned extent we consider does
not contain data until the end, e.g. an offset that ends with the
aligned end:

0            4096    4123
[extent1-----|extent2]

In this case the main loop will only read extent1 and we need the
"trailing unaligned part" if for extent2.

I have a feeling the loop could just be updated to go to the end
`while (cur < end)` as it doesn't seem to care about the end
alignment... Should I update v2 to do that instead?



This made me look at the "Read out the leading unaligned part" initial
part, and its check only looks at the sector size but it probably has
the same problem -- we want to make sure we read any leftover from a
previous extent e.g. this file:
0              4096       8192
[extent1------------------|extent2]
and reading from 4k with a sectorsize of 4k is probably bad will enter
the aligned main loop right away...
And I think that'll fail?...
Actually not quite sure what's expecting what to be aligned in there,
but I just tried some partial reads from non-zero offsets and my board
resets almost all the time so I guess I've found something else to dig
into.
This isn't a priority for me right now but I'll look a bit more when I
have more time if you haven't first.

-- 
Dominique Martinet | Asmadeus

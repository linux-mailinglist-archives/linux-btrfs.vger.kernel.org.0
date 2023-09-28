Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC28B7B28D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 01:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI1XcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 19:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XcT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 19:32:19 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71375139
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 16:32:18 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id F3B57FBFBA7;
        Thu, 28 Sep 2023 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695943936;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=te5bRIKgbAl6RNKM4T82tMacB+UdJpV7nGqfLtftHxs=;
        b=eNV6/66ImQm9b6WUws0V1q5zXMd9mEqkblO+b3mPD2EKdzls1HueEDOy3Ivvs43K
        ZC8BzWwJDcPj90BRifnyYhDpuhxpjizDJ1LaJTOEE9kGuAwp3IHZflHyVkjmzhvf0hG
        qA79T4vtuFbQ1gISnOgn/0fCrh2F8OKwQCzwUmJbBo+khEGnBYoCEIVbKLrc2I5a06+
        O+NyrBb6I2L6e1F/OwpN3wRz4oTAICMb+KdTEvwpPsHgRu9y9xl06xRq+LtKsSs00Gh
        kWeviGTGGlkzuWPF5z8ff7CjSS21bmXjFfOANyAsNHvnQ6HFhNhHaXcH1Dmz1eT7lIO
        OWgrQOAN9g==
Date:   Fri, 29 Sep 2023 01:32:16 +0200 (CEST)
From:   fdavidl073rnovn@tutanota.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <NfT7gZI--3-9@tutanota.com>
In-Reply-To: <4cb27e5b-2903-4079-8e72-d9db2f19ced7@gmx.com>
References: <NeBMdyL--3-9@tutanota.com> <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com> <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com> <NeKx2tK--3-9@tutanota.com> <NfJJCdh--3-9@tutanota.com> <4cb27e5b-2903-4079-8e72-d9db2f19ced7@gmx.com>
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Sep 27, 2023, 04:53 by quwenruo.btrfs@gmx.com:

>
> The compression is the easily way to create tons of small file extents
> (the limit of a compressed extent is only 128K).
>
> Furthermore, each file extent would need an in-memory structure (struct
> extent_map, for a debug kernel, it's 122 bytes) to cache the contents.
>
> Thus for a 8TiB file with all compressed file extents at their max size
> (pretty common if it's only for backup).
> Then we still have 512M file extents.
>
> Just multiple that by 122, you can see how this go crazy.
>
> But still, if you're only deleting the file, the result shouldn't go
> this crazy, as deleting itself won't try to read the file extents thus
> no such cache.
>
> However as long as we start doing read/write, the cache can go very
> large, especially if you use compress, and only get released when the
> whole inode get released from kernel.
>
> On the other hand, if you go uncompressed data, the maximum file extent
> size is enlarged to 128M (a 1024x increase), thus a huge reduce in the
> number of extents.
>
> In the long run I guess we need some way to release the extent_map when
> low on memory.
> But for now, I'm afraid I don't have better suggestion other than
> turning off compression and defrag the compressed files using newer
> kernel (v6.2 and newer).
>
> In v6.2, there is a patch to prevent defrag from populating the extent
> map cache, thus it won't take all the memory just by defrag.
> And with all those files converted from compression, I believe the
> situation would be greatly improved.
>
> Thanks,
> Qu
>
The backup itself is gone and will need to be re-sent. If I'm understanding things properly then by mounting the btrfs device for the backup without compression and enforcing send protocol one it should be written uncompressed which will avoid the issue correct?

I was also looking at the source code and it seems relatively straight forward to change BTRFS_MAX_COMPRESSED and BTRFS_MAX_UNCOMPRESSED to SZ_128M or somewhere in between like SZ_8M. Do you have any thoughts on how well that might work?

Do you have any idea on how complicated the long term fix is or when it might added? v6.8 maybe?

Thank you for your prompt responses. Sending the backup again will take some days but I will email you to tell you if disabling compression fixes the issue.

Sincerely,
David

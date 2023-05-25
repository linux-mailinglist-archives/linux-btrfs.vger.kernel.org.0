Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA45710A07
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbjEYKZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbjEYKZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:25:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128D97
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685010321; i=quwenruo.btrfs@gmx.com;
        bh=Iql8sI7Ie6HqTXD2PVn8o2pSso/VdsA+CpUGWLhdN6A=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=tquPOA3kOTIcjKzmGPJQVGMhrub7XCKaVO9YJVZwCsx7xMFoOA0ZUFcxY6qqNYaVd
         7OROPYpaAwKk3mjU8gjVrK7pTNuKU1x6cCQGf8QYPQeSh8P8T/1g5haUloOgFCzgw9
         4/MtBbMPMxQIhXQns+lkzX22qWdEz1yRay2E78Jf2+I5DdiGqanqbFLHwbiEMlyqzB
         wx82fdTE3EgpnUZl1JrVqQf34Gr8RmZmX83xtltshbPrmrqj2PKvGl9Oqw+k9n2/0X
         ePo3ePG4cPF2sLR+wDFlwj9VDpE6HRXlnanSaEUhrlYbG0shPOBt80DLaWgDO8def8
         ulBRi/Wugvu/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GQy-1qFU5A2J72-014CcE; Thu, 25
 May 2023 12:25:21 +0200
Message-ID: <53155753-162c-ffcb-f676-32be6d428260@gmx.com>
Date:   Thu, 25 May 2023 18:25:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/9] Parameter cleanups in extent state helpers
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5TU0y3rdLsKBcrdRL7iunm3sYhnCzq/N8GFnYUcPabtrd5rTm20
 c+5eLQ+vQYZjWgwOGQnXa2GUf5pssqsxoSOalcHUY5bM2v0nP8jH6khIf7R0Dhco4D/ncTL
 4Pc+YDdGybTkte2J8XcJwwkbpRo6v5V7+I0nOj47wOP+w6dFkY1ivqCC/JaiXOKts4pWpcf
 nd+qZtqnGZYSwSMRHqXDA==
UI-OutboundReport: notjunk:1;M01:P0:fKgZpuhKwog=;oAWHOQpngh8HkmBcsT+2DDbOEjl
 3lTYehUEykQBkKXbTeNNbBhaD8CKlRil93D086Vty7XfY9w4Wrqts0SjLYc1RSYyWkSXRawV4
 qmwQcdOeCQdHMSWsa878s7RzWIY0uACCw2d0cQQLcSkGWQepxhPNpFP6g6RHJ7LAhgmuWd1nJ
 xyF0TreswqDuPQptYT1wUHR4ylNMRMsDU/H97YZEzRIpKtS2ksvQxExNXkGGzK3mwRJfnGu7T
 IiyddE2rz0Gi8cs15jCKKYCiSkxs4dHa2eRX6AiIuBUiijkNPyxrKjpaYvfLuRFQffTNfUEnF
 wIwGgF8IyLyXQvcNnhjdDp4Cw0FGoQHA2LtqB2FowGP6rjZ7pdBkzaoIQqohSHMTe+mG6ff+E
 6IFJlH/VYEX8PgYpq38V1J1EhxxHGat/CgLdMQvdwINHVdqPNh/QN+9M3JdrGGh670gTv+324
 bm8ZGgRzYpiFM8xibGNXdqmm9s/mtTJ/c4QZxkJH/AH5rFN0s4UAVf6S0m513uB7FQ9sDNIPS
 9rmLun7aulNGmQpzzB7TlzjPu9Ufid8X/ByIkwFrJMm6oDkeVw3mwYZ+F/mEzflfOa0lCyJlp
 TvmboOpLLYtEVtqA5T7FmoCnwSYlSTYAsBeOe8vqHXF+NxyqJBqOWsMkUah5Ih9nsbCbEnFzw
 Hmc5C8CvDZN0R8XPijvSBWNHOH3Ku/tLTTD8TLvdxCzdjdXsqAtXZWpNGjWFoOf7rYRyg34ZA
 b/Nyxf7sCmwiIdOUBoeB8K/n6stAi77JcLVjTTz0Q9REonzsfEWRXxJ4cEzFhAY6qptUpdT5j
 C0Z4qWPbyJmgOIULVuedMp6NnFzotZBsZMjms+eINVl5jmsBE2xG9FflaT3rTYC/yUwDN4L5a
 1tmQ7n4u9fudKTo4A2C+q2IjBzRxcnB7DbVpEw+7up5TjzZa+mNm3w4t0J2C5WmDk4FGDYqFf
 Pvl8e0rEsctSNYXjDzC9DTrJUAM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> This is motivated by the gfp parameter passed to all the helpers and how
> to get rid of it. Most of the values are GFP_NOFS with some exceptions.
> One of them (GFP_NOFAIL) can be removed the other one (GFP_NOWAIT) is
> transformed to existing parameters.

The patchset gives me some inspiration on a wild idea to completely
remove the memory allocation inside set/clear_bits().

The core idea is to change extent io tree to have "hole" extent_state,
so that every set/clear_bits() call will only need to allocate 2 new
extent states, thus we can pre-allocate them.


Currently the extent io tree behaves much like no-hole, we only insert
new extent_state if there is any bit set for a certain range.
Thus the following case will need as many new extent states as the holes:

           |<------- Range to set bits ------------->|
           |///|   |////|    |////|   ....     |/////|
                 ^         ^                 ^
                 |         |                 \- hole N
                 hole 1    hole 2

But if we keep hole state extents, the above case will only need to
allocate 0 new extent state:

           |<------- Range to set bits ------------->|
           |///|000|////|0000|////|   .... 0000|/////|

Although we may still need to allocate up to 2 new extent states even
with hole states.
The most straightforward example is:

                |<- Range to clear bits ---->|
           |//////////////////////////////////////////|


But this greatly limits the new allocation needed, thus can make the
set/clear_bits() to return void and avoid memory allocation at all (all
pre-allocated by callers).

Obviously there would be no free lunch, the overall memory usage would
increase, especially for fragmented extent io tree.

Thus I'm not sure if the hole extent state idea is really a good idea or
the existing NOWAIT/NOFAIL allocation is more acceptable...

Thanks,
Qu
>
> Module code size is lower for the whole series and stack is reduced in
> about 50 functions by 8 bytes.
>
> David Sterba (9):
>    btrfs: open code set_extent_defrag
>    btrfs: open code set_extent_delalloc
>    btrfs: open code set_extent_new
>    btrfs: open code set_extent_dirty
>    btrfs: open code set_extent_bits_nowait
>    btrfs: open code set_extent_bits
>    btrfs: drop NOFAIL from set_extent_bit allocation masks
>    btrfs: pass NOWAIT for set/clear extent bits as another bit
>    btrfs: drop gfp from parameter extent state helpers
>
>   fs/btrfs/block-group.c           |  6 ++--
>   fs/btrfs/defrag.c                |  3 +-
>   fs/btrfs/dev-replace.c           |  4 +--
>   fs/btrfs/extent-io-tree.c        | 37 ++++++++++++-------
>   fs/btrfs/extent-io-tree.h        | 62 ++++++++------------------------
>   fs/btrfs/extent-tree.c           | 27 +++++++-------
>   fs/btrfs/extent_io.c             |  3 +-
>   fs/btrfs/extent_map.c            | 10 +++---
>   fs/btrfs/file-item.c             | 10 +++---
>   fs/btrfs/inode.c                 |  9 +++--
>   fs/btrfs/relocation.c            | 10 +++---
>   fs/btrfs/tests/extent-io-tests.c | 16 ++++-----
>   fs/btrfs/zoned.c                 |  4 +--
>   13 files changed, 91 insertions(+), 110 deletions(-)
>

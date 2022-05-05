Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496B51B84C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiEEHAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiEEHAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 03:00:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72C377EF
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651733813;
        bh=jcPAauoJj/vocHXhF/nosEuDqmx3h7ZubWVrVRYm5uM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=PICQ9QQuArnRhquuOU/dsn8YY0VsvD86VNxTjBrfvVzrnTOl4awZ+rm/ZOmihd88b
         q1QMmT483Njr0ku00D2t+raNV+jJ1agSqZwCp8TYyFfI6MiUDlIPf9UkAO7lb4zn6p
         8R3WspIhDacAws9fGzRZu/zEWq4k6K97vawOhcCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bfw-1ntgC237Ww-0180CU; Thu, 05
 May 2022 08:56:53 +0200
Message-ID: <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
Date:   Thu, 5 May 2022 14:56:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: cleanup btrfs bio handling, part 2 v3
In-Reply-To: <20220504122524.558088-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/GntCJjztdIXj88sy47gaeyxRTjKjs9fZCb5qgVKv1AcNF+AKKI
 e8+F78MSTCj7KK5tp0lAtziiJzN2P11qhCtzpIP4LjPfgHJEmGpNvAKQhtMgQz/goJMG0aL
 H8QNISXMzxrap5UCpohpwZ0o8m8wEEbv+ePDX64OPuCozFtQq1rQBkj4Roki22kTUhgn5gt
 uViY3DoHOSO5YVWfqojaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tNmj4kFdBWU=:U18rpan6O2kxhv73RDk5KQ
 n65xet2rHJ21Eb5pSJYHHCH75lG+7fn/7yaeewezF0ATIdlH3XlaSD/YvLR8b5K2dARJMXjvT
 0u5QoHX4svEh41bcp3Ly2Au+KmIL8Q/D+AgNzlybLIK85ST9rj3d6V0Sr9kilq0e8a8BhYXDR
 7Le3i8lh+7xGTCzmdmmcV5QHla31I5glqWYbQF/zJEq5NOwrEnSgtO/g2Q/+vThqLsADVJgFB
 NNh8I64EYrtLrXNp0mKcfqHSdDHDBwOTjk4w1TRvYQiGKmQdxiS1M/OIlcZ6lTSqCMOSJUkCb
 QEQ44QSD96gUykCwIXszDhbEwWqWZTOAtMnr1AvKr3kDCv0XRkPXOMVeyUycgOYvqX1V0L6O6
 /KQy3GD1yDW0FRHSlJn6KRa3VZiqVgHfHklvmxNqlLPydMsJh/8SjBqXvYsOEja3zWXS2ZHqs
 GguMCdHtJsjOyrgzv51LN9RyNo7U6zzEaTSw5gyVK6MxhKSW88RSWrPljHij6s/3EUdqbtZfe
 eb0FWY/PbrmVcheLjgkkBbzHrwTK8V/0cjCpasUAlif4VvC8VHrXw0O6bD0vyyWUOc7+u8lzr
 Qwzqzu6PBZUA7kCyh5v75mxl1+vAZXR+D0UuRfwmtob0plRMIGNWU00CM4K/k7bt0Iuhh7fLP
 +2zU6NCJdD0j/KKQ9xOBGs/NFnX1VDm4u/R+/ZMJDs+gNE43ad7mi6RIhbxGFKSOQJTLrTk1k
 MDldf/UA4BVGHQNDWSb6iSUWmwKBTVDxFS99wcqSo4m5k0Q8CXoZgdqnqOBidR4Wej9qgkpnw
 TG26deqSSbi2sx2Z/xfXSMIr+KBerG70Eqxqem2ZOusQej6LxGohIPjGD5rI7nvTOKipQA3h5
 GRn5172KP5ZV51GoUpr47LvJGj4phGnrB4nQxtWwSzgWiNl7K0JN8HMwUGamLMIlkVA0fcj0G
 XWlWvjGrb1OdILrLHgv21lDmZbBvkBzcowczXRhlwtFLBhILMVU7619IXtV/An3ymh4E05W90
 VSnCway/xeCmhBniGvtblMMFT8tMqGHVMfxxoi2KkLH/4xs1HAhAXFc6zx2Anv3nPqFcf2p2h
 TP5I93wvmnLi9g=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/4 20:25, Christoph Hellwig wrote:
> Hi all,
>
> this series removes the need to allocate a separate object for I/O
> completions for all read and some write I/Os, and reduced the memory
> usage of the low-level bios cloned by btrfs_map_bio by using plain bios
> instead of the much larger btrfs_bio.

The most important part of this series is the patch "btrfs: remove
btrfs_end_io_wq()" I guess.

As a guy growing up mostly reading btrfs code, the btrfs_end_io_wq()
function looks straightforward to me initially, just put everything into
wq context and call it a day.

But as I started to look into how other fses handle their delayed work,
the btrfs way turns more "unique" other than straightforward.


So yes, aligning us to other fses, by only delaying into wq context when
necessary, should be a good thing.
Not reducing the memory allocation for the btrfs_end_io_wq structure,
but also making the atomic part of the endio function executed with less
delay.

But here I'm not sure if the btrfs way is a legacy from the past, or has
some hidden intention (possible related to performance?).

So do you mind to do some basic benchmark for read and write and see how
the throughput and latency changed?
(I guess we can get slightly reduced latency without really damping
everything else).

With such benchmark the series would be more convincing, and I can learn
some tricks on how to do proper performance tests.


Also mentioning how other fses handling delayed work may help guys like
me to get an understanding of the more common practice used in other fses.

Thanks,
Qu
>
> Changes since v2:
>   - rebased to the latests misc-next tree
>   - fixed an incorrectly assigned bi_end_io handler in the raid56 code
>
> Changes since v1:
>   - rebased to the latests misc-next tree
>   - don't call destroy_workqueue on NULL workqueues
>   - drop a marginal and slightly controversial cleanup to btrfs_map_bio
>
> Diffstat:
>   compression.c |   41 +++++-------
>   compression.h |    7 +-
>   ctree.h       |   14 ++--
>   disk-io.c     |  148 +++++-----------------------------------------
>   disk-io.h     |   11 ---
>   extent_io.c   |   35 ++++-------
>   extent_io.h   |    1
>   inode.c       |  162 +++++++++++++++++++------------------------------=
--
>   raid56.c      |  109 +++++++++++++---------------------
>   super.c       |   13 ----
>   volumes.c     |  184 +++++++++++++++++++++++++++----------------------=
---------
>   volumes.h     |    8 ++
>   12 files changed, 262 insertions(+), 471 deletions(-)

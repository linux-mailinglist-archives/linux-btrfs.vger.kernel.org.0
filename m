Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389BD7631A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 11:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjGZJUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjGZJUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 05:20:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274395275
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690363006; x=1690967806; i=quwenruo.btrfs@gmx.com;
 bh=zCrC45+Ra8b5Sx/oVm5UlR6tAjJ6kD3W8scQ13C8J3w=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=olY/LBao+PQndT9Nn5yVlTdc4s8tcAS1o3sbrCOMvXdONr/yQeqtS6gkrase6kVCvaASLde
 PqQODoeEfKYAWi7ws57v5ozipaJdUWK51dVq7Nc5/0Oq4Qm/Pr1Pi+VWjeZtwbp+TWmpS83Wc
 U/09J1UB4dyEh4l48NvMHjEOppf/ED/9Rk4PjWjKrevVyuL9UUcq2WSwXL2FkYcth73sNdwbC
 MBYV+9v/qZc8dUXj1WET2MLyayuEX2PojYlVra8mAQV+VVwInXSi5C3h2j44X8dNGfYK5sFLq
 6Aqo8WXfDjhtV+skNWTsTQ9JsDOJR8KRzajrVH6g0Fkwx5LKijQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHAB-1pwhzq1knD-00gnCz for
 <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 11:16:46 +0200
Message-ID: <6c439113-d55c-8dec-e7bc-7c1332702f92@gmx.com>
Date:   Wed, 26 Jul 2023 17:16:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 0/2] btrfs: make extent buffer memory continuous
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1690249862.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <cover.1690249862.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7911EtpfzCXzyDT4FSwYAOhk+OHZbh9F7KvenlGMBOH9oyu0eC5
 iuUL9Ml8RtFhGMYc5LQQI+zIfO+5PNLuLC19UJhZ8ZR7REarKyOMszIJmqAOopI6fPe9m0J
 BHWwPDt8NSwTD7ke07lRAwEHxmGNvD6zFF3dzNdtf4D0jU7UJPMKR4GzeXiod3ddtvdOunX
 oZupxxpk5dL0oCU0YI7Sw==
UI-OutboundReport: notjunk:1;M01:P0:XbaKuIJ678M=;83ao/VbBGKDFu43HB57ANSN+2+x
 EFZqN3ddd+5JOy0H6DWTsRzIfynP0nI3YSQOynHCzQfM3qItFW9wTzD05ayqLscZ1GCwiXHog
 W/1jVXoa4wgzg7xKdCtOqPXn8AY0453Io641kQODRQ+hM5SNC1vxfzjLq/oJdba6frPQlxL8w
 0Y9F7M6qqpn7yV6ock59d+3WN8X79N6Oiu2Fgj/evnOLlj3K7naajLFoA/ND6ASZd0e+y9O1I
 3aUhHWB743WthpkZtnF0vP9gPSQwrhSLSmOIzSTmf8yIYK2v4k85yBW7ag/NCt0E3Q+IHqH1G
 zvm8ggTK8Hm9GMHwm+FzgF5Q41FSUqh/0bh6HOT0fCbjBS9NO3/A2WNNB1F+O2sw0AIzcDwmj
 z6afKUO9HqeOsqheq9jZsol0zig4REk+QQp6rY8NiKVmq2VbqxUayNJMVl9EEfyx95uvnTsnZ
 MjPIv/knKqLAJtYoPUM2yAXrid2HbJQfQrO5DZwTEDDj+1r/4JDqV8Hs1U9qN46zTlmdZygIz
 pCJ4kWvg40hLvjMpeqEHnVkf4vbtfkmFVRDmUmjzf95blATLuzLgiId3lFVEn/PmynzmmWcWX
 1bAS0uficiFHOmNuSt5Mb2U5s98i3UgUzUVVxi57QHZBwXGS7PDOUMuzwozArmIJ5eMQEMy0U
 2r97XFp1nC5mMxzkOnI/hRtD8Mzbb7AsVl9sbOGNeMHozuN2m8vHVputJamS65MyDjwv3MUGP
 ucU6oHcYydKvBGKykCehM38KkUvZI3SXnLHokdySpI/1tsV2CkOh/cQtIM3js9uYjdaRIY4GJ
 cR1XEf/2jcu64XuwzLhSvVLOilNm8NFyQbwH18+Ufmi/vBF/NIA4UaYJ9ZfsIoVS3kiUVch3C
 sXPc+gfqoVmtYPyM8/96wy7ubal0OjmUlKC/PNSHb03hi/Ciws0ltqSlNjxJX7+dasfAk60wO
 XztG36Hn2u8v/eYYam/haaQYAMY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/25 10:57, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/linux/tree/eb_page_cleanups
>
> This includes the submitted extent buffer accessors cleanup as
> the dependency.
>
> [BACKGROUND]
> We have a lot of extent buffer code addressing the cross-page accesses, =
on
> the other hand, other filesystems like XFS is mapping its xfs_buf into
> kernel virtual address space, so that they can access the content of
> xfs_buf without bothering the page boundaries.
>
> [OBJECTIVE]
> This patchset is mostly learning from the xfs_buf, to greatly simplify
> the extent buffer accessors.
>
> Now all the extent buffer accessors are turned into wrappers of
> memcpy()/memcmp()/memmove().
>
> For now, it can pass test cases from btrfs test case without new
> regressions.
>
> [RFC]
> But I still want to get more feedbacks on this topic, since it's
> changing the very core of btrfs extent buffer.
>
> Furthermore, this change may not be 32bit systems friendly, as kernel
> virtual address space is only 128MiB for 32bit systems, not sure if it's
> going to cause any regression on 32bit systems.
>
> [TODO]
> - Benchmarks
>    I'm not 100% sure if this going to cause any performance change.
>    In theory, we off-load the cross-page handling to hardware MMU, which
>    should improve performance, but we spend more time initializing the
>    extent buffer.

I tried an fio run with the following parameters on a PCIE3 NVME device:

fio -rw=3Drandrw --size=3D8g \
	--bsrange=3D512b-64k --bs_unaligned \
	--ioengine=3Dlibaio --fsync=3D1024 \
	--filename=3D$mnt/job --name=3Djob1 --name=3Djob2 --runtime=3D300s

This would result heavy enough metadata workload for btrfs, and the new
patchset did get a small improvement on both throughput and latency:

Baseline:
    READ: bw=3D33.0MiB/s (34.6MB/s), 16.5MiB/s-16.6MiB/s
(17.3MB/s-17.4MB/s), io=3D8136MiB (8531MB), run=3D245999-246658msec
   WRITE: bw=3D33.0MiB/s (34.6MB/s), 16.5MiB/s-16.5MiB/s
(17.3MB/s-17.3MB/s), io=3D8144MiB (8539MB), run=3D245999-246658msec

Patched:
    READ: bw=3D33.0MiB/s (34.6MB/s), 16.5MiB/s-16.6MiB/s
(17.3MB/s-17.4MB/s), io=3D8136MiB (8531MB), run=3D245999-246658msec
   WRITE: bw=3D33.0MiB/s (34.6MB/s), 16.5MiB/s-16.5MiB/s
(17.3MB/s-17.3MB/s), io=3D8144MiB (8539MB), run=3D245999-246658msec

The throughput and latency both got around 2.6%.

Thanks,
Qu
>
> - More tests on 32bit and 64bit systems
>
> Qu Wenruo (2):
>    btrfs: map uncontinuous extent buffer pages into virtual address spac=
e
>    btrfs: utilize the physically/virtually continuous extent buffer
>      memory
>
>   fs/btrfs/disk-io.c   |  18 +--
>   fs/btrfs/extent_io.c | 303 ++++++++++++++-----------------------------
>   fs/btrfs/extent_io.h |  17 +++
>   3 files changed, 119 insertions(+), 219 deletions(-)
>

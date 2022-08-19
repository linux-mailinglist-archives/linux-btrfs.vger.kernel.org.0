Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFEA59A822
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 00:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiHSWL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 18:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiHSWL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 18:11:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF508D7D34
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 15:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660947078;
        bh=rG0im+wm0wyIQj3ht4UOFbkTNLcAgbVvxdDxtb6H9O4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UZikcX+PTqG2X++a1zG9DyMOA8nYVh7nwwWNQctVVzyxegYcAst4Q/Ez5qkLXOgWH
         DVjyrxblW3hjWGtA4cqjj11zl2IvMGHc9sNk5+7tlaw9iWnvzwW4JL9myej6QCB1tk
         rsh8SO1WvcHotLtesUiqOhIiBFubM8gb27m9rpSk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1pGRU41Vx3-00rHlH; Sat, 20
 Aug 2022 00:11:18 +0200
Message-ID: <4327e8da-b6fb-3ceb-aa38-10e1e1180ff0@gmx.com>
Date:   Sat, 20 Aug 2022 06:11:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs: don't allow large NOWAIT direct reads
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Cc:     Dylan Yudaken <dylany@fb.com>
References: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qv56GJb7naKFE/c/0H1h3/55XjLvnX+PUabAhFjN5J/rp0JKMzT
 44z/ii6fe2M2i88HWOC47usnhiOG9FAJFWea8EKwgaCks1HZLn3r8RvMj4zca0FvUesA2G5
 PU0avbUgizQrYhVDFf6SZKdBA6qABDSMiYniUpEugSRgo9RdYC4PvfTChQ40U21FSfdmBRq
 vQCmpdph2dDgShUEvy+5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4y9oR9WEQ7k=:XDJQ5UlRlPUopcYDB7uL9g
 yg3+kui5OBwBFg/8vUpGiowoQwGlAv7ZoFFNbU3WN5q/cVerOTtG9NoBMqxHu5cxj1GI+44h8
 4Kax0DicX6Este3do9YPwAVO7QH/08niTKVc4fLwTjEDgin0DCk3UTCSfeRC3z3606/2UlH0G
 ozT7VlP+OYSUAAQWeIwIxDYJC9g9wvV/1XLoTb80WsIWsLm4ZwXo6aWVjERUvQvBVGuLBW2ie
 Ed1rS3781Rb6jQYl6NC+9bQEf0bU/qcJ6pSN/MyEc0VhCXRwhNSCTpj6I2QMd4eOMnX6M3ua0
 VVb1u+ZRi/EUr5W7hw/2gttRXP3fi3LDcqDRr356uOqvK9+Fn/QyW1vH99qJSlDIMVZJAQ0Rj
 fV0Gp3c+YcqZyV1bvqgG1C3MlU5Y4vQrsrNpPB4CSwQfwbRgUbRWgbyuyYi3h3xx1ZIBTeUiM
 TOtURc8A8HF0sqp5Emgym5x35dCN9YnfDKz94w/sy0y38ZKLIsHQiFJLhlz82nAA813bnk/7u
 nWUd7FLGvbrQjI/gQF93Dp2S1dW75ACkKAVgg7nwCG26pSASHY4MK+VU1rdqQzk15WkaCRyza
 u/D7NEQNlCKD7ujQabCYs98zigsJHQi466dmmTv+4B7Qr+lD77li3HxnIS4TSK91HP4udb3ys
 xPyKaeZQNput8gyimRzjc+tfWdw3W6iLmKyO87NeyuDFPKnTJm7cw560VF3IzSAZZalxuG4HR
 b11AVuPPP9tNIZ6UK3n1t8DNvL6SLO+ro1J4iC9Lsdsl4AhsF4fRjR6D3s15KHg/6D19E1R7y
 yoMkzb0Mx69kbuU+8dZqL0UhKQthudk3DLCzpHJVSzDtDaTviNuQA7VYCYkWXdQ2iBK0YrxxJ
 /4nbUopdRX+m3BKHK+iH6M9VM+izRB20i7Wg5SkJNkocnhdZ2Jj67yBKarJ9KK8eNKwtuV/T+
 HoDE2EESgvVnNY8nQcj9CJZc2ATuNNEcP4TRsa/bowlA4/5bO4vjcNO1QYaf3Tk8cJe2R0U20
 DQp0Fn1497mhqnB4EqK0uJs6t30sFI+5kZoX9jgVAzBPTZrNEmRrDjMt35Z1fAcxSj/0v08AA
 aBw+9lv7CkzXbcIrLYyGQp8l9iLa7jf1HY7PAh2Ki83KW5MzgUVcGUczQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/19 23:53, Josef Bacik wrote:
> Dylan and Jens reported a problem where they had an io_uring test that
> was returning short reads, and bisected it to ee5b46a353af ("btrfs:
> increase direct io read size limit to 256 sectors").
>
> The root cause is their test was doing larger reads via io_uring with
> NOWAIT and async.  This was triggering a page fault during the direct
> read, however the first page was able to work just fine and thus we
> submitted a 4k read for a larger iocb.
>
> Btrfs allows for partial IO's in this case specifically because we don't
> allow page faults, and thus we'll attempt to do any io that we can,
> submit what we could, come back and fault in the rest of the range and
> try to do the remaining IO.
>
> However for !is_sync_kiocb() we'll call ->ki_complete() as soon as the
> partial dio is done, which is incorrect.  In the sync case we can exit
> the iomap code, submit more io's, and return with the amount of IO we
> were able to complete successfully.
>
> We were always doing short reads in this case, but for NOWAIT we were
> getting saved by the fact that we were limiting direct reads to
> sectorsize, and if we were larger than that we would return EAGAIN.
>
> Fix the regression by simply returning EAGAIN in the NOWAIT case with
> larger reads, that way io_uring can retry and get the larger IO and have
> the fault logic handle everything properly.
>
> This still leaves the AIO short read case, but that existed before this
> change.  The way to properly fix this would be to handle partial iocb
> completions, but that's a lot of work, for now deal with the regression
> in the most straightforward way possible.
>
> Reported-by: Dylan Yudaken <dylany@fb.com>
> Fixes: ee5b46a353af ("btrfs: increase direct io read size limit to 256 s=
ectors")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/inode.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5101111c5557..b39673e49732 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7694,6 +7694,20 @@ static int btrfs_dio_iomap_begin(struct inode *in=
ode, loff_t start,
>   	const u64 data_alloc_len =3D length;
>   	bool unlock_extents =3D false;
>
> +	/*
> +	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
> +	 * we're NOWAIT we may submit a bio for a partial range and return
> +	 * EIOCBQUEUED, which would result in an errant short read.
> +	 *
> +	 * The best way to handle this would be to allow for partial completio=
ns
> +	 * of iocb's, so we could submit the partial bio, return and fault in
> +	 * the rest of the pages, and then submit the io for the rest of the
> +	 * range.  However we don't have that currently, so simply return
> +	 * -EAGAIN at this point so that the normal path is used.
> +	 */
> +	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)

Since there comes PAGE_SIZE, this let me wonder how would this handle
subpage cases.

Not familiar with page fault handling, but I guess since it's really
working in page unit, thus it should be fine I guess?

Thanks,
Qu
> +		return -EAGAIN;
> +
>   	/*
>   	 * Cap the size of reads to that usually seen in buffered I/O as we n=
eed
>   	 * to allocate a contiguous array for the checksums.

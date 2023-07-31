Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2057E7689FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 04:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGaC1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jul 2023 22:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGaC1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jul 2023 22:27:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18FE4E
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 19:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690770427; x=1691375227; i=quwenruo.btrfs@gmx.com;
 bh=2Rfg/Cjy03Dxaelan3wwXMSsDXS/L+fCC0lcj4jiDVc=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=BszjfaBtwocolpju4xHfrG6JrxPQ0/pB9GwvdI81WUVg2GdLAJZrvKC3M5G1jlthpBgn5lD
 L7KRcX+fw7alHU2BJnKi0JstZPot1vUXunSRB/FwePfO449Mp2ee+aDvenA62AJq1JkbQ4l5e
 Xh+hWAh/v1Dcttmbnq6nFwqP7HMYudCQ2r3uAwF1ugMGbDqA1xApr9s07qE53q2IYPaDQxX7e
 oBLlPhL0KjkCL+Cjoe9E4m1IzAf7YNRRHhLWqK9Sl6/5SvpuCWbYt1bs8mszfX69hLJw6uINS
 4m9nCUD6wvo+DI4SiY7rr+AV6vYgoMbWZ7kKErCj1/lAbRDPwBTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33ET-1pjMTH0oPN-013KQH; Mon, 31
 Jul 2023 04:27:06 +0200
Message-ID: <e6557f41-9c3c-628a-958d-057582f8cab9@gmx.com>
Date:   Mon, 31 Jul 2023 10:27:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com, hch@lst.de
References: <20230730190226.4001117-1-clm@fb.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
In-Reply-To: <20230730190226.4001117-1-clm@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJLf92KLJ1Onmu6utdcoV7k+JgKwNzHoMCZtrI9w57YeHCHfBOV
 oPFT3pRuu8Jx/b+XRqcnoqud0+lK0zBlKMOBtjBdhUqkRPczlpQqY6bvEHd3RYLbUIUtS/Z
 Y/6HyWPmMYPSyxCwr0bRo6YIInmr5KkKwS3BDqlezQ1fW/8ttvnVie1vkXn/mR1yRgOa1dt
 Czd4JdAy/fAPm9cb23cmA==
UI-OutboundReport: notjunk:1;M01:P0:DBxVV664KU0=;0hOTXVMeR5mZG9AcPGcj/NxZjBc
 4iy54VAYE3aYOA6KVvMrLLqlSuR1znylBAqEiPIljM8DTzpsjItq2cM2dR2cYIemdVMcLmNS2
 wORMiVzUKjndi1e1MPufv0D6kJMrfSOO1dXrfYdEeDvnmxjdKftuQ9yHP/b514BycGRB2xdSO
 MLzGGLIcbjj0xk/5Uv1Ncqj4PwcL66zf9wkuKR69s5CY8gwmcN2nHbhMiRYKpRohJ6cBBfZjn
 8TDejTbZpFS0j4tdlL1bekucmB8Ua1DrEaav7rhzpVh4gmxM+VN1UfNopOJzKqIoAzdNRGyy8
 gINaEKPKKjRRh2zSHPtj5PZ3+pM+ZU7RsLa2UnMmzR9rZY4/o1lWXDeFODelZ6qMRPhcXsaff
 lLzfGrcxFPthfu5WMjWG+4ELwmjKEiABkGyQB+VlaJ7jLaEzEhbTvO7rxOdQrxLVbwaNqQDsV
 mnp92IVSfZGAGLFMAGq5H9JMOvqLbEC+9Oo5hEAx4g91XTxAMuZBmMUDdiV2qMVFLHotE2fyY
 ANz1xI5llo4pUo4iKWD/0EIz0RSQaQ//IyzGwE6IS1JLxdu8zWqhhjKYEicTyeh+dvx3+2K7o
 JbbB5GQ9f3LDZs3zCgQiHqFf/raoeIjyFGhN0UcmwPZEvrEPtdqyrrN6thYFKiTIIYyWg6n5S
 ouH4TxM5EMkxqS0vENx30O22Cd+fbBDk+zYmlynXKrBbeKmPfswgrxSMzY+MsgDW7PxkvpEy8
 e5roRaJ+tPUNpijZ5qD8ovNAVvLsPFMhxIw1pm0wVsoEMvVEeprAME+qS15/HsHtikoBofcSs
 Hht1wzxetRDn6lnTPfveyzBRRN8uCvEHZgX9mKUIn5ueTTFD+eKKfy3V2RpCGScUA+p0vrm4h
 vb2v6ZrqwdFAYk9ms+wR+ljX+kI/iZhm2D2KVW8oA83vp6u2c/iOtsQcgTZRAYyUDZpNUPUZ+
 /FX9n5dv+cKYcihPPAlDSvj+/EM=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/31 03:02, Chris Mason wrote:
> [ This is an RFC because Christoph switched us to almost always set
> len_to_oe_boundary in a patch in for-next  I think we still need this
> commit for strange corners, but it's already pretty hard to hit reliably
> so I wanted to toss it out for discussion. We should consider either
> Christoph's "btrfs: limit write bios to a single ordered extent" or this
> commit for 6.4 stable as well ]
>
> bio_ctrl->len_to_oe_boundary is used to make sure we stay inside an
> extent as we submit bios.  Every time we add a page to the bio, we
> decrement those bytes from len_to_oe_boundary, and then we submit the
> bio if we happen to hit zero.
>
> Most of the time, len_to_oe_boundary gets set to U32_MAX.  With
> Christoph's incoming ("btrfs: limit write bios to a single ordered
> extent") we're almost always setting len_to_oe_boundary, so we might not
> need this commit moving forward.  But, there's a corner of a corner in h=
ere
> where we can still create a massive bio, so talking through it:
>
> submit_extent_page() adds pages into our bio, and the size of the bio
> ends up limited by:
>
> - Are we contiguous on disk?
> - Does bio_add_page() allow us to stuff more in?
> - is len_to_oe_boundary > 0?
>
> The len_to_oe_boundary math starts with U32_MAX, which isn't page or
> sector aligned, and subtracts from it until it hits zero.  In the
> non-ordered extent case, the last IO we submit before we hit zero is
> going to be unaligned, triggering BUGs and other sadness.
>
> This is hard to trigger because bio_add_page() isn't going to make a bio
> of U32_MAX size unless you give it a perfect set of pages and fully
> contiguous extents on disk.  We can hit it pretty reliably while making
> large swapfiles during provisioning because the machine is freshly
> booted, mostly idle, and the disk is freshly formatted.
>
> The code has been cleaned up and shifted around a few times, but this fl=
aw
> has been lurking since the counter was added.  I think Christoph's
> commit ended up exposing the bug, but it's pretty tricky to get bios
> big enough to prove if older kernels have the same problem.
>
> The fix used here is to skip doing math on len_to_oe_boundary unless
> we've changed it from the default U32_MAX value.  bio_add_page() is the
> real limited we want, and there's no reason to do extra math when Jens
> is doing it for us.
>
> Signed-off-by: Chris Mason <clm@fb.com>
> Fixes: 24e6c8082208 ("btrfs: simplify main loop in submit_extent_page")
> ---
>   fs/btrfs/extent_io.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6b40189a1a3e..bb2d2d405d04 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -849,7 +849,17 @@ static void submit_extent_page(struct btrfs_bio_ctr=
l *bio_ctrl,
>   		size -=3D len;
>   		pg_offset +=3D len;
>   		disk_bytenr +=3D len;
> -		bio_ctrl->len_to_oe_boundary -=3D len;
> +
> +		/*
> +		 * len_to_oe_boundary defaults to U32_MAX, which isn't page or
> +		 * sector aligned.  So, we don't really want to do math on
> +		 * len_to_oe_boundary unless it has been intentionally set by
> +		 * alloc_new_bio().  If we decrement here, we'll potentially
> +		 * end up sending down an unaligned bio once we get close to
> +		 * zero.
> +		 */
> +		if (bio_ctrl->len_to_oe_boundary !=3D U32_MAX)
> +			bio_ctrl->len_to_oe_boundary -=3D len;

Personally speaking, I think we'd better moving the ordered extent based
split (only for zoned devices) to btrfs bio layer.

HCH has already done the work to remove the stripe boundary checks to
btrfs bio layer, thus I believe we should also move the checks to the
same layer.
(Although unlike the stripe boundary, the OE boundary may need extra works=
).


Another concern is, how we could hit a bio which has a size larger than
U32_MAX?

The bio->bi_iter.size is only unsigned int, it should never exceed U32_MAX=
.

It would help a lot if you can provide a backtrace of such unaligned bio.

Thanks,
Qu
>
>   		/* Ordered extent boundary: move on to a new bio. */
>   		if (bio_ctrl->len_to_oe_boundary =3D=3D 0)

Return-Path: <linux-btrfs+bounces-15570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69380B0AE98
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059FB3BF59C
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3F23507E;
	Sat, 19 Jul 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4zvTaOA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F31D90C8
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913202; cv=none; b=AQzN5qaKPNm5FVJ2/9DFCQGA2njbAw5i0oq3oKJFV/CjQBy4UOxCxJgUyOu3EH9VLfH6rlFyUPP3Mj2nhRmG70DkIgidQaYIgRanw9DONGa5FCsAjhQYWbAzMxxVnAb0ThsfczN102vWcLOqUGmSbdUz2Y1KTXx3J2cFYfWOr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913202; c=relaxed/simple;
	bh=9dDZUPFm1CQ6DZOk2+qh7E854YAQN3YRC1ZpRIDdEbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pttbltqICPoVDSvZ72L5EZmDHgKI5K/29w8h2ujnyDqI1exFHzx7kW7VJ0EfWOjBMFkuqLxqxYuri6eFzAqT32g9iGwpa61FQsnvHR4QzhnLIWeyCzy3FhgVsWcPaasRFkyBN6lrn/O/uS0mgl2iOKVNOv0jjMq+llfPVfUvDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4zvTaOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472A1C4CEF6
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752913202;
	bh=9dDZUPFm1CQ6DZOk2+qh7E854YAQN3YRC1ZpRIDdEbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D4zvTaOALooVNQeB04SKuKPDouaR9uNwOcyXAp3zll/A2ZOzLpUkcv1OPz6+PyStv
	 kr59sfuAck48uvjXsLsJUWrknAgk+SFpkqUePWaR98B4fOxaJUgoX+WzzDkmnpQ3rX
	 EX/Ew4FjKYr1tOxlPHLBYYvU7t2gMtRNnhGfp4Bj6EvAuMvBZ3/xnCue1IxU7as+if
	 x1BqPfZPrHIdBmrq2x17S662TDsvukLpa2El8a4+EefsHDkq5W3f/2Ps5M9sOEyEl5
	 R6PNOsi1Dy6v5WuUM5l8H7bA7/qwK+mNk2S8qtEsxxwDo12+bocYswLU/qvtw8fl84
	 XRvDJO6UFGsPw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0e0271d82so511218166b.3
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 01:20:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXrB4ZByOjLkUYyBfDmJDti31MzJjCFYOViY6lQ1Edo0Gh3UTPLrnY/RZkjkxU0Z0yZYZp7CrQWc2m7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqL2Fy6nJMGmKAjDNVBlxLfTgMSzDKl2PCSHEAsvw/rWgdf3hf
	/uyA2dVHuq/bGx7c9WZIQT+O3GYERhUyuDMi6nXUHGWONlQUZNRvJHJcq+bwf02Qc2uAPq9yYmN
	S28xtF28GSbWBMMpddy0tWL8qmSNlzAs=
X-Google-Smtp-Source: AGHT+IGfzYTIPduagxq9MCKw3/krxdRQtVpDDZpdWYs1XJQKocd0G5c8BT5Ihr27IqICgwyiTfQNNkd73FHp9t+xnp8=
X-Received: by 2002:a17:907:6d0d:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-aec4fad6584mr892782266b.21.1752913200822; Sat, 19 Jul 2025
 01:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
 <45b28eee-c05a-4030-a4ac-a3543646be11@gmx.com> <CAFMvigc+GEc-Vim10Z_Z7n==EJ3i8qr8r8LeZSGHBxqbnZm_QA@mail.gmail.com>
 <83308a5d-5692-4b16-ab27-1a1459e74631@gmx.com>
In-Reply-To: <83308a5d-5692-4b16-ab27-1a1459e74631@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 19 Jul 2025 09:19:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7kiNsM0FnNLNUjopmiPsZQeZV_8tVQwHUvmYQvwqksRQ@mail.gmail.com>
X-Gm-Features: Ac12FXwzsqeuVLRAoEc2nlBg28ZMNg2qKHuUWHEt5W-l6FFK0tpf9Z82SkdCysw
Message-ID: <CAL3q7H7kiNsM0FnNLNUjopmiPsZQeZV_8tVQwHUvmYQvwqksRQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: use fallocate for hole punching with send
 stream v2
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Jonah Sabean <jonah@jse.io>, linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 12:00=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/7/19 08:20, Jonah Sabean =E5=86=99=E9=81=93:
> > How does this affect zoned mode? Isn't fallocated not supported?
>
> Zoned btrfs won't have fallocated extents, thus it won't generate a send
> stream with falloc.

That doesn't matter. This is about hole punching - you can punch holes
into a region that does not have fallocated extents.
But we can't use fallocate at all on zoned, be it for extent
allocation or hole punching.

>
> If you are trying to receive a send stream generate with falloc (aka,
> the stream is generated on a non-zoned btrfs) on a zoned btrfs, the
> receive will fail with error just as expected.

If we are sending from a zoned filesystem to a zoned filesystem we are
ok, but from a non-zoned filesystem to a zoned filesystem the
fallocate will fail with -EOPNOTSUPP.

Also I don't see why zoned filesystems can't support fallocate only
for hole punching - I understand why extent allocation with fallocate
is not supported, because of nodatacow for the first write, but I
don't think there's a reason to not support hole punching.
Adding Johannes and Aota in cc to answer that.


>
> >
> > On Fri, Jul 18, 2025 at 6:42=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/7/18 21:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> Currently holes are sent as writes full of zeroes, which results in
> >>> unnecessarily using disk space at the receiving end and increasing th=
e
> >>> stream size.
> >>>
> >>> In some cases we avoid sending writes of zeroes, like during a full
> >>> send operation where we just skip writes for holes.
> >>>
> >>> But for some cases we fill previous holes with writes of zeroes too, =
like
> >>> in this scenario:
> >>>
> >>> 1) We have a file with a hole in the range [2M, 3M), we snapshot the
> >>>      subvolume and do a full send. The range [2M, 3M) stays as a hole=
 at
> >>>      the receiver since we skip sending write commands full of zeroes=
;
> >>>
> >>> 2) We punch a hole for the range [3M, 4M) in our file, so that now it
> >>>      has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
> >>>      Now if we do an incremental send, we will send write commands fu=
ll
> >>>      of zeroes for the range [2M, 4M), removing the hole for [2M, 3M)=
 at
> >>>      the receiver.
> >>>
> >>> We could improve cases such as this last one by doing additional
> >>> comparisons of file extent items (or their absence) between the paren=
t
> >>> and send snapshots, but that's a lot of code to add plus additional C=
PU
> >>> and IO costs.
> >>>
> >>> Since the send stream v2 already has a fallocate command and btrfs-pr=
ogs
> >>> implements a callback to execute fallocate since the send stream v2
> >>> support was added to it, update the kernel to use fallocate for punch=
ing
> >>> holes for V2+ streams.
> >>>
> >>> Test coverage is provided by btrfs/284 which is a version of btrfs/00=
7
> >>> that exercises send stream v2 instead of v1, using fsstress with rand=
om
> >>> operations and fssum to verify file contents.
> >>>
> >>> Link: https://github.com/kdave/btrfs-progs/issues/1001
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Thanks,
> >> Qu
> >>
> >>> ---
> >>>    fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
> >>>    1 file changed, 33 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> >>> index 09822e766e41..7664025a5af4 100644
> >>> --- a/fs/btrfs/send.c
> >>> +++ b/fs/btrfs/send.c
> >>> @@ -4,6 +4,7 @@
> >>>     */
> >>>
> >>>    #include <linux/bsearch.h>
> >>> +#include <linux/falloc.h>
> >>>    #include <linux/fs.h>
> >>>    #include <linux/file.h>
> >>>    #include <linux/sort.h>
> >>> @@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx =
*sctx,
> >>>        return ret;
> >>>    }
> >>>
> >>> +static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offse=
t, u64 len)
> >>> +{
> >>> +     struct fs_path *path;
> >>> +     int ret;
> >>> +
> >>> +     path =3D get_cur_inode_path(sctx);
> >>> +     if (IS_ERR(path))
> >>> +             return PTR_ERR(path);
> >>> +
> >>> +     ret =3D begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>> +     TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
> >>> +     TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
> >>> +     TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> >>> +     TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
> >>> +
> >>> +     ret =3D send_cmd(sctx);
> >>> +
> >>> +tlv_put_failure:
> >>> +     return ret;
> >>> +}
> >>> +
> >>>    static int send_hole(struct send_ctx *sctx, u64 end)
> >>>    {
> >>>        struct fs_path *p =3D NULL;
> >>> @@ -5412,6 +5437,14 @@ static int send_hole(struct send_ctx *sctx, u6=
4 end)
> >>>        u64 offset =3D sctx->cur_inode_last_extent;
> >>>        int ret =3D 0;
> >>>
> >>> +     /*
> >>> +      * Starting with send stream v2 we have fallocate and can use i=
t to
> >>> +      * punch holes instead of sending writes full of zeroes.
> >>> +      */
> >>> +     if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
> >>> +             return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALL=
OC_FL_KEEP_SIZE,
> >>> +                                   offset, end - offset);
> >>> +
> >>>        /*
> >>>         * A hole that starts at EOF or beyond it. Since we do not yet=
 support
> >>>         * fallocate (for extent preallocation and hole punching), sen=
ding a
> >>
> >>
> >
>


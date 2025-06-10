Return-Path: <linux-btrfs+bounces-14581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0EAD33EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B451172C4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD43223DC6;
	Tue, 10 Jun 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVi2CRNq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E748633F
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552333; cv=none; b=TBI/JvbpOR3k8B0m2TzTi3u2m4HDUfJTBYRe2HwSIUKV9MnXBb9KKVCZhWS7GcMw24z5LtEn7AaIYMe9ZGsS8qWWiTJZj1f24mXoVvdcAqnUQF1MrAhbuWCVGWUjGN2QGt7kdPEIXQTw/NmOkxxlinEDARY+sWFL9Fhhh1ZdLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552333; c=relaxed/simple;
	bh=XQ8r3IWUS9gfy3W5B1xrQtXMMjyNyvkxgXjM2LtirS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZmFIBbJK6yKJNGYgH9HfgUyk3ieGIEwFIvg0srs0A9w4S5VzlsQn6ehC+bacC5INSy3zpzxiWICbmr0lnPvH0LtXnObSqagtS/E17cQfkIeKXjrt3XDBjRp0DNrFIKjbbUTV5jlqf97u1inHtj88yEUQ2yIUXioe9YPC1pIkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVi2CRNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DEC4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552333;
	bh=XQ8r3IWUS9gfy3W5B1xrQtXMMjyNyvkxgXjM2LtirS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AVi2CRNq7EYOhdTQPoZXkh1Hsnz/4IQvPYKtTQGtaOLti9gmghM2bhivjqiiu/deL
	 9nhm2u2Ag8c2iLhMkw7xbR9t9xqM00ZWH0KszAjtXvzgRVeflw+1XGVZojpp4xZlGC
	 Ft8PTNoWGsyDAec/jeSlB6zezHNJMG8N+cW5lXd+P0cf3GcMnVqknjpz/Ihx2M7MiP
	 qo9Lvk4rYAaTkmKuchX/TSS6mfa26+Hb9jdUm8VmLVaR7q1zNAVzsFUw/xOZZ9apeF
	 nIFHmz04N3lvS8/lF9XaVluRXq2KH2kXDazYKi3p5l4uhzjdktOF/t1pCC4sd1le/T
	 FT3DSZMmiEu4Q==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb2e9fd208so978458966b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 03:45:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXE6Lr3k9jTw8F9inwvHr/Y8lA/k5hbq432UNRYvLz9eCTl1FEpxCZu05/7vHnl9NsEMfHcj+MzmSWSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvCXf8YLDkihwpBlkW90Ung/ps26sMy/q1szOvIX85v1xqvLa
	/dno14G3KbvQV3taRXa8pVAMee9AMIONAeU4zY8H7Dz3cGk8dZeQMkypY8+A99fJ5mGhmw4eiIF
	rShS0aOvdf1BpGYw/SezGizXEz2I7jF8=
X-Google-Smtp-Source: AGHT+IGQ9PQEr3Z1iHA8YHRERo7G2JgUjrrIdxnwakIzIzPXTJC2qjLr3s+VNF9EDglkgUB72vfQ8F7Tk3JNy0DefNE=
X-Received: by 2002:a17:907:3d9e:b0:ad4:8ec1:8fcf with SMTP id
 a640c23a62f3a-ade1ab227b9mr1578416966b.46.1749552331708; Tue, 10 Jun 2025
 03:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
 <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
 <20250609185535.GA4037@twin.jikos.cz> <1fcb4fd5-a147-4614-a6c5-76857ee9503f@gmx.com>
In-Reply-To: <1fcb4fd5-a147-4614-a6c5-76857ee9503f@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Jun 2025 11:44:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4BBp-4TyW+agBwM-1-rkjW3-g78s59Fxs8A2EZZTaA7A@mail.gmail.com>
X-Gm-Features: AX0GCFv8_kGy4HGLipwFWzCy_kJbLFDLy4LKy-nwSg4NTAbvw019LTZ_LO0hGow
Message-ID: <CAL3q7H4BBp-4TyW+agBwM-1-rkjW3-g78s59Fxs8A2EZZTaA7A@mail.gmail.com>
Subject: Re: [PATCH RESEND] btrfs: add extra warning when qgroup is marked inconsistent
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:13=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/6/10 04:25, David Sterba =E5=86=99=E9=81=93:
> > On Mon, Jun 09, 2025 at 01:17:30PM +0100, Filipe Manana wrote:
> >> On Mon, Jun 9, 2025 at 12:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>>
> >>> Unlike qgroup rescan, which always shows whether it cleared the
> >>> inconsistent flag, we do not have a proper way to show if qgroup is
> >>> marked inconsistent.
> >>>
> >>> This was not a big deal before as there aren't that many locations th=
at
> >>> can mark qgroup  inconsistent.
> >>>
> >>> But with the introduction of drop_subtree_threshold, qgroup can be
> >>> marked inconsistent very frequently, especially for dropping large
> >>> subvolume.
> >>>
> >>> Although most user space tools relying on qgroup should do their own
> >>> checks and queue a rescan if needed, we have no idea when qgroup is
> >>> marked inconsistent, and will be much harder to debug.
> >>>
> >>> So this patch will add an extra warning (btrfs_warn_rl()) when the
> >>> qgroup flag is flipped into inconsistent for the first time.
> >>>
> >>> Combined with the existing qgroup rescan messages, it should provide
> >>> some clues for debugging.
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>> ---
> >>> Pure resent, I thought it was already merged but it's not the case.
> >>> It will be very helpful for debugging qgroup related problems caused =
by
> >>> qgroup being marked inconsistent.
> >>> ---
> >>>   fs/btrfs/qgroup.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> >>> index a1afc549c404..45f587bd9ce6 100644
> >>> --- a/fs/btrfs/qgroup.c
> >>> +++ b/fs/btrfs/qgroup.c
> >>> @@ -350,6 +350,8 @@ static void qgroup_mark_inconsistent(struct btrfs=
_fs_info *fs_info)
> >>>   {
> >>>          if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMP=
LE)
> >>>                  return;
> >>> +       if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONS=
ISTENT))
> >>> +               btrfs_warn_rl(fs_info, "qgroup marked inconsistent");
> >>
> >> About half the callers already log some message right before or right
> >> after calling this function.
> >> But this won't tell us much about why/where the qgroup was marked
> >> inconsistent for all the other callers.
> >>
> >> Perhaps we can pass a string to this function and include it in the
> >> warning message? And then remove the logging from all callers that do
> >> it.
> >> Additionally turning this into a macro, and then printing __FILE__ and
> >> __LINE__ too, would make it a lot more useful for debugging.
> >
> > If this is meant for debugging then the message level should be either
> > debug or info, but not warn. If it's for user information then the file
> > and line is not relevant.
> >
> > Otherwise agreed about printing the reason why it's marked inconsistent=
.
> >
>
> The message is to inform the end user that qgroup is marked
> inconsistent, which is a common thing.
>
> It's not for error paths, thus filename and line is not really needed.
>
> And for the reason, there are really one or two (except error cases):
>
> - We're dropping a high subtree
>    Either we queue the whole subtree for accounting, which is super slow
>    and can hang the current transaction.
>    Or we mark qgroup inconsistent and call it a day
>
> - We're doing snapshot where the source and destination have different
>    parent qgroup
>    The reason is pretty much the same as the above case.
>
> I can add the reason, but for most cases it will be the above two.
>
> In that case do we still really need such reason?

It's a lot more friendly to have such a message telling why and what
caused the inconsistent marking, both for users and for us analysing a
dmesg dump.

Those two cases may be the most common by far, but it's still good to
look at a log message and be able to distinguish between every
possible case.

Thanks.

>
> Thanks,
> Qu


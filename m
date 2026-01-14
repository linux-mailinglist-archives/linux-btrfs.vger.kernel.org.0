Return-Path: <linux-btrfs+bounces-20521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105CBD2083E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EBE8303E293
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766022F83A7;
	Wed, 14 Jan 2026 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5qw8Oh6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECDD2E1730
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411298; cv=none; b=JHvFhUf1kR7O9mGnKI2EBJJ5FafUtqtmCOn6C1Wi88iHoMuh/loPBBNLBW/HcJDAwi6vuOdAIlmSoiy1SQGx8sA94IyTNHOMXCu446J5qBbDktPkx+G5gQSVgpQE/CQkrJJc2FWmpaxIXMLGTY7fP90zFuqf5RAPedzZlrdnnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411298; c=relaxed/simple;
	bh=4gEX6Wfo34Pvtpk1xlDNFPxvpUaMSXm/OKPrK//1iYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACeExFPS9wQy8m6WenB3LVGES25gsDTCXgwpQm27unFhWKdtr1u9xLpSfwOwJQSaXVw2ZRLLUmymoS60PAjr0uR2oQXJ1TiR4XN+TgYqQtq3Z8DBQ37k+cd6FnpOnAimr4Z6au4h2oeFcyRD+zR0Js6FG5OO7diwMN6Xxw5TLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5qw8Oh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68EBC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768411297;
	bh=4gEX6Wfo34Pvtpk1xlDNFPxvpUaMSXm/OKPrK//1iYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H5qw8Oh6R/TgUuZoSo4lY9m1V/NRV6ZaTKP5NT+bJk3BIwHq3O7YkZi3dHixLGUGG
	 OZ2kq9pvlTbzaG/3SdLyry7d++oTYVxEcHin85vajqbDOGMX6aW0TK6+JbeiRr3KY8
	 P8kBlMaSfCa2U/QVS11OKvGsOA0KBS60p4IQaARyBZ4k8UmsHr1mIGsOtSp/WjaB5Q
	 LAjtGrz05KG596s9DcPUZde44EC/MUGZznx6Fo7HQeL4GCA7Rl8zZ6VNDqrlnkc5MH
	 1cNIvpumYTUqM0LN7w3Tfc1dXeiH3bbLgQrebR9/uzbpV5g1iIvdj86oMGfKxCrJXr
	 5nihdtvZn+ghg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b872f1c31f1so15061166b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 09:21:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6OZaH+NB2vXPp3q7bqgX0vxsVHhuCr+AwrlqxqqIN7znzKLTBwBhVWvxRy7i1SPHuHtUL/feF6YJY0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGzrwPgwgRqx5x4dNdvK7zMTDBW7EeuX1/9SqeMB5hbSG5+mW
	N9HMFhi4CGd1MjYWv4DGRNNngAhMVTe730EuYl20X6vSeFSIwfMHRhbxtJBu6dMD0bNrBp9nepd
	DyDrkYhcrnNlFkaSXEHvNk7O+/R5ISjw=
X-Received: by 2002:a17:907:7851:b0:b87:3396:d152 with SMTP id
 a640c23a62f3a-b8760fe0f65mr216710166b.15.1768411296352; Wed, 14 Jan 2026
 09:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114170701.6018-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260114170701.6018-1-jiashengjiangcool@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 Jan 2026 17:20:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4rLMtmWTe4jHrYMnUbOkJb_5rMUfB8YUNhJ=JXnJp5AQ@mail.gmail.com>
X-Gm-Features: AZwV_QgOj6c3Rl0hYMpWnR1Yk4rrdCxKhkUHe-GvR0RayLUwJtJ1hLQcMV0h0Ls
Message-ID: <CAL3q7H4rLMtmWTe4jHrYMnUbOkJb_5rMUfB8YUNhJ=JXnJp5AQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fail priority tickets in maybe_fail_all_tickets
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:07=E2=80=AFPM Jiasheng Jiang
<jiashengjiangcool@gmail.com> wrote:
>
> Differential analysis reveals that while btrfs_try_granting_tickets

Let's pause for a second.
This is yet another patch where you mention this "differential analysis".
Please try to understand the code instead of comparing parts of the
code and assuming any differences mean a bug or that we need to do
something.

> correctly iterates over both space_info->priority_tickets and
> space_info->tickets, the maybe_fail_all_tickets function only processes
> space_info->tickets.

Yes, and there's a reason for that.

>
> In scenarios where the filesystem is aborted (BTRFS_FS_ERROR), we rely
> on maybe_fail_all_tickets() to wake up all tasks waiting on reservations
> and notify them of the error. Because priority tickets are currently
> ignored, tasks waiting on them (typically high-priority flush workers)
> will not be woken up, leading to permanent tasks hangs.

Wrong.
We never wait on a ticket's waitqueue when it's a priority ticket...
That's why maybe_fail_all_tickets() ignores the priority tickets list.

Doing this "differential analysis" without understanding all the code
and how different parts interact, and without hitting the bug or
seeing someone reporting such a hang, is just a waste of time.

>
> Fix this inconsistency by updating maybe_fail_all_tickets() to iterate
> over both priority_tickets and tickets lists, ensuring all waiting tasks
> are properly errored out during a filesystem abort.
>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  fs/btrfs/space-info.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..09c76df8dbc8 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1120,6 +1120,7 @@ static bool maybe_fail_all_tickets(struct btrfs_spa=
ce_info *space_info)
>         struct reserve_ticket *ticket;
>         u64 tickets_id =3D space_info->tickets_id;
>         const int abort_error =3D BTRFS_FS_ERROR(fs_info);
> +       struct list_head *head =3D &space_info->priority_tickets;
>
>         trace_btrfs_fail_all_tickets(fs_info, space_info);
>
> @@ -1128,10 +1129,9 @@ static bool maybe_fail_all_tickets(struct btrfs_sp=
ace_info *space_info)
>                 __btrfs_dump_space_info(space_info);
>         }
>
> -       while (!list_empty(&space_info->tickets) &&
> -              tickets_id =3D=3D space_info->tickets_id) {
> -               ticket =3D list_first_entry(&space_info->tickets,
> -                                         struct reserve_ticket, list);
> +again:
> +       while (!list_empty(head) && tickets_id =3D=3D space_info->tickets=
_id) {
> +               ticket =3D list_first_entry(head, struct reserve_ticket, =
list);
>                 if (unlikely(abort_error)) {
>                         remove_ticket(space_info, ticket, abort_error);
>                 } else {
> @@ -1153,6 +1153,12 @@ static bool maybe_fail_all_tickets(struct btrfs_sp=
ace_info *space_info)
>                         btrfs_try_granting_tickets(space_info);
>                 }
>         }
> +
> +       if (head =3D=3D &space_info->priority_tickets) {
> +               head =3D &space_info->tickets;
> +               goto again;
> +       }
> +
>         return (tickets_id !=3D space_info->tickets_id);
>  }
>
> --
> 2.25.1
>
>


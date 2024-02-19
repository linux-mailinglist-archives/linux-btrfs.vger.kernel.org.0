Return-Path: <linux-btrfs+bounces-2505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A885A30F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C7A1F2527B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971902D638;
	Mon, 19 Feb 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHAo2b7V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56F2D05D
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345202; cv=none; b=UmpW/8gUh8mkeB+ARj2aDrSXis8uTTpGRgyrS++rYfm/KY2ydpgpGzwc3C7HI/fu1AIe82xQbOmThxycIZdu0Ib67kpl4au93vrs0Rul34nJHa+LQf8q+hdB4brW2is1sr5K97hVLdO+MY+eSFmrpa7GQXcuPS3pxB7Vn8pLDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345202; c=relaxed/simple;
	bh=noVq4bc7dnRPWFIIfMG4cgZiOJV/t9EJeRTr1qC+Nbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7J+EucuE/JnBJcArbxOjAqR/dmUarIsxAtVR5SuBAmWaFQjYh7BQbyg1kglWpBMyGImspvDTi0Hytbaw3KogiK+EPIK9UPwUQbWkymSH5PdCzEQUIXDm+HXMyfcD5cN063wkwlSEas7u2Li9Niiyru4g6WkeO6nYJvmLsAk+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHAo2b7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27686C433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345202;
	bh=noVq4bc7dnRPWFIIfMG4cgZiOJV/t9EJeRTr1qC+Nbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HHAo2b7VogCcf0COARLEVg4mNIY4ysGFuQgZ1QTvLTTq1sWBKCIuOrLrpnNJOOjSW
	 /1iYPh/FnCnAYih6p1wHHo1zBvEl1iJShDGWPxxhVkVfbhJilsziX0YtHxTfHClo6N
	 1IsCTohLBZc47TMXb9ydjjdCAu1Sju0cXO5lJQxq+4YQYsJSoaeWfv2gvS6R0a46lB
	 CDTcB6HZX+mh2BDWs/hzdtK3rLh1zmd0wGP1MRRjk5Qp7VGF4HsiwwYHfJiJkFW6x2
	 tUrkz7N2PFH8ce7KwDYESEoY29EY66X7YqZ3P+TgZzB1PbjzH/YyjGTGXQeNRoYcja
	 CzKdKnoeljpeQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso729031766b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 04:20:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwGRR+GvCQjp7VsB9dtGQ8+uFH69rcXGcoqEMayFqEnUendjkeq
	Ds6VxavKGBAks7tTjvUWvRJeOs8cRhAk0eGz8dLTk/3rx/w7iUut5x9osVwWZoDG4c8fl1DHxmp
	7228wBj3pghJU6UGJvn3ewBSOIaE=
X-Google-Smtp-Source: AGHT+IHl98tbu2NTQtVjdrbTar6SlFMWQkxRFJZnqh/DlELlwxeLqn/RIPVAT2cvIG3xsGxeaL0YUwI19m/dARcN01A=
X-Received: by 2002:a17:906:d968:b0:a3e:c2aa:adfd with SMTP id
 rp8-20020a170906d96800b00a3ec2aaadfdmr1069074ejb.23.1708345200461; Mon, 19
 Feb 2024 04:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me> <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
 <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me> <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
 <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com>
 <762c0677-56d9-4a02-bfc2-581b9f3309c9@inix.me> <CAL3q7H7-iO_CqR5PPaqTM2GdpsNtV2-EeSU=mxOwE2++Ggg1EA@mail.gmail.com>
 <e1ca1af6-7222-4f33-870b-a5e1acea2315@inix.me>
In-Reply-To: <e1ca1af6-7222-4f33-870b-a5e1acea2315@inix.me>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 Feb 2024 12:19:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6VL3O9J3Xu62x=UoknoNB9mZE+3GBDPiuja5OPtyPCZQ@mail.gmail.com>
Message-ID: <CAL3q7H6VL3O9J3Xu62x=UoknoNB9mZE+3GBDPiuja5OPtyPCZQ@mail.gmail.com>
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
To: Dorai Ashok S A <dash.btrfs@inix.me>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:34=E2=80=AFPM Dorai Ashok S A <dash.btrfs@inix.m=
e> wrote:
>
>  >> One surprise is, for any change to the disk file, such as I could jus=
t
>  >> do `touch thin-disk` and it will still be a large send stream.
>  >>
> ..snip..
>  >>
>  >> # btrfs send -p 5.s 6.s | wc -c | numfmt --to=3Diec
>  >> At subvol 6.s
>  >> 2.4G
>  >>
>  >> Is this expected?
>  >
>  > There are a few cases where we send the writes with zeroes where it's
>  > actually not needed.
>  > I just noticed an hour ago about one such case triggered by that use
> case.
>  >
>  > So that can be improved, I'll send a patch for that on monday and let
> you know.
>
> Sounds good. Thanks.

For this particular case, here's the patch:

https://lore.kernel.org/linux-btrfs/2888e22ef71003ad9dff455c7f4fb990b807754=
8.1708260967.git.fdmanana@suse.com/


>
>  >> If we could support send/receive holes, it will be useful for
>  >> incremental backup of disk images.
>  >
>  > Yes indeed. That however requires a change to the protocol to support
>  > a new command (hole punching), and changing the kernel and
>  > btrfs-progs' receive implementation, not something that can be easily
>  > and quickly done, but has been on hold for years.
>  >
>
> Makes sense. Thanks for clarifying.
>
> Regards,
> -Ashok.
>


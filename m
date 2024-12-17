Return-Path: <linux-btrfs+bounces-10482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11C9F4E2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE69188AAFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137621F63DD;
	Tue, 17 Dec 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAxzXbrZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F671F5408
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446800; cv=none; b=irC6FA6bkXjQkAnbNSIjpsw2qWtj/GJmAspBRSS59sdBk9Qej3/hGk78LggwszN9od/CTvPnW4otMMHYg92MaACD/ye3P+z8LMvHFFlPUsAfhg/ww1AEMW8ZeKuUGk/Eh3H+F1ghOWCyaVJb/mhEUGh1vT6bnbLJ10ycan4TjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446800; c=relaxed/simple;
	bh=Jq0q3cRyUzN2NJOeYMhscbwkKrSx1B3raQSgNrKxX+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLcajopeMQWBt7dzl/Qf9iKJszdwXpMzOhOIXsgb9AhEyC8f7Q3KPW7ubIqKXWwrj4anVcL/ozHA5WFXxiC7yD5vE+pNYfGwPyTAFzZz4IUs2AD+2Ycoqhw8WrNqm+//tedeLI2VhSQdQbaL7Ph4TKTiaNDhY+656f2aNrM9rDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAxzXbrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F7C4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446799;
	bh=Jq0q3cRyUzN2NJOeYMhscbwkKrSx1B3raQSgNrKxX+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fAxzXbrZwEgVIGgcpLvWCJYvbmMqvdIMde4wH+3XmtJ3vV+3rj7jYZNIRUl4htlXL
	 IazQs14NQgxo8dEkHRR5kEJ2QQoMLyLzDw6IPDZQknLzMGtbyB30vg47joDFd/y4eu
	 0feTCNzqLEgOJuzW4JecItjN80GaVOZztn+X+SDLLIUyUnqwILfEwTrEa9jyfYWs6U
	 czUngqerE4j1DyQsBo87QXh8xz98mWo0cnRarYpsiFiAlIEy8Ge9yG1aCZAWVJw6oW
	 e6kgjnan3h9bgH+y8v9h+GZbIYlOwbIDyPs5jrI1asgLmwKM5rqPiFsbU5ZIc/3nHa
	 MQsDpoavpSjSA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so724355866b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 06:46:39 -0800 (PST)
X-Gm-Message-State: AOJu0Yw9ONfBtYO3jJmXcsNNwpMIkiv0wtxhvVSWJbQ4lBwpWaP+BrPv
	sx3KOx9h5UFT8FkRlukRO6GRGM4vpOHXDHRKJMmz+XoplAB1GDZHHm9QI00jr0Iit0V+BmudtOw
	DepIeorZ+p7WAhT/GCfwGkMxDQBI=
X-Google-Smtp-Source: AGHT+IG5uklFL9frax+7LJlkwYZ3YoGFZ18Y65PDv5Lm0QcPC5/ZTUzyVLb/e8m6m8EkG3Irscmv+sDTXA1628Ez4dA=
X-Received: by 2002:a05:6402:5415:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5d63c3dbc28mr37671668a12.23.1734446798262; Tue, 17 Dec 2024
 06:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <83cba5c8af717d24462ff9d9490dd0849d604f64.1733989299.git.jth@kernel.org>
In-Reply-To: <83cba5c8af717d24462ff9d9490dd0849d604f64.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 14:46:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H54A+x2tKS7un31sLxAVx4dunkpdDtUYFE4183ofD07vA@mail.gmail.com>
Message-ID: <CAL3q7H54A+x2tKS7un31sLxAVx4dunkpdDtUYFE4183ofD07vA@mail.gmail.com>
Subject: Re: [PATCH 02/14] btrfs: assert RAID stripe-extent length is always
 greater than 0
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:56=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When modifying a RAID stripe-extent, ASSERT() that the length of the new
> RAID stripe-extent is always greater than 0.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/raid-stripe-tree.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 2c4ee5a9449a..d341fc2a8a4f 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -28,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct b=
trfs_trans_handle *trans,
>                 .offset =3D newlen,
>         };
>
> +       ASSERT(newlen > 0);
>         ASSERT(oldkey->type =3D=3D BTRFS_RAID_STRIPE_KEY);
>
>         leaf =3D path->nodes[0];
> --
> 2.43.0
>
>


Return-Path: <linux-btrfs+bounces-3137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B50876C83
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 22:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E631F21F16
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 21:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C45FB8D;
	Fri,  8 Mar 2024 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhtJ97Xd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA250A80
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934880; cv=none; b=K2dYfSdRYn5vsnxUgnH/C7rKgszxMj8hnG2EKz64T75nkTFMLHhPK3XryjZ/wgrm5b+yOGz/SaChTOE+YzFYwapcuHrnjcmcvWuUFhAIlzu7nIR6cs8jHKPoThKksi/eatz9fKmDq2y9yBG5xN7IHaFzsmI/zGFYSIfQ9+7VE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934880; c=relaxed/simple;
	bh=xT6y9c11YlwtcZtwKx6r82QxCE8Gox4JXnvszSPyeS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ac6bY0pbxD+zJKxtPagPSfhpirYnn5/2v+SULiVcD4g64VkfYCe1sdDRfooRZCGmd2U7sumQ7a5Eti8ZBXlCWmMSQxCom6iVwHnkG5yvh5KJFNGcqwx+NGzyIvjkE5HNzIqhAlUB6fztsPRVxjO0UcwRhtrY1YncPx/75OrXSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhtJ97Xd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so36525741fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709934877; x=1710539677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT6y9c11YlwtcZtwKx6r82QxCE8Gox4JXnvszSPyeS4=;
        b=HhtJ97XdGTEBW9/79JZUaxh7/XToTdg8H1Pn7JYnbHkr75lzPpvTbenzAE+xZmWwrJ
         fYVZV6RoFvOGRgBtssXu5yx7u2x10KwXdL6ltDXhEUmwOB1vQVm/gosDc1+uSDO8P1Km
         wUQMLGnq6oPkfpBGDK63mnO+gI/cgjrUkYpS6woFtEy8zxWB81bCAJvXwZuNcihLffVl
         gijb2d/SAWGUkHezlSMP6z3Rk4+8dQhbdwO1hxdvK8ovCtIBkSEjNzU1FoF/1prp8pvP
         G+XehFSdz1/uzAmr+1VGYWmSLHxuT3EE2lq8w0KWJVbiZA7G7c5Gjuem3aopXsjb37h9
         Gitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709934877; x=1710539677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT6y9c11YlwtcZtwKx6r82QxCE8Gox4JXnvszSPyeS4=;
        b=m20Pye90YYHKUrT/H2pyMkPXi6nzBIrnT+EeddhxoU35ad+Hr+s8tXWYxYqbr/sZdm
         sEjCbzEpXYUI8GoZqwNKM0iSwqSZerKIqtx4pbVgzaFJHkr/nKx5Wrdfbqw7INIpZBWF
         wcFce8UURZ3aY5SEoRQ0jFBGuXmawU3bXQSMdvwVPO62BVJdiGqpQkZTzN8TMJUxNWRn
         mR18lQ8AUXEJMXFqRg8hTEspFCYq5rhZrbDsFjRGvlEObe2gqVVY6tCZRM68u+Ga67bt
         lyVj7otOOxLe7T+FrMasZZbAdqtjm2PfAIKkZyf7PTU/txfOHYTu/sWDvxY52FK3RlTI
         /5JA==
X-Gm-Message-State: AOJu0YwmKp8C1e4ztICHZklCXZxe1oEObhO+zCrfpCQlnVNnuSZUUd7Y
	Xs9qqTmKM8gBBzSfKBpg84vKSmg5TlaXk6EFDrwcUG2v389i5zxu9W6jMcwsHfVzP5XBDQ/qmch
	m5vL9vUrSaBtWmg7cwNPYvBrVWlnBu/afGpAM8A==
X-Google-Smtp-Source: AGHT+IGLxMIxnsDshUIS2E8UO9tZlt9gFDLBJxwfdjdjzPk7kKSOnJ1zFc6CtXm4v4iL7RUKSo9jOq6LzWUavPmTTwk=
X-Received: by 2002:a2e:9844:0:b0:2d3:13ea:2214 with SMTP id
 e4-20020a2e9844000000b002d313ea2214mr290553ljj.21.1709934876415; Fri, 08 Mar
 2024 13:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com> <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
In-Reply-To: <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
From: Matthew Warren <matthewwarren101010@gmail.com>
Date: Fri, 8 Mar 2024 16:54:25 -0500
Message-ID: <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 4:48=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.edu>=
 wrote:
>
> Hi Qu and Matthew,
>
> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matthew Warren
> <matthewwarren101010@gmail.com> wrote:
> >
> > On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.=
edu> wrote:
> > >
> > > Greetings,
> > >
> > > I've read some conflicting info online about the best way to have a
> > > raid1 btrfs root device.
> > >
> > > I've got two disks, with identical partitioning and I tried the
> > > following scenario (call it scenario 1):
> > >
> > > partition 1: EFI
> > > partition 2: btrfs RAID1 (/)
> > >
> > > There are some docs that claim that the above is possible...
> >
> > This is definitely possible. I use it on both my server and desktop wit=
h GRUB.
>
> Are there any docs you follow for this setup?
>
> Thanks for the info!
>
> -m

The main important thing is that mdadm has several metadata versions.
Versions 0.9 and 1.0 store the metadata at the end of the partition
which allows UEFI to think the filesystem is EFI rather than mdadm
raid.
https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-versions=
_of_the_version-1_superblock

I followed the arch wiki for setting it up, so here's what I followed.
https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_software_RAID1

Matthew Warren


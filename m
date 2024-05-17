Return-Path: <linux-btrfs+bounces-5077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711948C8A61
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A219D1C208CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEEE13D8B0;
	Fri, 17 May 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3Du8hWR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1A13D888
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964923; cv=none; b=NVVUPN4o0wmM2ki92KpwJym4zcDjDS4pEVScm8y/xxQLBwAOj8EMrTpsfbJgiW3cPNxP7ELesDh4CayQ8KICwYLqtwEmPsFJsqZ9oAwPX9KiUx8z3INr0waihzqomeJSd8P0jLANiOKFj856Eye/ehQmjRA/RrVH2ARaQEpVAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964923; c=relaxed/simple;
	bh=/Woq4x3iShveBG5I3XnQFkikS15oN02vrdObi6hmow8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvGdDwGj8qoj+KBjev5CkxTLU4G942axqTQ2qCbAtd3BtkoV492ByevRjAgu2WX6sNWkZLoBI+t3F3XZlPPSmtINJNOV48T1UTtLjqFuiXReasv58fJ7+jIL+hZukzG1aoNwtafPwjodS4hq1R5TTkVdHBV/dlkU/2PlqA4MGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3Du8hWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D75C2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715964922;
	bh=/Woq4x3iShveBG5I3XnQFkikS15oN02vrdObi6hmow8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f3Du8hWRQ3kqWD+ZJYpMs+EYJ4fbMKjHWc8BxbSdsfgsq4voB/CHvb4OMZT8FB4kz
	 VXlNA2h4UuxSgbsQ8EsI9a/IZQZHk0Y5ImCqxld9r7vRxMgXufX73hPMKGRuvuXdRY
	 GGJPKkojpprC5CmmIyKXx54K6ra3YiQWiguv0Q5TOchFPnZoZS70ow37A2a4skbcCx
	 nosQ7HCNew35TElq7s5SLGp49y54/NmFSBsOjnbdtgmP4o5/61MnskyEzXtH0wsba+
	 7Gjz2r7prJklYDfNKo1vHLXZsvv0mRighJW7j8U4j1e6P6GAGyfBQzVMHefKI1GmIr
	 zg+68M3nEG5zw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5210684cee6so1131237e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 09:55:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwVxRKtVfAjtJmAipP+ANMXOnQBjmrZtTVD1TR66DoOxWasy7ne
	dUd+njiJLTsVYlORg+A5vi1wtrc1Hg7UH0cBtJqTGoGxOTMXKgAi07EjaMEDr6pUIu+ot+mcx/H
	RmzunLXA+iuD5KnB9HyiQ4UcIPPU=
X-Google-Smtp-Source: AGHT+IF5Q3XGgwfZYdPEFcRRzVvQI7bHTg1wesmShFrnRElWwXyXKr0zAtLBNrRkz/BzkjFvHE45AbjlrBGMJvGd3fU=
X-Received: by 2002:a05:6512:ac9:b0:51d:a78e:9036 with SMTP id
 2adb3069b0e04-522100691e3mr16580088e87.69.1715964920773; Fri, 17 May 2024
 09:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715798440.git.fdmanana@suse.com> <20240517162854.GE17126@twin.jikos.cz>
In-Reply-To: <20240517162854.GE17126@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 17 May 2024 17:54:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4zmyxwdXTEz5iWHxC+RSZQng+8TtazbdvYj9odbq2vcg@mail.gmail.com>
Message-ID: <CAL3q7H4zmyxwdXTEz5iWHxC+RSZQng+8TtazbdvYj9odbq2vcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] btrfs: fix a bug in the direct IO write path for
 COW writes
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 5:29=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, May 15, 2024 at 07:51:45PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Fix a bug in an error path for direct IO writes in COW mode, which can =
make
> > a subsequent fsync log invalid extent items (pointing to unwritten data=
).
> > The second patch is just a cleanup. Details in the change logs.
> >
> > V2: Rework solution since other error paths caused the same problem, ma=
ke
> >     it more generic.
> >     Added more details to change log and comment about what's going on,
> >     and why reads aren't affected.
> >
> > Filipe Manana (2):
> >   btrfs: immediately drop extent maps after failed COW write
> >   btrfs: make btrfs_finish_ordered_extent() return void
>
> For the record, patches have been removed from for-next as the new code
> does NOFS allocation in irq context (reproduced by btrfs/146 and
> btrfs/160).

Superseded by:
https://lore.kernel.org/linux-btrfs/cover.1715964570.git.fdmanana@suse.com/

>


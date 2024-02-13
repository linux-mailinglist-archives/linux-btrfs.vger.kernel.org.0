Return-Path: <linux-btrfs+bounces-2349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557BF852FCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 12:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0389B1F23D6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDA381A1;
	Tue, 13 Feb 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpjIqqwE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8B1B273
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824879; cv=none; b=hXe8HFWuWrwmEln+1PoWI/RGFwe5UhB4h1mzp5Ex4Ue7dhF9VSLrJKQ9W4GIp3D94W+aPWyuL8fIvKmnApJbQZBXOib7O7EfGRFkvytSFsdD3dkQA13Yz4iZQzm8BmN0sMXreYZ8ZF3djKlE9hR3bYBpqfdAuPzxitfuRnDonjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824879; c=relaxed/simple;
	bh=aWfDvqtITwEvQwNaQ8yZhm5ZubjGch/pTJJ6kpb4Tqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml412x6kiJOUuPi82ArB7f1AC7DzzLj6+Olmh+keX4SLu+0PMcM7B7SKIf66Xo2qK01yFsrHsDjtjxMrn1pc1ExO4HOMdCKtj4L3K9x+jmWasbgKbPDF25q4f/hv/DveCmcf2c/eOjd/mjKf2212FzmBOQrk3MlQtgaoYzXrjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpjIqqwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483EBC433F1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707824879;
	bh=aWfDvqtITwEvQwNaQ8yZhm5ZubjGch/pTJJ6kpb4Tqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MpjIqqwEubAT22S219avyIc04HMI4L+0Tbdmvc1m8DfFJDkgr1s/Ie6uy1OwJ9kd1
	 qNXgslVpYzBgNV1tF8LGXR0oSDwB0B8U89znbcu3WnMpaQlQRt5Y+9wUf2T3yfvTnm
	 CqS/RExY2Vt/tTaeXxbSEc7VzVIER58EeB96IVHm6xP96iLEALjs96NKp4yrGHPXE/
	 /hjXLZ6AO9h+qc7DExznVOosnOs/+PZiNCN9canwSeATWT75NwEeUWigMcS0Vd8ri7
	 jjaIQ6Gv78RzzPhn5gbQ6/osVZe9B/rdl9lmrzFMby6v7ZE1UukUo6t7lZvQZE1Q6V
	 0MWdtjK3SlTgg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a389ea940f1so472836566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 03:47:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yx+fXrdBIvhOIvB19cqEFUGeYs15oimymLMwAY65J2DYnwZMO0z
	RjpGJNzHwzBflFZ9E7Z3TRtYqmo6b5yop+qoDsPMx+uoLYZxRuJCEwezkz/PHu9ear74V59kxn7
	NF+zoYJubSP6ckzBSEiYXncKs7LY=
X-Google-Smtp-Source: AGHT+IH9UJEzYh4qGh/l7ZiWiYDgZ49XJh45D7gDTEXGq0bdgbHdK476dG4so9wGz898CB7lid8hwCbx0g44LgJhZHs=
X-Received: by 2002:a17:906:5789:b0:a3d:2124:c846 with SMTP id
 k9-20020a170906578900b00a3d2124c846mr94298ejq.13.1707824877704; Tue, 13 Feb
 2024 03:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE93xANEby6RezOD=zcofENYZOT-wpYygJyauyUAZkLv6XVFOA@mail.gmail.com>
In-Reply-To: <CAE93xANEby6RezOD=zcofENYZOT-wpYygJyauyUAZkLv6XVFOA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 13 Feb 2024 11:47:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7W+QQE8bc9VqgXZe071NxvESBtq+D0S3+XUZdmQ5NKnA@mail.gmail.com>
Message-ID: <CAL3q7H7W+QQE8bc9VqgXZe071NxvESBtq+D0S3+XUZdmQ5NKnA@mail.gmail.com>
Subject: Re: The issue of excessively large metadata allocation in Linux 6.7
 cannot be mitigated through btrfs balance.
To: Heddxh <g311571057@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:05=E2=80=AFAM Heddxh <g311571057@gmail.com> wrote=
:
>
> uname -a
> Linux myArchLinux 6.7.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Mon, 05 Feb
> 2024 22:07:49 +0000 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v6.7
>
> btrfs fi show
> Label: 'myArch'  uuid: 532916ce-b32c-4009-a0e6-93e73363d7e7
>         Total devices 1 FS bytes used 334.12GiB
>         devid    1 size 452.16GiB used 452.16GiB path /dev/nvme0n1p3
>
> btrfs fi df /
> Data, single: total=3D419.08GiB, used=3D331.38GiB
> System, DUP: total=3D32.00MiB, used=3D80.00KiB
> Metadata, DUP: total=3D16.51GiB, used=3D2.73GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> Above is after rebooting and before balance. Then I do btrfs balance
> start -musage=3D50 /, I got:
> Done, had to relocate 27 out of 453 chunks
> btrfs fi df /
> Data, single: total=3D419.08GiB, used=3D331.39GiB
> System, DUP: total=3D32.00MiB, used=3D80.00KiB
> Metadata, DUP: total=3D15.51GiB, used=3D2.73GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> My dmesg log is attached. Thanks for reading my report.

It's a known issue, reported before.
There's a fix posted for this over a week ago, but it's not yet in
stable 6.7 nor in Linus' tree:

https://lore.kernel.org/linux-btrfs/eba624e8cef9a1e84c9e1ba0c8f32347aa487e6=
3.1706892030.git.fdmanana@suse.com/

Thanks for the report.


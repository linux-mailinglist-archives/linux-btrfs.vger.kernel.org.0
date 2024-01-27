Return-Path: <linux-btrfs+bounces-1849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD783EF5C
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 19:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4651E283EA6
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935B2D61B;
	Sat, 27 Jan 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7yjMtXl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6728DD6;
	Sat, 27 Jan 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378614; cv=none; b=Od+Q8cKtPMOdKvtU6Hl2NXkwJbGD4isXiG2GXc/Fk+WgC1ip9/AmV25oeHYnHQ4JOBneGTo8ItXSxc1aToCD8LXGaUotPABXSvi9olIL4QidbXnmC3KvGXdEEFQ7WOrzsVm1sZNacmS1lsU0tY19U8PMUI5T5ank1s8fdrL5eVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378614; c=relaxed/simple;
	bh=4BAhjgv8eYf8HMbu/yGz+UQoqAiYyZwPlxNc7K/j9CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvhtX/DCh9tnVcTtOhCiQL/57fWBP/HAowMdvxeZAewSIkRXt5SN03RiLEO1ot+BxjEIgu4hwzmRqaq6ylmAXaAHvR07ZReI76aMfEdsUZFAMdS9Jwfg9q39Sm0hx/79CaiL5OFqS+Zn+Nwr5RKqiNeWlswLfXAx4L+iSO+lO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7yjMtXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE96C43394;
	Sat, 27 Jan 2024 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706378614;
	bh=4BAhjgv8eYf8HMbu/yGz+UQoqAiYyZwPlxNc7K/j9CI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E7yjMtXlD2IisAHSu0xHniQCD7qKD9+OMJAumxtqPzsDFTCImCW1soTo4+3tKowrZ
	 GKDonMkWPZo6TwcMJcOXYIAEIhiKmGbvgEEAHnFeyJaG5/Hy0UV+zgnNZ7z3kj+USq
	 dNC098Bcd24yxyu8aRpNi9zuQJAL551MYyN1NkDM+/my7SBpmxGtW6fQoZBLG6Spj9
	 IRdCEnT7CPbbS65vN1vSg0jihn6jvI5D26ruEKFvTowArBdVk4E5MQmp/Tk/ZQDX6x
	 LNlPla1uBMMqTb/cCcxQGgBZZuBBlSJTFfyRfKRN4yjUAeR1ywRCsOMbYddzWRwIf9
	 zv9l37qd1leqg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510322d5275so542729e87.1;
        Sat, 27 Jan 2024 10:03:33 -0800 (PST)
X-Gm-Message-State: AOJu0YzpUZHEUQUQORwd9HcXRmralhXNXA0cL5E3oLOpVIPvThlXlkMp
	R1A5aRllFUS9KrTAiQ1K+f7kVNBoIGbtytHeq2hxwoiMgQTDBuzauNRnI3sJMR4KnqWhb9ZhMvU
	phQ1KzzthAZY7BbIneZTyO53kDzo=
X-Google-Smtp-Source: AGHT+IGtUegp3Ss5mFNwTEAP2MtT0lqrwV1Zz3m5BszlTol023Ab/krigw9gq2VYSl3Dm/q3WJkg9w+IZDCJ7n5WbvI=
X-Received: by 2002:ac2:46e9:0:b0:510:25be:d7ae with SMTP id
 q9-20020ac246e9000000b0051025bed7aemr1679970lfo.55.1706378612244; Sat, 27 Jan
 2024 10:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706183427.git.fdmanana@suse.com> <20240126185534.GA2668448@lxhi-087>
In-Reply-To: <20240126185534.GA2668448@lxhi-087>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 27 Jan 2024 18:02:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5obj92hJ3qc8qUw_9aiMAwiF+RMZhu0M4dGT+hhp6Qsg@mail.gmail.com>
Message-ID: <CAL3q7H5obj92hJ3qc8qUw_9aiMAwiF+RMZhu0M4dGT+hhp6Qsg@mail.gmail.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: linux-btrfs@vger.kernel.org, Maksim.Paimushkin@se.bosch.com, 
	Matthias.Thomae@de.bosch.com, Sebastian.Unger@bosch.com, 
	Dirk.Behme@de.bosch.com, Eugeniu.Rosca@bosch.com, wqu@suse.com, 
	dsterba@suse.com, stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:55=E2=80=AFPM Eugeniu Rosca <erosca@de.adit-jv.co=
m> wrote:
>
> Hello Filipe,
>
> Thanks for your participation/support.
>
> On Thu, Jan 25, 2024 at 11:59:34AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Here follows the backport of some directory related fixes for the stabl=
e
> > 5.15 tree. I tested these on top of 5.15.147.
> >
> > These were recently requested at:
> >
> >    https:// lore.kernel.org/linux-btrfs/20240124225522.GA2614102@lxhi-0=
87/
> >
> > Filipe Manana (4):
> >   btrfs: fix infinite directory reads
> >   btrfs: set last dir index to the current last index when opening dir
> >   btrfs: refresh dir last index during a rewinddir(3) call
> >   btrfs: fix race between reading a directory and adding entries to it
> >
> >  fs/btrfs/ctree.h         |   1 +
> >  fs/btrfs/delayed-inode.c |   5 +-
> >  fs/btrfs/delayed-inode.h |   1 +
> >  fs/btrfs/inode.c         | 150 +++++++++++++++++++++++++--------------
> >  4 files changed, 102 insertions(+), 55 deletions(-)
>
> The conflict resolution looks accurate to a non-expert eye.
>
> I can also confirm there are no new findings reported by:
>  - make W=3D1
>  - make C=3D2
>  - cppcheck --enable=3Dall --force --inconclusive
>  - PVS-Studio
>
> PS: Could you help me out how (and if at all possible) to preserve the
> Author date of the original patch when downloading and applying the
> 'raw' file provided by lore.kernel.org ?

If I understand you correctly, you applied the diff of patches
directly with the "patch" command.

To get kernel patches and apply them easily, use the b4 tool available at:

git://git.kernel.org/pub/scm/utils/b4/b4.git

Then in the kernel source directory do this:

b4 am '<cover.1706183427.git.fdmanana@suse.com>'

It will create 2 files:

20240125_fdmanana_btrfs_some_directory_fixes_for_stable_5_15.cover
20240125_fdmanana_btrfs_some_directory_fixes_for_stable_5_15.mbox

The first is just the cover letter, the second contains the patches.
To apply them, just do:

git am 20240125_fdmanana_btrfs_some_directory_fixes_for_stable_5_15.mbox

Hope that answers your question.


>
> Thanks,
> Eugeniu


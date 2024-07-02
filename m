Return-Path: <linux-btrfs+bounces-6143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DD9241F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE11C20DFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F31BB6A0;
	Tue,  2 Jul 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhosaMTD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3A1DFFC
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933021; cv=none; b=VdVxG6/3OrxgUgU9Wy4GkBSXktuUmCsQAQgQOhBurNwbM+VLN00sgLQWNhLSy4pH741T2xRB45iGwXcXquREjGVMc/pYtPcDa8gOlBMw304duh9Eb/Y9kFVdjv/EYER7SegPM/+JBBazvIqdOxPHuk7/MwjtRNP0iXiCxe3tJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933021; c=relaxed/simple;
	bh=ASB/owSHTfhmG+PjSyVrIw2gf/QyQP/JccrcGSRz/fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxSOjywgG4rKRbI8o1l+ivsnesNMFqrMFuSaTf4AN2ZAoqTIXW6ijweOCSohmoTJ7FHey8L2l0B3fk017FpkSM8kbV1bdELaajbFGy060c/XXp1K3eYEF1fSbeJ0wwNUIkKKzoxkZZVFPFpOCIHV2hm1Bsao7ihbbr30otQf6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhosaMTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D33C2BD10
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933021;
	bh=ASB/owSHTfhmG+PjSyVrIw2gf/QyQP/JccrcGSRz/fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lhosaMTDYrlwY+PRjIhIur/A63FRbkpEQKTyrUcIH3gdwPF29USjJgLu27+45JNdk
	 yZkqf6nNJtVBdBtMqxoQgtvO52s0K8oKVgcQ8S7BKiiQm4PpR+L+3u233RP2pjOImp
	 UlInipgmMtvkutNLqjF0LLtyRXix8LnirWddVwll0fdQqV7fseqS5HGtwbL3AgsUAB
	 G/n2xqsiNF1GERGlL5IA5f4J7lBX3nWdT9gDbTA8ph9REDOuS/27FVUEwDVmAYpUv+
	 rijZCDBBghf97ldEABrv7ltOWfqV+OFLUdIgIA4M0FpwknKv1t5JxZlz1E3dmgztg8
	 7TJeQBWrckzgA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso1012239a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2024 08:10:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+vnJ2UptFBqvOe+8YbjcF6ujRTzFa8KMbfRXEhcD/JSX3jGO9
	hNMwAGUtEmK9F5O1dsIK58814j2Z9RrW5RI/YJejeIZh/Ci547oZF5xzOO6O+dHbs+xwx5jskPy
	/BvBopBshXRlGcLAvTtQ5NidzEF4=
X-Google-Smtp-Source: AGHT+IEYH3wb7FDFs5tvAziQhzQOSlwaM92BwjXvBQptTMn35NNSDJZNXVRXOXKqjWehHLVlM3W345qVkWdTzapuLe8=
X-Received: by 2002:a17:907:2d8e:b0:a72:840d:9ef3 with SMTP id
 a640c23a62f3a-a75148705eemr676038366b.48.1719933019629; Tue, 02 Jul 2024
 08:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
 <20240702145200.GF21023@twin.jikos.cz>
In-Reply-To: <20240702145200.GF21023@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Jul 2024 16:09:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7X9zMZh-0ruaQV++mMY2q3oFTq6kW2BwOe=v+0OECGQQ@mail.gmail.com>
Message-ID: <CAL3q7H7X9zMZh-0ruaQV++mMY2q3oFTq6kW2BwOe=v+0OECGQQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the last_trans field
 of a root
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:52=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Jul 01, 2024 at 11:01:53AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > KCSAN complains about a data race when accessing the last_trans field o=
f a
> > root:
> >
> >   [  199.553628] BUG: KCSAN: data-race in btrfs_record_root_in_trans [b=
trfs] / record_root_in_trans [btrfs]
> >
> >   [  199.555186] read to 0x000000008801e308 of 8 bytes by task 2812 on =
cpu 1:
> >   [  199.555210]  btrfs_record_root_in_trans+0x9a/0x128 [btrfs]
> >   [  199.555999]  start_transaction+0x154/0xcd8 [btrfs]
> >   [  199.556780]  btrfs_join_transaction+0x44/0x60 [btrfs]
> >   [  199.557559]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
> >   [  199.558339]  btrfs_update_time+0x8c/0xb0 [btrfs]
> >   [  199.559123]  touch_atime+0x16c/0x1e0
> >   [  199.559151]  pipe_read+0x6a8/0x7d0
> >   [  199.559179]  vfs_read+0x466/0x498
> >   [  199.559204]  ksys_read+0x108/0x150
> >   [  199.559230]  __s390x_sys_read+0x68/0x88
> >   [  199.559257]  do_syscall+0x1c6/0x210
> >   [  199.559286]  __do_syscall+0xc8/0xf0
> >   [  199.559318]  system_call+0x70/0x98
> >
> >   [  199.559431] write to 0x000000008801e308 of 8 bytes by task 2808 on=
 cpu 0:
> >   [  199.559464]  record_root_in_trans+0x196/0x228 [btrfs]
> >   [  199.560236]  btrfs_record_root_in_trans+0xfe/0x128 [btrfs]
> >   [  199.561097]  start_transaction+0x154/0xcd8 [btrfs]
> >   [  199.561927]  btrfs_join_transaction+0x44/0x60 [btrfs]
> >   [  199.562700]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
> >   [  199.563493]  btrfs_update_time+0x8c/0xb0 [btrfs]
> >   [  199.564277]  file_update_time+0xb8/0xf0
> >   [  199.564301]  pipe_write+0x8ac/0xab8
> >   [  199.564326]  vfs_write+0x33c/0x588
> >   [  199.564349]  ksys_write+0x108/0x150
> >   [  199.564372]  __s390x_sys_write+0x68/0x88
> >   [  199.564397]  do_syscall+0x1c6/0x210
> >   [  199.564424]  __do_syscall+0xc8/0xf0
> >   [  199.564452]  system_call+0x70/0x98
> >
> > This is because we update and read last_trans concurrently without any
> > type of synchronization. This should be generally harmless and in the
> > worst case it can make us do extra locking (btrfs_record_root_in_trans(=
))
> > trigger some warnings at ctree.c or do extra work during relocation - t=
his
> > would probably only happen in case of load or store tearing.
> >
> > So fix this by always reading and updating the field using READ_ONCE()
> > and WRITE_ONCE(), this silences KCSAN and prevents load and store teari=
ng.
>
> I'm curious why you mention the load/store tearing, as we discussed this
> last time under some READ_ONCE/WRITE_ONCE change it's not happening on
> aligned addresses for any integer type, I provided links to intel manuals=
.

Yes, I do remember that.
But that was a different case, it was about a pointer type.

This is a u64. Can't the load/store tearing happen at the very least
on 32 bits systems?

I believe that's the reason we use WRITE_ONCE/READ_ONCE in several
places dealing with u64s.

>
> I suggest using data_race as is more suitable in this case, it's more
> specific than READ_ONCE/WRITE_ONCE that is for preventing certain
> compiler optimizations.


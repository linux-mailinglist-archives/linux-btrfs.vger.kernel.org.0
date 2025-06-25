Return-Path: <linux-btrfs+bounces-14965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37174AE92E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 01:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9917A3C11
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC39E2D3EEC;
	Wed, 25 Jun 2025 23:44:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FA2F1FC1
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895088; cv=none; b=WGtQgef4ngsHpi8cC+XtaDZ9SdbeHFPbo4G4oOn5+B7F0hxjfiotWVVXeMu9wlpuTspuzkVBKXABRTnnaf5/wbeZ5HKlZbSnD8GirNEjvv62jdjxfnm8OrS4wjkMVuojmqkiIaXBXMmURPmZulzt8bFg9qHYNrM4Xanulfn0hc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895088; c=relaxed/simple;
	bh=mtrQNGlliUdKWWwwYHLIr198wqZ13tkZb3P4BHGPIJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFgOUjJ/O8CvBE39JE0PnyCY1IJUxCI72w8fG+TPqtE5vrxeft+KALqvHvCi+4FXnjmhC6GGnJXzuWnKpu8ukoI11ojBq5cvkx72VMyBCuXwxR46QsJE1kOQPn60YdRxsGE3RsBwzuYmGWOMrDG5kHFIXeaB7N0coBfPqwaspYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 685C89DE000026EA; Wed, 26 Jun 2025 07:44:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9282516816285
X-SMAIL-UIID: 559E04F1492845D58A02B8FF3EE710FE-20250626-074431-1
From: Hillf Danton <hdanton@sina.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
Date: Thu, 26 Jun 2025 07:44:18 +0800
Message-ID: <20250625234420.1798-1-hdanton@sina.com>
In-Reply-To: <1d765fc0-e971-4c8b-95ab-4cdfcea183c8@gmx.com>
References: <685aa401.050a0220.2303ee.0009.GAE@google.com> <tencent_C857B761776286CB137A836B096C03A34405@qq.com> <20250624235635.1661-1-hdanton@sina.com> <20250625124052.1778-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 06:59:14 +0930 Qu Wenruo wrote:
> =E5=9C=A8 2025/6/25 22:10, Hillf Danton =E5=86=99=E9=81=93:
> > On Wed, 25 Jun 2025 20:19:06 +0930 Qu Wenruo wrote:
> >> =3DE5=3D9C=3DA8 2025/6/25 09:26, Hillf Danton =3DE5=3D86=3D99=3DE9=3D81=
> =3D93:
> >>> On Wed, 25 Jun 2025 06:00:09 +0930 Qu Wenruo wrote:
> >>>> =3D3DE5=3D3D9C=3D3DA8 2025/6/25 00:00, Edward Adam Davis =3D3DE5=3D3D=
> 86=3D3D99=3D3DE9=3D
> >> =3D3D81=3D3D93:
> >>>>> Remove the lock uuid_mutex outside of sget_fc() to avoid the deadloc=
> k
> >>>>> reported by [1].
> >>>>> =3D3D20
> >>>>> [1]
> >>>>> -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
> >>>>>           lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >>>>>           down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
> >>>>>           alloc_super+0x204/0x970 fs/super.c:345
> >>> =3D20
> >>> Given kzalloc [3], the syzbot report is false positive (a known lockde=
> p
> >>> issue) as nobody else should acquire s->s_umount lock.
> >>> =3D20
> >>> [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
> t.=3D
> >> git/tree/fs/super.c?id=3D3D7aacdf6feed1#n319
> >>
> >> Not a false alert either.
> >>
> >> sget_fc() can return an existing super block, we can race between a=3D2=
> 0
> >> mount and an unmount on the same super block.
> >>
> >> In that case it's going to cause problem.
> >>
> >> This is already fixed in the v4 (and later v5) patchset:
> >>
> >> https://lore.kernel.org/linux-btrfs/cover.1750724841.git.wqu@suse.com/
> >>
> > Can v5 survive the syzbot test?
> 
> Yes, I enabled lockdep during v5 tests.
> 
Fine, feel free to show us the Tested-by syzbot gave you.


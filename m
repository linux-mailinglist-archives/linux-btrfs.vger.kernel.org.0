Return-Path: <linux-btrfs+bounces-2176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273BA84BF7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 22:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4902849DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439141B971;
	Tue,  6 Feb 2024 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="pO4LI/dW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7391B963
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256136; cv=none; b=F20JALGTT0MznvQcMZV0c/++cO8Pp9kXXxo7PQSrJ16QjRucxgfRnuSC/4t+zt6/0sqQqlnKekEjzhKaAOQIbfh0NdOYwlfmTPL6yo6FVYP3bDanpLVLJoOdeM8dbdrtCCE4rCHSDiAyLmL+Tm2G0sC5pn0XlZUtxCZWanuDK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256136; c=relaxed/simple;
	bh=HiifBXKqLQ0/SFWE533vnqx8ItJ/oPSLKUI3R0bTAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXhkPLopVtg8EOSurUZ4Tq6c8qT9GiSagkoPi+fU2w8iIAbWrIBO/gOhkeVlNmnLUFFk0O5skklKJ6VszzUeq7ylg46TxDJzxx3v7IKSjmW8CPvgARsynHMvPMb/qSP7l86OMGmtkOgz7HGaYktBB+98TsMw4q+tVlxgzKfFZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=pO4LI/dW; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c00ec6f1a7so505468e0c.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1707256133; x=1707860933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC7+ofs7+Cfc+TsNR6H7BiUSfo/MehIbGxGKhJ+aiQQ=;
        b=pO4LI/dWgAVGfk77OMkOHCY2IszmCQA5EWRXIao1NQw8f8plagrELXRToqGo3/WZpH
         dguFtlKPGhfs4xt7OmsLbUx4Hm7/8IWPIkd/wvdZP/QRn0AtVqSEz0LiKUeTJfB2yq/Z
         j12vWK1y2v5rcL8GAtm+GhKVLL8iFw4w9GeyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256133; x=1707860933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC7+ofs7+Cfc+TsNR6H7BiUSfo/MehIbGxGKhJ+aiQQ=;
        b=CkI9WPae4U5NyqDt6ByaAIcnnSSh0IOCTIljp2aG5T2xlRsjgQJAe7TuLI/5d2HTMF
         0ZMGbUyl++b/ZPOGCrxhSyKdkVKCRhKXdyqMvix1/A1Cp6UhaijBN9PpyESBFcLh1j+1
         mAAxFV+OWZecgkkOB7dKnBXvKIEyJMIR8+UzXKXtBJXFrs1pXgmSDOL1NxC3fpyr6OBV
         Ql1aPf0Z7akQs493ccCClXPlCRdt9GUHIEm5znQTxdezm7OaPt9FM9LuZul3dOjmPhUB
         /0jKO6qZIPwg8V0l4yGKmqGKToVt/8NPaRUOeTL57PMSRVHPBmaQ6sB+u/JhkQdCtIhT
         dyeA==
X-Gm-Message-State: AOJu0YxeNBkZBkpva3ZgK5HfVMDbX+69i/OTQJsqxWMxAW/cAO5LaRrw
	NwMoQnkChyBSoDzg5/qtAzdnV8e4RSXr7JG6NUpauQj1R7YDGSUDMrSRS5oitB13aZVV7hIzJiL
	VVWUJtpAGJjBJ9a7/mI4kO2qBobM=
X-Google-Smtp-Source: AGHT+IHMHXpYb+GF1VBMs15JdY3Htx2pTtkNDb8qJSn9rrURhB6qcMcd4j2XzOoYrbXBZgvnZsfkl9d5zEIF0Ec6EUc=
X-Received: by 2002:ac5:cac9:0:b0:4c0:29e5:d31f with SMTP id
 m9-20020ac5cac9000000b004c029e5d31fmr767868vkl.2.1707256133485; Tue, 06 Feb
 2024 13:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com> <20240206201247.4120-1-tavianator@tavianator.com>
 <60724d87-293d-495f-92ed-80032dab5c47@gmx.com>
In-Reply-To: <60724d87-293d-495f-92ed-80032dab5c47@gmx.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Tue, 6 Feb 2024 16:48:42 -0500
Message-ID: <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:40=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
> On 2024/2/7 06:42, Tavian Barnes wrote:
> > On Tue, 6 Feb 2024 16:24:32 +1030, Qu Wenruo wrote:
> >> Maybe it's missing some fixes not yet in upstream?
> >> My current guess is related to my commit 09e6cef19c9f ("btrfs: refacto=
r
> >> alloc_extent_buffer() to allocate-then-attach method"), but since I ca=
n
> >> not reproduce it, it's only a guess...
> >
> > That's possible!  I tried to follow the existing code in
> > alloc_extent_buffer() but didn't see any obvious races.  I will try aga=
in
> > with the for-next tree and report back.
>
> The most obvious way to proof is, if you can reproduce it really
> reliably, then just go back to that commit and verify (it can still
> cause the problem).
> Then go one commit before for, and verify it doesn't cause the problem
> anymore.

I just tried the tip of btrfs/for-next (6a1dc34172e0, "btrfs: move
transaction abort to the error site btrfs_rebuild_free_space_tree()"),
plus the dump_page() patch, and it still reproduces:

    BTRFS critical (device dm-2): inode mode mismatch with dir: inode
mode=3D0142721 btrfs type=3D6 dir type=3D1
    page:000000004209c922 refcount:4 mapcount:0
mapping:000000007cadbbf5 index:0x8379d17c pfn:0x13ca315
    memcg:ffff8f2cba7d0000
    aops:btree_aops [btrfs] ino:1
    flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|node=
=3D2|zone=3D2|lastcpupid=3D0xffff)
    page_type: 0xffffffff()
    raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff8f1d446218a=
0
    raw: 000000008379d17c ffff8f2faa26ea50 00000004ffffffff ffff8f2cba7d000=
0
    page dumped because: eb page dump
    BTRFS critical (device dm-2): corrupted leaf, root=3D518
block=3D9034951802880 owner mismatch, have 15999665770497355816 expect
[256, 18446744073709551360]

Is it still worth trying that specific commit?  I'm guessing not.

> Although without a way to reproduce locally, it's really hard to say or
> debug from my end.

I can try to make a VM image reproducer if that would help.

> Thanks,
> Qu

--=20
Tavian Barnes


Return-Path: <linux-btrfs+bounces-9995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC19DF9A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 04:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3333D281313
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 03:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95611F8AEF;
	Mon,  2 Dec 2024 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8iycQmx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3726AE4;
	Mon,  2 Dec 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110592; cv=none; b=PW8Sy1Et+iyBu/VRCzfLBVgz8h8nCCopDs/aMHlwXnrx8tMZ+fCeEDxwg92FWhecCWNQ4V/WIV4tvekM3j9lvB0yPeesVUmQZZ3XockTF7QgxtXH0upv559nomuhL9crY9LaFS41sY+o/txa+8Om9qEU9zTWPUMwp1EeLE1OuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110592; c=relaxed/simple;
	bh=v5nSndO/4ZT5+voHPl/5rulmF50bumWwUnVkUlfXcpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxZu3LWfngWj3pf0mmyw6B/1083xq75IZGCbMoa2etpLdk5m3SeSc1WCEv6ZYxWpX9sMvsuAicGvVFWBrHxlridM3nDhJARxXqZFH2vEYyQR0YapIQaJF1VrO2vekvyNIHfS1X77gUfAvDtHYdHPgBqSM7zIHbHa4ts8kEev1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8iycQmx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso321866a91.3;
        Sun, 01 Dec 2024 19:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733110590; x=1733715390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kFHM/3yCu0aAVH5q7RWPOzshWMRnBnfX8Dn0iOsBNk=;
        b=W8iycQmxzx3Q4DoPT/bD/+LbWl7lltUr+CjcpV1ziwrz7do7lR1H6GB5robOTN265D
         CtZheZNT3NBURIz31VzH/N3c5zpi7G3hijMFr+MEuEOkkTJIUW7S6eA/LNu8To9rxIyt
         qyaHhLSAEy4SjPkjL2OEkN+ZP2sUhfA/433z4ubLMEytmaXkrUSEzJ8CrAAkQJL/xhY+
         VkauxFHXU0aqIwT/EYKgfWjOLpGO6oFbqSVHl2pNu8QTSSG47/ukfMr5zUHY5LhLWl7m
         opz7FahTLa+1Db5i5eeDQv09ZQGQjLUIpmPNnOTqDUgz95QHbYs9B4KRqS/j7JhRxxGf
         KnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110590; x=1733715390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kFHM/3yCu0aAVH5q7RWPOzshWMRnBnfX8Dn0iOsBNk=;
        b=Hppqu3eLDhLoiilKz4BRCHVz3IRyqpvSrWRP7PM9lk+pG3F575zF7Wok3cWrq//1Wh
         VKn4VxBglYV/LtLcf9wM7LuaZpzOI1PmI+O3S3Cx04ti/iYFLIO9uigM3wLltc5J/GJz
         CrPgjH/LdMb2peOJRd1t8o9V6nfXXm53g9folfkvbBSHSke4UyrxSOX1Vy1q8jesnG6t
         4bA/OUSTHH06D0fE7+RVel83gjT/f0IR+/CrwkK8Hlf+ftpMYR5zKErQg99BLDOiY8hU
         6a4kWtQCqPZQY7WehV9dwdiROnEFjbHp2MG+3zYXLX7PB66QA2K8ElahHarPy2WGjk9q
         s9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVYi94irIwI8WuP0oqOYi3h0Q9EU2V+DtjQBr8GzXKOOz9QYC14bRtTwddMFXJkawaO3xx58OuaSYjQRrJi@vger.kernel.org, AJvYcCWKatxoEX5DTQaJWLDGfL33Mw5axCHmroW/U80CsNAj08rJ0ckpttcqHGMT5OdKaK4Kzzc9Wd4FfwMCDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeVWbDbbgu3j8kYTtchCWpklEhg2jl8pPi9jAijcABVZA5S6Z
	eDFok3LbEalWE2eotEB31GCoda3MF0B+b09zzo7jp/IuactHzGaGD5EmDtFk1/xxjpeWEFvZNsk
	MUBfk0t2b2zdQKx9yg3gAEoyVC/o=
X-Gm-Gg: ASbGnctnlb0gB5GcOz5jxnIi854GKdpMdlTprM0eienIXP2I64r1kHvkW09G/D+EwYy
	l7iaxM+0AHrvEvBBHp4l1HxEuEraMEOAL
X-Google-Smtp-Source: AGHT+IFNYgbr+M7uilMzhsyRj1w6CrBheFEiKqIdb/5PvSDfBtq4U3UQI6Am3DoxbHNKqwO3IL1GdUe9UHTWZELa8J4=
X-Received: by 2002:a17:90b:4fd0:b0:2ea:bb3a:8f11 with SMTP id
 98e67ed59e1d1-2ee097dd62bmr24080635a91.32.1733110590418; Sun, 01 Dec 2024
 19:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201112550.107383-1-zhenghaoran154@gmail.com>
 <CAL3q7H4P9O-6jay6cPYLrrX85y1t52QRQ=_feifY_A0D7p_gLQ@mail.gmail.com> <CAKa5YKiedRVhJoORSa3t7cENo8sZ_Nxq4bHfiMvbDrh_ccvcTg@mail.gmail.com>
In-Reply-To: <CAKa5YKiedRVhJoORSa3t7cENo8sZ_Nxq4bHfiMvbDrh_ccvcTg@mail.gmail.com>
From: haoran zheng <zhenghaoran154@gmail.com>
Date: Mon, 2 Dec 2024 11:36:19 +0800
Message-ID: <CAKa5YKjmKA8hGJgp_Px1-EGifLY_N9gR13=i54PoDcb=dMjMeA@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix data race in btrfs_drop_extents
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I read the relevant code again and found that modify_tree is also used for
judgment at line 331, but the judgment here may lead to the release of the
path. Will this cause other problems such as unexpected path release?
331: if (recow || !modify_tree) {
332:     modify_tree =3D -1;
333:     btrfs_release_path(path);
334:     continue;
335: }

On Mon, Dec 2, 2024 at 11:13=E2=80=AFAM haoran zheng <zhenghaoran154@gmail.=
com> wrote:
>
> Thanks for the explanation. I will fix the description and resubmit the p=
atch.
>
> On Mon, Dec 2, 2024 at 1:39=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>>
>> On Sun, Dec 1, 2024 at 11:26=E2=80=AFAM Hao-ran Zheng <zhenghaoran154@gm=
ail.com> wrote:
>> >
>> > A data race occurs when the function `insert_ordered_extent_file_exten=
t()`
>> > and the function `btrfs_inode_safe_disk_i_size_write()` are executed
>> > concurrently. The function `insert_ordered_extent_file_extent()` is no=
t
>> > locked when reading inode->disk_i_size, causing
>> > `btrfs_inode_safe_disk_i_size_write()`to cause data competition when
>> > writing inode->disk_i_size, thus affecting the value of `modify_tree`,
>> > leading to some unexpected results such as disk data being overwritten=
.
>>
>> How can that cause "disk data being overwritten"?
>> And the results are not unexpected at all.
>>
>> The value of modify_tree is irrelevant from a correctness point of view.
>> It's used for an optimization to avoid taking write locks on the btree
>> in case we're doing a write at or beyond eof.
>>
>> If we end up taking a write lock when it's not needed, everything's
>> fine - we just may unnecessarily block concurrent readers that need to
>> access the same btree path (leaf and parent node).
>>
>> If we don't take a write lock and we need it, we will later figure
>> that out and switch to a write lock.
>>
>> > The specific call stack that appears during testing is as follows:
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> >  btrfs_drop_extents+0x89a/0xa060 [btrfs]
>> >  insert_reserved_file_extent+0xb54/0x2960 [btrfs]
>> >  insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
>> >  btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
>> >  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
>> >  finish_ordered_fn+0x3e/0x50 [btrfs]
>> >  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
>> >  process_scheduled_works+0x716/0xf10
>> >  worker_thread+0xb6a/0x1190
>> >  kthread+0x292/0x330
>> >  ret_from_fork+0x4d/0x80
>> >  ret_from_fork_asm+0x1a/0x30
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> >  btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
>> >  btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
>> >  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
>> >  finish_ordered_fn+0x3e/0x50 [btrfs]
>> >  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
>> >  process_scheduled_works+0x716/0xf10
>> >  worker_thread+0xb6a/0x1190
>> >  kthread+0x292/0x330
>> >  ret_from_fork+0x4d/0x80
>> >  ret_from_fork_asm+0x1a/0x30
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > To address this issue, it is recommended to add locks when reading
>> > inode->disk_i_size and setting the value of modify_tree to prevent
>> > data inconsistency.
>>
>> Can also use data_race() here, as it's a harmless race.
>>
>> Also, please use a proper subject like for example:
>>
>> btrfs: fix data race when accessing the inode's disk_i_size at
>> btrfs_drop_extents()
>>
>> Also please update the changelog with a proper analysis - saying it's
>> a harmless race and why.
>>
>> Thanks.
>>
>> >
>> > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
>> > ---
>> >  fs/btrfs/file.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> > index 4fb521d91b06..189708e6e91a 100644
>> > --- a/fs/btrfs/file.c
>> > +++ b/fs/btrfs/file.c
>> > @@ -242,8 +242,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle =
*trans,
>> >         if (args->drop_cache)
>> >                 btrfs_drop_extent_map_range(inode, args->start, args->=
end - 1, false);
>> >
>> > +       spin_lock(&inode->lock);
>> >         if (args->start >=3D inode->disk_i_size && !args->replace_exte=
nt)
>> >                 modify_tree =3D 0;
>> > +       spin_unlock(&inode->lock);
>> >
>> >         update_refs =3D (btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJEC=
TID);
>> >         while (1) {
>> > --
>> > 2.34.1
>> >
>> >


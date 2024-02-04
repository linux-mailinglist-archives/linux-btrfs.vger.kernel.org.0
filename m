Return-Path: <linux-btrfs+bounces-2090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF8848BC5
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 08:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235FD1F22A8B
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B678825;
	Sun,  4 Feb 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POdoqo9u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183A79D8
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Feb 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707030976; cv=none; b=IikPj7C3QujNWN+SS1avnK+v7VK9eJdHsNQZzD1BR4V1eFavabot0XUEIBQCMqYA1sFBjNjfsLRzJ9BjR3J0t3UnKyuZDj9RtCuSIFvEPx7U4rQOe4ErxjbkrLzFlkZDYCapTI4ZTxLmQttJXLNifggLq5hI7eDySevAiFUqal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707030976; c=relaxed/simple;
	bh=dYeOQG+QUHxdtjaxKBk9OOGcGFH7+9lzVPeiLo6Ynl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITCt6U3OpQ863xqyq0bYUUmhPisDm+dGlpvhlPohCc5iDmsJKIy6liHlagR40RW2O5sify/SkWPNI1WrolwROTJLzgm2x5SUi037mhW0/IjfCo/qVp//msET8zq63kDVtuGAZ0PsyW/cq7xwSXVKBXNJSChtvJluYwuwNQUKMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POdoqo9u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707030973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlK3YajkS6vAuRFI/v29CUReV4AqGYEhTRG/C9e3Odk=;
	b=POdoqo9ufAepRLdlL0PgsmOwJQCGfZSDXKPggO+Ftkw8wXRXqWcAb8wlvuQGVcTHL2MPsV
	N/T5rf7GfoscoLgWSahNIAIWiF5jUG0FuguE5yFI3oAjz/WLJvxantGjKbMWsXp7RDNQ/B
	cz1CTsk3QzJ9N5vrUwOpiO4bXj4Jnyc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-RUseUugWM0Spncj5fg-uVw-1; Sun, 04 Feb 2024 02:16:11 -0500
X-MC-Unique: RUseUugWM0Spncj5fg-uVw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dd65194396so4607160b3a.0
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Feb 2024 23:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707030970; x=1707635770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlK3YajkS6vAuRFI/v29CUReV4AqGYEhTRG/C9e3Odk=;
        b=eYqMk9fs8zfUicgg8U8QrlmXNjOhHe39iEe25ICszQ6o7hgkHyBGAFrdv7Ob4NOzVW
         GOKKiInBwiAfjdikaHuD7OyjiJsDw7PmN5krkKaLadKx0cKVMpKMg+dwNAzsKTPCWcbX
         2R4qQA1sTRRbMGmq0YqAgjywsjUjwCUW45P3glEX4uj4mO3rosmnOvzqXvAk1CIPuNTa
         3dKW9GYuItQs2KlNz+P8O3izgXS9eQbPGpg2B9O1QwAWUEMV1r5DyxRy4eHKaAL63IXh
         N23JQW/NrMZ5c0Z8a9H4Wt51lYpvCT0MaXk1W0Q3gwxKJi00nwKft+ZLn80T5x1OVw8U
         0/dA==
X-Gm-Message-State: AOJu0Ywk+rJjRUSNiZ+2AOb/pnm/0NQOGq4c+WBbeVVwETEnphAL8a2w
	mPm2jNJuStsHlVohf1WH+uK0odoz/9UTVLAM5ZjqnZuTw1r8rkpy3+Gf9KzYejjXCpRWtWK5Rc5
	Ljv1CxxbRcF2Co0jcWZG6XyOdbMkq/7S9SI9I5ibPJzBa8KVodCJLHJLM10Z7CttULkqH
X-Received: by 2002:a62:ab04:0:b0:6da:ed17:bfa7 with SMTP id p4-20020a62ab04000000b006daed17bfa7mr2780470pff.6.1707030970391;
        Sat, 03 Feb 2024 23:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz/NKkl+W2C5dKEdzs7ZlWJPOOhNuQ8E4n6DDL8xAVhQIZcdfQ9KblOK/7Yvm0v007PhT/Sw==
X-Received: by 2002:a62:ab04:0:b0:6da:ed17:bfa7 with SMTP id p4-20020a62ab04000000b006daed17bfa7mr2780456pff.6.1707030970006;
        Sat, 03 Feb 2024 23:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXms7r7HKG+sNWXoTWgqWUwNJTr8YYCEs5aVdj2A6Db4W4Ct4fbKRRyTxejE9gxRhYinyEgx1zfbLZPUVRj9ODjknvSwJYSUS9NLVusVYJKvDUnCePVQlcNVptjqK7vWrzM1cxDR/R5IRU=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm4490513pfe.19.2024.02.03.23.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 23:16:09 -0800 (PST)
Date: Sun, 4 Feb 2024 15:16:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>,
	kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove btrfs/303
Message-ID: <20240204071605.qt6famqusr7til43@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
 <20240202131120.q35fe45cmu5e3dqz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7MsG8pLsrEeKOhtXPMw3psw3pFbTTn5k-LGLxLo2oCBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7MsG8pLsrEeKOhtXPMw3psw3pFbTTn5k-LGLxLo2oCBg@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:51:09PM +0000, Filipe Manana wrote:
> On Fri, Feb 2, 2024 at 1:11 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Jan 23, 2024 at 11:56:59AM -0800, Boris Burkov wrote:
> > > This test was reproducing a bug triggered by creating a subvolume qgroup
> > > before creating the subvolume itself with a snapshot.
> > >
> > > The kernel patch:
> > > btrfs: forbid creating subvol qgroups
> > >
> > > explicitly prevents that and makes it fail with EINVAL. I could "fix"
> > > this test by expecting the EINVAL message in the output, but at that
> > > point it would simply be a test that creating a subvolume and
> > > snapshotting it works with qgroups, which is adequately tested by other
> > > tests which focus on accurately measuring shared/exclusive usage in
> > > various snapshot/reflink scenarios. To avoid confusion, I think it is
> > > best to simply delete this test.
> > >
> > > Signed-off-by: Boris Burkov
> > > ---
> >
> > Just a reminder, this's a test deletion. To avoid test coverage decrease,
> > I'd like to give it more time to get more reviewing of btrfs list. If no
> > one has any concern, I'll merge it :)
> 
> It's fine, it's the right thing to do.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

OK, thanks, I think two RVBs without any objection is good to this patch, I'll
merge it.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > >  tests/btrfs/303     | 77 ---------------------------------------------
> > >  tests/btrfs/303.out |  2 --
> > >  2 files changed, 79 deletions(-)
> > >  delete mode 100755 tests/btrfs/303
> > >  delete mode 100644 tests/btrfs/303.out
> > >
> > > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > > deleted file mode 100755
> > > index 410460af5..000000000
> > > --- a/tests/btrfs/303
> > > +++ /dev/null
> > > @@ -1,77 +0,0 @@
> > > -#! /bin/bash
> > > -# SPDX-License-Identifier: GPL-2.0
> > > -# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > > -#
> > > -# FS QA Test 303
> > > -#
> > > -# A regression test to make sure snapshot creation won't cause transaction
> > > -# abort if there is already an existing qgroup.
> > > -#
> > > -. ./common/preamble
> > > -_begin_fstest auto quick snapshot subvol qgroup
> > > -
> > > -. ./common/filter
> > > -
> > > -_supported_fs btrfs
> > > -_require_scratch
> > > -
> > > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > -     "btrfs: do not abort transaction if there is already an existing qgroup"
> > > -
> > > -_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > -_scratch_mount
> > > -
> > > -# Create the first subvolume and get its id.
> > > -# This subvolume id should not change no matter if there is an existing
> > > -# qgroup for it.
> > > -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> > > -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> > > -     "$SCRATCH_MNT/snapshot">> $seqres.full
> > > -
> > > -init_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> > > -
> > > -if [ -z "$init_subvolid" ]; then
> > > -     _fail "Unable to get the subvolid of the first snapshot"
> > > -fi
> > > -
> > > -echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> > > -
> > > -_scratch_unmount
> > > -
> > > -# Re-create the fs, as btrfs won't reuse the subvolume id.
> > > -_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> > > -_scratch_mount
> > > -
> > > -$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> > > -_qgroup_rescan $SCRATCH_MNT >> $seqres.full
> > > -
> > > -# Create a qgroup for the first subvolume, this would make the later
> > > -# subvolume creation to find an existing qgroup, and abort transaction.
> > > -$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seqres.full
> > > -
> > > -# Now create the first snapshot, which should have the same subvolid no matter
> > > -# if the quota is enabled.
> > > -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> > > -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> > > -     "$SCRATCH_MNT/snapshot" >> $seqres.full
> > > -
> > > -# Either the snapshot create failed and transaction is aborted thus no
> > > -# snapshot here, or we should be able to create the snapshot.
> > > -new_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> > > -
> > > -echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> > > -
> > > -if [ -z "$new_subvolid" ]; then
> > > -     _fail "Unable to get the subvolid of the first snapshot"
> > > -fi
> > > -
> > > -# Make sure the subvolumeid for the first snapshot didn't change.
> > > -if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> > > -     _fail "Subvolumeid for the first snapshot changed, has ${new_subvolid} expect ${init_subvolid}"
> > > -fi
> > > -
> > > -echo "Silence is golden"
> > > -
> > > -# success, all done
> > > -status=0
> > > -exit
> > > diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> > > deleted file mode 100644
> > > index d48808e60..000000000
> > > --- a/tests/btrfs/303.out
> > > +++ /dev/null
> > > @@ -1,2 +0,0 @@
> > > -QA output created by 303
> > > -Silence is golden
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> 



Return-Path: <linux-btrfs+bounces-14516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2AACFA88
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 02:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECFB3B0A19
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 00:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B670800;
	Fri,  6 Jun 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2D0oT7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180CC2B9A6
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171195; cv=none; b=WRxmw22bPyW2Dx/5t8ulG4bYIEh5ot64H+04tCFuZVdQwgg/D+3EA2gl++n2kIqPUCXd6+4t5WXhfTtVjrSsuc4paHyq0rrYai2vhmEepAL/K9foTBV2hXB67wVj/n4cZUtKW9DJCtMif9kEx22CVndy1N1b6Qz113ER2krkWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171195; c=relaxed/simple;
	bh=q7Dvx4CG0RnexWO91J4oJDH6lHiISM1Me3lDpSwX4SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsHrfm8fVh4DdBIZy+64bGJ8obNt0lGIvTdoY6IOLbUbDZE06ho2KWQVCZnDbEqGsghz4iwRgI5NnfNeafJjogdqwUQC7KY8iMwjlC0kz8Iy+MQqaoKO7eXIKbtl8AWwPhB3oM4q1f8h1SZ7f87FgWDsMLHSY36zNJawrdnVwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2D0oT7i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749171192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsFQl8sr8n30OqS4v5DdSHOD+ukUcT8jWVTD0i0oygk=;
	b=R2D0oT7i63Hnjt/JHaF8jXxYE/pKwyBNaWZGZjTYwICuQnokBSb5wD+bp7gn3Tc0SgFtJu
	JZ4rfM5QDzqmc69ajg4yPkgKutFFDztnZLTXlLbIqCYP6claiKLPIEDCSxtRAFf8pw0b8W
	P3F97/UYRMp7BebhzRZKlykd1zr6jd8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-eeAbppCjNhKmyrS684_oUw-1; Thu, 05 Jun 2025 20:53:10 -0400
X-MC-Unique: eeAbppCjNhKmyrS684_oUw-1
X-Mimecast-MFC-AGG-ID: eeAbppCjNhKmyrS684_oUw_1749171190
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748269c6516so455918b3a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 17:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171190; x=1749775990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsFQl8sr8n30OqS4v5DdSHOD+ukUcT8jWVTD0i0oygk=;
        b=H3G+rZRMP7gDhduEOu6QiYIZH0wbqueHqOwjjSzaeeQzpv1vyYNWXGCYE+KqYuEN8s
         +/RJnPsKpzGp1wSYIoHU1QOlceOHT2iWeg/ka1t5Yi2fJYIWgMfOV2B2nRP6DP6Q1Q48
         Uw8tKFlEf3Pg0BGrDO3tD6kkc00Y3GodPRHixPSbjIjcUj48AbAKW+MN9PtllcyvBFrE
         C4l9eOlh64vj0Ai2IGlgdJcDusfMl9lBV92ws/BmzWldQhdI+3DTK5NGqWyJVTj1Q0LO
         R8kZFVq0d+iFjGfFOGqihEmpHQI5Fpr2gMgI/VBlQnNGYbcuqTtflo/ifaMBFdl4BaBW
         QLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZgY5bEB38EGx5JaIqXMlJdhuiQjKixCw9KPDOzdKXrFd7vHtpQRU2y9tqVh8bSBCCXbp7fBM90uZW+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtm+iCQ8/vUvTH8qv1Wx+QocLiaDDnHwJ+anrpdaqisVjMGxOK
	VkP26as5kcbqUpOGmCJpLy0ISYJ3PhxYtdZOFjO3gqbQk7jG5H6yUdbVAedlXe65LP8b39Es/N7
	VWdtoaF8Y2aR5sl40qCsuDUVnKZbqfhX5Y7iwpJooREwlm5jhGmG7pG2D0xd9vclA
X-Gm-Gg: ASbGnct8jdf7Q/pY0pptcgiYqpaRsJhwj7uWeV4Qt2IJi2K0syTw/N3LZclnx9a1Ytx
	GN6qpGSLRH/ldV+W21AgSt/3+bQ/419vlbTK4OZmvaqdPX1pXediE7FASGxkZXYIvHIUJZzi+It
	Wz7qH+1VkSsu17T78Ji5YuWlPzpYHQW/+hI/9IDzvkNydY4IwuJsppzX+Y4D+MEQKlcM4nqz9ST
	PtbK0QgorydK84IdiT6aGhfbs1KO9qx8NLIpvTkohy+z6ezufFYSkYP+nZkG28dJULSdgY2pU9/
	S3+RkQVG8EyAz41QeOb3HWmuFpUi90tFCGBUfdghBQRHNsFonsHJ
X-Received: by 2002:a05:6a00:806:b0:737:9b:582a with SMTP id d2e1a72fcca58-74827f3dab7mr2316530b3a.24.1749171189604;
        Thu, 05 Jun 2025 17:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhuxf44JkfMsS77q5YopkK2jKVaIaGt4qLF9JgjzWMXCZwCKbi9NDscO6soj+5oZzAbA+TlQ==
X-Received: by 2002:a05:6a00:806:b0:737:9b:582a with SMTP id d2e1a72fcca58-74827f3dab7mr2316513b3a.24.1749171189202;
        Thu, 05 Jun 2025 17:53:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38386sm263376b3a.6.2025.06.05.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 17:53:08 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:53:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/032: fix failure due to attempt to wait for
 non-child process
Message-ID: <20250606005304.p36cjy23ekdlg53u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
 <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>

On Thu, Jun 05, 2025 at 08:37:35PM +0100, Filipe Manana wrote:
> On Thu, Jun 5, 2025 at 5:52 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, May 28, 2025 at 12:42:20PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Running generic/032 can sporadically fail like this:
> > >
> > >   generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad)
> > >       --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +0000
> > >       +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad    2025-05-28 10:39:34.549499493 +0100
> > >       @@ -1,5 +1,6 @@
> > >        QA output created by 032
> > >        100 iterations
> > >       +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: wait: pid 3708239 is not a child of this shell
> > >        000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > >        *
> > >        100000
> > >       ...
> > >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/032.out /home/fdmanana/git/h
> > >
> > > This is because we are attempting to wait for a process that is not a
> > > child process of the test process and it's instead a child of a process
> > > spawned by the test.
> > >
> > > To make sure that after we kill the process running _syncloop() there
> > > isn't any xfs_io process still running syncfs, add instead a trap to
> > > to _syncloop() that waits for xfs_io to finish before the process running
> > > that function exits.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> >
> > Oh... I didn't remove the _pgrep when I reverted those "setsid" things.
> >
> > CC Darrick, what do you think if I remove the _pgrep from common/rc
> > and generic/032 :) On the other words, revert the:
> >
> >   commit 1bb15a27573eea1df493d4b7223ada2e6c04a07a
> >   Author: Darrick J. Wong <djwong@kernel.org>
> >   Date:   Mon Feb 3 14:00:29 2025 -0800
> >
> >       generic/032: fix pinned mount failure
> 
> Reverting that commit won't fix anything. One still needs a mechanism
> to ensure that we don't attempt to unmount the scratch device while
> xfs_io from sync_pid is still running. The mechanism implemented in
> that commit is buggy and the trap based one from this patch should
> always work (and we do this trap based approach on several other tests
> to solve this same problem).

Sure, don't worry, I didn't try to Nack your patch:) Just due to you remove
the _pgrep() in your patch, then I thought it can be removed from common/rc
totally, looks like nothing need that function. So I tried to confirm that
with Darrick (who brought in this function:)

Due to commit 1bb15a27573 does two things:
1) create a new function _pgrep
2) call _pgrep in g/032

You've removed the 2) in this patch, so I'm wondering how about removing
the 1) and 2) totally. As you can see, g/032 is the only one place uses
_pgrep:

$ grep -rsn _pgrep .
./common/rc:40:_pgrep()
./tests/generic/032:87:dead_syncfs_pid=$(_pgrep xfs_io)

Thanks,
Zorro


> 
> Thanks.
> 
> 
> >
> > Thanks,
> > Zorro
> >
> > >  tests/generic/032 | 13 ++++---------
> > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tests/generic/032 b/tests/generic/032
> > > index 48d594fe..b04b84de 100755
> > > --- a/tests/generic/032
> > > +++ b/tests/generic/032
> > > @@ -28,6 +28,10 @@ _cleanup()
> > >
> > >  _syncloop()
> > >  {
> > > +     # Wait for any running xfs_io command running syncfs before we exit so
> > > +     # that unmount will not fail due to the mount being pinned by xfs_io.
> > > +     trap "wait; exit" SIGTERM
> > > +
> > >       while [ true ]; do
> > >               _scratch_sync
> > >       done
> > > @@ -81,15 +85,6 @@ echo $iters iterations
> > >  kill $syncpid
> > >  wait
> > >
> > > -# The xfs_io instance started by _scratch_sync could be stuck in D state when
> > > -# the subshell running _syncloop & is killed.  That xfs_io process pins the
> > > -# mount so we must kill it and wait for it to die before cycling the mount.
> > > -dead_syncfs_pid=$(_pgrep xfs_io)
> > > -if [ -n "$dead_syncfs_pid" ]; then
> > > -     _pkill xfs_io
> > > -     wait $dead_syncfs_pid
> > > -fi
> > > -
> > >  # clear page cache and dump the file
> > >  _scratch_cycle_mount
> > >  _hexdump $SCRATCH_MNT/file
> > > --
> > > 2.47.2
> > >
> > >
> >
> 



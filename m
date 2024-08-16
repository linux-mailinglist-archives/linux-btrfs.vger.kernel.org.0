Return-Path: <linux-btrfs+bounces-7222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08262954011
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 05:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61121F22968
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA075F873;
	Fri, 16 Aug 2024 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM8LgF+U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07E482E4
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723779405; cv=none; b=Ti6n2+/Fsi1SQhh/7cHQykJ0kKZAHtX0JXHicN7ycerUbwOqKe2DfeCwfW3phRmKrMyIft3O2opJcHZEmIanis1kD4LuG8Z3qeXnmwZFpvI7l37zQR9j+3gbrVEY500sVI8ygDKSqYj5MbPfFQ6fwtE0QXmKwKmyn4MUE/moJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723779405; c=relaxed/simple;
	bh=LDyutCRlNsC8DYeLe8q0IW5u6nG5OBACoRADpWAdcTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWAon+2Q3BwkoCXW8isOFV+n2fOWm5BVHSUfVJLBmQ3hSfA64Rd4Li88xocmwBWBw5LFBQrJ0Wi8R8Oh2M+xupgFWBAFg9JUQjd/rm77Oiwl5lX5pM6JItY+MSXOhfQFI15/hSLD+RAaUNWVrKSp5bNngAap9tzFxfGyvPTEfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM8LgF+U; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso16298511fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 20:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723779402; x=1724384202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdtvqKmgpVkKBV/pWHXhhYEJQzAqYKa4fYJ6jG8kFW4=;
        b=JM8LgF+UVqMnIaqFB2l87/oBgz51U+AlFAo6s3EB0IvH6jUxaQKmsFxsbZRQVCEsMF
         XOj//Kl431MCmJvb01qZS10oshIBfnRIH6gyX4j4Vl3BRW8/1Q5wCLSpjd6mdcV1VpzE
         +h9QBvayaSGTy19m+cpOK57PtCh9uDVaXBsJ04pOryMNO7r78Zr47Fi6lxVGS5PNF/Co
         Vf1gy+5NdC6PBJObXiTdbEW1KF0x564dLu7kfAY3xMuqYXGeQirYdfcTgqputZrRO59y
         WJKfkjykdl+Z6WIpOpC3ccxmOwhaHINZIlD4jKR7dt4P7XUFG/d9vDvhpx5m1mo6LSo4
         XmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723779402; x=1724384202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdtvqKmgpVkKBV/pWHXhhYEJQzAqYKa4fYJ6jG8kFW4=;
        b=pn4DyPvYopstCwTejn0MFQekSWw1QEcyaGAjbZJCwjKjueptr/xYCEuxZT+VTB3LmD
         6Lo3ldrBnd6gzTqtUibjx2zO1PwTfsE66z5BFxRuWeAmO0RptlB08UOUg3xXRAbwVp0H
         InM+XtxiV+X8mFLDLxWdjTneI82iazWUiumzakC4Ga2KRp/h81Kf8ZxR7YPrbywJptzZ
         15nYwuMXAfbnYjhAQyqKGvvls1RLjwO+88PTD5pIalUPXyaGrMyN24cfo3/D/MMV6sg0
         zjJ1mDU/swnUIIDdJNN8fuY2atxe81vVB/Cx6Kd6zfsxr1T/5+PjGR+dMwSIkQBVhyk6
         kirw==
X-Gm-Message-State: AOJu0YyZ3TiWiqkTJD/+df/uS/pvXOE+jPT+FsvyttqTjQNAd/al38j1
	qdLoIv6AkbEpyFVuX3KKt5KnPI6gb1OvvBQ33uoCyaFI3RICvflUjMASNhLrBPLDKhYIwRrdJl8
	n+EpHg0XkdHoh0xebhBf5w8QDgFw=
X-Google-Smtp-Source: AGHT+IHgr4KOvS7fcDf1iNfIYiy+nrXb8QMJ3h9RQPqZvfYPAM9jZvyxzOmo/qh+qWV2LzsmF4CSll6z4+VxlL5eJWg=
X-Received: by 2002:a2e:8898:0:b0:2ef:2c4b:b799 with SMTP id
 38308e7fff4ca-2f3be5aa1d3mr9847791fa.28.1723779401255; Thu, 15 Aug 2024
 20:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607143021.122220-1-sunjunchao2870@gmail.com> <20240813224433.GV25962@twin.jikos.cz>
In-Reply-To: <20240813224433.GV25962@twin.jikos.cz>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Fri, 16 Aug 2024 11:36:29 +0800
Message-ID: <CAHB1NahuscKz-4b7MTR2xzLSocswDFObXjKuqy9g=QL=QnKyRQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: use goto style to handle error in add_delayed_ref().
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Sterba <dsterba@suse.cz> =E4=BA=8E2024=E5=B9=B48=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=B8=89 06:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 07, 2024 at 10:30:20PM +0800, Junchao Sun wrote:
> > Clean up resources using goto to get rid of repeated code.
> >
> > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
>
> I had the patches in my testing branches, no problems so far so I'm
> adding it for 6.12. Thanks.
I just noticed I missed a commit for a file. Sorry for the oversight.
Should I send a new version of the patch?

--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -125,7 +125,6 @@ struct btrfs_inode;
  * Record a dirty extent, and info qgroup to update quota on it
  */
 struct btrfs_qgroup_extent_record {
-       struct rb_node node;
        u64 bytenr;
        u64 num_bytes;


Best regards,
--=20
Junchao Sun <sunjunchao2870@gmail.com>


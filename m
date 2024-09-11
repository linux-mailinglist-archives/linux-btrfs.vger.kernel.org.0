Return-Path: <linux-btrfs+bounces-7928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A8974C44
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA501C21F8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5F143878;
	Wed, 11 Sep 2024 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlHKRPXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010B14A60E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042422; cv=none; b=utgNsR78v0nNZALiNwTBwf2T+Zacf3WYl6IKi3MW7ZK9GJQo8uxjIr2lNCVH6Mopjnul1ec0P0Uvbvb9KBkFWS5xvFYL7tyOfw4l4gbXE8r8O0OV0pegnu48PRcv2aKY+zfRR93C8BGPEsBE9IjW/uoSBckT6gJSZ74ClZ7sdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042422; c=relaxed/simple;
	bh=PWH7c0lTUR3DMqPIjSjH9CSS31LrYFpO9QRTrPbaUtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZO1uhkqW8B7HFBSuWFNmlGYjqvSb+C5vEXifQGToJnmg0Bk7q/iZTpanPMUTRUIMi6My3O6G32YJzVYGRWyWmq6mNHT3jYcfqmjbsiPcUSYfyfPnWjOd16M5VNwL2vtUttv152cWfH7opdT3CbJ2gbxw0NcgZu4ZrW2rSZ0mA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlHKRPXX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a4df9dc885so54902885a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726042420; x=1726647220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oth4FRHI7PNA9Gzk2OnWRPzsE+HE7rr0F6kv2BBOqRw=;
        b=nlHKRPXXAOZjyEn81IkvSt2E64qV1ynGtHKcDB7CY9lPnD3sZn+s/BTGR2Bz0scOmG
         VA0AUV1sf3eilNj973f1mbmsssFuBbdhpc1UdyWNF47s0QoKoqrVnT7eVtgUL91xKnJ8
         Pl1H/I6WRgHYUe/Kxd0OiJikSJk09Ol2SdZyDA5jAcMZoDvcREKS5+I3OYm0BUgDFASH
         57U0jvHij2dFKPhj5YW6/Q1gR95RcxYGqH8HdShTbAgriRLXZuWirshw9QonXsuksbzL
         cm37/hI7RSb1WEgj9N6gCMznrXP8gUtD8DpkWzltPqq+Q8wPPuhqodvRX+JDFwsZ/P0N
         blqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726042420; x=1726647220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oth4FRHI7PNA9Gzk2OnWRPzsE+HE7rr0F6kv2BBOqRw=;
        b=HrIj5q9NFWkAHh7tEHawn0CtboH5jHRCdcduMhF5y/RBOn4MsihnvHyKjAJf+K08+v
         48Cc+CwUw4lTDOqVB310TY+QZJ8d7A/WSf4aIfQ7DZFSfAGDf6UbuB197vHxz4qRpZFm
         JR6N5k5z/TtzzEmsd1rbjpGIHC3lNApDGYuBZnrPer+TJg69dIJFYOvhzJOqMYeCWGXF
         E6CShff7BEGs6NtCUjUqxzfdVU8dpzvqn3RNiiclkIEuDJ+GXUexG6opvH9CI+zYykgP
         7WcA073HlIk8o4r/Q+gw481tC3k/0eTWGGgqZXcOBIXzJOThm+jbqrUlhYFBXkCGMZo9
         egOw==
X-Gm-Message-State: AOJu0YxfcK74T//6qSa+IXw66a/KqA7m8xBrgBgRa2I5ZdThElbpns/1
	GJNSNzNYHL9xKPeBL+slyNMDPQhXGEOzZmURy6xxg98WTpWQq82CE4Z1smRSwEfRztlZ0U+w72O
	kGTdYcteQMtzo9hqXoivI/jaWwxs=
X-Google-Smtp-Source: AGHT+IEDus8SYSFnNgGI4Dc6JYAxAiCy860TUuZ1VLHZcWLEubf1B9nzz2QvQIMVNTk8vT7sslpyWAKzsCZpPbpHGU4=
X-Received: by 2002:a05:620a:1aaa:b0:7a7:d37b:3ee3 with SMTP id
 af79cd13be357-7a9bf99130amr1205316285a.26.1726042419714; Wed, 11 Sep 2024
 01:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com> <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com> <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
In-Reply-To: <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 09:13:29 +0100
Message-ID: <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
the array?  Reason I ask is when this first occurred it was one
particular drive reporting errors and now after switching out cables
and to a different hard drive controller it's a different drive
reporting errors.

It's also worth noting that this array was originally created on a
Debian system some 6-8 years ago and I've gradually upgraded the
drives over time to increase capacity, I'm up to drive ID 16 now to
give you an idea.  Does that mean there are other gremlins potentially
lurking behind the scenes?

On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> > btrfs check --readonly /dev/sda gives the following, I will run a
> > lowmem command next and report back once finished (takes a while)
> >
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda
> > UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 24251238731776 bytes used, no error found
> > total csum bytes: 23630850888
> > total tree bytes: 25387204608
> > total fs tree bytes: 586088448
> > total extent tree bytes: 446742528
> > btree space waste bytes: 751229234
> > file data blocks allocated: 132265579855872
> >   referenced 23958365622272
> >
> > When the error first occurred I didn't manage to capture what was in
> > dmesg, but far more info seemed to be printed to the screen when I
> > check on subsequent tries, I have some photos of these messages but no
> > text output, but can try again with some mount commands after the
> > check has completed.
> >
> > dump as requested:
> >
> [...]
> >                  refs 1 gen 12567531 flags DATA
> >                  (178 0x674d52ffce820576) extent data backref root 2543
> > objectid 18446744073709551604 offset 0 count 1
>
> This is the cause of the tree-checker.
>
> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache.
>
> Unfortunately that feature is no longer supported, thus being rejected.
>
> I'm very surprised that someone has even used that feature.
>
> For now, it can be cleared by the following command:
>
>   # btrfs rescue clear-ino-cache /dev/sda
>
> Then kernel will no longer rejects it anymore.
>
> Thanks,
> Qu


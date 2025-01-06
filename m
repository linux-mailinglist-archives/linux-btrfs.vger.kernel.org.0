Return-Path: <linux-btrfs+bounces-10754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F97A03252
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 22:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43DDC7A295C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C11E0DCD;
	Mon,  6 Jan 2025 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PXcePQBv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467811DFE0A
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200273; cv=none; b=upyIDwoQGUQb1QeDLeiWxBArCvu2A8aLd2ZZ+XxVM96vssrqHcI2ueN70/iEI0bmga3uLo+G3LmNqd9R0lZEEj73+Hnl+RIMdASznDnfmI1bqvqvpdLYmofZAHffVviMnluM7LamIDFPI8NS6m3a/JBOFrF4lPvHOx+G+xxj9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200273; c=relaxed/simple;
	bh=IwSR31+V1zc12HohVb1Y6oX2YZTzAHDke7c82kPYWcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeDpxLSxZJnMCEspXy2ZqvFhDNQ7i4QW694pJQkE+vTMn8VS5e5dpws2v15Md5iZL4rtCSCAQIDNw6548NDIGq7Vl6hxG9H858xPDzEZoTcMnmlwnlatuTg4PTkqW2PeHD6CNezWV/7LaaR8KjbM61ZgTvSfldG/SNTenhg0/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PXcePQBv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaedd529ba1so1641312666b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 13:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736200269; x=1736805069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2Tf9kl7fMh2IKDkNrv4YmXHlRq99NuJrVWu2Sqk7+k=;
        b=PXcePQBvr6pcmAQTAe5GmJHhL1O5YxZR4oeTfrOA2DSWc0818tYS8KegFT99BglXTW
         3NwIcnVADh+LE3wdPKuiBDSlAWcpinKh4NBipFApjRwa9NKa2a0g11Fc/oJq5CCQnxfr
         P2jr4jQTve1t/lz6R75hrdiXZHvKMQ0Q0ISysczygkZ2yNG/vc6bTstgyKOAD6997C7c
         bHfpVorLoeTOFyJHWxiIIrea5ZTM2DoWQllI50ZsQdfHgnS/DVnZN4sQqWokiR3v5+m0
         W3DIsDi2ejAXptjevZ3xWz3MCXcnO/4zq1ssirZBsIktY/P+iKGvHJqySmbqkr41cxyX
         EH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200269; x=1736805069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2Tf9kl7fMh2IKDkNrv4YmXHlRq99NuJrVWu2Sqk7+k=;
        b=C054nWlhJTCNdvrsg4hcuvWGUc6GCJjdb9+C2AolImb0KJnwPCPBhV3emtlu29yL2F
         pKYpaZj56ocmPYZkpllh+/mj53T68Fj45ydEL+LV2uWyzt16hSqZ8tOQtLkUZYmYWxrM
         P7Xu44Qpm++S2YwtVg+m8wxIigST2s10pb7bJNU43dzsPBG2iz0v7mIYUGjTdN6KwjXb
         9j8zVpScUat1T8acPV3hqWls0nQYwfi6WIRsWP7tPJZtlKEsKMAykiK4FxVp2jLsQxRm
         Y4StABDd54cBXn1Ppx1pdwcKqhapTv75JH5MlHDRqv9ExEPbCkHLrHjaahvkxGI76Wk3
         J3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXR6TIJ1DuuvKRU+eTrh2xM9b+OmEhVU7aqSrGrYfEE3ElFe7YUuIvacMKhqmpcDLMmNtOMRpwM+BQSKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84H54XLg85Il/4tBZvBspGpcYYDL0//4Vd4QJsoEZjy0nZrKa
	B50bNTEMVkOUN/8KuHnvYfpSf3D4GR9rUfawyJINcRtBiFrE6RyaqOdlAgpYWErx6DuUChcDyfx
	S667bG7YeX4+/pr1y1c0Zm2XlGMSgXvkRD4/0QA==
X-Gm-Gg: ASbGnct5M1TbbyVUVjn5EuPcy1nIg3wU7qmuOTfFA66o5fIA8gK6ChM9BW4dZw6Z2KM
	XIy1kMrgEMT3x9bSqfVZCEtTLbAoOSARq4tZj3e16G9WYtIs0RqHV0ED3AOHAqrBDaiO11/o=
X-Google-Smtp-Source: AGHT+IEbdBIHOn0SO06cyrEdOiCaD/dm+Y2tlfbyyUY+2pGFVOH+/CPxrh+Wr1PntEPavQ8d1cPYlSvzXi+zmWWeFjQ=
X-Received: by 2002:a05:6402:4405:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d81dd83e12mr139504348a12.2.1736200269599; Mon, 06 Jan 2025
 13:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com> <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner> <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
In-Reply-To: <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 6 Jan 2025 22:50:58 +0100
Message-ID: <CAPjX3FcG5ATWuC1v7_W9szX=VNx-S2PnFSBEgeZ0BKFmPViKqQ@mail.gmail.com>
Subject: Re: mnt_list corruption triggered during btrfs/326
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Jan 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/1/4 21:56, Christian Brauner =E5=86=99=E9=81=93:
> > On Wed, Jan 01, 2025 at 07:05:10AM +1030, Qu Wenruo wrote:
> >>
> >>
> >> =E5=9C=A8 2024/12/30 19:59, Qu Wenruo =E5=86=99=E9=81=93:
> >>> Hi,
> >>>
> >>> Although I know it's triggered from btrfs, but the mnt_list handling =
is
> >>> out of btrfs' control, so I'm here asking for some help.
> >
> > Thanks for the report.
> >
> >>>
> >>> [BUG]
> >>> With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
> >>> upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
> >>> mount failure due to remount races"), I can hit the following crash,
> >>> with varied frequency (from 1/4 to hundreds runs no crash):
> >>
> >> There is also another WARNING triggered, without btrfs callback involv=
ed
> >> at all:
> >>
> >> [  192.688671] ------------[ cut here ]------------
> >> [  192.690016] WARNING: CPU: 3 PID: 59747 at fs/mount.h:150
> >
> > This would indicate that move_from_ns() was called on a mount that isn'=
t
> > attached to a mount namespace (anymore or never has).
> >
> > Here's it's particularly peculiar because it looks like the warning is
> > caused by calling move_from_ns() when moving a mount from an anonymous
> > mount namespace in attach_recursive_mnt().
> >
> > Can you please try and reproduce this with
> > commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> > from the vfs-6.14.mount branch in
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?
> >
>
> After the initial 1000 runs (with 951a3f59d268 ("btrfs: fix mount
> failure due to remount races") cherry picked, or it won't pass that test
> case), there is no crash nor warning so far.
>
> It's already the best run so far, but I'll keep it running for another
> day or so just to be extra safe.
>
> So I guess the offending commit is 2eea9ce4310d ("mounts: keep list of
> mounts in an rbtree")?

This one was merged in v6.8 - why would it cause crashes only now?

> Putting a list and rb_tree into a union indeed seems a little dangerous,
> sorry I didn't notice that earlier, but my vmcore indeed show a
> seemingly valid mnt_node (color =3D 1, both left/right are NULL).

The union seems fine to me as long as the `MNT_ONRB` bit stays
consistent. The crashes (nor warnings) are simply caused by the flag
missing where it should have been set.

--nX

> Thanks a lot for the fix, and it's really a huge relief that it's not
> something inside btrfs causing the bug.
>
> Thanks,
> Qu
>
> [...]
> >>>
> >>> The only caller doesn't hold @mount_lock is iterate_mounts() but that=
's
> >>> only called from audit, and I'm not sure if audit is even involved in
> >>> this case.
> >
> > This is fine as audit creates a private copy of the mount tree it is
> > interested in. The mount tree is not visible to other callers anymore.
> >
> >>>
> >>> So I ran out of ideas why this mnt_list can even happen.
> >>>
> >>> Even if it's some btrfs' abuse, all mnt_list users are properly
> >>> protected thus it should not lead to such list corruption.
> >>>
> >>> Any advice would be appreciated.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>
> >
>
>


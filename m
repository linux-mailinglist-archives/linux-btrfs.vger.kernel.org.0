Return-Path: <linux-btrfs+bounces-18237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD6C04487
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 05:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689BD3ABEAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96602749F1;
	Fri, 24 Oct 2025 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IA6iWw6y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07726E158
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277795; cv=none; b=tGDdfnyH+4Op+ekeJkJXlO+Vz0PNWnNPgVl5luonxkUpNkzJx8DcMAFvIh4mjdKfhjBOhtu2WEN2/18N46OXoupYg3GFhgH7d0Qv91xFoHoTtthntnZd+lv0nItxRQhHmVLgv3NZLuWQkQMzg3A6Msqd/BcCcIFJoMSDcJdTbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277795; c=relaxed/simple;
	bh=qmaB1CXtUY1e+C/t58DgmOYZlR8DAdBz6UTk8GaUBVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs2NIW/4IDaK79Di7FQQ66OWCF26wGa1Irk2QLb++/PhJOOd4fyY3kAxc/Fc0truizciSgrnV7uOsdw/su5wnJd3ypZUgPlm2F5Ck7rw6e6XfFwYs9rG3GA9NNjI6uqD7HMXGgeg1TA2f/FMDm+5S0mDaO1FfHoqKiMaMNGZeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IA6iWw6y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29301049db3so2425855ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761277792; x=1761882592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=;
        b=IA6iWw6yVIbRiWEyNoiqiwosgLZ/KcAJtTQvoa+GTfyECyAZA2wF9FPTt66NyPMdEw
         QMqrT9zbQbFt1kKO4MW69O+AwuXp8d3lDCbz1HVqLa5Pp3Dm+jun9AK4g60iUm8hZlik
         KbIaiPuKp6aCFfLZ1GKBuw8gnGdp5BdpEBhrncin9Pj1AfijMkUnbM/Qmx0xUTeq7qMo
         Ul5zBINgV/n0pm9YtyCsxjqb9HwHy2NR9e0oA8WqpFSU4dexTIzk949K5GlGboqHEZ50
         WVZc/UU6VjgdMJfmXb3KfH11N0kzEN1ITmTluW1NJDTOhCfJx3Cdn6ZUrOGp2gy+tqCH
         Ptag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761277792; x=1761882592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=;
        b=LZz4kKVY0DSjvibaX1JLTru6VeomUnaa63tquyvhCIaBrYmYkWrYyx6Lo7kBpSeykE
         FuWGsax/4Ey7elAl6VQ6xKkfs7WwKBgL0WIkKMSrHlxrkXPRhKXofwlrLt9n2AHdCWRm
         V2HFjkYdnk3dsVpGAeRRCA1Hq508BUMQ8YatckSZOMZeFj235fpe1SV2qgk24/JcW/eJ
         Me1HSjIRlwJZgYb02mBL2kbPTCcDXN8JviZxyeXTSXhqllPduWj5HMzYEK+tyQldCzLg
         U9y6UPFuo8SXaABeX5EFtCQNmUId1m+PWMVHH54hEVJqdiNokSU9yT1h83GOvqOZUxT5
         mG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/RkeJRiwd4rzvQFCbI8fYdLgG0tbDu5I5s9blbj4CIGHlcb6GkIO4HTGOZdgVdwYR159IXgGIWYh8Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcr+ZzEf1SR+/np/dEok3hfipUYK9Mhoh4W/BCITkrDr1HCycE
	uI+6o/T2II659XSokP0A0bzZYHPzUldh/28fIF55gazHmLH4aDdO700njwYSGR1pzx4J/zjfMrZ
	Jw/25oqjKHh6J+3Fkc4GfGYQxXeqnsWvZjM++RF6W0A==
X-Gm-Gg: ASbGncvH2EZcaeApAPAzYk69Vuhuadt86z/hYDO0qdsSNslNuMeawXWxM4cZZWuS85I
	v2iOMrQYt6s/2ixUoLU2ZDsNnmDZmJs0fIxSVr9l9wp+KIZ8UW8xaS2jmUPs5iWudaGNkRpih5l
	aLXig6eNqOCk/8+GgSmhdNwJCe6PxM0k9DUzhp8O/8wWWjNpiLTWYIxH/4Nfbn4ZfvJlhMnAZMJ
	1jZ6ahCt4mIh2QLVlG6S2ZjzFsjMBWxHJ9S2Kqdm8nFL52gmmbVd3YKwf31gNqYxv8hbnkN1OgS
	W861J8aAwSdABbCucFQYXNYuBouw
X-Google-Smtp-Source: AGHT+IGVLYN9Qj6K5Oe/DW7c2O9tXpDx7qrMeaGk8fBmXzVZ28GOkgKOMdnoBQ6ElA4mEZO6qJsf1CoAlmZoTYuCH80=
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-292d3fb7f47mr85578795ad.7.1761277792499; Thu, 23 Oct 2025
 20:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-4-csander@purestorage.com> <aPr1i-k0byzYjv8G@fedora>
In-Reply-To: <aPr1i-k0byzYjv8G@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Oct 2025 20:49:40 -0700
X-Gm-Features: AS18NWDTISZzm2iqXdmRxUGBIwGGbwvM87S0nOqV0xhWOuEGVlx6sx6Z4Yq4U7g
Message-ID: <CADUfDZp21icTKrWHcgRTfmsxtdab85b6R75wAYXW2dA+dzXmoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:42=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Oct 23, 2025 at 02:18:30PM -0600, Caleb Sander Mateos wrote:
> > io_uring task work dispatch makes an indirect call to struct io_kiocb's
> > io_task_work.func field to allow running arbitrary task work functions.
> > In the uring_cmd case, this calls io_uring_cmd_work(), which immediatel=
y
> > makes another indirect call to struct io_uring_cmd's task_work_cb field=
.
> > Define the uring_cmd task work callbacks as functions whose signatures
> > match io_req_tw_func_t. Define a IO_URING_CMD_TASK_WORK_ISSUE_FLAGS
> > constant in io_uring/cmd.h to avoid manufacturing issue_flags in the
> > uring_cmd task work callbacks. Now uring_cmd task work dispatch makes a
> > single indirect call to the uring_cmd implementation's callback. This
> > also allows removing the task_work_cb field from struct io_uring_cmd,
> > freeing up some additional storage space.
>
> The idea looks good.
>
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  block/ioctl.c                |  4 +++-
> >  drivers/block/ublk_drv.c     | 15 +++++++++------
> >  drivers/nvme/host/ioctl.c    |  5 +++--
> >  fs/btrfs/ioctl.c             |  4 +++-
> >  fs/fuse/dev_uring.c          |  5 +++--
> >  include/linux/io_uring/cmd.h | 16 +++++++---------
> >  io_uring/uring_cmd.c         | 13 ++-----------
> >  7 files changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index d7489a56b33c..5c10d48fab27 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -767,13 +767,15 @@ long compat_blkdev_ioctl(struct file *file, unsig=
ned cmd, unsigned long arg)
> >  struct blk_iou_cmd {
> >       int res;
> >       bool nowait;
> >  };
> >
> > -static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int is=
sue_flags)
> > +static void blk_cmd_complete(struct io_kiocb *req, io_tw_token_t tw)
> >  {
> > +     struct io_uring_cmd *cmd =3D io_kiocb_to_cmd(req, struct io_uring=
_cmd);
> >       struct blk_iou_cmd *bic =3D io_uring_cmd_to_pdu(cmd, struct blk_i=
ou_cmd);
> > +     unsigned int issue_flags =3D IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>
> Now `io_kiocb` is exposed to driver, it could be perfect if 'io_uring_cmd=
'
> is kept in kernel API interface, IMO.

You mean change the io_req_tw_func_t signature to pass struct
io_uring_cmd * instead of struct io_kiocb *? I don't think that would
make sense because task work is a more general concept, not just for
uring_cmd. I agree it's a bit ugly exposing struct io_kiocb * outside
of the io_uring core, but I don't see a way to encapsulate it without
other downsides (the additional indirect call or the gross macro from
v1). Treating it as an opaque pointer type seems like the least bad
option...

>
> ...
>
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index b84b97c21b43..3efad93404f9 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -9,18 +9,13 @@
> >  /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
> >  #define IORING_URING_CMD_CANCELABLE  (1U << 30)
> >  /* io_uring_cmd is being issued again */
> >  #define IORING_URING_CMD_REISSUE     (1U << 31)
> >
> > -typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
> > -                               unsigned issue_flags);
> > -
> >  struct io_uring_cmd {
> >       struct file     *file;
> >       const struct io_uring_sqe *sqe;
> > -     /* callback to defer completions to task context */
> > -     io_uring_cmd_tw_t task_work_cb;
> >       u32             cmd_op;
> >       u32             flags;
> >       u8              pdu[32]; /* available inline for free use */
>
> pdu[40]

I considered that, but wondered if we might want to reuse the 8 bytes
for something internal to uring_cmd rather than providing it to the
driver's uring_cmd implementation. If we increase pdu and a driver
starts using more than 32 bytes, it will be difficult to claw back. It
seems reasonable to reserve half the space for the io_uring/uring_cmd
layer and half for the driver.

Best,
Caleb

>
>
>
> Thanks,
> Ming
>


Return-Path: <linux-btrfs+bounces-18472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F8FC26903
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 19:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8B434E9104
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E2355041;
	Fri, 31 Oct 2025 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Llr3y5I+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7334B411
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935392; cv=none; b=q0MGLgum24BQGp+ssvf3rfbPU1suM72Tw73FrWhKYeLV+OIdSDXmCI2hzMP4uKjmXlBW0cWApPCxxOFWGvz92D+cHS9LiOmYm5m16WRrPfg5TLc1YVKDYbL93AZFnnWkIcVV8dFOARLsOgB0C5IntYfY3rIvLvVJB5SZYcM0310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935392; c=relaxed/simple;
	bh=GcWNr8ONcdUk3tv3RdW5BzwUDCvDbBv2CleRoh2qN1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFiuzr2YU6r6Jvfu8jzJLvVeolMdpPojBsUjriAWuOGdRpBUzt3/b14XvtW6YH560Iu11XAIygB41bvOyrOO2dnwhZ2rpTrZVLUIm/jAe/+qXbl5SRsOmz+fovPKyzYMyIlswMn5ECZo1oHZJKctQxD57Z+OVeFdADKYVcQDngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Llr3y5I+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290af0e154fso3726805ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761935390; x=1762540190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=;
        b=Llr3y5I+97HxllqBCRtK5H4f0aJsmc5PViNZgIIYZiMPpVXG6Y/BxrJFjL7X3Dc2Vi
         h1cCj6yLOulY66SZyjfXdkCrDxWYQmtLJCZXzlG6OOhYrg4rJRp6MqFH9FS+fpbP6BZ4
         w98oW87ATaOMb/UaHNM9YpMv0gTbuFkuUhAqeoMyun4zHTiIc3bHA3dhr0qRwtDiIi05
         8cOegTxHcTAkdfvToqqktqX7wYia7JvYEnPVvaGFDWbXgQN1LyJ2wk+1HlbGU6git7Eg
         SIk6OxqDYCvJ4mIlsFXF54miGNQiskdLmGleOjgx8baXX20HlAtPahV3vxAo/lBTFxEw
         C7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761935390; x=1762540190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=;
        b=lw8OKfGG8fpWM3suhzpneypgNNAmTQuNruo4U3Fd/9t7GRFHyXsm81K9QxH5UQcnYg
         b996UuNpwZEDEwGBHxH1Bvu5tFJrvXInQnQLWGTIoIqL0LrzspLD57VGT0Ah3HLgwBdc
         dDTWw8vCpyNTSEZYp9roN+gkSVwDD5kdqJPHlWfSUihmcH89PV1fnVfcFBGYuVd3fkue
         dSn9Prq0MrVNILJu1eqMnqxqPB6NIeOcqIsXX0SoivtvHiAw4+AZSFcTLMczyhgGRKV4
         cPexJSQ/2PjOGcgQx57wr07fUVtf+l5cpUV9xynbLUrqbTrwpxVizTRvWs5Xdj+4tpeX
         P5yg==
X-Forwarded-Encrypted: i=1; AJvYcCUnBrrbGGevyhEx2AUvIiNYvn5rwoBdxfq3VKt6DthC0/d/wO/6CsRWB420t/X28sgFt4goc4j+68nFyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLpeofkWNGdmEUf3l1MX+8Y0upoBI0qHfIzDw8mOi/pfcLIQb
	wzFfePswp+xhQHyRXodkhuDKKEDNz9YEjOJKTrPObjKWolPXxusRD7DzgK3D/KDLhyYWbWxuZw+
	l2izs53Kzu6pPS5TQz733Ey0PIiXCRlWL1/PcMJh3ow==
X-Gm-Gg: ASbGncsIc71s+Xi6qUnbDPAURrPieIZVuvfklz3xNjYtQ6s3Y7OU2UimygyR2XPARra
	pl+jIXRGTbnNHS4mnP4JsbQJHCfQiNBLUl2+YkmU8bZaWhK99dpzcDXwATQ4yL7Xuv9P7zIBfVW
	IT02euaJtYC8Aq1VYEDJTV12LHvhxo7HTT/YkIHppUStRW634wVmD1hHqwFjd8T1IU3pagexpQr
	kNJDq2EEvlY0kepCQOFbHeqPAyyAehSSf9TiE+gz3fSmcK+1/87oIxHL6PR6psUO+647EYFWQAd
	eWZ1Fy4+GS8Kce/XdKhUFtZBEycGDQ==
X-Google-Smtp-Source: AGHT+IG4bOkdfsFJZblcFZ6qJHvTEYrpwiVlyRYTXktlwfAYyq7KD0P/FbFEhEndkdVv+NprV5snVBt3nCQR/grG0qM=
X-Received: by 2002:a17:902:ce88:b0:290:aaff:344e with SMTP id
 d9443c01a7336-2951a36c31cmr37241305ad.2.1761935390144; Fri, 31 Oct 2025
 11:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027020302.822544-1-csander@purestorage.com>
 <20251027020302.822544-5-csander@purestorage.com> <20251027075142.GA14661@lst.de>
In-Reply-To: <20251027075142.GA14661@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 31 Oct 2025 11:29:38 -0700
X-Gm-Features: AWmQ_bnD9cmB_he1htZLcay_wVtXtWzu-O7fBpjGn-Ny_vwA3iif2bU7bDu7dec
Message-ID: <CADUfDZq88mkARUOx-RQw72dwkTc2EB+0KiBtC6BL66e4pgiZxw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> > +static void blk_cmd_complete(struct io_tw_req tw_req, io_tw_token_t tw=
)
> >  {
> > +     unsigned int issue_flags =3D IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>
> In most of these ioctl handlers issue_flags only has a single user,
> so you might as well pass it directly.

Sure, happy to get rid of the intermediate variable in places where
issue_flags is only referenced once.

>
> In fact asm most external callers of io_uring_cmd_done pass that, would
> a helper that just harcodes it make sense and then maybe switch the
> special cases to use __io_uring_cmd_done directly?

While issue_flags is mainly used to pass to io_uring_cmd_done(), there
are some other uses too. For example, ublk_cmd_tw_cb() and
ublk_cmd_list_tw_cb() pass it to io_buffer_register_bvec() via
ublk_dispatch_req(), ublk_prep_auto_buf_reg(), and
ublk_auto_buf_reg(). Since uring_cmd implementations can perform
arbitrary work in task work context, I think it makes sense to keep
IO_URING_CMD_TASK_WORK_ISSUE_FLAG so it can be used wherever it's
required.

Best,
Caleb


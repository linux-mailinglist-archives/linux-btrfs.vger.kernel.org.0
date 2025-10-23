Return-Path: <linux-btrfs+bounces-18221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB08C03262
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D84F64EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192E34CFB7;
	Thu, 23 Oct 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fipiGJX8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2F34C992
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246740; cv=none; b=oBu3UpJItnBS/ox0PyVrjIfd+pdBCPY6e+TvpD5X2v7DhLOox8bXP2S6hfWJstqVVUdH0KgQceR1q/hmV2BRNxNQhT6qqLpzzkU1EFNCFGml1AXp7OqiyrftGZMNALFcW8jc2+Krir+1svp+XcAscEx0TFYnGgeOfWUJFhqrRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246740; c=relaxed/simple;
	bh=WOIv/HQOmDXhlsKgWbV5uUKMg9vn4FI+7vFtMCzboUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbDQWFY4XiDZRky7ztrj/8czk4YsyyUWgMLoZX9a4mu+AeXGAf+68hSMMl2MwjnssNAlzCgBwebpCilLOSVWEOaPpKdHoxyrXQXsunDwRcXVAXkWkjSSqy9nkE7uCk2TsdtimbQEPpI51E87wF3BPToEvh5WD0AEkR2pcwH5K2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fipiGJX8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2699ef1b4e3so2050025ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761246738; x=1761851538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K/5org+RE12u94kWINaZqrKuzfu8gGu9fC3i1OMh3w=;
        b=fipiGJX8dPxoMr2545eGq912NO7DB2OYnJgTbM0invCo9J/JSSdToACfCUizIbhfzg
         EGOophPpdxyV59a0Bkk74RvE8hOtWTwcsgZA9tp7aAVuc0HcczUtuDdiY4tdu+mscJv6
         99XUrKUD0KFiqM+1QgKHpN5F+0iCVhlFjDsm9AkgBGKVDjPMhWqpuX9esHA29lUFQAu/
         wELHXKXH4ViBi4m0+LVET18WQUqQhlGnweij3ELLAvQfkSpmSCKI54o3nFkTqeK6oocZ
         6BJHThUS3sU5sZvaIMImc3giZEeumrnXSC7ARARbJX/3fEaIQvbpXYnWY3Qo9wf0z7C9
         23Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761246738; x=1761851538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K/5org+RE12u94kWINaZqrKuzfu8gGu9fC3i1OMh3w=;
        b=FBv1yZAXTU0hrrQrxTs8HD3gTaPTAEhOP5qIRLBKYM8geAvGFzrA9iK0jQMu25D+0W
         ++s4auB7mot4l09qn89Jue4t+1QVMHTO0/z6yi9LuLtdFFis+TcLp6g63qsN8mSKoagB
         pDkVkSf8q2TrMD3EWcnmc/Cbbvy9l3F1Nzs416RtI7xMPpRdcdOiyhmlPIaekLsKaZeK
         Zg1ejBp/ly+ScI/athtF3e4ha8iRvOQN2GZYf/ODa7sNFft0Yg8zwHC2kIKU7r2Ywiyv
         oVSnr/VF+BTfeO6U2ZA/YGHfui8XNszH2bbkYI08rvDfT3sILP1WX3UHnwM1p6uy5Jbh
         GqZA==
X-Forwarded-Encrypted: i=1; AJvYcCXMgrWylYYWljEFx+T3jTEJYKvW/clIq51tpr02bSnlmIqfupvkfScsXOrYCDGsjMsI/kogNlTp1H07cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEyB0Ic64b6zKqZx5PP+pn3xj316SMhxSn6sZXfuiy5mzsTiD
	Tl3wyVSxNsWwyl/5qIb186ymJ/rd9SdRgDkUnVyVh8B8z7N5gMdP9UpubKr3btfOD6Mv9qnAc1n
	06vXc3hLYg9nt9aFeIE2ny/ZgWLyRtLA+F5elJTf8tw==
X-Gm-Gg: ASbGnct2NJdZ+de4RP+9wjOCrglS7df/jdY9lsTm6NHqB57viGx+GzLFMSJK0lJo51u
	H3X21JSXTg+Bl1vPkWJoMe5yWIlcruw1kiBdiRw5GJsKVBJWw75NkwkdDK467z04J7DMAsz5qDM
	7aBb5oqVLZKFs/1iZLl5J72O8bAa/+BL9HNFO6NFeh3CJ6AHUz/T3SvN1JmUYggYK2lU0sIAT38
	RgU2dilHSL2fERXA4s4VwUhAFtSVGHBqVl2v4c5nXdut9839+kDCQHa/CFpNodcSYiw+akCqR8/
	HELHkoruKlwhFBFh+YtYlq3PC/4YlFs3dCLgStOE
X-Google-Smtp-Source: AGHT+IFS1hF1mKJs9xtEGggpEYx3hS9IactTEcTVuTqq3cz04fXfG2tDmrwqCzZgwa2XisCpo38KJZa1Jx+ld2uWSgM=
X-Received: by 2002:a17:903:19e6:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-290cc2023d8mr183803265ad.9.1761246738317; Thu, 23 Oct 2025
 12:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022231326.2527838-1-csander@purestorage.com>
 <20251022231326.2527838-4-csander@purestorage.com> <20251023134047.GA24570@lst.de>
In-Reply-To: <20251023134047.GA24570@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Oct 2025 12:12:06 -0700
X-Gm-Features: AS18NWCMPnrkTE6bRuzJFrSEBQu8dMm91LH9slk7_UilpxZ_vUHOFG7TTmSOab4
Message-ID: <CADUfDZoMJ26nS9qzk1ACKX_MXkSpBy1kEEkekZoHyCrHtrGZRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 22, 2025 at 05:13:26PM -0600, Caleb Sander Mateos wrote:
> > io_uring task work dispatch makes an indirect call to struct io_kiocb's
> > io_task_work.func field to allow running arbitrary task work functions.
> > In the uring_cmd case, this calls io_uring_cmd_work(), which immediatel=
y
> > makes another indirect call to struct io_uring_cmd's task_work_cb field=
.
> > Introduce a macro DEFINE_IO_URING_CMD_TASK_WORK() to define a
> > io_req_tw_func_t function wrapping an io_uring_cmd_tw_t. Convert the
> > io_uring_cmd_tw_t function to the io_req_tw_func_t function in
> > io_uring_cmd_complete_in_task() and io_uring_cmd_do_in_task_lazy().
> > Use DEFINE_IO_URING_CMD_TASK_WORK() to define a io_req_tw_func_t
> > function for each existing io_uring_cmd_tw_t function. Now uring_cmd
> > task work dispatch makes a single indirect call to the io_req_tw_func_t
> > wrapper function, which can inline the io_uring_cmd_tw_t function. This
> > also allows removing the task_work_cb field from struct io_uring_cmd,
> > freeing up some additional storage space.
>
> Please just open code the logic instead of the symbol-hiding multi-level
> macro indirection.  Everyone who will have to touch the code in the
> future will thank you.

Sure, I can send out a v2 with that. My concern was that
io_kiocb_to_cmd() isn't really meant to be used outside the io_uring
internals. But I agree hiding the function definition in a macro is
less than ideal.

Thanks,
Caleb


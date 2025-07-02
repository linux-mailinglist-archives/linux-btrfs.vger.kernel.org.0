Return-Path: <linux-btrfs+bounces-15191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F9AF0BA2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 08:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D57A51C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8D221543;
	Wed,  2 Jul 2025 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R0aYEvhX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA71B4F1F
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437662; cv=none; b=XeGmoRo2JtfmuVTrkNheZ84huxXrvLebMR7CDLHAhvtQwrSmouC77dVVA9saw9bjG9YbAEawUj+KhAwYgM4OeMiJX9R7/mrtuCeN4PVwE9H9JjDvKUDJV7DKzkSR1ynuWv29ISl8yUaL5CFnsT2tcj14MfHIHrkBCwCT6ErZ9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437662; c=relaxed/simple;
	bh=myHASR+X5ssBqjEu1CM8REWLywC8Qy4nEDxDpgmgB2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpB52FKPa1Ga12VKSEZKQvPpB2FTIp6ZTYlJQrdpP8MuNISTiyRUVwD3I44rfUDytYwvDkQSLI0rCrQRghA7Iaote3EzyO81Rd469NZ4W+jsS5fbcgxiatUGuNgr4p5SD5t7dCZWqJKNlhmxXvJUYNoBIHgClp7CMMuYvrwHW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R0aYEvhX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad572ba1347so588989866b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 23:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751437657; x=1752042457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfvX0f6CCpo4khEDE50idlQCLa2H2opfHCksFcfRdXw=;
        b=R0aYEvhXibM32BYEl/oPXWdkVlFXTNOYzeobEL/55tlwIl1ojOZ2+Dvn0569/sZlkn
         Ya9LEwQKSqvFa58F+8CcM9qDWZ8uGu7a9ZRpUlF0/ypmPdx5baym8EoM4oO7rIUKL1Kx
         vSI9AAJsVYEZw6y4EWTuxBtKuRdQDmPJy4kYyw2IxHv8KU3xdZciL2SVwYzcPDpd4S8G
         xcJAd3zGMkTPrx70NHBnfycqpgJNhzhu79jgjlmF/wBPtt7qha5iEteEuuFjuY4eVtra
         4qHrM5xNEn90fODoHjV4C6KqWhGP2rAGY6Drr4+r5FM/rp6lsqhGUdr2AZF3YPl1tGin
         M3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751437657; x=1752042457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfvX0f6CCpo4khEDE50idlQCLa2H2opfHCksFcfRdXw=;
        b=sjCdgFG5yp+GCfYLo5AjQdq+GMvH8MfI60+4jhnFRgqWb5OBx3XE7M0+VwEd5nNsz+
         u6fDRw//x/KIYsB2gmKvNss+3Gl6m8IrjDFW9LtDkHJz7A9lSl/lxu3TZW0RrpKWnrHa
         iTST54Ib3yaj3rnzGFvuXEI5SElFHVbqN9tywoN6cMCbhBPsRZYsUC+l+AvfsaiZx7XM
         O8N+T6ywl/AC4HygaQ+eilsti1Uj5gynccuj1Gl4nXcOcpMejuChTeBxjbb9dpQFRVoY
         ejH3jhKkB0gXE7593ph2Z4blW4RfyHn43qRjnrcPFivcbW8e7NDoaT096gSXPforse+B
         njbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVASl/zKE7pm/UupHPRtdg4KrMIvVmSGbkDqbO3QNciYDFIFBFnSGfSMDWQQ7+MWXkYm9TS8nHvVi26Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45NTLLhNhUZjwwAJV01qZgoJp5NQb/FAtGhU236vLmMmlu57b
	uxY+6CTzLbxtFkBCUkWhIdCUa65Xw00eO7vt+oU6f+N1OgFwOmhRZqspTgyMqxvQpnZvGlsw3BC
	rNmMzUYfBf/0xkWpVBZqs9qULYnnslI5+StEVuuqQnQ==
X-Gm-Gg: ASbGncvYd4Q+epUbPMz9oexzkJDuSBDumKCDewEZvSYa3r6oWC+Ra1EjFRREYllfyWc
	u5Ocv9PhOiVcqTGEajM/03NawYSQEomyBdzdR0aRscrG0Klzuqqi28M5PRuEIq8nnezKJwTKZjt
	TrGnqJExTs8L8qkruUmkYikvK0aTj7kOLooR7dEGFlUg==
X-Google-Smtp-Source: AGHT+IEVsP/oX4SavVAomHyls7aE2eXpU769FttlHpj9iGiqfFPRyb3bd/0w0SwVCgrXq2hCbU8tVxR2F6muLA4g2gs=
X-Received: by 2002:a17:907:3d44:b0:ad9:85d3:e141 with SMTP id
 a640c23a62f3a-ae3c2e1a407mr159852866b.53.1751437657457; Tue, 01 Jul 2025
 23:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-3-csander@purestorage.com> <76d3c110-821a-471a-ae95-3a4ab1bf3324@kernel.dk>
In-Reply-To: <76d3c110-821a-471a-ae95-3a4ab1bf3324@kernel.dk>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 2 Jul 2025 08:27:26 +0200
X-Gm-Features: Ac12FXw_9in0adUkmoIgljnvz7S4Xj-lA7oSoD13D_kmAXoq3dHMYxm4RdfBGD4
Message-ID: <CAPjX3FfzsHWK=tRwDr4ZSOONq=RftF8THh5SWdT80N6EwesBVA@mail.gmail.com>
Subject: Re: [PATCH 2/4] io_uring/cmd: introduce IORING_URING_CMD_REISSUE flag
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Jul 2025 at 21:04, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 6/19/25 1:27 PM, Caleb Sander Mateos wrote:
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index 929cad6ee326..7cddc4c1c554 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -257,10 +257,12 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
> >                       req->iopoll_start = ktime_get_ns();
> >               }
> >       }
> >
> >       ret = file->f_op->uring_cmd(ioucmd, issue_flags);
> > +     if (ret == -EAGAIN)
> > +             ioucmd->flags |= IORING_URING_CMD_REISSUE;
> >       if (ret == -EAGAIN || ret == -EIOCBQUEUED)
> >               return ret;
>
> Probably fold that under the next statement?
>
>         if (ret == -EAGAIN || ret == -EIOCBQUEUED) {
>                 if (ret == -EAGAIN) {
>                         ioucmd->flags |= IORING_URING_CMD_REISSUE;
>                 return ret;
>         }
>
> ?

I'd argue the original looks simpler, cleaner.

> --
> Jens Axboe
>


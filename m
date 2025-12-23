Return-Path: <linux-btrfs+bounces-19994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6743CD95AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 13:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 042D03020CED
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB433A00C;
	Tue, 23 Dec 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slu5Iu1W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CC334696
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494112; cv=none; b=RD9O4dfj8AEdVqTleYMCcDsv0j2uC20/GbbPs6PsnawngRIMwEsyX6JVvc8NTvAo8yxdoISRVLTd7nqFQHGAk5XyeexGLZnzEla1DvOwrnAuNoQ+Pf9Kjhgnm8pCEoOtWXrBjPDFqp3SWZLU70OdKMtki/Qc0JPHtfbTZHOJtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494112; c=relaxed/simple;
	bh=TyWuiUjuv9NRlQrw9eDAeqNsuN51Gj4isH1mSnPF3CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghYddjJ2dN5bG3+PcHFj5N2wF2D7eAt/kANKTtXefTryHVAhZmr5He94F/D+8P11FqjKJeg54t1aYRvXLW8ZSAUbqTLX7XM8IOS9PP6zzGX05ORTxVbX0FNzyCNRZT3xNpScvZydm4Q00RPkGujfDd8jsydKw7Ri3iS8A+AUiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slu5Iu1W; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3196261b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 04:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766494111; x=1767098911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mDDIc7BTT0YBvGu7kbXjGPnOpXphnLDgy+PVSG8Nr0=;
        b=Slu5Iu1W8wqwZ4uJ3irz1pp25uCYAK5sCsp/roqtvEVnhHBfFP84xlAuVsj5etDL3T
         TVtijIzkEu2YqhQRBnL/W9dKR08vktlC6jCNYZMCh9UU7aCc00awYZnXSOuPuwVo2MmV
         qjxgQHpM/f+APkoSWcaJ9jaxMulMpcCxktkgBucoNmxOjQsohsNTWHy0RPzTFxOQMJk0
         bEamojtBCOC2O681Raltnu2dHa9gOppG4ZH2AHXgp/jUVwN+yrYLU/O7iTmhi6z+5jJD
         /3j9TfatiOJTHTj+dKvmLPq0jKvKKEJqEGt5EY6CCtDXMbKmZN4Mh6uuviH6IcJyEycQ
         CK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766494111; x=1767098911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mDDIc7BTT0YBvGu7kbXjGPnOpXphnLDgy+PVSG8Nr0=;
        b=kQiGP/BNAHI6pgupfBEN1NZWAIabkvHBkR/bxqAgXz5fVrZ15GrnssIixjIgqRE7uk
         /eGyIyHXQsZsGebUjcnSBlJvni3nN4NEUjFeu/ZNb7mjIchtZNoQTM+8sgyOTv2U8jXm
         2DPDek5lMWy63WCzYnvXvOxvYqa9vzUN2t1aGVU/Q+4NctAwZg15Gb5zzP5fDDrCuvst
         R6/AMSMT/RI/A+9OJqJYp56XaU/M6YF2Zr1ffSBdwtE+4BxqX5te/p9U0NQyN72FguTh
         KICwXGIQR9Kpa3qoZvVs4U/+iXH9hdZcbrrzV5o1YvobpqAbPWfVDDPRxT0jNLbWrbH+
         SrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4fhFv2HpeHtqsb0/3NRzZfay662IkN3dXDEWQDGHoTB7XfOMfXtqkvbN1w4jQaHwJMMnLitRi29rXUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIa+vTxm0mxSRSSKAn1Wqou9kJoDVZqBVJSMn+BFnl7up8up5
	Tv0iKuiBG2qQx78AuUG3IzPJE7tWWZ34I/qIZQixZlWP1eg0uLraxst4auLA8siM4XuXXSmi19D
	N3SdNpFVbOPy+Mf+XftP5lpGltDaQtJg=
X-Gm-Gg: AY/fxX7mSqro+3fOQvfhG9VV3+Dkh5l0kr85i4jkUIKFIGgUFYKTPSoMLk6Ex/QqfTr
	mOKy6d39pZ8B1U1fATs1170mKNvzHejTgko7MIpKPE7DQ9MRJfbKOE+9EmQryNWS15eyCkyBY6a
	TPEsl62FWPEmWo3kaYLBdmr8Ymf7uGFe7Fqo90ZZ1gMk+MWQd1wqz3yv+X81mbZmUnh4qI60IMI
	Yz4CiRUkXQoCvCRczhaGAMIW/JLE48aMaYv8HN4dNFa0ksYIxOgvtZeOA0hvJyl6Uzsg1T5
X-Google-Smtp-Source: AGHT+IGanwbn0o7zCluiAFK9QCpFbaBWJLPE29IQ1PJA+36ZhyjXk47nZ1z1lvZUz2318wsX1qVIziBioFPQhuJJrRk=
X-Received: by 2002:a05:6a20:7349:b0:370:8204:2179 with SMTP id
 adf61e73a8af0-376aa6ea9aemr12228834637.76.1766494110686; Tue, 23 Dec 2025
 04:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <79ae6c26545c107010719ee389947c1c@posteo.net> <20251223125647.6626b266@nvm>
 <1403c713e107106e18e000d7b0f81eaf@posteo.net> <CAA91j0XJNaGMyxJegYr7kr+JDg1RRFv9mOcGkwmoDKKk5dDp8g@mail.gmail.com>
 <282168f52d13e55e466c2fd079a246de@posteo.net>
In-Reply-To: <282168f52d13e55e466c2fd079a246de@posteo.net>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 23 Dec 2025 15:48:19 +0300
X-Gm-Features: AQt7F2r3hfQk9Gg3-S5eJpQ6Gs400ttLpSKI3o3hXFhqARhiceYKnstSlHL6m94
Message-ID: <CAA91j0Xsfd+U=diWpiWOVMjNZ1-Shj9idOU0oWiPOpetzrODPA@mail.gmail.com>
Subject: Re: Snapshots of individual files
To: BP25 <bp25@posteo.net>
Cc: Roman Mamedov <rm@romanrm.net>, Linux btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 3:08=E2=80=AFPM BP25 <bp25@posteo.net> wrote:
>
> Thanks for this message and the clarifications. The key was your note
> that I can put the copy in the snapshots folder: is this correct? if yes
> then Roman I think your answer indeed addresses my original question,
> and I misspoke in my previous email, sorry. Is there a standard way to
> 'follow' the same file along its snapshotted versions? Say, ask btrfs to
> return the list of snapshotted versions by giving input this or that
> file in the current version of the filesystem?

No. From this perspective reflinks are far more inferior to the
subvolume snapshots indeed.

> Note that if such file
> was deleted and another with the same name created I don't want that new
> file also to show up. And related question, is there any command that
> would list the snapshotted files which have no corresponding in the
> current version of the file system (for example because I deleted such
> file after having snapshotted it)?

Again, no. A file, "snapshotted" with reflinks, is indistinguishable
from the original file.

> Please CC or BCC me. Many thanks.
>
> On 23.12.2025 12:19, Andrei Borzenkov wrote:
> > On Tue, Dec 23, 2025 at 1:26=E2=80=AFPM BP25 wrote:
> >>
> >> Dear Roman,
> >> Thanks for your informative answer. But this is precisely the wrong
> >> solution: btrfs snapshots shouldn't and in fact don't clutter the
> >> filesystem with previous versions of the files because such ghost
> >> versions materialise when the snapshot is mounted.
> >
> > That depends on your subvolume layout. Nothing forces you to place the
> > file copy into the same directory as the source either.
> >> In my original
> >> message I seek for the analogous behaviour.
> >
> > It is exactly analogous.
> >
> >> Also I don't want to
> >> generate more and more copies...
> >>
> >
> > To reference a snapshot (be it subvolume or file) it must have a name
> > which you must provide. To create a snapshot with a given name in some
> > location this location must be accessible at the time the snapshot is
> > being created. As long as this location remains accessible its content
> > remains accessible. There is no difference between file and subvolume.
> >
> > If you complain that you cannot mount a single file outside of the
> > default subvolume and can only mount subvolumes - it is an entirely
> > different question which is unrelated to how this file was created.
>
> Sure, I'm not asking about this now.
>
> >
> >> On 23.12.2025 08:56, Roman Mamedov wrote:
> >> > On Tue, 23 Dec 2025 00:43:25 +0000 wrote:
> >> >
> >> >> Hello,
> >> >> Can any of you guys help me understand why it hasn't been made
> >> >> possible
> >> >> to snapshot individual files? Because technically it's trivial to
> >> >> implement therefore I suspect there must be some abstract reason...
> >> >> The
> >> >> only thing I can think of is the case where some file which was
> >> >> snapshotted is then deleted hence there is no way to 'select such
> >> >> file'
> >> >> and ask btrfs for the snapshotted versions... but even in this case=
 I
> >> >> see no problem: either the convention is that when you delete a fil=
e
> >> >> then all snapshots of such individual file are also deleted, or bet=
ter
> >> >> there is a command that shows all files who have been deleted but h=
ave
> >> >> have been snapshotted in the past.
> >> >> Any ideas?
> >> >> Please CC or BCC me cause I'm not subscribed.
> >> >
> >> > You can make "snapshots" of a file with:
> >> >
> >> >   cp -a --reflink filename filename.snap
> >> >
> >> > from what I tested this appears to be atomic (entire file is reflink=
ed
> >> > at
> >> > once), someone might correct me if I'm wrong.
> >> >
> >> > Works on modern XFS too.
> >>
> >>


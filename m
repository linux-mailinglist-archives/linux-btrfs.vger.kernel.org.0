Return-Path: <linux-btrfs+bounces-10911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD48A09C22
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF237A37D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F009206F1D;
	Fri, 10 Jan 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of4D9K5V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEEBA50
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736539397; cv=none; b=EsjvjX1OkETBXZHsXBesxBo8EC0a8zeyiBpozymcWLonP8zwHbuBmVWne6hzj2EItnsTxNVw4wO+LM1LG544d6v+190wRlo0LX1S1NTaanC0q4L0NHh328xsJ7T7vHhX4LFCTNTkgDOr0Xr1KypOu1YQeK1VlfkSpyWahDQeFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736539397; c=relaxed/simple;
	bh=N2MmUOKLWGdhrMrCCoJXLZQdW7np5UzetarXaVdxzi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYk1uPn6ffvO4FLcbtce2hcK0ZPollSjyLc6NGBZ22HThIP+D2Gm5RuY4g9/bYHcMwlXQ3rt+X8YNwA3OwcMTrm3g6I7bDM9w3XVvUpYz4f9ejp9GM6dEoaSSjdQKcbmUGrertdJK9G80LN45zYEYwPnVApVNSsu79mEC28mMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of4D9K5V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so367189066b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 12:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736539394; x=1737144194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLnpQzMZe87Emzj/Px9oJmvp7hBPvlVzu8zEeh9PExw=;
        b=Of4D9K5VAFk/N8nox1QCuOtduJu3dxo+VOlblRb9QRziw2kekEyKmfwwpP8a79QrdG
         X5vesp10CA/qgxQtovU+3ElVnlmGxQ/dwCtQFx7C0dPOwzXQahKwbtfCLpN7QfdC2nFp
         h1S/iBCCkeeidm6KHTfAWliALpEucoo34dVvHLGNa1gf4JUEMZSNkgS6lW0ynBaoOqi/
         PswWeDUGyWB8wNTfkyBJUn1XKqa8+Z9p84Cl0kX3YOQicYl2UXvQ8CYxPN/NDIVMV5gN
         IUb9g2JkM9adZxb1yXccLgTiwYHnBDfB4L3I58ae18h350aUZ9r+e5z7I64Tc5+IgEtT
         eX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736539394; x=1737144194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLnpQzMZe87Emzj/Px9oJmvp7hBPvlVzu8zEeh9PExw=;
        b=ezYiaOSkdz/rA/eqhM+rya/19VK9yCSCU4CCZYgg3Y1Pxay5DsS86goyR6ysrpmCgX
         pEZBag8JMkc9CkYCfSLV1UIQrZHLuXShFamZ7jIHKIW3GS4ddmvjpr9yUxf52cyEVolN
         7jqkdMvG0b8bX9i/ftzEtv0Po6eMKg+CihOQ++e9L5pMfLDb/3reNpmXCvGz9gWoKUA3
         fD1AznaP2QAzod8fyJahQe1gx6jfpABVC/4mCUcsCkPjLE/x4h0WzozDRvTzqHATEHvo
         G1xf/cHW/qp/VcAvgKCMkL3l3V9cOYNh/FW68dr3aYSJPgc9pw49AytCTeh3+7NFoHQg
         sE8A==
X-Gm-Message-State: AOJu0YzxvLoWwRQTIcNfSfH1HnX8OAv2foyXO/6VJjQ3T3t0IthbCcBD
	TxiSDe8/HzfASa9TJwU8SQ3Zxj2OykxlGQbyqKEt2Ko10JB55kzgDtFbf5XBhcFvPYm9VclcRKi
	doImR7OV0iqFfhunQyxSnjSznwlU=
X-Gm-Gg: ASbGncs6hfHRZmWuR/mFjzGRFZs5knHkkPrXSwcDOTXKB3bSeKeMWhkEpS5pOPMciwG
	/+jBgQwwW1by0yNCuvFlvvd1BztWxJdMLV/JcfSI=
X-Google-Smtp-Source: AGHT+IGWURheHj6vLNxHviUJBVGd+sasUn+fp3Ldvh6RrcZY/eBUIVG4PJd4E82FHp/+0eE0FVoU8YEsnE01d8IyvI8=
X-Received: by 2002:a05:6402:321a:b0:5d3:cff5:635e with SMTP id
 4fb4d7f45d1cf-5d972e63d86mr26692236a12.26.1736539393820; Fri, 10 Jan 2025
 12:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOE4rSzjUzf66T0ZxuN-PJqjRuoXoC9-LBQqg4TJ+4Hvx4h9zQ@mail.gmail.com>
 <db84010a-f5c8-4ec5-b5ae-babb04421307@meta.com>
In-Reply-To: <db84010a-f5c8-4ec5-b5ae-babb04421307@meta.com>
From: =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date: Fri, 10 Jan 2025 22:03:01 +0200
X-Gm-Features: AbW1kvavyRA4XkDXxahjEyX2qs-pY8ojUxyjl7RH75JbCR4UkKn6FTSQduAD_-o
Message-ID: <CAOE4rSyH7XrYO1ACwOOxF=S1bKDYTK2jbVtz6w=+yFSo7rjeFQ@mail.gmail.com>
Subject: Re: I created btrfs repair/data recovery tools
To: Mark Harmstone <maharmstone@meta.com>
Cc: BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

piektd., 2025. g. 10. janv., plkst. 11:38 =E2=80=94 lietot=C4=81js Mark Har=
mstone
(<maharmstone@meta.com>) rakst=C4=ABja:
>
> On 9/1/25 22:32, D=C4=81vis Mos=C4=81ns wrote:
> > Because most of the time block checksum is correct but only content
> > itself is corrupted,
> > that means you can find earlier generation (unreferenced) block and
> > try to guess/reconstruct corrupted block by copying data from the
> > earlier generation block.
> > And if checksum matches you know you got it right.
>
> This is an interesting idea (though I think I'd be looking to replace
> any hardware that had quite so many errors). Maybe look into translating
>   it into C, and getting it merged into btrfs-check?
> I'm not sure if it would be quite as useful for SSDs and NVMe drives
> though, as TRIM makes it far more likely that prior generations will be
> inaccessible.
>

This is orthogonal to replacing hardware. Even when doing that you
still might want to recover data. Like in case of HBA card failure the
disks itself are perfectly fine just with some non-persisted writes
etc.
I'm not sure if this would fit within btrfs-check as my understanding
is that it's more for repairing filesystem to be usable again while
this tool's idea is primary for data recovery. It's basically like
forensic tool aiding in recovering as much information as possible.
Also I don't think there's any other way to access earlier generations
than scanning everything which can be quite time consuming.
Essentially it would be a huge new feature that doesn't have that much
overlap with current way.
I don't remember if I ever encountered corruption issues with
SSDs/NVMEs so I can't say how well it would work for those but we
might learn about it when someone tries it out.

D=C4=81vis


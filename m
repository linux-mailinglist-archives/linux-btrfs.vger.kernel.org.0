Return-Path: <linux-btrfs+bounces-10315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4489EE412
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 11:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B145167030
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFB21129A;
	Thu, 12 Dec 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aJ3SWmA4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250E2101AF
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999194; cv=none; b=pB5N/VggJOznBe/onEEN/r/jNEn+Ou1/cRXX+y1rSwF7JTNhbMdRU0Eve2uuPbxRUR1k3mlV1WZCk18DPkdt9j1fiEyU6/A/0NZmn1FzSy3nCC3m+VzMkTe8sH8TugQ3O3k8C8KPF2Jim8IKby9wqTiFj34Wti98aSTOQ8zwyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999194; c=relaxed/simple;
	bh=jVswUeBk2R+z9ZnLjLAPKeYEEMow4andpI80HQc9KSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RstGm5Wwn33FS1IL+ev2OBdnUrQEXoRJ7L8xk81v6jSSeIIX04QXb6o+0rK8F5N9XhGupGEQCMY0lvO8cTPcKwylw1GbQzSu1MIKXeRwVljNRikgz7ygijk+e54GtUguQ3Rbnj+A0YcgMBzTdGbDiWGrKI/19vtU5JnI3qw8q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aJ3SWmA4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ec267b879so81967166b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733999191; x=1734603991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVswUeBk2R+z9ZnLjLAPKeYEEMow4andpI80HQc9KSE=;
        b=aJ3SWmA4KW0pFlp/GrBX1QWlBYRcizdNjbVpZAFJKMqJAiJBTiDaJz+GKBdgHj6Vf4
         KncicSeLN7hlfaT1MLkduV6ReE67pcwtFiGl94lI6YZ4JaErQ4ChtRJyngzG9ZlrYg5o
         k1bHb7mNiFI0yXovQbvQFCERNoo0LgdIEuqtdkeRwasrqs/IzETdeSYKIJSn+mE/rMXT
         QgpWfMj1DHp8iuLwhZFtauMq1gLL6zMSz8kvc99kd8qzfBZ0CreupOb3epmLn6L1V1he
         sjNY6aHjnUuYRiJMCbr1ttk5fmvV533cBpxJcOssgCth0Nr7e1RhrtCNKPoKmiWMJHrE
         pZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999191; x=1734603991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVswUeBk2R+z9ZnLjLAPKeYEEMow4andpI80HQc9KSE=;
        b=mdwEj86XPw16YgSWd1BiNMicjk+0lj4WwvGtexfMlu4+qllivCJ5r3CKyv91SERb5S
         PWJE/NBMjE92/CWz+qBj7QDb+7smaHccMbhrL0nv001RNcXCR2pkcaD+e00H+aYACOBc
         9Ie08cNvymWoQcAUqeCZzJCKNlYr/PDlCvRPq7OI/8GT8EkxidBez6J1aHI8GDY/6vHc
         J+dLUB70draDTLyScTAB0B4NQEoLpoN1kxo8urnO0PN2dlf87kR2/ZSME8O03EWTcrVG
         CROmgSLzdGe5jZ5vDpv6wm0vnmYSN4Kbrh3INLjwK/xKXW91o7k9J1R2hjDoAy2GXgyK
         dsQA==
X-Forwarded-Encrypted: i=1; AJvYcCWR22MQ7aT8ncBPcRGr2v2bXM7TakKWjPFpQQ8Wm/8rIsk2oLTm2Fwc2MRyEv12cpr+wMQkWGwka4cU2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+gDOrZrEEP89Gb9FJL1VqXDsHvkrVjcXl2kz2kWl13uFlxmo
	IzfW/0+NjC8P7AsBVNP6eDEZDi4focOlCTmEZocsfl7o9zNjtpPgtEbZFIRTf2euTCzVYqCSlnW
	V0Sp0/RuXGIzd9xJteNF08w8btvXnOsCE30d9SQ==
X-Gm-Gg: ASbGncvoIz4S8RgEd8IG9Z9lAghflIb1x9skDzfST5BIHgS6Qclzbt81jACD+AVfodR
	XLV4Jxqt1TzHYbZkqoFB3TFCpRAHANGK4P8hX
X-Google-Smtp-Source: AGHT+IH5yAN/gbiLL76Dk6LGA9jPui58kjRG4i8N9veQAZCoYkURqjEfO9YzuGA80yAQIDSiR81lnOHnHecPK3+61BY=
X-Received: by 2002:a17:907:9548:b0:aa6:7737:1991 with SMTP id
 a640c23a62f3a-aa6b10f5f65mr510217466b.2.1733999190969; Thu, 12 Dec 2024
 02:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com> <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com> <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
 <a8047d3a-ab45-42f0-8c60-f00829e40518@wdc.com>
In-Reply-To: <a8047d3a-ab45-42f0-8c60-f00829e40518@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 11:26:20 +0100
Message-ID: <CAPjX3Fexb19AcchSttsmm=JCcobBBCPXxF6_qkK=_yuqtgNRRg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 11:10=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 10:35, Daniel Vacek wrote:
> > On Thu, Dec 12, 2024 at 10:14=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >> It got recently force pushed, 34725028ec5500018f1cb5bfd55c669c7bbf1346
> >> it is now, sorry.
> >
> > Yeah, this looks very similar and it should fix the bug as well. In
> > fact the fix part looks exactly the same, I just also changed the
> > slab/stack allocation while you changed the atomic/refcount. But these
> > are unrelated, IIUC. I actually planned to split it into two patches
> > but David told me it's not necessary and I should send it as it is.
> >
> > Just nitpicking about your patch, the subject says simplify while I
> > don't really see any simplification.
> > Also it does not mention the UAF bug leading to crashes it fixes,
> > missing the Fixes: and CC: stable tags.
> >
> > What do we do now?
>
> I think it's up to David if he want's to send the patch for this rc or
> not. In my test environment the part that went upstream was sufficient
> to fix the UAF, so this was the part that actually went to Linus first.

But it (I assume you are referring to `05b36b04d74a`) does not really
fix the UAF. I'm still able to get the same crashes even with this
commit applied. That was actually where I originally started testing.

> @Dave can you send '34725028ec55 ("btrfs: simplify waiting for encoded
> read endios")' in the next PR? I can update the Fixes tag.

The commit message definitely needs to be updated mentioning that this
actually fixes the UAF which `05b36b04d74a` does not really address.

--nX


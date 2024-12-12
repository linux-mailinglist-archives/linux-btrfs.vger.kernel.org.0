Return-Path: <linux-btrfs+bounces-10313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD59EE324
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F1A1889DA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B2A20FA85;
	Thu, 12 Dec 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dm/A1yj6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF620E30C
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996101; cv=none; b=fF/eLWermwiQPFjdBaWkezPh9ltMiop3L/oT8zdhEwnDt3L6Qf29VDyHCOG/sv58Dbk9TV7R7rOR8gnLDtp2VgPPc3TS4J4tu8w3ib8hQ3k8U2Uuf2aNIb6F1hnSgz6/qqgxyOm1QOfFmn5pfVpVHENXT9VFv6K2sHxY3V8z9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996101; c=relaxed/simple;
	bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX/uevPII7ga4xCZchcWnomW+O/nJSHOv3hHVGFNn8wBE2/gNovUqMfVGa4n75lYC6KRaaOCDMg5bzIG7ZkCFpf3uPy9+gW2+7XVPrAeSbblTAHtU+2dFgez7esFt6hMDsbT6gQIOvf+tGi2CHzxwpcAWe2F8u6mNMBhztOBrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dm/A1yj6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa67ac42819so57647266b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 01:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733996098; x=1734600898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
        b=dm/A1yj6i/bNJkGbkc7RTTAXe1u5S7qlb3bXU8SWdFKPl29E9HDHrfDZD0U32zTIzw
         jGXLRG4VKr0BNdok5TNMfjzD7ZbKZq4eW12x767WmqB3TGPRYanBIzRchWncrolt36ZP
         bLGyRTXrnEnQVgf70x5dGnkn7kiuZGyRjHhAmrCL51xvtOPHPAbN0Xn1zegl1xNngqqJ
         uLw6XbrKajB0Zn7dYtY/EU8UPoPHpKKFF2cMcVhsEPyP1v/lCQlaYH1p0KOR99o/WNKM
         BJkegtILYSXOzo49VfwV0vdn+0k9Qx+w6dh4SVcpUDj5UzF23ANOTeNcR/ep0QfD0wa4
         wBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996098; x=1734600898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHclkJEe7ltjnV5LPkMt6YBe5vpfC581sZsic1DZYno=;
        b=gSbm4bKL/iMB7abQI/38uUxJQr8uTojDCxU9N5xG45Cfv2Yrsu+8rFYpB8krjnAcC1
         /osaocIN2pevogJkI8s9T/24sl/Xvao49hzKnIci80Ta6QhvzaZDAPY03QgQT9IFIC9y
         NenM0VTeBly7a7qVwnQtbnhr2sjz/RWHXBkfDHNuzIMiOM214vFN1kYO+6W0rP7yTNUq
         +Xp29TlXvUqw5L3QZ8/PmONPP2gTtlQICyCeUqEXZSZK0/f4fTfyFhwd9Kw4k0xYXq4u
         Flv5xM8SdH5zkxTgUn0C4Sm3fzOmr5oip3p5MAs+PS4/dxlUEaHqJ6pqAFQnN+l/rFBt
         CPdw==
X-Forwarded-Encrypted: i=1; AJvYcCVnpUIKnPp/3keXc1wsuBKxzyzF2y4UZm7AG60k1wI/KCr0MKqN1u0Y5CL5sUG3gNHQ0HGSbH3U+sQLbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCa3LOOCUPWUb+YfZXAXPUzLmmOLkF7YcajeEK+7q6rEfiuyr
	qUxLfb+cTJd71rmdpX8mJOc0mW2DWwL02dONIk4cEMyXRDVwfgyfWtA1Yu7oHWo3sJvZpwf7DFy
	t/rIeZgIH9PQt0/Jb0JCU7JdT/aMH9kj4IPheKQ==
X-Gm-Gg: ASbGnctfID9VEEkyL72UTOhNHEO8eSRw3Bqx01xG9a1b14jxCbydPVjuSHMAc7WBiPg
	zLIQPnRI+Kz5r3YMWD2AwGUeIzdozvjmJ/Whl
X-Google-Smtp-Source: AGHT+IGjmOUF0dmAFvQ+spqIORx1VvFbP7DOU+11FOPHLYxp+IkPWpvwS4gEQHgdr928IyJxvQcPXfqsqgvUnrfIthM=
X-Received: by 2002:a17:906:1da9:b0:aa6:a33c:70a7 with SMTP id
 a640c23a62f3a-aa6c1d02831mr275658766b.49.1733996097955; Thu, 12 Dec 2024
 01:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com> <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
In-Reply-To: <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 10:34:47 +0100
Message-ID: <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
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

On Thu, Dec 12, 2024 at 10:14=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
> It got recently force pushed, 34725028ec5500018f1cb5bfd55c669c7bbf1346
> it is now, sorry.

Yeah, this looks very similar and it should fix the bug as well. In
fact the fix part looks exactly the same, I just also changed the
slab/stack allocation while you changed the atomic/refcount. But these
are unrelated, IIUC. I actually planned to split it into two patches
but David told me it's not necessary and I should send it as it is.

Just nitpicking about your patch, the subject says simplify while I
don't really see any simplification.
Also it does not mention the UAF bug leading to crashes it fixes,
missing the Fixes: and CC: stable tags.

What do we do now?

--nX


Return-Path: <linux-btrfs+bounces-10970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB21DA116A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 02:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECAE18867C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDE35969;
	Wed, 15 Jan 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9k3XOEU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010023243D
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904737; cv=none; b=eeWTXCEN7693U9IIh43tFmkZ166T/MiBN5XGlPe+9ln4z+1pCiszuwVRlJkyDh/ct98INJ1Pp3vheOwMgJ/1FKbfyNDW9fzZWk0OX6hG+N+ZFMSxGnc9HQZD8jAkZRyZSoR2S9Q8/nR7bUzcWfBrqZTUNvulY8hpyUNvzKvYmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904737; c=relaxed/simple;
	bh=TR1gJIVvOVRCum5zrxl5EkJ0UiIxSEIVdX9Ws8rK5gM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Swi/F5ecyQ2SIMLi1R57mdyHSoerULp5QtD7nXOD6po+sTFEhmjNEyEOo1LFfcoIx842F4tltYR6ayWGSftwWqepXxw5FSB5X34+bqAx8C1pjGBfKIfhp9EZ4goIAnkHHj/DJPM+q40kNgoKpQr5GrpL94IOfINtXvfD9nI52/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9k3XOEU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f19a6c04so546135785a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736904735; x=1737509535; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TR1gJIVvOVRCum5zrxl5EkJ0UiIxSEIVdX9Ws8rK5gM=;
        b=J9k3XOEUqIDz+90YzadfQxpH0vMKXtQrzn2YgY8V6nfQRQL3r/xsCRq9FkCH+CSrff
         2cY9eDc1Sj3RwW8fM3qK2iLbuSQg8vH76pYeeyKJx1l5VMxUXnrsekaRY2lasrql3SUo
         KscYyNTWnJgke0EuO0iyu0KbdodnhU5gouqfA3gogc4WA6LeGLl5ThWUSRuWN7LmyGP0
         MH6S1gm7EbObKoBso0NtRtp+a9p5fYEdB8Kyp4lvbFRLUZn3eRhRQeyDOXfviss4Uk+X
         XgM0g5agQZAFtYTbSwrP0ukFzjYhp8GcfiQqnHKGRlFG4zMzh/ePPlUHsKnSBnpT6s7R
         pJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736904735; x=1737509535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TR1gJIVvOVRCum5zrxl5EkJ0UiIxSEIVdX9Ws8rK5gM=;
        b=QOpckeRsTiz2nXB32dsj8+9+qccACFUZJaqGloVhTAc23ZCntdPOIl6OvpmlGBA3Jz
         YEbSv2j9pHq21AQJp4X3cew5Nxg7bWuQar63dZ4+VDBMNs4NPs+c7Nwkrpa+fNszxzKU
         vhw+q5KtXcMpC7Yh46xMGzHq8eeVf1jMPZwN57lhPboy64GSOGdqoA6ST1cwHjaB0sO9
         U+v1KR4t7pCkBybCkxHbfGvlIKwBYik2/kTTNdDIV4GU2AkgDuEWCPwoFMiRN5Yd+rHy
         TELDDMyDamNkueGzpDDC9Uwtlg3TqSLAogtYY5h8rM92ymmYzACd5EL18eUMNXWyad15
         QoWA==
X-Gm-Message-State: AOJu0YzcprLqLJcbtSDczAoq/UwMun5ZbCjhHekE1Wj5uIpWRr4VBnIA
	SGDEBahUWjEowbraq9/F18o2C/i5FFJ54F9CcQWAGWhtfX8uBeuv
X-Gm-Gg: ASbGncu0kAU3oqHPeUP/k7QWaLgCsSzY50bKy/hXHg7i4oQKzBUst4dLCZbwprg7nt7
	7aHDXT+gdv789uoN3r9KK5uyAVX2DJVP/HXdY9HAetGf+mkeQ+SPsNvSY23hJ510o4ynih607qQ
	DWjTTE70uB1FGs5VltUCPx+KBEYruy3VDArXVyGS0y5kIme2u95dZ5z6a17TYQhDD+6/+5prxdT
	YGHhZDRaY48KpZrBVbLEvgUstHOJDNJ2U54jZ5uIe8+05XkFxIZALzrONVfJf0fuLRcTF42zC5k
	OVrO46//hnJG+MHBrl1nINU0yK2tVZJ63f/R6g==
X-Google-Smtp-Source: AGHT+IFpZT56che+IZ1UeiQ61d6pfCf8/N87oQeYDtlio5Oat7UgDwFq3WbwIFkIAvpiEW76lFpZGw==
X-Received: by 2002:a05:620a:24c9:b0:7b6:dc1f:b98c with SMTP id af79cd13be357-7bcd97c8f55mr4197903385a.52.1736904734713;
        Tue, 14 Jan 2025 17:32:14 -0800 (PST)
Received: from ?IPv6:2600:4041:5b0d:f100:fec2:7085:7ce5:711c? ([2600:4041:5b0d:f100:fec2:7085:7ce5:711c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3504268sm667171785a.94.2025.01.14.17.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 17:32:13 -0800 (PST)
Message-ID: <adf490d379b1970b8cbac849f98b92247d7f1cbb.camel@gmail.com>
Subject: Re: write time tree block corruption detected, forced readonly
From: Jared Van Bortel <jared.e.vb@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Date: Tue, 14 Jan 2025 20:32:12 -0500
In-Reply-To: <c5c9bce6-070a-4138-8a13-2618a75b3477@suse.com>
References: <fcc9c66cac45aee144755ee35714d2d358199d25.camel@gmail.com>
	 <cd42beff-741d-4b9c-b78d-4244df06d0c3@gmx.com>
	 <41deb494a3e661d78cc5f2427356457fa5ab36c8.camel@gmail.com>
	 <c5c9bce6-070a-4138-8a13-2618a75b3477@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 15:59 +1030, Qu Wenruo wrote:
> =E5=9C=A8 2025/1/14 12:22, Jared Van Bortel =E5=86=99=E9=81=93:
> > On Tue, 2025-01-14 at 07:24 +1030, Qu Wenruo wrote:
> > > =E5=9C=A8 2025/1/14 07:00, Jared Van Bortel =E5=86=99=E9=81=93:
> > > > Hi all,
> > > >=20
> > > > I am using Arch Linux with the latest linux-zen kernel (6.12.9-
> > > > zen1-
> > > > 1-
> > > > zen). I saw the below error in dmesg today, and my filesystem
> > > > went
> > > > read-
> > > > only. I haven't rebooted the computer yet. This is my root
> > > > filesystem.
> > > > What should by next steps be in order to get this computer up
> > > > and
> > > > running again?
> > >=20
> > > In your particular case, it's a very strong indicator of bad
> > > hardware
> > > RAM (bitflip).
> > >=20
> > > Thankfully the corrupted metadata is rejected before writing to
> > > the
> > > disk, so your fs should still be fine.
> > >=20
> > > So your next step should be run memtest, either memtest86+ as UEFI
> > > payload (preferred), or memtester inside Linux (with minimal other
> > > program running).
> > >=20
> > > After fixing the bad hardware RAM, then I'd recommend to run a
> > > "btrfs
> > > check --readonly" to verify there is no other problem in the fs.
> > > Although tree-checker is doing a very good job, it's impossible to
> > > catch
> > > all bitflips.
> >=20
> > Thanks for the suggestion. I ran memtest86+ and it found an error
> > fairly
> > quickly. I switched to some known good RAM for the time being, and
> > btrfs
> > check --readonly reported no errors.
>=20
> Forgot one thing, you should also try scrub or "btrfs check=20
> --check-data-csum", as if the bitflip happens in the csum tree/data,
> it=20
> will cause csum mismatch and unable to read the data.
>=20
> But it's a great news that all your metadata is totally fine.
>=20
> [...]

I ran a scrub and it reported no errors.


Thanks,
Jared


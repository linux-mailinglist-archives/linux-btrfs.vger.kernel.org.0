Return-Path: <linux-btrfs+bounces-13543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED6AA4986
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D6C9A38B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A656248F70;
	Wed, 30 Apr 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMGE7Vpj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAD210FB;
	Wed, 30 Apr 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011361; cv=none; b=JSNNS4J9eanSo614kGF5igd5YNhSFL78Pf6oVeRaUkcXW5AcnnYLfgTT4hKh6B/9qfaNd6AhxvGQdwkt1eLrnTBgWH06J3+YSn5eXlsJWrWLZFT7CpoSRGS+UAWY+7Z1NYuetOiG+VGTVTXdWJcrvUIVk5SvBES+vOVLWaeaOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011361; c=relaxed/simple;
	bh=YSaFNmzNjtEF5p0dsK8tdZykWTu+wWo88X4YUeJAgw0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5AoBaDK4Vqw1MQliwfm9cSjeivN6123xg9tS4oQUibHRnqS4emDlWb5lW5nv1lr7FKIFg0ss1WuAF4OZA7P/E/LzjwehQ+81xqQZc/7TLgeQ7q3UmE6htr0fZsBtUGYBYEWjOc/q4h9ky6TrBIaF6B+39j+uQo01VicPJ0nrlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMGE7Vpj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c0dfba946so5329331f8f.3;
        Wed, 30 Apr 2025 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746011358; x=1746616158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SEitgjtahAtNU2wvVTIjLweOLMfaME/emj9moqRDOvQ=;
        b=dMGE7VpjvmJEWtLYdo09VP2sKvcNewMn7CevCNMUOIiAXTZF1Vv3K6hNTvJg8SSX5U
         COsjOBb6ggMpycd99eP4RqLQTWDw1QyhPmLyexZODzhXguAvDk9fjwfsEaIBd/Eam57T
         tfc4UWzXgV4AHiR4Nm8bAO3Uz9CHLsNa/79WEx76uNWzr9k8gD7/YzY3VdJJbC1tGQrf
         a80mHar8RSa7TowfLuqi0dO5S21p/9Bb1f0pwEdQdifMP5/GkgjOPp55CGT0MbqUio/r
         vX4I7+vZR2UFv6edk/Za00ryEWM7q8wnJ1G5EoVrcJu0CRtj94TUkEweZwE7nTsr99Eb
         PYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746011358; x=1746616158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEitgjtahAtNU2wvVTIjLweOLMfaME/emj9moqRDOvQ=;
        b=WZIfTq6vBF2VhRIHpDrrmcHA2v24+jsF6Y2TzwX42PSTm/cjI/LMecpvUXK+CeP7ix
         r4zQJYpE4lQK34Xrp8Ys/Bai4/nge1mMrGe0EUGJZWcmmisqD56KBo2CVh80AOvpKfc3
         pT5ZsjMefENQ1LTbEiJ/7GkFoLVgu/lGkzPu1sazrgvHXiMI+5o/8fU6dUDqyptgwCFu
         Vnv5BX94c98tow/rx1bvfX9V+13SY7qZ977QnCOdT7WHIk1tjqqmggQaokpOFgZn4N2H
         J0QaW+uExr6f4H2sqGaFXgVODGzjk12s6NqmMwpcmVqvQG1FXSosROo4Ngjgo7J+duq0
         2rPw==
X-Forwarded-Encrypted: i=1; AJvYcCWCpRmCNMbjM95sPlCSunmNZ1sED1DUeVo+g49d6ZSism6I8ctAaTmV2PxDN6ynhCOI7SczvKFdWI7kaIiw@vger.kernel.org, AJvYcCXtj8r3crfoC5m0bWgtssKac9T7Bjf5Bb9en0p/HadPn6VO2m7Uwmo0bGQOQ1LdixIPtPm8N+A/+fPdxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1i130Z1t1MghPhpaN6wriR//hXKyQx9lvmQ7AelSNU985MPv0
	NfnkHHliMKiq6d8jLi/Np/5xYwpv/ZCgWdGpeLIxqVr1C0A+V5rF
X-Gm-Gg: ASbGncuL6Jz5uFMM8YNSQ2B7xok6WTnglTy46ub8paD65Lc/UWZI280V2vuS4bZrWJa
	ws88in57pTMIGH1srBwzsmWlIwrVHeTrjFZ171nagE2bPt/vJRPKEO2vK2UYBIRnLHSJS870trV
	+SGswHKFm7I/JKj5EuWNI/PotsWedXouRJD/H9GN6M/Bbk8RrBqIwDFbyc/kJdERTNna3Rc9K6B
	RjtwgNDJhZ+HWoXmf1jqrwFQUMEa0ADk+lNG25W6KxL/L00+lpgK4WKtxlZGH89VGez3xvczaZm
	sa4VGBo1N/7hkbNdgISbW8idIbmQ63Quy9pXXXGA/q4OBpaDRa+p3aMRcqSaPetZ6XxJsg==
X-Google-Smtp-Source: AGHT+IGxu9Uh4q2RnnhbGf0tPulsnpozzeUe4ztSuFazWW+jQqWLTtORjDXUbuDaxoelee08v6dY9w==
X-Received: by 2002:a05:6000:40c9:b0:39c:1257:c96c with SMTP id ffacd0b85a97d-3a08ff555b3mr1768979f8f.56.1746011358215;
        Wed, 30 Apr 2025 04:09:18 -0700 (PDT)
Received: from fedora (p54ad9e64.dip0.t-ipconnect.de. [84.173.158.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c9cdsm16597307f8f.87.2025.04.30.04.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:09:17 -0700 (PDT)
From: Johannes Thumshirn <morbidrsa@gmail.com>
X-Google-Original-From: Johannes Thumshirn <johannes@fedora>
Date: Wed, 30 Apr 2025 13:09:15 +0200
To: Filipe Manana <fdmanana@kernel.org>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
Message-ID: <aBIE28WHbC2jPkpz@fedora>
References: <20250429151800.649010-1-neelx@suse.com>
 <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
 <CAPjX3FevwHRzyHzgLjcZ8reHtJ3isw3eREYrMvNCPLMDR=NJ4g@mail.gmail.com>
 <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
 <CAPjX3Fe3BZ8OB2ZVMn58pY5E9k9j=uNAmuqM4R1tO=sPvx7-pA@mail.gmail.com>
 <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com>

On Wed, Apr 30, 2025 at 11:26:08AM +0100, Filipe Manana wrote:
> On Wed, Apr 30, 2025 at 9:50 AM Daniel Vacek <neelx@suse.com> wrote:
> >
> > Nah, thanks again. I was not aware of that. Will keep it in mind.
> >
> > Still, it doesn't make sense to me to be honest. I mean specifically
> > with this example. The header file is also private to btrfs, no public
> > API. Personally I wouldn't differentiate if it's a source or a header
> > file. The code can be freely moved around. And with the prefix the
> > code would end up more bloated and less readable, IMO. But let's not
> > start any flamewars here.
> 
> I'd disagree about less readability. Reading code that calls a
> function with the btrfs prefix makes it clear it's a btrfs specific
> function.
> Looking at ext4 and xfs, functions declared or defined in their
> headers have a "ext4_", "ext_" or "xfs_" prefix.

To add my $.02 here, it is also a matter of namespacing. There's nothing more
anoying than having two functions with the same name in different subsystems.
IIRC we did have this with the in_range() function, that is available globally
and there has been a btrfs specific as well.

Byte,
	Johannes


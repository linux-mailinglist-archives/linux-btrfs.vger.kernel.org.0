Return-Path: <linux-btrfs+bounces-19150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8263C6F287
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 786FD2EC54
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99A3659EE;
	Wed, 19 Nov 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kwf/TCl7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F2364EBA
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561410; cv=none; b=aG52Gll/gnXiNMbg7BVofzGCk3ObNYUtNFMKXP8EMgWdqYIHn7T2ekJQ2GXFSp11etvtn85JIz/APePVaQEMQwlemRXvdhrNxvEn1GK7yKhMdaQjyb6MK8QPd4Y9Ro6V5eywB+RfxRKPVqyRE+1ITHGGobBnwnAEZdV7n/fZSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561410; c=relaxed/simple;
	bh=wjXlOrZ+78jX+pXwU67z6t0fceDV3Si4bP9kHk6aAAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgZEn/jtVK1vMtKJmWZxzprPsEXrUeCqQfeIAolwyUtAxldDdQAoTyEPO7fUowDIRszRrf4PPDj89c6FhamtA1B98B2BTMQMTaXcipsMzM6jdrHIfbURz8RbvUOWcaPtUAGDxiaXZ0VyIHf+EgY7JAk2Gy1mlQ6uG5Sv4uD7/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kwf/TCl7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632d45c9so50177925e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763561405; x=1764166205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oRKwoQcgf5JkDjyYd5r4HdqXCQvo5X+fvSrgHsSakOs=;
        b=Kwf/TCl7dTJ4A+gP/113g/8FsEQIdcM9h5pLH2i4d5kzDH4IeFZDbDpbYYRFOKPWK7
         1CplM3DCilaqes6dOCy7ylOigiFU90H1csT4IiNSx3KU3H32YLs2L4tYtRSomuAaNevm
         2vfkNd+kpc1yt6xSLzZlUtidReRj5xAQCC+K0j+g2MVZlW6UY4mjf/2SC3FIGttNpYrH
         3IaZ1loT0QGz2aaVW2qL01QuJwUVC4SPeE1M9TPOxYMRVHcA8K0J9jBr7QuL1N/cwZUm
         QTcdiC1fFJSB7E4O2luuRZal7uQvTpRV2mCRb7FyMP0fAY5FCN9IDfuh2QS7py889GCi
         jYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561405; x=1764166205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRKwoQcgf5JkDjyYd5r4HdqXCQvo5X+fvSrgHsSakOs=;
        b=mEreQ6FSAb49otr3/gUfqA42nk0WCXIfs7+mGF9yAxlDa9693cRXoyIgYj5CUCIKhI
         sBMRThu3NhdkuqaB+h+KH7ep6Z3OcOp1+pvy4BLhy24Tc8ZjRPsahkMsmPpntI+VhAWn
         6/NM/cldOedXz/TfXOtTf+z6ZkwZIjB7RWtzIvd4eZwmbkHZlbxlqZwudwgdKqw0i7+0
         YdC/aClIx8clWf8Bdwe3iF+snJWkCLuZTrQTd1X/kluFU+uOzVJMkA70nMtrTTzAjDNV
         bgwE6XEdM9A/KgGzhq8a+w+JYlxvGon1qW6LkZLOfFmnVhhlPWFrPderIuQkQc9mHrQ6
         P+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpxi5+E9tYTtFAX0bWNj+yewLKKGdwYebmtzY+VQl/1KM1p9z0YmHyNLeA/HxaoAk9EFJBWyJUL9y5xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl7DUzzpK8btqOX5PBAnBeeNwWCVMM4PCGaOfBbFq+VUrZw+e
	rremxNDpr19d1INEcGvagmvHawYyFpZXd9tPd0WclZuOj6t2qSGDgKu4XfpoETq4u2EQUXy0T8U
	nsNruvUvBONwjNjYpiuBXu111WxwaFt5QUO1O19+k8w==
X-Gm-Gg: ASbGncsKODNOGxEEP61Pfa0BQKm/LzmS29fXpcHcUe61C0iVUfg9MwDOYJnsGFIl1Tn
	gR+NZbr8mcs7vnyV+lK7B7UYHp/33XVQvce09vjkQVtdiETR+BdwTRDwzadoCwZnpZHoNEAz7eq
	dMQE0ecnJ5JCydmwAWh5uCJszuHp3T+0FOHlOWAyiwHyBj8qcn3SBxXmGiMw2jCRLPglpKS7X/J
	agjKVCSHhs7KNUDSxu+ZHGSEQ84mlH1giaLIUMMOUlqcze2X8fAYMq9CWwP7Q3VD8W6X62/08he
	bTM1OWJ8pZlZBr3K3h84r//QfxpVv2hAE/xOeH1NsJj6z3hpIHgJVDFN1BNTX2UK0fVPrbYz2vA
	1Y6U=
X-Google-Smtp-Source: AGHT+IHsIkZXbl8vEqsE2xWCqOr0m/w6QkhgIUzY0tQC/+X+u9Pb7pZ23g3BeSjeLOML+KjgIL4/a2b8Yu0mYEz3ck8=
X-Received: by 2002:a05:6000:22c9:b0:425:7406:d298 with SMTP id
 ffacd0b85a97d-42b59342d64mr20459223f8f.5.1763561404868; Wed, 19 Nov 2025
 06:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118160845.3006733-1-neelx@suse.com> <20251119121645.GF13846@twin.jikos.cz>
In-Reply-To: <20251119121645.GF13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Nov 2025 15:09:53 +0100
X-Gm-Features: AWmQ_blJDaINcxQwiF7pPz5lbDEH0m_LX-dCaryIXmPgUeUtoG2HbMSXLtcsNbw
Message-ID: <CAPjX3FfN+Mfb41vYVGM19mm+-XYM0sBUFX1i5vProp1mDU9TPQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 13:16, David Sterba <dsterba@suse.cz> wrote:
> On Tue, Nov 18, 2025 at 05:08:37PM +0100, Daniel Vacek wrote:
> > This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
> > native encryption support to btrfs.
> >
> > It will come in more parts. The first part this time is splitting the simple
> > and isolated stuff out first to reduce the size of the final patchset.
> >
> > Changes:
> >  * v8 - Clean my mistakenly added Signed-off-by:
> >  * v7 - Drop the checksum patch for now. It will make more sense later.
> >       - Drop the btrfs/330 fix. It seems no longer needed after the years.
> >  * v6 vs v5 [1] is mostly rebase to the latest for-next and cleaning up the
> >    conflicts.
> >
> > The remaining part needs further cleanup and a bit of redesign and it will
> > follow later.
>
> Thanks, I've added it to for-next with the following note:
>
>     Note: The patch was taken from v5 of fscrypt patchset
>     (https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
>     which was handled over time by various people: Omar
>     Sandoval, Sweet Tea Dorminy, Josef Bacik.
>
> And added your signed-off as you're submitting it.

Thanks. I'll do the same with the rest of the series.


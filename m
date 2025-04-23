Return-Path: <linux-btrfs+bounces-13287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DEA98669
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4465A1848
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116525F798;
	Wed, 23 Apr 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pygl6aTV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43A1E0DEB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401698; cv=none; b=tZBJ3pASVjprHsJ6T7p2r7WcWGTsY+JYRTcVs6XnnKlyAUTj3x0dK2DtLpm/dfPBA/fl9hM+YWjVMOjKrr5gC1grwEnz101RL2wW4+OxFvFfCAs2V09iXqisTgOXmtnd24ApowCG2JmA3z567C4qZJgnK5waLw28N77i2eN1c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401698; c=relaxed/simple;
	bh=CkYe7KQz50Vk5hVwM4De0HxlJ6l/u7mNP1mNAfjOGrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUdl/git8FEqQRELGScrd1jKohmBW5YUcXiQpVX9qRCaTgcGhTwMJTdYUVZJJ1n5X0LtrCdUmJlckFRryQaPO+rGpJJyl+zBIjdCkDJPLS8rKLv/mZhaw2Ij2ejQPLDel21eYGeRbXsvecTq7l4y6wUa4VJ8y/B2ZxrcGZXL32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pygl6aTV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2aeada833so155370966b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745401693; x=1746006493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgKA9pbsvNPBxBjf1g70tKPE1M+bS/FmY4rPNG02f4Q=;
        b=Pygl6aTV7U9v4W2dprD2mc1cWVtL9+4NVQ3vMrCi75xRrylGLb5joQf7n7b/DIpHn2
         7B6MjMNZwvNVw0XnSR5Ev67G23kvw9Tfedqa7BQ1kWLgy89Q/+XedxgbHiRpXxjzc44o
         G6k68arsHzCPcsDFDvHzg431/ILtZhY8TT+E4v6CqMLgJtAVMz7VZLxobgf9ivgDKg2T
         kIuhoUI9QyDL66lhnSyIKKRhk02rkW56zJX5K8qAS22JhLVCCsKO19nO9r12nJsqB+fP
         UraqQX8mdKIHMuMK/i/VSVa7f8/IcgLxUkIYAGIWEGVAWuNTZdwx/YVwfc9NhfhgGuJV
         SWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401693; x=1746006493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgKA9pbsvNPBxBjf1g70tKPE1M+bS/FmY4rPNG02f4Q=;
        b=BhCDYouQIoraOpqj1bgx6BFXjQT2/8NJMB15h3XLZrcJantuvlSN3rCArNWRABx02b
         BovnLVPzh/bwAji2PJbcXL7qXFF4jySDGuokVc+B2KFmRPJZ1iM86jgi+XOjC7BFOFLn
         c0UGCVJeF4sIVrIK+lMQ6QH9uZp+LK0zLDcJ22X7PBYp3XkJxv8Ln0mN7P0DMcSO6Ndn
         YRrhKmAFobuzhHeRDuf7cIj8iNY5KLyZ+WduCHTFNlHLqA2ThhFyshRA8ziARlpSWpy5
         oyTltB6X9kX0C3vk03S2IOU63JiBQCcnsqdJhQdWTdWNK0lyVjZ57c5bJeLvAlMwG1Vx
         UJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUTuLfF4/yT9OJDb15mzBmHyKkPHTWJLcYn9/ZPFAmXfWdaieojZ9YTgpXu0kGMhyrUze2yEbd9Fqqs0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YylWejGRXspNQ/K1/PnyeePuf2mqr299ThwtIyb13lVpK1IRulJ
	sToX9/Ao2d/AhoVcZw/TDpb+JRKwngnn1b/9QGYw+7j1OJGFR0WNLTfSeKTXSHZeJooZ/v6q1oU
	iL9ew53BcInktfWFNofCldV4K6dHfBga6IFqLqA==
X-Gm-Gg: ASbGncsPEq1j5Hlr0tvIciThQLFyDdt8fyvV+mlVNi0p9IoM2JJW+foiD+DXFOxrJ/k
	WzYiQYR0FOouYC4z3h6f+PvDJpI4g3acQSuSMJfiGO4EPoMXGF6owuA2mhebvwWBI23O9SjYNwE
	zIeSTGnovLXJp0ij78ihWvoKSNHjoHSHI=
X-Google-Smtp-Source: AGHT+IE+8bYSke4FP+p6PQMgiRcJuZXFwIGogu92r+zEM6Bmo3Q+Idw1dhZWveMvN+FH++UzViCxM7RmqkVA0x2IHms=
X-Received: by 2002:a17:907:1c8c:b0:aca:c699:8d3c with SMTP id
 a640c23a62f3a-ace3f254e7bmr220960366b.2.1745401693592; Wed, 23 Apr 2025
 02:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423080940.4025020-1-neelx@suse.com> <CAL3q7H7A_OnTQviZpCgzrGUFe1K=VfMiWXaba56E3ucPHnVkNg@mail.gmail.com>
In-Reply-To: <CAL3q7H7A_OnTQviZpCgzrGUFe1K=VfMiWXaba56E3ucPHnVkNg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 23 Apr 2025 11:48:01 +0200
X-Gm-Features: ATxdqUF3U4FzwbWeM5rcfOACcVKfWJgB7wLcEF0eM2OaXd5lqZeWqt45UzCmIy4
Message-ID: <CAPjX3Fdor0TgkQtb2meJD4PFerOQV1Qcjs5HEyBCt5TNt8-vsA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fiemap: make the assert more explicit after
 handling the error cases
To: Filipe Manana <fdmanana@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 at 11:04, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Apr 23, 2025 at 9:10=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > Let's not assert the errors and clearly state the expected result only
> > after eventual error handling. It makes a bit more sense this way.
>
> It doesn't make more sense to me...
> I prefer to assert expected results right after the function call.

Oh well, if an error is expected then I get it. Is an error likely
here? I understood the comment says there can't be a file extent item
at offset (u64)-1 which implies a strict return value of 1 and not an
error or something >1. So that's why. And it's still quite after the
function call.

But I'm happy to scratch it if you don't like it.

> Thanks.
>
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >  fs/btrfs/fiemap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
> > index b80c07ad8c5e7..034f832e10c1a 100644
> > --- a/fs/btrfs/fiemap.c
> > +++ b/fs/btrfs/fiemap.c
> > @@ -568,10 +568,10 @@ static int fiemap_find_last_extent_offset(struct =
btrfs_inode *inode,
> >          * there might be preallocation past i_size.
> >          */
> >         ret =3D btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1=
, 0);
> > -       /* There can't be a file extent item at offset (u64)-1 */
> > -       ASSERT(ret !=3D 0);
> >         if (ret < 0)
> >                 return ret;
> > +       /* There can't be a file extent item at offset (u64)-1 */
> > +       ASSERT(ret =3D=3D 1);
> >
> >         /*
> >          * For a non-existing key, btrfs_search_slot() always leaves us=
 at a
> > --
> > 2.47.2
> >
> >


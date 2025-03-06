Return-Path: <linux-btrfs+bounces-12052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B25A54BC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 14:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5C3B36E2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567620E016;
	Thu,  6 Mar 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LmgtsH9d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6820E6F3
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266927; cv=none; b=gr9sEQUcMoYF3DFsBNUJqKMu1iF7dQqsFbBEZF1hkkkzM682xq9idjGRPoDIw8wF5V4XBjllZnCxWfprhfFPSOCkWbmYFvoZihnePzH1uFRD7UdD0AdfBlgSEdWiUghmDPrbI/NXXqdE1Y/5Iexa+fBS6fGvlVzEoJ5545FhOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266927; c=relaxed/simple;
	bh=tuXAj8epHA1okuSh3jNGyyI9p2J9gO/ol36jpkgVrGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgTeGuKvbTDR57GaSMTWr5ESfMPdPzUnGgeKTFrxXN7Bwf/8F+shOgSJsuO9/sa9A2pij+HV4C0PUqUV7xn1IRM5IWRagV3FF9iUwAfsXJY4e4ZAAoX/N8wECMqNc5lp8ar+m5XbDsgXnww0D0B4U+lIsOgIhyFJHD0AhHC86jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LmgtsH9d; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf52666efdso101881366b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266923; x=1741871723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tkjipGCLl59HXX7zIHl0ZVIsR0Gq+aS61W9w8YQk4eA=;
        b=LmgtsH9d2f0gIWB7aUwalJmvasY0JFbQFFl9IfH3XdJPcU7oLkvc87/VMJYF57YiZ0
         osjSxAWEaAST2TQwvnqty47usGgv5/9tPmtw86LlWR4sD4aKWbg3VIFtPoGiPUGGIVHP
         QVpWH83HIY8G2VpdauCMT8k3yh2/oeQK7iTskKa4VkuGFZ+MOoFTsmOyiCE9etXA2C1I
         zk6pnaJ/OkAP+WPuUiOMFV8XGYnaahki5I6Dgj45ykp+TK/gkOvBn4iAw3mot/H0EcnF
         uh5by/gnjlh604Io8GvLsZogWp5e4+EcyvKU3VKS/poWxEdjzvkiT4zY8tD1f+ddoHK2
         MWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266923; x=1741871723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkjipGCLl59HXX7zIHl0ZVIsR0Gq+aS61W9w8YQk4eA=;
        b=L45DN4La6rAHQ0554/7Cmw91wW0E4vqdryxBv0KubCC1ZRYGV/UTeFT74jIySTA5z9
         qNwFTJppULtejYNytVTGDTOtdFv0NYepoZOBzLfEL3uETDVATadIEUw/SpwWaqpbPrsU
         LfW3jB6aF1/WMYRU5TF+gJvB0ZDu0bXwZoGc8FD0JS1BtFyGhjV5j3wA9LIBnjAekZRM
         a2lxRF/HmkWtD9Iw8aPJaefMCnDCUTUqG1anwecUmFW+fBwdO0CTHp+cEhEHrG8cgcz+
         /mxG+oK+HrdmsHIVzDG/YpIsAISKoM7n0751DPeBQMolGqK/XuoIjLvUtWG61NskFQK5
         IBFw==
X-Forwarded-Encrypted: i=1; AJvYcCXIDE2cYm+S2o/9WUWp5hvOFS9rYZdOocp6TR4YhYS/uZtwnTmEw5Rhfz4vIKAHzdE/TaQ+kfKd2uUCZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkqx3Q93NQx1UIuuYtWFbaxvYguMjocei8DuAgnIN2wNKcZvm
	vjnH6f3d0BMArQq1KrYhq147kCYrq3JF3zSmPhD/pLo6tskSv8FaM4rn7KQDlQE9YTuIAaMk5zs
	FIdhta+w6xi6R08lL0vDsB+v/smGO788hBzT4dw==
X-Gm-Gg: ASbGncsiMUl/KxpIN6p7pe0gfNctGRiZHDaS2Mwk1P/K357kjwk8B9yhdAyJUqz8XDa
	jFoOxjUgKewTdGPCTvlaV98d22BPzkQHSV9ntzbDaVH1F3fHWK44HuU7+/jRZi7havXELnx51hW
	MFFZgSdKgtnosWOde1NRaUD0F8
X-Google-Smtp-Source: AGHT+IH1nTf2aYG2MsKHGRRVysAJUQZtUWYOVVYk8ihsB5hOgO5e2gNmewj2gMfrlyivRtXUsTVQNcE00VH9S1lvD9E=
X-Received: by 2002:a17:907:da9:b0:abf:497d:a23d with SMTP id
 a640c23a62f3a-ac20db01cbbmr767637566b.53.1741266923049; Thu, 06 Mar 2025
 05:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304171403.571335-1-neelx@suse.com> <20250305103235.719210-1-neelx@suse.com>
 <20250306082730.GG5777@twin.jikos.cz>
In-Reply-To: <20250306082730.GG5777@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 6 Mar 2025 14:15:10 +0100
X-Gm-Features: AQ5f1JruieyZRQ8kZf1KT75C5t_eIN5DR3-4IzvxJDsf5PbdFyekwC_gnrW5kX4
Message-ID: <CAPjX3FeBVghdwQO8v+DGXzzFRcpfkHTprrpv=GtWbCPfyuZkmg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/defrag: implement compression levels
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Nick Terrell <terrelln@fb.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 09:27, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 05, 2025 at 11:32:34AM +0100, Daniel Vacek wrote:
> > The zstd and zlib compression types support setting compression levels.
> > Enhance the defrag interface to specify the levels as well.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > ---
> > v2: Fixed the commit message and added an explicit level range check.
>
> Where is the level range check? It silently clamps the range but this is
> not a check. What I had in mind was to return -EINVAL if the level is
> out of range.

I see. For some reason I still had the clamping on my mind. I'll send
a v3 with this.

> > @@ -1376,10 +1377,21 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> >               return -EINVAL;
> >
> >       if (do_compress) {
> > -             if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > -                     return -EINVAL;
> > -             if (range->compress_type)
> > -                     compress_type = range->compress_type;
> > +             if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > +                     if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> > +                             return -EINVAL;
> > +                     if (range->compress.type) {
> > +                             compress_type = range->compress.type;
> > +                             compress_level= range->compress.level;
>
> Please put spaces around binary operators, so " = ".
>
> > +                             compress_level= btrfs_compress_set_level(compress_type,
> > +                                                                      compress_level);
>
> This should check if the test is in the range.
>
> My idea was to add helper like this
>
> bool btrfs_compress_level_valid(type, level) {
>         ... ops = btrfs_compress_op[type];
>
>         if (level < ops->min_type || level > ops->max_type)
>                 return false;
> }
> > +                     }
> > +             } else {
> > +                     if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > +                             return -EINVAL;
> > +                     if (range->compress_type)
> > +                             compress_type = range->compress_type;
> > +             }
> >       }
> >
> >       if (extent_thresh == 0)
> >       if (ret)
> > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > index d3b222d7af240..3540d33d6f50c 100644
> > --- a/include/uapi/linux/btrfs.h
> > +++ b/include/uapi/linux/btrfs.h
> > @@ -615,7 +615,9 @@ struct btrfs_ioctl_clone_range_args {
> >   */
> >  #define BTRFS_DEFRAG_RANGE_COMPRESS 1
> >  #define BTRFS_DEFRAG_RANGE_START_IO 2
> > +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
> >  #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP        (BTRFS_DEFRAG_RANGE_COMPRESS |          \
> > +                                      BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |    \
> >                                        BTRFS_DEFRAG_RANGE_START_IO)
> >
> >  struct btrfs_ioctl_defrag_range_args {
> > @@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
> >        * for this defrag operation.  If unspecified, zlib will
> >        * be used
> >        */
> > -     __u32 compress_type;
>
> Please update the comment mentioning that the type + level are used when
> the BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL flag is set.
>
> > +     union {
> > +             __u32 compress_type;
> > +             struct {
> > +                     __u8 type;
> > +                     __s8 level;
> > +             } compress;
> > +     };
> >
> >       /* spare for later */
> >       __u32 unused[4];
> > --
> > 2.47.2
> >


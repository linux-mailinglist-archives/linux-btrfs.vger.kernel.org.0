Return-Path: <linux-btrfs+bounces-18252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD1C04EC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BA11A6431C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018F2FD68B;
	Fri, 24 Oct 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve8M67mQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14018AFD
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292976; cv=none; b=Ai0fiwLpFiZJO+3gOKKZlpKsMpDklcvc5AueVIWSwLvcauGEsCthd+7YG1eCv96RMtED6HS2fVfcSP0NG4hxTcX8tEwZhf9dpO+JuSsO5lvLkE0nYYYIAa9jzb9dPrwYL1n0bmTxWnT8DNEZLYorifp20dqh+Hrj8+hhnV/mrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292976; c=relaxed/simple;
	bh=UvJWdwsZNhy1Hrfio+QqlSg1cgrhxke0P5v4DVDv7kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idevSEtrJCiZ4p2fRAkYvzTEscqBHdo2ID/6//bxmAva4r5S36HgDzEZ/muC0c0tXkwIvmY+tietUHVSmB7i+Oboqoe/BnMjXsWy5XVX34yJHUAhEcsY2o8HaZRiyI+WpjqyLdJfkMWqwrB+PDu5mehBZ5MdXiTpgbojHkMOaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve8M67mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CFCC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761292976;
	bh=UvJWdwsZNhy1Hrfio+QqlSg1cgrhxke0P5v4DVDv7kI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ve8M67mQcGYXRQBWff09TebITKZq12EWxtbJmqrYglBtWATggkiWjBqF/73B7uVKQ
	 xL3VJcSOu9/BSXZiFBpOUcHPu4PbJY0LC0CXf2YHa6LZL3P4SiwYyCzF1vihAeKOkD
	 r6ZgZqHB5Rit9GzYsnCquk4RN9mvNEc/JFnAsRq+SH6GneCJ6NsVq+WMDQFtH5xEze
	 oElbh/tPUzq8kNtb9+xVDMknG9GZNUWCocoRMb9toE68W+NgbFyHglO340UekkNOtY
	 Nrn4A0wog4YoSiyymoT8+cH80TcmnHMe/rK/xaHU8JIssGetaPyQNxy5NURk9XETN7
	 56bRIyjBmVHZA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d402422c2so406996766b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 01:02:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxTgsv7dWASh84cqYQc+hXyfwDOOCyJY3uvS1PEt0lHAhVAaXaX
	sIu+JX8CDq6kWJNi3NWQNaiu+h7XkX9qYPwlFgZ0dYEqZwNNDluFIvGBAFF3a2WJWOuvIcRcCbY
	CFV2simGfB7sqfmVglUluvxwq/Geq6ZA=
X-Google-Smtp-Source: AGHT+IEhAEpI9qVhbX4VlrqnBui00t5YZpA12l0TYJSRIPLf78sh5T9XO62gCls5/PM6g4wUbcDCCyh3/QL4MNRzGo4=
X-Received: by 2002:a17:906:9c82:b0:b38:6689:b9fe with SMTP id
 a640c23a62f3a-b6471d45a01mr3113112666b.7.1761292974579; Fri, 24 Oct 2025
 01:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761234580.git.fdmanana@suse.com> <6ad94bc6f4671e932d76188ce9aeb7026b22b27f.1761234581.git.fdmanana@suse.com>
 <14fe0899-0f5f-4c57-bce5-7a42efec0b16@wdc.com>
In-Reply-To: <14fe0899-0f5f-4c57-bce5-7a42efec0b16@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 09:02:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Nh3aNb3agCqEMLOa1pAefV2boVdAyhbpVwrMSRxr4hQ@mail.gmail.com>
X-Gm-Features: AWmQ_blhPSGS2rORiGro3mj7QxT9rOTRXk8nSKlCikSxhww6heP41uAn2S0N2bs
Message-ID: <CAL3q7H5Nh3aNb3agCqEMLOa1pAefV2boVdAyhbpVwrMSRxr4hQ@mail.gmail.com>
Subject: Re: [PATCH 19/28] btrfs: reduce block group critical section in pin_down_extent()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:21=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 10/23/25 6:02 PM, fdmanana@kernel.org wrote:
> >   {
> > +     const u64 reserved_bytes =3D (reserved ? num_bytes : 0);
> > +
> >       spin_lock(&cache->space_info->lock);
> >       spin_lock(&cache->lock);
> >       cache->pinned +=3D num_bytes;
> > -     btrfs_space_info_update_bytes_pinned(cache->space_info, num_bytes=
);
> > -     if (reserved) {
> > -             cache->reserved -=3D num_bytes;
> > -             cache->space_info->bytes_reserved -=3D num_bytes;
> > -     }
> > +     cache->reserved -=3D reserved_bytes;
> >       spin_unlock(&cache->lock);
> > +     cache->space_info->bytes_reserved -=3D reserved_bytes;
> > +     btrfs_space_info_update_bytes_pinned(cache->space_info, num_bytes=
);
> >       spin_unlock(&cache->space_info->lock);
>
> Again do we need to have cache->lock and space_info->lock to be nested?

Yes, many places depend on that.
The goal here, and other similar patches, is just to reduce the block
group's critical section.

Getting rid of this dependency, locking space_info, then locking bg
and then update bg, might be doable but will require broader changes
which are outside this patchset's scope.

Thanks.

>


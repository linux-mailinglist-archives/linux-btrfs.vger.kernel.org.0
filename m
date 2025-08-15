Return-Path: <linux-btrfs+bounces-16081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A832B27AFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F26CA22C96
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7062BE7C8;
	Fri, 15 Aug 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVmIGzFY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1429B78D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246553; cv=none; b=sESHjyEg16G0ZUEnEPBGY/a6SexGrs4M9k/i+A8VuKRl2v1J/sFyp2ba7zb+7HB6c+KDZ5Qsn4Ii3jd1bRIjC6lk5BdYS2FDNfVSzqFAa27OADNveUSScqDuPMpqzXzbEk6VaUPqXE3QLki+rdRmg65QDlehE4/ME4MUkzk6O7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246553; c=relaxed/simple;
	bh=J5uAyrnh2U3lA7b9hW0jcl/Z0Ad8OiOdt1pfxiSQJd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oADA8XfTbJfgM2MPr+iM+Q2XPXY2NJiBNMACtof+DkpBwDkZkfpKs6m9E/bCAAFjyVir5g/fVoRjtKzZyGprHJ6Igp394eOrykrVn+Q5MmjlJNE/w78d8+lLmddRZeQtQA9hcTSiNScPNiAjW2z8gmbGEezPgFUVuseuADSQlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVmIGzFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEBC4CEF6
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755246553;
	bh=J5uAyrnh2U3lA7b9hW0jcl/Z0Ad8OiOdt1pfxiSQJd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LVmIGzFYYwktRxvAmasEw66e+uH57myZeK41fnJ9cLuuwarcKiH5/9I+CNet0t2IJ
	 0rCTthF6rIU/O95xo+pHmvGuBqmczn8eM6SHuRtau1ht+eX16UHEW5sbpLqqoIAguT
	 tuQkiqWHFmy9vnEcJVd/wRVGDmfNtsog0nRAddovldNFjEOUesnYF2FUnpNqY8lL2x
	 zSMutBjSoBCfDiKOso8jyZOoGYndCg+vo4hzXga8j/nNYIsgqXQuff6J5SmpzxMhmD
	 zWjqbjsGvZ2TLaoe4jNra1XEPU59Q53+71TGOSkqfArJVDy2CQOEPMtOl6LAJXMoY5
	 erx1539UKmENg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so235527666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 01:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0NGnMBENrC96yT6keYl/rklpgIohhps09BcSS+wl4BGarfSpQPWN97d1LlgjVUCZiuUEyEeB1c53mkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+LF5k8fRS39h41muDHQfOI2CwLtkl+tZItWjseipAqWYSm3Y
	gYSI1OD6zPdvnpYaqz8ht9WmsFntCD0/u/j/MYLkqcFGsmlGx6E1QzHm2bmRYLiNBVdK+0LY+Z4
	5MUKn/Th7Nc9drOFeYKvW+P+P+jAufzc=
X-Google-Smtp-Source: AGHT+IHMZ6O/9MKq6eUgQnMtGryHTnl/mAOoac4l13xUpxFNmVK+Eh1zlBkfBUZ6WzLSi/Gt7o3kGPKNHTba56SbkBg=
X-Received: by 2002:a17:907:3f25:b0:af9:5ca0:e4fe with SMTP id
 a640c23a62f3a-afcdc2b9e7amr114286966b.56.1755246551620; Fri, 15 Aug 2025
 01:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJ7YkIlcNnv1YKeh@stanley.mountain>
In-Reply-To: <aJ7YkIlcNnv1YKeh@stanley.mountain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 15 Aug 2025 09:28:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H60EKQbXUm_cfEY+bsv+SpnYV0uLuVSGNKkgMnHKCkiGg@mail.gmail.com>
X-Gm-Features: Ac12FXwjozf_nWP8ZQFOc4Emm642j8A6w-ozquRubhfBrU8s0cFNMgSOYi4PJ-E
Message-ID: <CAL3q7H60EKQbXUm_cfEY+bsv+SpnYV0uLuVSGNKkgMnHKCkiGg@mail.gmail.com>
Subject: Re: [bug report] btrfs: abort transaction in the process_one_buffer()
 log tree walk callback
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 7:50=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Filipe Manana,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit f6f79221b128 ("btrfs: abort transaction in the
> process_one_buffer() log tree walk callback") from Jul 16, 2025,
> leads to the following Smatch complaint:
>
> fs/btrfs/tree-log.c:377 process_one_buffer() warn: variable dereferenced =
before check 'trans' (see line 375)
> fs/btrfs/tree-log.c:388 process_one_buffer() warn: variable dereferenced =
before check 'trans' (see line 375)
>
> fs/btrfs/tree-log.c
>    374          if (wc->pin) {
>    375                  ret =3D btrfs_pin_extent_for_log_replay(trans, eb=
);
>                                                               ^^^^^
> The patch adds a dereference

False alarm. This already happened before that patch, we didn't check
if wc->trans was NULL before calling
btrfs_pin_extent_for_log_replay(), and that's fine because if wc->pin
is true then trans is not NULL.

Thanks.

>
>    376                  if (ret) {
>    377                          if (trans)
>                                     ^^^^^
> And also this check which is too late.
>
>    378                                  btrfs_abort_transaction(trans, re=
t);
>    379                          else
>
> regards,
> dan carpenter
>


Return-Path: <linux-btrfs+bounces-20905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HLZHbPxcWlKZwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20905-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 10:45:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6664BBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 10:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8C88622F43
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202D346A15;
	Thu, 22 Jan 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKXpblty"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5E332EAF
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074579; cv=none; b=go/X7RjfShdjA6AMG1FqRi/IlQHEjhPxRIG32OgWlUQxe9MHnhYY76KBfA3QoinuH5rTzIsUH2de4O0R85jATNTFLpX35qaJ7n+WIFj4yBKmvJPu9BqPG8D6xesGHITqVDHxC1gofSmYocRe3cILtU9OrezRtE/pa7PUIksnwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074579; c=relaxed/simple;
	bh=aMoGf4sGVvC3D6oHTQPOt7yeVbufNTqw5h4WmmeAE8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhQd79Tbf6smkZBakuOLbUGEy1vMRmW3LUWbZqnCKEvJnHbS+Yept0PWr2m7Dh9N4BVOLgoDQ44yceQ+pjyd0DmsRHvWTNyhl9/C1xwT6HNbe+on0rkB+53O0om5fjG+ioUdsh14AZOwV4KqVQfR7cFrQoPKi9dFsyFUPKjqfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKXpblty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F52CC116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769074579;
	bh=aMoGf4sGVvC3D6oHTQPOt7yeVbufNTqw5h4WmmeAE8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZKXpbltyCDNJgylt3VXeingSsZa5gh6PuQQwOMPosuQ5eZlBaciMOTDLlywvrhiy1
	 RAak7LzwUmuJ8nBAEtTh0jG6BmfQu6xVpW3fC+tyrgFV8X3t0qF1C8JLNlXn6bP6Ei
	 OCAOE5AGkYOW5zxSCcPf7c8GrSFfu3WqyEvB9rOq9gDj+0k3uWO0MmmoVkhOdz2pln
	 gZInui9QHTYjFCbKNpZ0QU1chjBBTy7CtpPsQxzZkZyVcc5uccb+mhlcjNwsm19E58
	 /h5FCq9CGWp7lPDU6HrFz6beSrDzb/8FfmlT+J1R2BwDu6j4nSa/Ub1D7pjhIrG3kg
	 93ZnO1hem+dqA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso89686466b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 01:36:18 -0800 (PST)
X-Gm-Message-State: AOJu0YzIHPuDlfW52zj0fkBrQ8VsSObaN+e42bv1JNhjr8SuNj3q/Vxn
	AcdcdhFv/Jgar7V3etwbh37EN8gWV0WujTDCFFng1nANh8QGp5Klh/h76abV+TGf1NWfbtTzzg0
	YKUyIQm/fw1WH+Sn1iNfovlQR5vc/MlU=
X-Received: by 2002:a17:907:74e:b0:b83:972c:77fe with SMTP id
 a640c23a62f3a-b8792d3be19mr1692967866b.2.1769074576745; Thu, 22 Jan 2026
 01:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769036831.git.wqu@suse.com>
In-Reply-To: <cover.1769036831.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 22 Jan 2026 09:35:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H569i9KrpkbWXTTbhSUQnMr8CUBXGBXjSRhj_L6-YRHDA@mail.gmail.com>
X-Gm-Features: AZwV_QjfpixHcW0xENOohtPH-aL5tQbxUHiyQzf5_Rss8DWbUK_dBSNycxWTBH4
Message-ID: <CAL3q7H569i9KrpkbWXTTbhSUQnMr8CUBXGBXjSRhj_L6-YRHDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] btrfs: apply strict alignment checks to extent maps
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20905-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2BE6664BBB
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 11:15=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [CHANGELOG]
> v2:
> - Grammar fixes
>
>   Not only spelling fixes, but also extra new line after an item of a
>   list.
>
> - Remove unnecessary ASSERT()s inside inode tests
>
>   There is already enough comments on each test file extent item.
>
> - Remove some unnecessary commit messages from patch 3
>
>   Which not only introduces grammar errors, but also duplicated.
>
>
> Although we already have strict checks on file extent items from
> tree-checker, we never do proper alignment checks for extent maps.
>
> The reason is mostly due to the failure of self tests and how hard it is
> to touch them, especially for the inode self tests.
>
> I have to say the inode self test is really something, the extent maps
> of the self test makes no sense, and would be rejected by the
> tree-checker if they show up in the real world.
> Thankfully only the first few file extents items are invalid, the
> remaining ones are totally fine.
>
> The comments are not any better, after the first line, there are no more
> aligned number at all, and the numbers are not offset by 1, but 3 or
> even more.
> Considering we're using decimals for most of our dump-tree and comments,
> no one is really going to note the wrong numbers until one throw them
> into python or whatever calculator one prefers.
>
> The series will mostly rework the inode self tests file extent item
> layout so that they represent the real world better, and update the
> comments and make the poor person who needs to update that selftest
> suffer less in the future.
>
> Then address the minor problem in the extent-map selftest where
> fs_info->sectorsize is never properly populated for the 4K based self
> test.
>
> With all those done, we can finally put a proper alignment check into
> validate_extent_map() which is called for every new, merged or replaced
> extent map.
>
> Qu Wenruo (3):
>   btrfs: tests: remove invalid file extent map tests
>   btrfs: tests: prepare extent map tests for strict alignment checks
>   btrfs: add strict extent map alignment checks

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

>
>  fs/btrfs/extent_map.c             | 12 ++++
>  fs/btrfs/tests/extent-map-tests.c | 16 ++++--
>  fs/btrfs/tests/inode-tests.c      | 96 ++++++++++++++++---------------
>  3 files changed, 72 insertions(+), 52 deletions(-)
>
> --
> 2.52.0
>
>


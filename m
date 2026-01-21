Return-Path: <linux-btrfs+bounces-20862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLlUI1MacWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20862-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:26:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF535B3DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01755A681FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAF2C0F7A;
	Wed, 21 Jan 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9AOcmC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E732D45E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015595; cv=none; b=Gtk1c+O8qMYhZ8MWL6h/wb7wycic7fL0CWrWiIu02MFtT12GnlBIs2eEj5LnNlqmyQ4eeqOahWYljreD19OWoD6XSBQe/d/O9VgPDLfXUKERWXyYwoyZYJdvjRYg6tLT7CayVqGXwC8cAZP411Mpa46Hwxeyo+Ey5AltAnGgSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015595; c=relaxed/simple;
	bh=fAMn+RfVvCvRlc6aieFsWDqBoR00zx/ahI6yAXmaiC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l75tmor5LUS6V0kYPIaU0HL0HtGjvjQAkd7DORh1iH+PDoli+opacZeipKr7KJe7ZHtBet6FrDE6XAZ2TyWwc0TAZ8hZF01Y3di+0lK0eZXd0jPk0a8AEGXN/vPBAVG0B7RTBhkghAiZ5IetGMb0uYp0AGPOhZY9pk14PXn3x+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9AOcmC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0684FC4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769015595;
	bh=fAMn+RfVvCvRlc6aieFsWDqBoR00zx/ahI6yAXmaiC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L9AOcmC0YrPzKZDNM/QvBTIpN8pNz+RfOqBvoAtftMyDap0kDhBShUmDSOlW/E9Q5
	 9sJU2xbJzARyELT6VAhH1c4fsN18yoSdEGcrgZs+cKfgmIzoHxSvJi1e6ODt1/DqJp
	 ju+x5n1h/S527F9M3TxFx5i+F63nRnZ7t/qJ12GSSiyBDDtSDAJOAWqyfSt9gsSg/8
	 btGIwYHMkVNdK0+zVbwsIW01q1dIKfBWNDOVIfB8/BAJ5mbl3Px1fPmdnnv6gOv0WC
	 qxTJRaQMsfoeD6PhcrLwC4Zm8kcFZcZ9JolcziigyIZotX9Nkjrpe+QOeMNmlnK2bu
	 YpgmT5aYx4M/A==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8825463733so1801866b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 09:13:14 -0800 (PST)
X-Gm-Message-State: AOJu0YyR+Z733bR4vv5inPpvIQbteb6KPXIC+Vtog2UO/4e98btGBmlt
	aYVq/1ZmDDkhOgBOUZklO7rkrLXvDgoOs1bj9CUpXSYoqo0u7gtF8kSHlxNIYPPagAdrzPznPQi
	XieRMR4Jys2W7k9Hzk8gMqXUj+cABo3Y=
X-Received: by 2002:a17:907:97c8:b0:b87:40fd:c913 with SMTP id
 a640c23a62f3a-b87968b6b22mr1587188866b.2.1769015593604; Wed, 21 Jan 2026
 09:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768714131.git.wqu@suse.com> <81ea002b4dd0a522b41fd9f9fd2bec5ef97d515c.1768714131.git.wqu@suse.com>
In-Reply-To: <81ea002b4dd0a522b41fd9f9fd2bec5ef97d515c.1768714131.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Jan 2026 17:12:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7edbz+gA2+5vkoCK1O4JkjrAPz-is44DVyUqujHq0Gkg@mail.gmail.com>
X-Gm-Features: AZwV_QjflOm2LQp70940LW18Xu_1idP13rWx3ITbRV-jb6h_5V9KJ-yMT57ltYQ
Message-ID: <CAL3q7H7edbz+gA2+5vkoCK1O4JkjrAPz-is44DVyUqujHq0Gkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: tests: prepare extent map tests for strict
 alignment checks
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20862-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FF535B3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 5:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently the extent map self tests have the following points that will
> cause false alerts for the incoming strict extent map alignment checks:
>
> - Inlined extents have their sized smaller than block size

sized -> size

As usual, there is a lack of punctuation in the first sentence everywhere.

>   Which is not following what the kernel is doing for inlined extents,
>   as btrfs_extent_item_to_extent_map() always uses the fs block size as
>   the length, not the ram_bytes.
>
>   Fix it by using SZ_4K as extent map's length.
>
> - btrfs_fs_info::sectorsize is not properly initialized
>   As we always use PAGE_SIZE, which can be values larger than 4K.
>   And all the immediate numbers used in the test case is based on 4K

is based -> are based

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>   fs block size.
>
>   Fix it by using fixed SZ_4K fs block size when allocating the dummy
>   btrfs_fs_info.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tests/extent-map-tests.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-ma=
p-tests.c
> index aabf825e8d7b..811f36d41101 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -173,9 +173,12 @@ static int test_case_2(struct btrfs_fs_info *fs_info=
, struct btrfs_inode *inode)
>                 return -ENOMEM;
>         }
>
> -       /* Add [0, 1K) */
> +       /*
> +        * Add [0, 1K) which is inlined. And the extent map length must
> +        * be one block.
> +        */
>         em->start =3D 0;
> -       em->len =3D SZ_1K;
> +       em->len =3D SZ_4K;
>         em->disk_bytenr =3D EXTENT_MAP_INLINE;
>         em->disk_num_bytes =3D 0;
>         em->ram_bytes =3D SZ_1K;
> @@ -219,7 +222,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>
>         /* Add [0, 1K) */
>         em->start =3D 0;
> -       em->len =3D SZ_1K;
> +       em->len =3D SZ_4K;
>         em->disk_bytenr =3D EXTENT_MAP_INLINE;
>         em->disk_num_bytes =3D 0;
>         em->ram_bytes =3D SZ_1K;
> @@ -235,7 +238,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,=
 struct btrfs_inode *inode)
>                 ret =3D -ENOENT;
>                 goto out;
>         }
> -       if (em->start !=3D 0 || btrfs_extent_map_end(em) !=3D SZ_1K ||
> +       if (em->start !=3D 0 || btrfs_extent_map_end(em) !=3D SZ_4K ||
>             em->disk_bytenr !=3D EXTENT_MAP_INLINE) {
>                 test_err(
>  "case2 [0 1K]: ret %d return a wrong em (start %llu len %llu disk_bytenr=
 %llu",
> @@ -1131,8 +1134,11 @@ int btrfs_test_extent_map(void)
>         /*
>          * Note: the fs_info is not set up completely, we only need
>          * fs_info::fsid for the tracepoint.
> +        *
> +        * And all the immediate numbers are based on 4K blocksize,
> +        * thus we have to use 4K as sectorsize no matter the page size.
>          */
> -       fs_info =3D btrfs_alloc_dummy_fs_info(PAGE_SIZE, PAGE_SIZE);
> +       fs_info =3D btrfs_alloc_dummy_fs_info(SZ_4K, SZ_4K);
>         if (!fs_info) {
>                 test_std_err(TEST_ALLOC_FS_INFO);
>                 return -ENOMEM;
> --
> 2.52.0
>
>


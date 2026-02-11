Return-Path: <linux-btrfs+bounces-21627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGBxKbJ6jGkcpgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21627-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 13:48:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E3112484C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 13:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E6E2302BE33
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F8366DD7;
	Wed, 11 Feb 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnm6dLIt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881435CBCA
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814113; cv=none; b=JpJSnY/NnpI0fQJ2s73eh0+qIDgEHlXcYH+5jh0oFZGe+96doPtPByWs4MPIrl0vhdyUGgJ6dhAmMChRdCGjTzB7ksddly7rnpzlMy17wpgETySXDOnDm09sGqUiYMTqMWkQtMZ1fIrQPq0tcC1Bge1qJ0++EpEpGkNs7hIAM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814113; c=relaxed/simple;
	bh=Z3jevyMmN9/BN30/XzneF12cZAwFYhGZ+aQ7A9UDsR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZvtG3W7gGPleHWJkyvPfel4tYC0aDlcormchdUTAXRTZGvOd/PbBPOnctiYcWvU98d6uzJajR8yUSI+yXv+FyDtqPMCZtWQbi+DnuNxk6S7YAISBX7rFmmj3FgyzUEWORT75ANDSROcIhh9uibaHvA/Y3xTWaIvojTKohwt8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnm6dLIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F895C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770814113;
	bh=Z3jevyMmN9/BN30/XzneF12cZAwFYhGZ+aQ7A9UDsR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fnm6dLIt8ZNYH+8xhbd+2Q/9/ZJ82TFiB8MQvdORhP2AEOVg+cFtAEh98tZY6nqcx
	 KUk7dq6w1UpNYyw1WzSnUYhOOru/4uockdHtPouZ7tY0C8Umy9xmLs+W72VEzy+sR3
	 NtBxvYQqOIQdpw9Bf5XFqRRfAv5jHHdU7zKF2qzrs8EZfYo4mDJCEDM06acH7kwbhe
	 SNHTsV4Il8hnUxJXHuViZxFFL+XdPL6BCEb1ug23YCbYTJq86Q0l2UYZobaXDoUkF3
	 Z3qMogObS4kn8iAdG/ejTS8kbnsSN49EGKPAJBD9ChI2ExDAjwAVVfy4D657fE69bp
	 ZdUF4GyisenHg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so537500a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 04:48:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxlezbgsaK5q+980OYhxWHJuVf9oxtAq6S9alTrTD2+nzQUcRyD
	HhTrn6E4z3w+EnxB7CQhAQt0NPrHvFpHe5BivXWGL+LYynB26R6C5FLG+6WtMKgKSWDpdAhjQnC
	I9drJCgLy644yiwAIj7lMjx9JMnB4Nsc=
X-Received: by 2002:a17:906:6a1e:b0:b88:31c1:c770 with SMTP id
 a640c23a62f3a-b8edf174362mr1124616666b.5.1770814111794; Wed, 11 Feb 2026
 04:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f1694e9264f14706a274009aca35504f128c1df1.1770779554.git.wqu@suse.com>
In-Reply-To: <f1694e9264f14706a274009aca35504f128c1df1.1770779554.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 11 Feb 2026 12:47:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6p1ZirZ4cqGkjvU3oUSQcEfoYPLdchNS+94N=fCxO7DA@mail.gmail.com>
X-Gm-Features: AZwV_QimI9D3pTqp07aMAhzwCENAcyZ4Z5AhcXxesSpOF473zqOB1SBDoUBSb28
Message-ID: <CAL3q7H6p1ZirZ4cqGkjvU3oUSQcEfoYPLdchNS+94N=fCxO7DA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove out-of-date comments in btree_writepages()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21627-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 01E3112484C
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 3:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a lengthy comment introduced in commit b3ff8f1d380e ("btrfs:
> Don't submit any btree write bio if the fs has errors"), explaining why
> we don't want to submit the metadata write bio when the fs has something
> wrong.
>
> However it's no longer uptodate by the following reasons:
>
> - We have better checks nowadays
>   Commit 2618849f31e7 ("btrfs: ensure no dirty metadata is written back
>   for an fs with errors") has introduced better checks, that if the
>   fs is in an error state, all metadata write will not result any bio

"all metadata write" -> metadata writes
"will not result any bio" -> will not result in any bio

>   but finished immediately.

but instead complete immediately.


>
>   That covers all metadata writes better.
>
> - Mentioning functions no longer there

mentioning -> mentioned

But which functions? The only function I see mentioned in the comment
is  submit_extent_folio(), which still exists.

>   It mentions the function submit_extent_folio(), but the correct
>   function is submit_eb_subpage(), which can return the number of ebs

I don't see any function named submit_eb_subpage() in current for-next.

Thanks.

>   submitted for a page.
>
>   And later commit 5e121ae687b8 ("btrfs: use buffer xarray for extent
>   buffer writeback operations") completely reworks this, and now we
>   always call write_one_eb() to submit an extent buffer, which has no
>   return value.
>
> Just remove the lengthy comment, and replace the "if (ret > 0)" check
> with an ASSERT(), since only btrfs_check_meta_write_pointer() can modify
> @ret and it returns 0 or errors.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 34 ++++------------------------------
>  1 file changed, 4 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3df399dc8856..9999c3f4afa4 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2386,38 +2386,12 @@ int btree_writepages(struct address_space *mappin=
g, struct writeback_control *wb
>                 index =3D 0;
>                 goto retry;
>         }
> +
>         /*
> -        * If something went wrong, don't allow any metadata write bio to=
 be
> -        * submitted.
> -        *
> -        * This would prevent use-after-free if we had dirty pages not
> -        * cleaned up, which can still happen by fuzzed images.
> -        *
> -        * - Bad extent tree
> -        *   Allowing existing tree block to be allocated for other trees=
.
> -        *
> -        * - Log tree operations
> -        *   Exiting tree blocks get allocated to log tree, bumps its
> -        *   generation, then get cleaned in tree re-balance.
> -        *   Such tree block will not be written back, since it's clean,
> -        *   thus no WRITTEN flag set.
> -        *   And after log writes back, this tree block is not traced by
> -        *   any dirty extent_io_tree.
> -        *
> -        * - Offending tree block gets re-dirtied from its original owner
> -        *   Since it has bumped generation, no WRITTEN flag, it can be
> -        *   reused without COWing. This tree block will not be traced
> -        *   by btrfs_transaction::dirty_pages.
> -        *
> -        *   Now such dirty tree block will not be cleaned by any dirty
> -        *   extent io tree. Thus we don't want to submit such wild eb
> -        *   if the fs already has error.
> -        *
> -        * We can get ret > 0 from submit_extent_folio() indicating how m=
any ebs
> -        * were submitted. Reset it to 0 to avoid false alerts for the ca=
ller.
> +        * Only btrfs_check_meta_write_pointer() can update @ret,
> +        * and it only returns 0 or errors.
>          */
> -       if (ret > 0)
> -               ret =3D 0;
> +       ASSERT(ret <=3D 0);
>         if (!ret && BTRFS_FS_ERROR(fs_info))
>                 ret =3D -EROFS;
>
> --
> 2.52.0
>
>


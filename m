Return-Path: <linux-btrfs+bounces-21642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOVMLLGijWlh5gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21642-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:51:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51012C09D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACABE30A7808
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B462D6E78;
	Thu, 12 Feb 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kicrWLBW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBF6F2F2
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889858; cv=none; b=QwA8eaOFFZ5hJGknI0PiRmEisaodYXMjpCp7IrfQ0RLGvBupgLbbngKlnU9MlFeblVj6JT8JZyt2RpdrGlpFUqnt+zwVGWEgVPLt+0XvlItZMYogJBiTaMqKiDNJz5ix/bXRIiGf/S1n4S+SHfbR8cYIm7Gx8OWaxn8yPjy/v78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889858; c=relaxed/simple;
	bh=r9/zZ2iUm/M/XB1QWrZEkGNCUUmsLvjy8O99vq+hxcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBnVM0LqRhokmOYRrYznk2TLHUK1CENzLDrwQUo1aiQpxrID5RSRCg8Oi5KF2DIFn8n4zZNMWYns/oozyU6YupPLzcZwxipH/u6uvet1npElSE77m9NVeMA0cHxsN7BW/vpLaLLsvfZtBKzs+p+LoPfhZjmwtjkysH1CoX8desY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kicrWLBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6035C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770889857;
	bh=r9/zZ2iUm/M/XB1QWrZEkGNCUUmsLvjy8O99vq+hxcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kicrWLBW8ZaMRGAUtzeHtKBCQVkNasDSCPqbWxBVmFEpOriTCA6yvPL2EjkBqkkPN
	 /XknK8GC+oQ1W5729GEmthp7clJU8eXlswIdrUvkKK/gfOOP3NhZb7XGCdARV01p+z
	 2TvV9EFT44eg1sBO88J2FLOU3FTyPPo/un4ogt+KcIekFaPLb5LXZBEHGZRgxofA+Q
	 0xYPWr/FV2Sbyl7kTh0CI3CNjC9fOAZjmyi5/ahZen5X2/T+V+kghkGihvhv+S9Ks9
	 Pmx4Wv3CobzbkqOU1rlEKeLpAOWZ0mWUwfDzvr/U5JfDXv9NDPv7oXSCIRNG4z7qNN
	 4Gsb6RyuE0N/g==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so1114437666b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 01:50:57 -0800 (PST)
X-Gm-Message-State: AOJu0YwievAvRM3RnOPhvoJnUtegef+0XYXqWdsLbGhBTcIwEmDrXJ09
	c8Fu+GSzKniicN/vjzrCS/X3c2QfqlV+TN7mkbQ8schkx6UAu0Z+Xg4GPmbtsBebfI4WRnXh9OA
	fyg/wIxbVkcdSePJEqiIj9/NdUpYt5D4=
X-Received: by 2002:a17:907:6e9f:b0:b88:60d2:11a2 with SMTP id
 a640c23a62f3a-b8f8f6e1243mr108421266b.34.1770889856322; Thu, 12 Feb 2026
 01:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <270c2de0f0f5380088e8899e783471843a1f0172.1770844117.git.wqu@suse.com>
In-Reply-To: <270c2de0f0f5380088e8899e783471843a1f0172.1770844117.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 12 Feb 2026 09:50:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7A8T2Tr0G_Gmn522Q2xuFsofDVD6nXeNU50S4KR4q5LQ@mail.gmail.com>
X-Gm-Features: AZwV_QhZk8NrxN42OQUOO-BYTz9Z4R_5lI04TtlewuL4rT8hBnqjc4o11LN-84c
Message-ID: <CAL3q7H7A8T2Tr0G_Gmn522Q2xuFsofDVD6nXeNU50S4KR4q5LQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: remove out-of-date comments in btree_writepages()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21642-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EE51012C09D
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 9:14=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a lengthy comment introduced in commit b3ff8f1d380e ("btrfs:
> Don't submit any btree write bio if the fs has errors") and commit
> c9583ada8cc4 ("btrfs: avoid double clean up when submit_one_bio()
> failed"), explaining two things:
>
> - Why we don't want to submit metadata write if the fs has errors
>
> - Why we re-set @ret to 0 if it's positive
>
> However it's no longer uptodate by the following reasons:
>
> - We have better checks nowadays
>
>   Commit 2618849f31e7 ("btrfs: ensure no dirty metadata is written back
>   for an fs with errors") has introduced better checks, that if the
>   fs is in an error state, metadata writes will not result in any bio
>   but instead complete immediately.
>
>   That covers all metadata writes better.
>
> - Mentioned incorrect function name
>
>   The commit c9583ada8cc4 ("btrfs: avoid double clean up when
>   submit_one_bio() failed") introduced this ret > 0 handling, but at that
>   time the function name submit_extent_page() is already incorrect.

is already -> was already

Otherwise,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>   It was submit_eb_page() that could return >0 at that time,
>   and submit_extent_page() could only return 0 or <0 for errors, never >0=
.
>
>   Later commit b35397d1d325 ("btrfs: convert submit_extent_page() to use
>   a folio") changed "submit_extent_page()" to "submit_extent_folio()" in
>   the comment, but it doesn't make any difference since the function name
>   is wrong from day 1.
>
>   Finally commit 5e121ae687b8 ("btrfs: use buffer xarray for extent
>   buffer writeback operations") completely reworked how metadata
>   writeback works, and removed submit_eb_page(), leaving only the wrong
>   function name in the comment.
>
>   Furthermore the function submit_extent_folio() still exists in the
>   latest code base, but is never utilized for metadata writeback, causing
>   more confusion.
>
> Just remove the lengthy comment, and replace the "if (ret > 0)" check
> with an ASSERT(), since only btrfs_check_meta_write_pointer() can modify
> @ret and it returns 0 or <0 for errors.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix grammar errors
> - Add a more comprehensive history for the bad "submit_extent_folio()"
>   mention
>   It's incorrect from day 1.
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


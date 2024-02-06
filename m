Return-Path: <linux-btrfs+bounces-2178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D5284BF9A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 22:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82AA288414
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8671C29B;
	Tue,  6 Feb 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="QlMSgNEW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02411C280
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256447; cv=none; b=oOKkWUb5/XQCLKCpD/DY0iS1crbSbsOBUcIvBmrAD6dAMXq0BGLQAlUMC1oeCOYo2ZcsskyV3EqhK8sXGnXhbRgRDVZzmStIldDS/NqmLY1V9Ugo55Ob1rgSixGw8YQR9zudzIioFo/ZaT/0YmcQ00KBaOdiIeficuun+s3YOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256447; c=relaxed/simple;
	bh=eR94FRUcQje9rxMAkyKQBQUt8ucHO9j/d1aeHSUuc8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSGs1FvwM52J1ZI03jvDNGlaEGukaDXBmS0dJEF37Nvb7eNwr9d9bdJjB4oi6CaDQQw4qBY1LnraSgEx5AeuxQSC8IVg8BbZ4SoZ6lQ5PETEkki37+CpaFj3mP3iJHJaqQ5U28NfwqWyEeYVgF5Wl0RJ0rYNNoUSB/akun4MblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=QlMSgNEW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c3a14c6e7so27774756d6.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Feb 2024 13:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1707256445; x=1707861245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnAeh8uB/tNfwUqlYi11NqjInG8DSr7X736W5T6E9HQ=;
        b=QlMSgNEWyV7g2TAeW8uBDqvtEwOhOZMnRa0cFTYjVlry1HSc1d8QXunW4FaenN8YRe
         TZD7PARZ8f4idsllR9qiUal7veTyVG9izUik4e1zfKfgcX5Ogt7pXn15F0iG8VHztMQd
         eZamco06EnuQ77PSV9KfD/nm2IXFRNf4URzYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256445; x=1707861245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnAeh8uB/tNfwUqlYi11NqjInG8DSr7X736W5T6E9HQ=;
        b=cgWTxUxuwUiwmKu2koHlhJKshQ9H36HUINWRUmTkxrwcgUcRVIHLaz8+h5Gn8mcnbI
         7qrEzZdjRhbx+LV3OWSjP8zNThmnvtgGGk0bPnB4eK1Btv8RDI+FVZYe5fLZ/i8pZj5t
         GJl6yzYtwGgv1m5WpzCrkA6UmOR1736Poyjhu2X3NBHxd6MogJRvpJCwBuoMtV9rYV3K
         NWHsDYdH+2H00gtL/NHvlREUCd+4mqb0gApJsl1WwUWFDE23AukAOoii9zyV7bzgp7Ln
         9pbwEvtyr8buWEIJkYpuKWmfOGrxbk6CTnK4sH4gh4rjIsuGVyJdkFGU7sQte6vsxi0O
         iVpw==
X-Gm-Message-State: AOJu0YxHkviQ6selJ4uP9+jU9NLUoGvp4TInUqFGSYr326PdxoXHls2h
	ZiJfgikfOwuYgshSFI86gxvvbE77UmbemTS92sn3FeZHYCl7dnWYKhalQMYaKOVuTyVokMDQuTF
	iQwx2qtWbrXFARMfWaZlb+mJwUm4=
X-Google-Smtp-Source: AGHT+IGzfLRtSr9Tj7po/yoXHify9u3h3locIZqHDnIMRLQdI5N0UzTM5wYdfNs4j7QUcay0VHbRIAqbuGLzCINLpNY=
X-Received: by 2002:ad4:5baa:0:b0:68c:ae95:ddd2 with SMTP id
 10-20020ad45baa000000b0068cae95ddd2mr4836933qvq.3.1707256444696; Tue, 06 Feb
 2024 13:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com> <20240206201247.4120-1-tavianator@tavianator.com>
 <60724d87-293d-495f-92ed-80032dab5c47@gmx.com> <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
In-Reply-To: <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Tue, 6 Feb 2024 16:53:54 -0500
Message-ID: <CABg4E-=G4sL9KGjyNgFozUx2=jbe4+q_U+=eHv-cX_897HP8Ug@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:48=E2=80=AFPM Tavian Barnes <tavianator@tavianator=
.com> wrote:
> I just tried the tip of btrfs/for-next (6a1dc34172e0, "btrfs: move
> transaction abort to the error site btrfs_rebuild_free_space_tree()"),
> plus the dump_page() patch

By the way Qu, you should fold

@@ -2036,6 +2042,7 @@ int btrfs_check_eb_owner(const struct
extent_buffer *eb, u64 root_owner)
        if (!is_subvol) {
                /* For non-subvolume trees, the eb owner should match
root owner */
                if (unlikely(root_owner !=3D eb_owner)) {
+                       dump_page(folio_page(eb->folios[0], 0), "eb page du=
mp");
                        btrfs_crit(eb->fs_info,
 "corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expect %=
llu",
                                btrfs_header_level(eb) =3D=3D 0 ? "leaf" : =
"node",
@@ -2051,6 +2058,7 @@ int btrfs_check_eb_owner(const struct
extent_buffer *eb, u64 root_owner)
         * to subvolume trees.
         */
        if (unlikely(is_subvol !=3D is_fstree(eb_owner))) {
+               dump_page(folio_page(eb->folios[0], 0), "eb page dump");
                btrfs_crit(eb->fs_info,
 "corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expect
[%llu, %llu]",
                        btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "node",

into the patch.  Right now it's missing the dump_page() for the
relevant error message.

--=20
Tavian Barnes


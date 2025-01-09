Return-Path: <linux-btrfs+bounces-10838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E53A07413
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 12:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6535D168CEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1E2165E3;
	Thu,  9 Jan 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PxfFMGFx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEE1A8F8F
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420423; cv=none; b=WIUY9mySfWSlI/h2Ynh40oZsc+r12CZZ0bSLTgoFr05eWCbAAmCOvabEGxHc9kroH0u7JDMadWboDqxQRMSVNvnmrLApdbEVB7peAEDVptJKrrUKh4hBPXUqhvIO/Yj+VkwPrKwX++5zvAdajq55XpYvs/rqQU0NbZDMzzG7mmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420423; c=relaxed/simple;
	bh=SstKZZ2j321+E/rud9OdGtPbjeZgs4bRLHG9liE1154=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9PNK7JMkkvbpSmwn7hwd+dR2Sr3A75xU2zslnyaVB1te5B9+/KB7qeJypBxOYSauIF2qpWRqTV3SYCSW7rx99wNUIqD7K1jIljV5WRQRM0Ky+Q9fmeRj5eZgnQ78EqkR4FnG34/8hTeLQosvJYyKwNKxxDLdjDgoxXBchxk73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PxfFMGFx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso149421566b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2025 03:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736420419; x=1737025219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Txcsl1EX1i7iSk/FGq8t23SMRsKMBneJpEIGK1c+/4=;
        b=PxfFMGFxSN3kconKDBOsk+QzUZToSZcix79bg5zRWSryAdASn46Emo7lx8dZJ5q9st
         02geXexM4YZ+EzmMlTR7AUNLqsu1ZNhP5cY1BeuAHrM6dok3IqzEMsjYXqfZatvt+Ypn
         a5R1jpZFsrq4aGy0xDGpdwoAMYtxqw0/FdPNWQqR6bVyb7FKio2bBBF09ETXHUylQm2M
         EMtQnVYQlvbWVfZZPBIZn86enx4tuofVUaYL2aESRjjX30i7o1npy21m3zPvUsyBGO9I
         GqiMQwtGbKMAdT/PDL6m2DRa5GvYFMQHp+2LcfaH/i+57MeNvUI3kF6EJkOZCtaW+n+I
         FG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736420419; x=1737025219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Txcsl1EX1i7iSk/FGq8t23SMRsKMBneJpEIGK1c+/4=;
        b=tfSN4nqfohLrp25KUdjcxhZdnfq8+W9knxGsv90pV4hueLoj21NpObTRaVyzTVUYWU
         x1urF68CT98WyrefhtYfIZnMJVHUxEJAxzeLRviXow6FJvoz5UmQXmsSzhlYNWkN57n9
         bJOQcn2PAKf6apggTwgNkFOanFBa7HXwYePn0lNiR6yIzZk/CfEbzeDPCpG2XLYm9BkQ
         fgoUOmvTLvkzZjnYsiRe0lGZkJfexKCJR0ZOPqKNrdk2qvGqmGCh8EJyJ2KBD7tyVlpz
         gXV4kOf/Xqw8yxYUvM6JDWMWD/6kkVK4vRMDRKAOwuQESbdQyOiO91BI2jnAWeTGK0GT
         G2gA==
X-Gm-Message-State: AOJu0YwrSQZzUAuNwXLq1xjXIsL1DdolrTKLVPBQ78cJDSg9c53WpfOy
	XDD5qAea1sLt50D+F2i+p9Co8XZ/JnPL37m4FSVmOarEBWwoi4BkZ4zZRsXgAIE1Bve3DxBxX80
	Hnd24BX7npOXN/wCOM413prx4gAF9XmXnoADpddXTIbcPO7lCULw=
X-Gm-Gg: ASbGncucPOvFfs7lxES/mfJzjkHOKNiYjJVpeMGy1Kd0vN1LUcgyQrAwbUeD1PgZViZ
	M4fe1YGIHE9R5n318uVt6bjR8LXiZn3B5Lry9
X-Google-Smtp-Source: AGHT+IGbX42ytUZfvcbQlpq8n4c4iSqoRtVdgdIZcuk1V2gUIEKLb1w0PN8aurqXzWXSSTO8oj//d22OcfEC2jiAfVI=
X-Received: by 2002:a17:907:1b97:b0:ab2:b610:35fb with SMTP id
 a640c23a62f3a-ab2b6103692mr362587966b.3.1736420419546; Thu, 09 Jan 2025
 03:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736418116.git.dsterba@suse.com> <94f6c64568a10ae8470b1477f6ce1f1b452a7117.1736418116.git.dsterba@suse.com>
In-Reply-To: <94f6c64568a10ae8470b1477f6ce1f1b452a7117.1736418116.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 9 Jan 2025 12:00:08 +0100
X-Gm-Features: AbW1kva4UJ-109Ke-Ojq8x6-xCBqsWfu4JTP6sNw4XsLhzvfCFgKdxiqIkrFxh8
Message-ID: <CAPjX3FfpOgnsjRNBJd0SwOmMV0VZ5L13m143jvyyNrn1CeTmaw@mail.gmail.com>
Subject: Re: [PATCH 02/18] btrfs: remove stray comment about SRCU
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 11:27, David Sterba <dsterba@suse.com> wrote:
>
> The subvol_sruce was removed in c75e839414d361 ("btrfs: kill the

subvol_sruce typo

> subvol_srcu") years ago.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/disk-io.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index a7051e2570c1..587842991b24 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -96,9 +96,6 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
>  /*
>   * This function is used to grab the root, and avoid it is freed when we
>   * access it. But it doesn't ensure that the tree is not dropped.
> - *
> - * If you want to ensure the whole tree is safe, you should use
> - *     fs_info->subvol_srcu
>   */
>  static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
>  {
> --
> 2.47.1
>
>


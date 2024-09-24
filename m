Return-Path: <linux-btrfs+bounces-8183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE5983BE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F4E1F229D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 03:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683D2745B;
	Tue, 24 Sep 2024 03:56:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DD1B85D6;
	Tue, 24 Sep 2024 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150175; cv=none; b=cHxLLTTgxw8tSP/cNfA3EneQZ1j6OEep9ijLwlqPmdD5NgzbFdxp0/pjhD42YP0KMD4CslasSo8YCPU7XUmIEjs3/H4KyDHywY0ZbVynGVUIuZrD7S7SHpCr/KRwsuMfxK0kTHCeNmSxYCWw6NtmupQZKBHBNE8kdKTMV1MGXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150175; c=relaxed/simple;
	bh=9NA04HrVGAgsUcwLKqgHLboN48/GCIJ6SkxVELRemlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDcJaJYIAzi1XJrXzpz5qB0vbAwwKVut+qeEtWvGizs9JV+jb+qwr26dr8llkQYkVLfFHL0QkLqxd1HOYbsX42pv9L3ET6SA7lk6+1DmJqxQBxHL39UYfEEbAusf3TgQ4/m38DqneKjT+T0SOzS7BfLP0fELJUfwwR7Z6Xe66q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so825872066b.1;
        Mon, 23 Sep 2024 20:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727150171; x=1727754971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWDITLXaUjkwRec9NX8KLDU+y6dklIaCwmpsqTq32JI=;
        b=cMyzMXyrAuvnNgTTTczUxTz2VMWvBmNRivwqMjXu1fw7eL8BbdTuVEZneWvQtOFa3e
         GjKbtC9tt4pHqSmFHsJOTOxc6C0vZz8QVS4/8rYKcRMotPqfhsltUffRpiNV2Z0ggZ/h
         TSqR5R1IQh3Eg2z+edMjIk2ZIihoC4rUrQm4wwwuw6f2AxmDow8J5fk9InS3qt2sklBx
         fZlQLkYPLsbbyJ1/XiyruE6CNLllyauIUwIHqnPjGc2YYVVNqfWtyYmGmfHDF/HOAva4
         lAfauBP37FjmvBx6CUImFPT/QAGVjpggfwVQ7c8PlRc8A/qajuES+VN8ENPCVaaP7ufy
         KYIg==
X-Forwarded-Encrypted: i=1; AJvYcCVY8nkWeRIsHlKlU0Vk4jw/EsxScC3a4ts2mSln4n9ru/wbt0/UCel78FN8OkKVJTvCl4oNDRAduYVUjg==@vger.kernel.org, AJvYcCVlHiPSGYMxfIHk1dQdm3u5QHQlk6DW+zH4fI2eViP/qL77XZWRzopvfnp5HY5WMjZ9OOq7LXHtpa4+ywSy@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKbgCOMfBOM5vrofddlhYgl/fWxc8naID/cD88M+VvuNvksdh
	pe6KwJRkgj5YSkL+V11840f+tFGXioMD+AyysEZWdl6td5u+4s2y4ybwKECu
X-Google-Smtp-Source: AGHT+IHXRPWqsdtWgX7a0Anrtp4Vil8ujHGqzvayPRBqNHVlhgwAG2MOcAOHqQYBF/CsHLmZz7vbQw==
X-Received: by 2002:a17:907:9343:b0:a86:963f:ea8d with SMTP id a640c23a62f3a-a90d516abaamr1445536266b.64.1727150170518;
        Mon, 23 Sep 2024 20:56:10 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930caf21sm31044066b.98.2024.09.23.20.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 20:56:10 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so753957566b.2;
        Mon, 23 Sep 2024 20:56:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0SAsybh/j6IHVwTz6oKAswdB6GuFeY9SzmR6Nfw9JnB7hjQAINFw7Ip/xBykOa76n11e86Zy3cIqMFjeV@vger.kernel.org, AJvYcCXijREmdYrSsnutm3nVhSOSYdRxKE807IJ0k5ZsmCYuk1wlPKQGklW04+7l9pihuf6Rxxe7zQ6uWugjfA==@vger.kernel.org
X-Received: by 2002:a17:907:f1e6:b0:a8d:2c00:949a with SMTP id
 a640c23a62f3a-a90d4fdf816mr1330985666b.9.1727150169831; Mon, 23 Sep 2024
 20:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924023135.3861974-1-youling.tang@linux.dev>
In-Reply-To: <20240924023135.3861974-1-youling.tang@linux.dev>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 23 Sep 2024 23:55:33 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_Lv7x7u8Az49xr04T=S5tk3XAmtoCYL+97wKVkftNOpQ@mail.gmail.com>
Message-ID: <CAEg-Je_Lv7x7u8Az49xr04T=S5tk3XAmtoCYL+97wKVkftNOpQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove unused page_to_{inode,fs_info} macros
To: Youling Tang <youling.tang@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:32=E2=80=AFPM Youling Tang <youling.tang@linux.d=
ev> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This macro is no longer used after the "btrfs: Cleaned up folio->page
> conversion" series patch [1] was applied, so remove it.
>
> [1]: https://patchwork.kernel.org/project/linux-btrfs/cover/2024082818290=
8.3735344-1-lizetao1@huawei.com/
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  fs/btrfs/fs.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79f64e383edd..82169cbd99e1 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -876,12 +876,9 @@ struct btrfs_fs_info {
>  #endif
>  };
>
> -#define page_to_inode(_page)   (BTRFS_I(_Generic((_page),               =
       \
> -                                         struct page *: (_page))->mappin=
g->host))
>  #define folio_to_inode(_folio) (BTRFS_I(_Generic((_folio),              =
       \
>                                           struct folio *: (_folio))->mapp=
ing->host))
>
> -#define page_to_fs_info(_page)  (page_to_inode(_page)->root->fs_info)
>  #define folio_to_fs_info(_folio) (folio_to_inode(_folio)->root->fs_info)
>
>  #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),            =
       \
> --
> 2.34.1
>
>

Patch looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


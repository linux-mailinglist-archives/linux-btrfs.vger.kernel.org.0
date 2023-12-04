Return-Path: <linux-btrfs+bounces-568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DB803931
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0529F1F210BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219162D039;
	Mon,  4 Dec 2023 15:51:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB8A4
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 07:50:57 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1b7b6bf098so165242566b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 07:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705055; x=1702309855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/n6Z7YnJlCIWTsaHqbnpnO3LzBqMi7wD11sZnELj6k=;
        b=vNRAXPgVt2gExEHy2Zg5T8LqSaulhPic2veJqMXR+DGIZ2Qyb0X5TB7XrexVhjjLa6
         1+U+phJvkHBbdb5hUB4R+SDf0b9qmT/Vp9HxeMiKsCc0MNvG+jULG2XQzX0u57C5JLti
         pNq9Pz0qmKGYI7dHhB9lM99tRj+GnpcmAPuw9hZh4J/Mj/5AOYGNsv/6OmiEsbdlXgn/
         f+bXHRjMG0eTFoliOL0A4M7K/Opg5JWpTfYHbxHJKsqS5FiMh6iZ5XQW7dC205PFn6aw
         0oZ0dBk53715Tk7kiHX/rPu2DyCWJxOE7t/nU1MeGOlzQgY9+dfFI/0ktsZAow0i6bF+
         ZPXQ==
X-Gm-Message-State: AOJu0Yxpf6PvqTTWMKuRUZmRYuNIUKxreK7AbOXNP60Ng5VS9A6A9uq7
	PnZLgJAy9BjhJbYJqH8Gh042A+8EhjKMFQ==
X-Google-Smtp-Source: AGHT+IHzui22i2xUMXTuhUgCaipTUY+1qyGdMJEl/XFEAyXMhOgmbVgADd+phdDqCjkffeolST3rnQ==
X-Received: by 2002:a17:906:103:b0:a17:d879:7f06 with SMTP id 3-20020a170906010300b00a17d8797f06mr6096165eje.4.1701705055452;
        Mon, 04 Dec 2023 07:50:55 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id oz11-20020a170906cd0b00b009fc990d9edbsm5391275ejb.192.2023.12.04.07.50.55
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 07:50:55 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a18b0f69b33so825406966b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 07:50:55 -0800 (PST)
X-Received: by 2002:a17:906:88f:b0:a19:a409:37e1 with SMTP id
 n15-20020a170906088f00b00a19a40937e1mr6286847eje.58.1701705055092; Mon, 04
 Dec 2023 07:50:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d28d747954ec9967f6e01dcc2185229f1667b7db.1701658076.git.wqu@suse.com>
In-Reply-To: <d28d747954ec9967f6e01dcc2185229f1667b7db.1701658076.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 4 Dec 2023 10:50:18 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8bQmfC5tWztqz3LRym0BWA01JVLuNQf0VB6AFDR7ufuA@mail.gmail.com>
Message-ID: <CAEg-Je8bQmfC5tWztqz3LRym0BWA01JVLuNQf0VB6AFDR7ufuA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: Documentation: update the man page for btrfs
 check lowmem mode
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 3, 2023 at 9:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Lowmem mode has improved quite a lot since its introduction, for
> read-only check it's definitely fine.
>
> For repair mode, both lowmem and original mode are considered dangerous
> especially for complex corruptions.
>
> For now lowmem mode is only bad at fixing fundamentally corrupted cases,
> like bad shift offsets or transid, which in real world it's not an easy
> repair for the original mode either.
>
> This patch would move the --mode option out of the dangerous section and
> update the notes for the lowmem mode on its limitation.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-check.rst | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rs=
t
> index 046aec52923a..41ab39fab317 100644
> --- a/Documentation/btrfs-check.rst
> +++ b/Documentation/btrfs-check.rst
> @@ -57,6 +57,20 @@ SAFE OR ADVISORY OPTIONS
>  -E|--subvol-extents <subvolid>
>          show extent state for the given subvolume
>
> +--mode <MODE>
> +        select mode of operation regarding memory and IO
> +
> +        The *MODE* can be one of:
> +
> +        original
> +                The metadata are read into memory and verified, thus the=
 requirements are high
> +                on large filesystems and can even lead to out-of-memory =
conditions.  The
> +                possible workaround is to export the block device over n=
etwork to a machine
> +                with enough memory.
> +        lowmem
> +                This mode is supposed to address the high memory consump=
tion at the cost of
> +                increased IO when it needs to re-read blocks.  This may =
increase run time.
> +
>  -p|--progress
>          indicate progress at various checking phases
>
> @@ -117,24 +131,6 @@ DANGEROUS OPTIONS
>          .. warning::
>                  Do not use unless you know what you're doing.
>
> ---mode <MODE>
> -        select mode of operation regarding memory and IO
> -
> -        The *MODE* can be one of:
> -
> -        original
> -                The metadata are read into memory and verified, thus the=
 requirements are high
> -                on large filesystems and can even lead to out-of-memory =
conditions.  The
> -                possible workaround is to export the block device over n=
etwork to a machine
> -                with enough memory.
> -        lowmem
> -                This mode is supposed to address the high memory consump=
tion at the cost of
> -                increased IO when it needs to re-read blocks.  This may =
increase run time.
> -
> -        .. note::
> -                *lowmem* mode does not work with *--repair* yet, and is =
still considered
> -                experimental.
> -
>  .. _man-check-option-force:
>
>  --force
> --
> 2.43.0
>
>

This patch should also include updating the code in check/main.c to
drop the warnings and notes of its experimental nature too.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


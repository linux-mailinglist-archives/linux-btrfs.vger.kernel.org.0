Return-Path: <linux-btrfs+bounces-2793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA286742D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C4EB22CA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E75A7BB;
	Mon, 26 Feb 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPw4KqPY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633A1CFA7;
	Mon, 26 Feb 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948718; cv=none; b=BC4FTiLJEuFFJVdEoBwzTbgWrsdrpwDPmLIYkjOvDvITwvumEcOVEIK2cwjl+xJXbjebDtUVgRP0SZu3K2sIkVttu1DSAVuQb1i0GE/WYgCJkluVmw9sLdBwcvH8QSwQMOyI10OlX29rPk/1qc0uTIABbM0Ovw63J8LvuyFWiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948718; c=relaxed/simple;
	bh=uyzo1NviveB9u26bBniycVUdE9DMvuI16pe0CprZOLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSeh1liBIYFDYf9yHGUzlfbKYmbMDbmIXlsIJiMlKn11IcLjua0+b4Q5o0q9e20If8ui2VSTPQieqTp2ndbfJJmLqVieDDcRi2LH3z9s/FZoxV04phEY1NNZ6lx6I0753HFlOw4/S8PgOJZwP5v8iwLOkmSv6yR+ss1Qu6oZxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPw4KqPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D79C433C7;
	Mon, 26 Feb 2024 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948718;
	bh=uyzo1NviveB9u26bBniycVUdE9DMvuI16pe0CprZOLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bPw4KqPYI1Ju25ZJSbcLFX2+nxnd5WDqc6b6+Ser1Txt+2Z08YzfFKenDhPxewk5n
	 HpvsBnFYZgSg3rpBOPgN0WjS91pk1c19u/boFVxgGfCU/ZFn5SYfVLRc66tjA4/e5g
	 MCHaQdo58bzsw9JK9hAwTrm2q+nsnWNVuRW2x5mkiXTfjFszFncB8g5++xApGHKcvF
	 J5e3aGPQEYX7EHRKD0CzGgfurekqIta7wpDgxcXeTKkYNqZapiljpvK4G0w1CBMJf+
	 sgnzuGSTxbo5NsSlMI64O+8mefxsDvZfGAYB4hJYTiJAEA8DAt3gAeWW93tEo9dhFK
	 at3VTe2fQ7e2g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3974860a12.1;
        Mon, 26 Feb 2024 03:58:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgDUSV43dMbUo63YWc4Ux6JBmwvajcw971Zbdq8nzQUj4IRyJ48fbRf5tZZGORwT40fc5a8N2AOUHN7Dauvr2OSrvozWfjFF8I+7k=
X-Gm-Message-State: AOJu0Yxu30krh4FRB4knsKuG1GJH1bH281dZkng1XaaLEGjtfMUe+pFB
	Tg4b4ykCaCxW4xOVGsrq1THGaSpuufxV3oKpB5HayTs2Z/036nRkIBeOv/OYsLe9PFurgo4RKHp
	lgMc8/TfKqX61m7MT8qgcaD0xYx8=
X-Google-Smtp-Source: AGHT+IElN4W1ZxLsmW2h7dyVdRSTWVIA5qpqWlx/4H6nujNatsQDKv7vDdk9YFYOL30supFhEIgxfoSNWyiH62MmkhU=
X-Received: by 2002:a17:906:5804:b0:a43:a7:c683 with SMTP id
 m4-20020a170906580400b00a4300a7c683mr3352406ejq.42.1708948717032; Mon, 26 Feb
 2024 03:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <8b66778c41341db1ae73fcdf4d30b8f1cd32208c.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <8b66778c41341db1ae73fcdf4d30b8f1cd32208c.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 11:57:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4bSot6bVr4etNvWOogv-NqeZmz7LOU2=S7PgUOmqVm0w@mail.gmail.com>
Message-ID: <CAL3q7H4bSot6bVr4etNvWOogv-NqeZmz7LOU2=S7PgUOmqVm0w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] btrfs: introduce helper for creating cloned
 devices with mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:44=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Use newer mkfs.btrfs option to generate two cloned devices,
> used in test cases.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v3:
>  call
>  _require_btrfs_command inspect-internal dump-super
>  _require_btrfs_mkfs_uuid_option
>  in the function mkfs_clone()
>  Remove the conflict fix metadata line
>
> v2:
>  Organize changes to its right patch.
>  Fix _fail erorr message.
>  Declare local variables for fsid and uuid.
>
>  common/btrfs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 55847733b20e..04ecff6ada71 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -840,3 +840,26 @@ check_fsid()
>         echo -e -n "Tempfsid status:\t"
>         cat /sys/fs/btrfs/$tempfsid/temp_fsid
>  }
> +
> +mkfs_clone()
> +{
> +       local fsid
> +       local uuid
> +       local dev1=3D$1
> +       local dev2=3D$2
> +
> +       _require_btrfs_command inspect-internal dump-super
> +       _require_btrfs_mkfs_uuid_option
> +
> +       [[ -z $dev1 || -z $dev2 ]] && \
> +               _fail "mkfs_clone requires two devices as arguments"
> +
> +       _mkfs_dev -fq $dev1
> +
> +       fsid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                                       grep -E ^fsid | $AWK_PROG '{print=
 $2}')
> +       uuid=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
> +                               grep -E ^dev_item.uuid | $AWK_PROG '{prin=
t $2}')
> +
> +       _mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
> +}
> --
> 2.39.3
>


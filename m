Return-Path: <linux-btrfs+bounces-572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9C803997
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3CC1C20BB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36902D62D;
	Mon,  4 Dec 2023 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssE74X8E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134D2D04B;
	Mon,  4 Dec 2023 16:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB3BC433C8;
	Mon,  4 Dec 2023 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701705920;
	bh=eW/xwmr2Z29kXOy67JOm9RxoY7MTyJYyHuHnVi9Slco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ssE74X8EGT2596AdtfeMFrCYD8exSWsLI95rnwxQm3KHa+lwi425XRE79awWEFZ1q
	 SagBb7PIHT5diy+hFNYS+ew40uXMqO80Vx5pk+bHkLvcWn5nK0Ixvj/cb1cZCBBfub
	 KtfB38+sI7gMoOa2qdB4Jind0CNohZ2+7fV9tJhkuUPpOVcxDqO7nV1F5pFGBafjqH
	 zKSXydp5ZBnj7y9tyWA4u7u4gNTgws+tf+2re14POQCtNXKnF/Nu66cNIa7ynwNNCf
	 a5z0hXEBDMRfT1amCgpdvuovp+JeozK+p+VwYdl4OHH23BbH8yeGMfmmmnQW8rrvmU
	 c7TmvBfuD7BOg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a0029289b1bso601520466b.1;
        Mon, 04 Dec 2023 08:05:20 -0800 (PST)
X-Gm-Message-State: AOJu0YyJKO0zFmHS01VWT9G7iYCz8BFmHm5eD9FcBm2ER8EOpr2GRmfE
	WiRz9i0iVWlW6vvA3mciRE17SMf8BTbCKDjTLFM=
X-Google-Smtp-Source: AGHT+IF3F3UyQ0YA21qPf/nPMAJuCxrUM1j4fdv+da2fY6eMATdkOc2n8qXeEk94qslUMdlmW5WhWqUMWGHw+ICjAUo=
X-Received: by 2002:a17:906:3f0a:b0:a19:a1ba:8cb1 with SMTP id
 c10-20020a1709063f0a00b00a19a1ba8cb1mr3172459ejj.79.1701705918637; Mon, 04
 Dec 2023 08:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com> <20231204-btrfs-raid-v1-7-b254eb1bcff8@wdc.com>
In-Reply-To: <20231204-btrfs-raid-v1-7-b254eb1bcff8@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 4 Dec 2023 16:04:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7oXb8N74u6xmio1Q8P7zb4oi+Ohc+7G6fnbLFiZYdOzg@mail.gmail.com>
Message-ID: <CAL3q7H7oXb8N74u6xmio1Q8P7zb4oi+Ohc+7G6fnbLFiZYdOzg@mail.gmail.com>
Subject: Re: [PATCH 7/7] fstests: doc: add new raid-stripe-tree group
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 1:25=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add a new test group for testing the raid-stripe-tree feature of btrfs
> with fstests.

Ideally this patch should come before the tests themselves, as the
tests are listed in a group that does not exist yet.

Other than that, it looks good.

Thanks.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  doc/group-names.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index c3dcca375537..9c1624868518 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -94,6 +94,7 @@ punch                 fallocate FALLOC_FL_PUNCH_HOLE
>  qgroup                 btrfs qgroup feature
>  quota                  filesystem usage quotas
>  raid                   btrfs RAID
> +raid-stripe-tree       btrfs raid-stripe-tree feature
>  read_repair            btrfs error correction on read failure
>  realtime               XFS realtime volumes
>  recoveryloop           crash recovery loops
>
> --
> 2.43.0
>
>


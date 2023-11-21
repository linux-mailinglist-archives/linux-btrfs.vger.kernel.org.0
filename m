Return-Path: <linux-btrfs+bounces-225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964C7F2AFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA54D1C21570
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A7482C4;
	Tue, 21 Nov 2023 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5z79AFK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1C1D55C;
	Tue, 21 Nov 2023 10:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B7EC433C9;
	Tue, 21 Nov 2023 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700563838;
	bh=A2fRnAzjDOJG5OGghT9s3Kx+mumrPQvbmzfdU6q6+Yg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q5z79AFKkVMpaHlQqy7nA42PVq/3lLj/WT1XKSQPRbZh8QxEEkTf8zLYWxEekNtbn
	 IXcdtG3HiMFpc9rZ+LjYF9WkB9K8HyO1lCtDfspno6vJIBAGyg9g0fRFjMX6OUCeyU
	 LVq5+uk7lkbL4bKHhahkCZB4oWn/SHeR7h8oy0MjczQsQVn/3nfJlZPsaL+7d1/Q12
	 MKMaht63IswvrxgaA6yXcAZt1ApCGVZONCwWdtQgyfIV+MrEpQ3krYf+7LH9PGTN4P
	 g3gLbuHwx5rXndMG5RFpNZB4uFUM5AGxtIghXTlDOHTcDdWvuSMxtWSsUg0rjGlabV
	 GqKhYCeHAnfnA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9c603e235d1so729543866b.3;
        Tue, 21 Nov 2023 02:50:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyBlyeh2Ae+Rh652nIj+xQeY+tkhIAYgvD321BBwwifzgvbfF/d
	d0JDly/Xs1VOgSXaP3aAZ0SH4ECKRLLlARc6g7c=
X-Google-Smtp-Source: AGHT+IEHxP2jwUxARN4Yufkncqlqaa/ovuOM8VnzbGD3jACpZSC7F5WQZhXhFNoZztvTBXYvDOoBKJM7yusLth0dWZE=
X-Received: by 2002:a17:907:d503:b0:9ae:46c7:90fe with SMTP id
 wb3-20020a170907d50300b009ae46c790femr8857763ejc.72.1700563836607; Tue, 21
 Nov 2023 02:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700514431.git.boris@bur.io> <f93722f124c528622e6f0717949a4df45738827b.1700514431.git.boris@bur.io>
In-Reply-To: <f93722f124c528622e6f0717949a4df45738827b.1700514431.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 21 Nov 2023 10:50:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5MUucGAcedifGFEfeKz4mBLiSRUqDPVR8j_AAbC2Pdxg@mail.gmail.com>
Message-ID: <CAL3q7H5MUucGAcedifGFEfeKz4mBLiSRUqDPVR8j_AAbC2Pdxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs/301: require_no_compress
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 9:10=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfs/301 makes detailed size calculations to test squota edge cases
> which rely on assumptions that break down with compression enabled.
>
> Fix it by disabling the test with compression. Compression + squotas
> still gets quite solid test coverage via squotas support in fsck and
> normal compression enabled fstests runs.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  tests/btrfs/301 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index dbc6d9aef..82363f717 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -22,6 +22,7 @@ _require_cp_reflink
>  _require_btrfs_command inspect-internal dump-tree
>  _require_xfs_io_command "falloc"
>  _require_scratch_enable_simple_quota
> +_require_no_compress
>
>  subv=3D$SCRATCH_MNT/subv
>  nested=3D$SCRATCH_MNT/subv/nested
> --
> 2.42.0
>
>


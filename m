Return-Path: <linux-btrfs+bounces-1165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919381FF81
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AD51C21890
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2111711;
	Fri, 29 Dec 2023 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHT8FPUq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC611701;
	Fri, 29 Dec 2023 12:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABF2C433C9;
	Fri, 29 Dec 2023 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703854451;
	bh=0xy/Jy8Li58mpWqFAJmqFN74u7S5lVF968MvYS6wZgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZHT8FPUq2z6A5SOSZLe1gy/Tc/r5gLkDylWaz1lqaiBrkQDhw4Q1B5DuhEyt/DjlI
	 g9tqgOKKfrMkDk4QzhIqwof4iSZB8vhb9ZHHOZOXmvfC1Uj3oGblkvVRfCGRHz4awe
	 oHbtCNAUZ3OG7KGQuQ/+Nk7v4mZXi14mF436ISI7gvVbukdr62ctY6FToDabD1l0ZL
	 F0JSvFZTxouTe+WEqesPVY+lG2N2CaXpNneIG3YnfMwprk7CyVXfriu6GB8He03g24
	 CMaKONaSWhO5hICWbdWlvsZWclwnQam0CKI0kGKQ2lC7aJcIInL4RUOPWhS0RRO4fN
	 I50XH2dWpMeNg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2335d81693so1187851566b.0;
        Fri, 29 Dec 2023 04:54:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzBwjdmANy2K626Mkb5R1i9gPyUS4MLfwy1ZhTAqmqhfIaaC55Y
	EmG9WfIo1Yb64QE6HL/5BXVFKXFsxmaGPRiJPlQ=
X-Google-Smtp-Source: AGHT+IE0rZHCnddIMEboiJvBxRIqS+1IO+gjxivEidOuzzaPa23boOuRqiySLE2mvgjX7653GPhaSjANB8b0LB68y3I=
X-Received: by 2002:a17:906:ad7:b0:a26:ebab:d86e with SMTP id
 z23-20020a1709060ad700b00a26ebabd86emr7974844ejf.60.1703854449701; Fri, 29
 Dec 2023 04:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703838752.git.anand.jain@oracle.com> <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
 <c4e9ad2c-8c36-2cb2-caed-f42c4fd91052@oracle.com>
In-Reply-To: <c4e9ad2c-8c36-2cb2-caed-f42c4fd91052@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 29 Dec 2023 12:53:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5iF+_gBXqnkQzNx5-dbstodg_C0Mjx_p6GBx4HC-Raqw@mail.gmail.com>
Message-ID: <CAL3q7H5iF+_gBXqnkQzNx5-dbstodg_C0Mjx_p6GBx4HC-Raqw@mail.gmail.com>
Subject: Re: [PATCH 05/10] common: add _filter_trailing_whitespace
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 12:30=E2=80=AFPM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> pls ignore this sole patch.
>
How can it be ignored if other patches in this patchset that introduce
tests use the filter introduced by this patch?

Thanks.


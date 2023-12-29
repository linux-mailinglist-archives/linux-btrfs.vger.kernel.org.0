Return-Path: <linux-btrfs+bounces-1166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD72D81FF85
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125D1285160
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D8111BA;
	Fri, 29 Dec 2023 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbdgiJBW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BF2111AA;
	Fri, 29 Dec 2023 12:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2968C433C8;
	Fri, 29 Dec 2023 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703854699;
	bh=0m8RudOupHJ7LsIBcYkLa63tEynpahTQD8Y4S2yD+mY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rbdgiJBWXi6Qgr6VWoHU4uQ1mlL8fbNuBvdKWJGed1loxUsY9h/Ey6kCgbErtWMqc
	 kVls4eRz12J8IvjbTAABeRCBMSHX7qRboRRvNEvnAdtUVP2KyXUm0tHtH+Rkh4uQOd
	 lT8c+kyWSphgIg4o+labbMPxpWHEFV4ikAajn8qzwVctQPSGwiOCeaTwqGgei+cYqZ
	 6z8chuaTalG0vEU6ZBVIWLP9s4Zl/xwQzyoL3+7/x1PS+T7SwXnVOim37bpXN661Bg
	 oAC1gix+dQIZBNJeTUfBjoZOdT2Cpqxb+L6Qd6Z5OzvPIRlUcIO/pWL74hnxL3ntrE
	 stHIJUNGqep6g==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26f3e98619so386323466b.1;
        Fri, 29 Dec 2023 04:58:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwZKSJDoK6EIwkwBcBqU5nkC9J9jemhvpxKNXTzRV0UuRe0ZjQ6
	0MeC9EP/s0tCsJcG+9SGArM28/o01T/Y8qqMK64=
X-Google-Smtp-Source: AGHT+IGZ2Joowh5EBNj4ezX1z6a+3Kkr88PxCjHxageyeJZkztjQthAdjNnfYvdmJvnYFCDaG+I330geVGDdWix9b7s=
X-Received: by 2002:a17:906:d511:b0:a23:4a2b:37bf with SMTP id
 cq17-20020a170906d51100b00a234a2b37bfmr5263714ejc.110.1703854698244; Fri, 29
 Dec 2023 04:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703838752.git.anand.jain@oracle.com> <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
In-Reply-To: <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 29 Dec 2023 12:57:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7C10hZKyKgP=6H-+umNVawUn=vwJ6-gqDA8s0QZNFVTw@mail.gmail.com>
Message-ID: <CAL3q7H7C10hZKyKgP=6H-+umNVawUn=vwJ6-gqDA8s0QZNFVTw@mail.gmail.com>
Subject: Re: [PATCH 05/10] common: add _filter_trailing_whitespace
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 11:02=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> The command 'btrfs inspect-internal dump-tree -t raid_stripe'
> introduces trailing whitespace in its output.
> Apply a filter to remove it. Used in btrfs/30[4-8][.out].
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/filter | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/common/filter b/common/filter
> index 509ee95039ac..016d213b8bee 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -651,5 +651,10 @@ _filter_bash()
>         sed -e "s/^bash: line 1: /bash: /"
>  }
>
> +_filter_trailing_whitespace()
> +{
> +       sed -e "s/ $//"
> +}

If we're having such a generic filter in common file, than I'd rather
have it delete any number of trailing white spaces, not just a single
one, and also account for tabs and other white spaces, so:

sed -e "s/\s+$//"

Also, since this is so specific to the raid stripe tree, I'd rather
have this filter included in the raid stripe tree filter introduced in
patch 2, _filter_stripe_tree(). That would make the tests shorter and
cleaner by avoiding piping yet over another filter that is used only
for the raid stripe tree dump...

Thanks.




> +
>  # make sure this script returns success
>  /bin/true
> --
> 2.39.3
>
>


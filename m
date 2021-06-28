Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E23B5B2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhF1JY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:24:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:42063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232527AbhF1JYX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624872099;
        bh=vhIyYZ7msZOYr3lfD+Hbl2Brh69vI/AmcDPrLyZarKM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Tu7S1y1/RgeQcammVM22heUno73b2dRhM2aoG7J8RFDaLXVyoT3nJbZF1S7QpSmIN
         puMJoNqMVfIWnvc9JpLEf3mUJpcbx+jOPojh2/xM1O4X9Yn7ehVamZnLpg/fbKL9Za
         b7XNJ9EBNlgkqmyVM6JFNbtGtTgndtc5eGESKI+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbp3-1lZw9h2kiB-00P2MO; Mon, 28
 Jun 2021 11:21:39 +0200
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
To:     13145886936@163.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
Date:   Mon, 28 Jun 2021 17:21:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628083050.5302-1-13145886936@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8U1F7hZf+AwSnmCB198rs0tWTeB5BJjzQp8Q1ItNgZOIwVOAp50
 zIAQ8HqAzrx5vtBTDbLFr4TwHPMpW2vvfNyEGIFO0vd+dN5zch7FKJxP3oSSDgmLMo0qFRp
 KZSE2YdkbjyVfQE8Pl4HgqPO+76lS9MYbm8X+M8MYCkZGKm4NL5prFaX59o8HGVof7fg9v3
 k2EQUVqu3ipojHwqPjQNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2DTsEmU7shc=:48pCwe61dCYyPvENXti+e2
 pKkqbunx/nQiVvDYuvCtR2nJF+vX34KUw1/82wWwm4xldLYxsxKuSiCXvkpSqty3DVOCiUucm
 DyBJVynz0y52IkKqX76wh5AZ1DoTZUx1mNjXNVS/T6HWgJFTk4OoF1wgKZ+OEWFEHJ9M99q1e
 NyAtPXQ2SCsPr7b2/8AjuwNL9Nlobb3oCDjHm8MO2FhiMPGoibrK44QEEbhD9EMMUZ1sqv7uL
 AWkjeyiW7UHHLGthuk9p70tr0ZeOYTWmcIBap+BjztcIkqgvmiWvl0RfLJ0q0gb3+E4FyTYl9
 ixxjhESORN44wLCRRgU1SIhOkXu1fJHfuVsm6uZOxPLznYSmyebP7OlqJgQsPLXAJ9lY0WM2X
 vAR0cDYb4H/1vxEuGhlSsUNKQ4rtrL7ggYvYqb9CFOpy0fIf9OZB2FDN7+0hSvFInhoNxXMZl
 wbJ1BXMDXNjEn/nXuMkpirUyglRHvEIqN89vjYBXBHjPWE1V1Olwl/G8gQUNJiTmqXen594B8
 +ft594yuY10lqv9xlrpndFDpmtusmNzRSmJ2ZRFFGYJYNGnFfauCpkAPObNrcsa3Ix8gyjT2W
 5nD3saIS/e8yXVHutJvDcVmWUtqul388U0sJQvVGt/fKE3+oH46cqMEMWrsr7YdBtuTZoVnYn
 9in6KFx7IEt7bjW+ZX6pBJ+XfTVAVuT3kRJqza+hYwlYMrMGWETAD+OQ6dgGhngXxVP59HwcF
 TI74raW1fhhbLLqvZhfrAZXwbh1xqtASOg3GU7/qRTUrOY/H1IhnVfwk2u5zZ++ueYdCu9P3B
 vyXt8lTT0d2eEcu1gBXSFsqrktXqKusnMm6zX7BWXNN50NfLuYgtFlrf3cTpm4CUjbGt4wd+A
 APqfY1pWasGee91P4II22fLsLR9QKX5wLrNY7D3e1qjfRhdxz66alIH8VryFJ9vU5QSEn4yeQ
 LM9BApnTBNYE9Nrgd3DZ+2yB8Ls5LNU8xIOIsnEPAX2L4MwowCa7U1rcnaPFtpuNr15rOoKMB
 8Yr1ik2JOJmhtDFUSX91mDVnu8GiV8gAa7vC4r0fq/a9KbeRkTefH24JViT3b70bjET0Zy0jQ
 zh/cZOBbn8tNFXGCkvjnUIJquyAs4zpxeQ3De3p0rMAYeIs4E4L9Jt+yw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=884:30, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>
>
> Remove unneeded variable: "ret".
>
> Signed-off-by: gushengxian <13145886936@163.com>
> Signed-off-by: gushengxian <gushengxian@yulong.com>

Is this detected by some script?

Mind to share the script and run it against the whole btrfs code base?

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b117dd3b8172..7e65a54b7839 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4624,7 +4624,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	struct rb_node *node;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
> -	int ret =3D 0;
>
>   	delayed_refs =3D &trans->delayed_refs;
>
> @@ -4632,7 +4631,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>   		spin_unlock(&delayed_refs->lock);
>   		btrfs_debug(fs_info, "delayed_refs has NO entry");
> -		return ret;
> +		return 0;
>   	}
>
>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {
> @@ -4695,7 +4694,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>
>   	spin_unlock(&delayed_refs->lock);
>
> -	return ret;
> +	return 0;
>   }
>
>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
>

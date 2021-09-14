Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4840A243
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 02:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhINBAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:00:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:49023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhINBAQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631581138;
        bh=HdUgqoWdGxXkMnxxYNha29YD/h9okPNWumU6ONSuC2k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LnMoO8JOCKSpLjEhvnfANpPGrJiiYfXlXdqj0JhuJK+bADe3Kwd7wvGHj7K3u3jVx
         Cf0SEaaN3KlkJ2rkq4eEkxsh75Gy++/1TPCPP4vYfpVQ7zrhvcToKW9DZl0mJAhOC0
         z8xPC0wtfJ/sdFnuhc9P/klI4IiazslJrsy+PqyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1nFhze2aHb-00rodA; Tue, 14
 Sep 2021 02:58:58 +0200
Subject: Re: [PATCH 1/8] btrfs-progs: Add btrfs_is_empty_uuid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210913131729.37897-1-nborisov@suse.com>
 <20210913131729.37897-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9a16eae4-5dd0-cb03-7457-38ba62760a7e@gmx.com>
Date:   Tue, 14 Sep 2021 08:58:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913131729.37897-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Po7pDAKgICKrKSm+HBsU/NtN5YE6Vg1e0WXGg7qssKGPu0kX/5
 3Fh/MZzsrNL1oA60sTbXSREuAW3YsuktfjiXEqrwcOB01nICTck/ZjRG/56bZhwiuw0mMTk
 ZAtIaFJYo+VC7LJ3WLiYOICnYI8dXhlsqd1fwn6dw3wiUi5Y61SqZC87HQIRDeVkvit6GzI
 9nhn+K8Uc65CBwBfInUZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XsU6J273cgo=:Mpx6pEupCSqOPfc5U/EOlp
 uawm9g8rkVgfM+c2TFkM0Ks03XTyV5y6lQlFI8IEsnxnc2138wlHsY4gpIp44heLTZuhDxXEe
 Lpd+Xh/GTlzWoY7W+uQMlvsYxJveW8i07avhZbjkaEOYYBNl1pzZbF0mYBLc7JCakj7jOA1sA
 u9Rs0WL7gpDwQLY376yJnfSJqkOW7mS9Aaek7x7A924/4Irn2AXvOQHXqdS/J9S/lSP9DfSYr
 vdplOUkYQ+MgElxYmn7ozwHWQS4zdQ73yJJI4CAa2USVxfO+t/b9Ii2zPAh/+v7wRvGzpyHQq
 IyHKVCNJgOS13PL9eGQPlLCkTmSj4sG1TT5XtERWGeW9bpfI+pwChmVv1D8giU6Njti/zq2G6
 HKzZ9WQPdeno/OILF+ylxeObKlrlbvyrZ5vUXH9kecYVdVpma2lX4dXL8+CNpoF+kgZeubQwS
 gZIj3zM9e0uQNoSMkZspGYwYvufc8T71yKwL/Ym6UEO8qfw7aRPy5FAIFYvZJXoglxN0CCerX
 V4KU6RH2+iHYh3eRKyYjMWpa8DNT4BU1hsZiQy/klw/3jJ5pw8YNhRssCXnc+LPCy2Vq6E8bA
 BUtO2vHwKPznjxjGi5FWjtFp8PDqqmJA4Sk9wR3qGPKANmKQUThK+G6VGPwAWFpu2DWlEI9vA
 kTfbr8StTrE2tSp3fsZabDyr1Zhfk7gaYlIJx21PCA8RMPbHNMccXdMBN1QHDTV9KLp6eAGu1
 vLuVtKWSABVeVl798uIiQf8KYVGmaoTXasHI+wWqCLBJDfctBWJB0ypJDStc68/H+ZxZ/dlXs
 w/YiNSqIuX+Q0LDfQs61uBGEVZ3Z+MdhUgnjH4Jaxctb33mYfEUE15bhDNj2rUBPFnsbTopXn
 SR7S0jTwtiTJrgO6s8+a9Ay72LUS9S/XHCI8bzsmKiItZWfmc/8XFRjXSet0x70TyiG7lwhpc
 NJ9ai/21hZ/ytQHm425w0kbclnC33eQfxOcjomUn1bzEh6D5iRRKDifuKsqTrLOUPlOlzvfa9
 dLgny+Y0FlcEWuHHGCpDhfKw9ynJ4UdjSKQlTemPtpjRXFB73hpO0OTSYD5UWGWmNoSmJRClO
 gP7n2+QJ/b5hdU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8B=E5=8D=889:17, Nikolay Borisov wrote:
> This utility function is needed by the RO->RW snapshot detection code.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   kernel-shared/ctree.h     |  2 ++
>   kernel-shared/uuid-tree.c | 11 +++++++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 3cca60323e3d..f53436a7f38b 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2860,6 +2860,8 @@ int btrfs_lookup_uuid_received_subvol_item(int fd,=
 const u8 *uuid,
>   int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8=
 type,
>   			u64 subvol_id_cpu);
>
> +int btrfs_is_empty_uuid(u8 *uuid);
> +
>   static inline int is_fstree(u64 rootid)
>   {
>   	if (rootid =3D=3D BTRFS_FS_TREE_OBJECTID ||
> diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
> index 21115a4d2d09..51a7b5d9ff5d 100644
> --- a/kernel-shared/uuid-tree.c
> +++ b/kernel-shared/uuid-tree.c
> @@ -109,3 +109,14 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, =
const u8 *uuid,
>   					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
>   					  subvol_id);
>   }
> +
> +int btrfs_is_empty_uuid(u8 *uuid)
> +{

I did the same work in my previous warning try, but it can be even easier:

	u8 empty_uuid[BTRFS_UUID_SIZE] =3D 0;

	return !memcmpy(uuid, empty_uuid, BTRFS_UUID_SIZE);

So simple that I didn't even create a helper for it...

Thanks,
Qu

> +	int i;
> +
> +	for (i =3D 0; i < BTRFS_UUID_SIZE; i++) {
> +		if (uuid[i])
> +			return 0;
> +	}
> +	return 1;
> +}
>

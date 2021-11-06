Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A0446B80
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhKFARe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:17:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:33983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhKFARd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636157689;
        bh=M5QAWGcXFXVDogajivrkmyfHnh/lUlnPlFgEhY9GCyI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HR6foO3rr/b7s1SYk9bXFlHh9bBreF7acmzwAKkhUbBRWIg9kTZivfqstzwRqQiow
         qn97LlAD19Ro1Cwy75SRSqVisGnCJVf+H+faLKRzOa3PS9YLbkm0XzSlFYTxDFCZGl
         JIot4kQZS9k52sXkd5OOJeK3Mm3qPX4ZWth4FYos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1mDPhf11J1-00fltS; Sat, 06
 Nov 2021 01:14:49 +0100
Message-ID: <0c952da2-c971-78fc-64e6-f314d1c85dba@gmx.com>
Date:   Sat, 6 Nov 2021 08:14:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/20] btrfs-progs: check: don't walk down non fs-trees
 for qgroup check
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <ee44994bf587e662c6cd99ac165da53d5b0cfd9e.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ee44994bf587e662c6cd99ac165da53d5b0cfd9e.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4hqaqEYemzbmj4/a3+UAdTsW3xzZDzNp63lNLOeMA7CkYv2Iw6F
 LMT6z58aAptifovseK2h9JqLxB5YyAyS9z4BNNczQmcj3hy/lODN6qGa4aSULx+MZxFY6lx
 ZRUeZAmeTgiZ3hdnrTnhtnYIoL0fvXMyho7aWL2nyFRu7vkI1PhNQal5FvIoKxZcvFsKUJo
 ItbFqNCry7ApSy1ooXE7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w7z7CLT+AzA=:fQBsiY1toE4ioA4R7oC0l+
 QXujFq7P2DjiYHW2myqhbJbT6F6IACwqNn8w0eWJ7Jwc63HeInWPdM3DNDNxXwGWJGib1db3P
 1FOVe6A9+tLjOOb1/FbpU+O2EwM0NGF45/aVY+I16BhodHzHv/QOP3CmE+OlgYgUtfSXEipJX
 tXplpzfye7c3mVrYBOCTSqLMZBTMBFFT5EOd9PWZRT+wYg/4isLRasxwRWSmRc1MtnHcPDH0I
 IR7HQGo3sBIJ/ZBgX5DMyDmvo7oWXPS1hIjvsX+aC/E6yfquT6AQ+EZe1CLcDHZWqZVenNoyW
 nfQaVmU/jFH1H9QV+bw/GI2gDSGMZJj+sjEx6KQjc2tvt2GjtxHerDJlHOHsWmuXXRd/PKIlb
 6dE9gynu4g5Ug06kW87cDOGd7esIUh92ojbTudk+rxMl33+f8otZCqvQfwa1/klddoIraM4al
 pQgYB/ihTXd2kIQNI2IqH5VTUQPjcvOCuf4tqS8D18Vqm590T4ceJ6aj3nEoMxQCSikN8fQw7
 3eg8z69eObQ3/nlAn7iss1DOj2yfEx5kyA74unyDNRtzbusfsXc6T4vxmsR6MS5gVAmUVVCkW
 K+2rOHYEMA+oU0OnKUjz4h4FC8JQbf2wdQCORGdi18vVV2BSVy1ojgMXaif+F+XjaUrW+Hh83
 kuJ41AH04YW5fab/DgQWgRCD1gGQkqueigyQPTDxFTrltbZZ6cXHSMKoSJ5KM76iznW640qxY
 9xpX79Q40fERS/INTu1No5nADE0Lt+Sa8deM+XOHlO4rk2RdtUVGUb9g11zV/7oLvLnnFbY7W
 zKRFtpCNg9d0+GsIZl7ToKe5DgAdRic5zalPFZpOuZLykHAlVTfrRmEY9ew4ahj5NoxLaAHQa
 heKbgE7jQdV9z233jkK8Eh6jtilfBMR1+h5zzGBhxcpc4Teb1ylWu+v0AdayVI3+4DyyLfRcY
 CUD4lq8gjL+F6wsRdKzwKOBYqL/UiscSZz18yzg3yCuVCzXx0k6nadbqPgdksixNEEdELr2xx
 LoEzvEY16PirDnWvfDtQPmA8E3e09gnGBkGqSZQMqkF3H/j0N+4799BHnOFKiB7OiVMmLQOUN
 OQILVumXURsxcQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We will lookup implied refs for every root id for every block that we
> find when verifying qgroups, but we don't need to worry about non
> fstrees, so skip them here.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   check/qgroup-verify.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
> index 14645c85..a514fee1 100644
> --- a/check/qgroup-verify.c
> +++ b/check/qgroup-verify.c
> @@ -765,6 +765,10 @@ static int add_refs_for_implied(struct btrfs_fs_inf=
o *info, u64 bytenr,
>   	struct btrfs_root *root;
>   	struct btrfs_key key;
>
> +	/* If this is a global tree skip it. */
> +	if (!is_fstree(root_id))
> +		return 0;
> +
>   	/* Tree reloc tree doesn't contribute qgroup, skip it */
>   	if (root_id =3D=3D BTRFS_TREE_RELOC_OBJECTID)
>   		return 0;
>

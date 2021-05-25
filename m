Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228B5390D11
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEYXwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 19:52:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:49089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhEYXv7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 19:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621986626;
        bh=3knFpNCVp24esQWfOwz5n44+EydK6ilm4m32IkO9HeU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WgObvDPC82V9qvdh5iNv6IZreNYFMzbUTRczyyLNZ7xZkyJ6rcuf4DiHwhiyewzqm
         cMiIfiNBs1x6godPHkC8JpJvBCnNhmpNm7urnr3yWiBN4AhmhT813eh4WRgK+6/wRd
         6AToVY5F0WBhxvMVAGEAul8xECmGaMf2Ivsf2st8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1l48rz0z6w-00il2g; Wed, 26
 May 2021 01:50:26 +0200
Subject: Re: [PATCH 3/9] btrfs: clear log tree recovering status if starting
 transaction fails
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <2a572b691dd9f79de5649894dd24ea555913e1c7.1621961965.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <11027586-02b3-c9ba-344e-a820e1086eb5@gmx.com>
Date:   Wed, 26 May 2021 07:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2a572b691dd9f79de5649894dd24ea555913e1c7.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+y3nDP6rcrXrA/rTjOhWnIoPDbZ8WhRm6GiE0gF0IYDEYWnJBf
 0fjwlZ1AKaW+n42uShWbldE2vrZs61WR4TTD4xQYP/0AaiKDcvtO3IQ+B5qxncVqmcZgKFM
 F9xphKCuSzkecNHuij7HRnSO1VBKzTnJa345d6eVOkVaNg3eCl2i2CXFMDT9aaAtjIEE9hy
 J4Lhd7m96B98a37UW1Vyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6YuwDL7+4+Q=:DLta9XdhA+cH/XwZtayxzF
 waf7BpYSenFyPB20tHWwurbqbVJ4hapVOna6uC+K4p/LbnC20rswzjvY+O7mKcFhZtZcc7wpq
 LORCQavoVI+2ADK9gz3gI8N6wJaxBnMZt+IJwu23qunpHIrHnUzZi3eFAbBxFHFG5VSStE10x
 VH1r3vuWW7ZHiswJnU/kMxDC6eaeQvURR0Hb+n2U47LMlnz7RbsWWSe4uUWKBExG3mc0vtrsZ
 Hsl9WQlovb6QNt2ZmmGr3tyKB9Go2YZyQkpdPRNv8r1l7SPCu5U8fvNN/+r0LhoKq6TNiso6B
 EAoRyW9SOn8SqN7vX+HPJ8heXWBkvLeOhdJJHKPZyv23fQN7WssC/gvtVXiakninnltXH4CaN
 Jcw1VCO6Nzk793bLiMGXJPg/gAzxqhG9QdDUwm1hg+1zHps49aIkemhCrxXSvxIgLXOVCzo7V
 KHRlyv/QpLbmke4NSUYff2Aex5MK6evVlV9O0lVtd9+WOfVyPaRyiBHPBGDkdYZ8MGyIaSKx2
 86Exzo71ZFz7Rkost8HGXFFUDh9L/LJpdyGYXPVBlgM3N6H+s0Ua3Hg/7TkN7R/1g3meiBjRf
 iHK5RM7X2v/7ebCqyge8c3YF4sansGXEPnUVETiBzSr+F/Dxr4+D0nPZ+fsiNNSfHS0ORZBHj
 x9fc5HpWxgTFGqUI4QEMvo7UrPvMmx/LjMAV+clDaKkLw0scDqSfPWpGGS7pR9jnCJGMvZFHd
 HKERZQyGwj2n5gXeyaPzXLMbNYKvrbJLeWrLdoxQrbbTmrQbeso/kUGBSKetrKPmk/ofkR7YI
 0nxMnRXvO7Sm1PcSEgLnG7e/eMZd5iaDRvkUKNr6PXmhZUKhBmInx++uMFKMEkAvyzIhnO1g3
 jiwFePAHLmyLGRoRClRuObXdHQb0yRgBgbXyGymiZYjDvifrAOJBlUUtSt3uKVIlpN+A/+QOL
 Tod6vE0SdfGpXxBsbIpW6H+sDGqq8FEjqZfvHZey6zKrqqp0bwWULC7VZlcb/VQsq4Douo3ZY
 NFVsZoNE5e16bktzZnHfOl+5DNLJ5DAPl03YDoHQPbBjxeb805D1aONvpeAnTP/tffb3qR4k1
 iheMp4krGxf5YCQ3CNUWKf7sIU5qSfi56A2n5jM4XJP/Foy48pxMUYE0Cr36ZMbDYv5NLgaRB
 66QRxq8bOvWLC6ee6ad0Vz0yXP+StaXIzMjA/p3Fv+i1nNTtFBVk7zvShu+Yq4IjZIXj/xlE8
 rGuGbMwb/1paq3Fa4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> When a log recovery is in progress, lots of operations have to take that
> into account, so we keep this status per tree during the operation. Long
> time ago error handling revamp patch 79787eaab461 ("btrfs: replace many
> BUG_ONs with proper error handling") removed clearing of the status in
> an error branch. Add it back as was intended in e02119d5a7b4 ("Btrfs:
> Add a write ahead tree log to optimize synchronous operations").
>
> There are probably no visible effects, log replay is done only during
> mount and if it fails all structures are cleared so the stale status
> won't be kept.
>
> Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error hand=
ling")
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/tree-log.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c6d4aeede159..5c1d58706fa9 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6372,6 +6372,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log=
_root_tree)
>   error:
>   	if (wc.trans)
>   		btrfs_end_transaction(wc.trans);
> +	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
>   	btrfs_free_path(path);
>   	return ret;
>   }
>

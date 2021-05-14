Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD13806D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhENKGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 06:06:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:55299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233982AbhENKG3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 06:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620986709;
        bh=hooDLDOqiYBb1tO2UjhQsEE5rtvioUJk22wwsjj7GhM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VvI9HSmCRlwxqmDun1dFVMSfSi8a98DmNwrkHgLPtRYn30vSAt/5iNaifrB9b0d5J
         BWMvXVaevFrtJoncXwZF+eAaV76kXdMk0+/3DD+HReQSph8Odu8KiuuxvbXEuCRUUT
         ERQYKitm9nGMio+CFd1RjWNdoItB/I6VlximCXqY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm2D-1ljSVL3XNz-00GJLW; Fri, 14
 May 2021 12:05:09 +0200
Subject: Re: [PATCH] btrfs: zoned: disable space cache using proper function
To:     Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210514020308.3824607-1-naohiro.aota@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <275c2c31-c8e4-cf9e-9137-483efd3e1efa@gmx.com>
Date:   Fri, 14 May 2021 18:05:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514020308.3824607-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O5e8Bu5FW9sP8hoXx5CMu9PgJE0UTHwQ3b0ZkDRMWvSr2atTKw9
 qwKpchxSt8IDogZP6TGUT0zxGXGdtvkGtF8xv+ouiGAk61nR9i4KtVjaSe/FcBGMa9xvr5l
 RCwF6bR3S/3uhSjroU+y0UgY3RvQwlaGYX1SLWp+p7KjIA1OeVt5f8S8m2TM9LTSLBrRdAN
 TEgEAl2V0R57Ii/tx62HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D6gNdo/L4qo=:DWIRfFELO3t6CCMcu5at1R
 MXv6f6uA5g78BRXG5bXr1UmpDylDQlSmm7CixvUMwFGJjArzXWZuwo3jJ2gjQbmiGhRSDd9Kb
 oKqYAZOc3D/Y/ZRnvWRZ4ukhe26mUUjXTDSb/7pbKtwsDaIxMqK3MNFBjhMGRhFRFdAwZLe4F
 12x/qQJh4D95KpXSZJackH2q4A0kU2OPis3dMnHcawFkuCy/MD8GaH2NeylapHzU3j8wFMHK9
 k61coUkXqjLa6tA2yMmVrDPeqAXxBR34yaOiYdMCn2WbCSmxexsbmvNtRp9U7ujmWc/vzPVpa
 71ZLRbm7noFP2vINleSwUhMcZpS7vuLl9FrdOnrwyxfdhXXMsht/iPjJxT0dP5BzufcqrKy7U
 XjqFzXFlZxVHRGxHN6+yp7lUgNd6NbvJOa4z72HeFmdpHB23Hwy0GuWoMmwe/w4ZB4Je9DzKS
 yQJCyZIzQCytS7HuWsYkeAKpb9LehfCw60hURakYloUGq+Mo0n2675QmUJ9MMAFcPVho4YUn/
 2sFJHVsGqKkktZAc8VKfvVQY4UDV8N8EkyddCiVpMbvjgNBVUQQnQ0Pf7TooyKJ+l/HOv0Gdm
 q3XrTIuBW7HPKEDB4nfAS9KPKElsv6B/y5uyPIPgq1U3/tra6slgeHan/+4sfC8hHe34OaT75
 2xZbnzJ6fPrckdEml4RkzntZld3nQBQSAmp89PSwF0NPOFWRpezYXgdOM7AJCWqRU93WopGs7
 KNLuWPR1SwVyLJtjK1J73NINgjD3SFudHE2exA2bhoby0b1PGszkfK3mL8ZbF/UvvtIyLyb0L
 HIJbvb+8/CUDBiL1m1GBUXLeOPR3Q8IaeeFsxTMkapUQvqy9ztN20Ruer6S2V8GtX6iorMh0a
 wNB+Jkt0mqi18/c3xFSQFTz+gyD1xudfbmqbYLueB/3Z5kbtJsVUibMVq1c+R8r9vPFwJS+Bi
 G+o12jldhqxxbWmI8Qm3Yq9x7QNbgjo0COvDX0gcDXKcSmDwYWeJN5LPyiIfe0uskRQsNVMdm
 0/AOYuzEemBZ1nELVUMz1WK3MljnJQD1fPe4BRzlFDmQzekHWgK3FeAQk531S8TISzYBM+JE4
 Sya0pa10IgC1QvlaKYuIkMxssNIup7xzdyPu7JTbhpLxJV9zeXPVKwdK3fhYRGRGP5ggoXU+D
 ZTxpOyv2M/2U5DBg/c+5OHqr7n4OclNaLHZ0Oc4/dvuUd3NkOmdF+acXOWt7K1CGGozPx02Au
 ei+7fNVB+BUguAjKA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/14 =E4=B8=8A=E5=8D=8810:03, Naohiro Aota wrote:
> As btrfs_set_free_space_cache_v1_active() is introduced, this patch uses
> it to disable space cache v1 properly.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4a396c1147f1..89ffc17d074c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -592,7 +592,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, =
char *options,
>   		if (btrfs_is_zoned(info)) {
>   			btrfs_info(info,
>   			"zoned: clearing existing space cache");
> -			btrfs_set_super_cache_generation(info->super_copy, 0);
> +			btrfs_set_free_space_cache_v1_active(info, false);

Can we have a better naming?

The set_..._active() really looks like to *enable* space cache, other
than disabling it.

Thanks,
Qu
>   		} else {
>   			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
>   		}
>

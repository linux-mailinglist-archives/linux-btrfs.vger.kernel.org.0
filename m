Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26449167E6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBUNX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:23:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:50659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBUNX2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582291403;
        bh=q/RMwsKJ4auxtnj/oEcv4vqBO0ux3oQSeaimSLC/+/A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KHaSqf9KorOi7bcq8dMY1MJg7pbtAmCNslEFgsSPYLYA1z9HHcr7nj/6Xu3+Wjj4E
         6xE2KYZtctewvBcyK33qA/rKVmPAhjV/bl3JGcDqfv9MHDzZT3mE10xqOCz3cetBcW
         FNaNRwpMTM7CeD1jxMkaZJoVN2ub64WKAWE1VoOM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmGP-1ikyp92uAD-00K94j; Fri, 21
 Feb 2020 14:23:23 +0100
Subject: Re: [PATCH 2/2] btrfs: Use list_for_each_entry_safe in
 free_reloc_roots
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200221131124.24105-1-nborisov@suse.com>
 <20200221131124.24105-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <7d5e99e4-4122-bec5-6fb8-83a29fb6ce41@gmx.com>
Date:   Fri, 21 Feb 2020 21:23:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221131124.24105-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hBqWI9+myTu6Wy4+3p+ZCCjtuDcWZ7HjGM2ESdc36jGSxtt5hHr
 NUAgKpfqIXi2tmFzP4OpI0/cYn0Se6DnfrZGGGwSKKyZqBuuJfOGJ76l7mcguzpgWH2epTF
 LXPL4r4XXgweAB7sALCPaq2+kf7CLwy7CC/rZlo67hH+/KAWAAOqTe/RdGzzUQEh+I0ngjr
 hqitcPXIcOjFLo0tfKmMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/ffsOlJd3c=:2EFBSkxy4+hWizWW8F1CZb
 XHOwQjkbEBkVwUrhsVQ0apeIdaRBCbUaOFtRokXKl3JAePHb6ZX7kXqUaYHPLd9pTMdI9O6H7
 D9IWGbERjgt5mNqdsjSY2/ZVVk6dXkQRMCp1QaexyeKKt8JkXwG1b5REqRCXJqDRqd48KNNka
 eVnMfFgy07rF2zOo03FnVeWSnb426j2hAYj/10+o2m82HLBjzYRzDy0sIolfUBrjrBtY6pRqa
 kSssOWjTBBlVkAIvb4uauAfNhVdiq/KnODb5B7nBynBO11qWd4FlWfBgtYA14JPH7JHnkKxAz
 51t7dL+5HoZTOF7z9VrxdVQr2BcyeKG5i4amL0QV2HiYxY+xE88suLQZbWAWX8KfIRUilugVs
 QAshmcZp2hz1O83/PUYJH6hQWdZvRCIRmh1/wduV5EyaovsOlGlsd1FY5XX2tdSFU4eicBywj
 R/LgJ2/pdG3qWmr405pToClUdaYAzm8BvbSOqt61P9MVoMiNnrIrKnCGXry5GxaUeL2QSXUVc
 hal1Xo1GrBwq967F44gwygYJWwVHlWdEdZw1/FqN3TzyCZu8IWY30dsZK3YfUOaJ3L5jfdhjh
 snQP1SYqkRTl6Edwvw9pMCZD9MfxFW3lDvEg2WUjhPWETBiZZZAZLifgHtOteY+YbQ+rLOE19
 wEYMMLPd+V8gmyQQlN0Vhg5/UMrphbXRJh7CIxAiqPFOOIG6pzROu/mNW/CoDSOkl0+D55xwx
 ZklQRrFsaFccv3Vo3T+bKsclN0BLj6uDgtLV1qBS6x/vuNqLDiR7wEkbPUsqs/bWqo34jMUeP
 W5WGgTQZWzzh6pgPhEQB9dRC6kgUpxS9LikOzNLmARDrlnyCGHsQQYZ5Kc/TVg6JvoyxcJs4a
 0MGMQ1XdnTlCzF+dgiQYVQr/8btMgmQuTjZC+cMGS15TMgBpRUi4ABRtMvBUaBvFr24+fAi1p
 MXWbNLZtsF4URzEys7ziX1MUr5IT4LUG6DQuygRUMqcWDCq/Ww/WT0FD+9NGko6Bh255pMSIJ
 crDFPZbENm36kpwVlcvn4Xzk55PQ8fAduClkaCp6pee0fqojj7fJaGp32dWsTl9LrcVzF+11p
 qH36fCvIj0ukeZ3KqKltgMmfBKS2/2jq6cUK13rhkAgxM5Bs7tfvHIek2fEDpDaoqg/SxdNZr
 AJ5kThv++XMhaUblPeaC9Sx8P6kuchp2OODx5mr06suUdTXHJE/xg3c2tSheLCyYEyYNAmonh
 Ceqt/7a8aS2dW2vCU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/21 =E4=B8=8B=E5=8D=889:11, Nikolay Borisov wrote:
> The function always works on a local copy of the reloc root list, which
> cannot be modified outside of it so using list_for_each_entry is fine.
> Additionally the macro handles empty lists so drop list_empty checks of
> callers. No semantic changes.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index e5cb64409f7c..f13b79adf6b0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2523,13 +2523,10 @@ int prepare_to_merge(struct reloc_control *rc, i=
nt err)
>  static noinline_for_stack
>  void free_reloc_roots(struct list_head *list)
>  {
> -	struct btrfs_root *reloc_root;
> +	struct btrfs_root *reloc_root, *tmp;
>
> -	while (!list_empty(list)) {
> -		reloc_root =3D list_entry(list->next, struct btrfs_root,
> -					root_list);
> +	list_for_each_entry_safe(reloc_root, tmp, list, root_list)
>  		__del_reloc_root(reloc_root);
> -	}
>  }
>
>  static noinline_for_stack
> @@ -2588,15 +2585,13 @@ void merge_reloc_roots(struct reloc_control *rc)
>  out:
>  	if (ret) {
>  		btrfs_handle_fs_error(fs_info, ret, NULL);
> -		if (!list_empty(&reloc_roots))
> -			free_reloc_roots(&reloc_roots);
> +		free_reloc_roots(&reloc_roots);
>
>  		/* new reloc root may be added */
>  		mutex_lock(&fs_info->reloc_mutex);
>  		list_splice_init(&rc->reloc_roots, &reloc_roots);
>  		mutex_unlock(&fs_info->reloc_mutex);
> -		if (!list_empty(&reloc_roots))
> -			free_reloc_roots(&reloc_roots);
> +		free_reloc_roots(&reloc_roots);
>  	}
>
>  	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
> @@ -4689,8 +4684,7 @@ int btrfs_recover_relocation(struct btrfs_root *ro=
ot)
>  out_free:
>  	kfree(rc);
>  out:
> -	if (!list_empty(&reloc_roots))
> -		free_reloc_roots(&reloc_roots);
> +	free_reloc_roots(&reloc_roots);
>
>  	btrfs_free_path(path);
>
>

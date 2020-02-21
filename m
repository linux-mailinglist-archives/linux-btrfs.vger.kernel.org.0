Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27BA167E64
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgBUNWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:22:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:47981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBUNWW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582291336;
        bh=O+T0VbZ6RwfJ9Mvo9vKA/tjvd8XT+zyTlZIGsSRN4Ws=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CH+c+VnyvS6FajwhLB2ZGwrhYfxBx6ZLyf57lXvWsShFhHNuBFYXoOjCmIjVVXxeg
         TURWTn/oHSzV95nIeOMaILq4zhZVxN11VrdIiroedeBRzfsp2l/vJzTGn42Q3jf1sX
         6SwdqQu0q8GFVL8STk5lPPX6KlaUtXLunE1O/yuA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1j8Q3A0Hv2-005dLe; Fri, 21
 Feb 2020 14:22:16 +0100
Subject: Re: [PATCH 1/2] btrfs: Remove superflous lock acquisition in
 __del_reloc_root
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200221131124.24105-1-nborisov@suse.com>
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
Message-ID: <b4c2a95d-b76d-0f8d-52eb-077f97bb4530@gmx.com>
Date:   Fri, 21 Feb 2020 21:22:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221131124.24105-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TvtvMDtnUzlIhY9YwFEYDye3VI7Jtth4HJqcH6b88Ad8EpG/DXA
 w+f5aE12IE5F7k8Rr3l3ErM7ZWvU/hVceU//nCbULOEFG8hnz/kiLxxka0RLXBq5eDv+BmN
 +piAKI4vIDz0oKw5UWVpWC/2qdjtk9dyIAokOqorRYZbn8CCyZaB+FdEvWVvX8tQX8rYpF9
 YPwMHHRNrAxJOlO9R1qfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z9trz3Hh9wM=:fjtEn5Kbg2jM3LDhcPnis9
 GzA2Jj8yXtJ6HmPqby13buL860aS9tb9XIARtp0g4W1UCNMhqn79qGvuiUlP3eov64j0zfIPk
 rgwVyfxA3B/sjuD9IJnUXZa7YZjLNurltY421++2pHvif2+xukNhp4+Epe0G9vIaJVNo9kxF7
 ItRZH3A1diqTugB0jLLcLFyWyEZyGLs54OyhPavL7ZzMTaHbnucqYRBEauWEbjf2wSF2YMWVG
 MpyasDcjKGwqvwbiVExqFk2210/uM1CG5iaVI6hydlufnp4849LWdlxNGwxCBgqumBT6yaFzA
 KHFw9q9TtLa72xCMLZX3VLXgCYnFNQps9q8Hd/hHTOUFzpCNGu75sOJ8VI9M0a+XkGZ8L9Zba
 SDMBGgv4w/cMgFJAKHrJ/1Hd7Uk6M3k9PK9ztm//gASL1zvDo62kfbVF+V17KHStxabHdmPBe
 aFsrJplYeYadHY7RxuAI+tLe6Sq2e3lKohr3ieT5cImpREFFEdjlNw+hBvBDAFSyNty76Nlk7
 8TywuvJFrik4iOOuUHQEYomAHDJiggWNj9vniFLgL4HoWy5rQ8KTwB5zHKzf1+gC2RttS0mRb
 cgvhIFnnOu4m0+x9TcXNe9WtzZZz4B2MBwLqG5SKGoxbrwl1CSWfS3ri5ZtohOaA0gWCvC7Yd
 S0ls2oKtjNNbdxv7Mv0bIUKQ/MpxUDxxMdx7YPZnvirhWe5x/sieBL3v5iyqPlFcTOZ9c9W38
 /SoIraCp3r8K7kyb/Kc7sFpoRvbswVDpgg4Dj7KzVNPlZQ5rjpOpgiqjhYBTYHyBERAs7Ti5s
 idWWD6BkCqPMNXK1ecOOA+6b4B5Efjacih2MJZzo4Y4Z5EzPvDnu8338oTFzH1ULvb8/RmuA1
 9vQCfwfXzTWgzUGo4kT5ofc6R4PqSP6o0iLY4JbkcK/P6OkHI464UMEXjp05nSadk4JqUTkn/
 paEhy1QHwjCwlPT2PiwW8TjbudSeXPSc73QlCdYt8AOpWGppzS9g3FXrEqLG1p1voEPckwU3H
 qmWVVI+J7xFoiUSmaXb0/BSTR5Jlhzoi2naTL7IZmoYMBr9FxfH1Rhvjji6oPwPnFC/nuLVPC
 kv5JB0iLjTS2fJtWcxy3tkp5fX+RSvkixJI26+yxmIfQhy8KBzy+LHcsNVvYye60lQTM7R60o
 5KIZMrXCS+UEPnP5oZCoskqGA8dTDL4drHKC7GUfn4Nb+BucaWNuN5R4wayLX0EZVO4xIl3Th
 rVmYRaqDbioLCCH+l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/21 =E4=B8=8B=E5=8D=889:11, Nikolay Borisov wrote:
> __del_reloc_root is called from:
>
> a) Transaction commit via:
> btrfs_transaction_commit
>  commit_fs_roots
>   btrfs_update_reloc_root
>    __del_reloc_root
>
> b) From the relocation thread with the following call chains:
>
> relocate_block_group
>  merge_reloc_roots
>   insert_dirty_subvol
>    btrfs_update_reloc_root
>     __del_reloc_root
>
> c) merge_reloc_roots
>     free_reloc_roots
>      __del_reloc_roots
>
> (The above call chain can called from btrfs_recover_relocation as well
> but for the purpose of this fix this is irrelevant).
>
> The commont data structure that needs protecting is
> fs_info->reloc_ctl->reloc_list as reloc roots are anchored at this list.
> Turns out it's no needed to hold the trans_lock in __del_reloc_root
> since consistency is already guaranteed by call chain b) above holding
> a transaction while calling insert_dirty_subvol, meaning we cannot have
> a concurrent transaction commit. For call chain c) above a snapshot of
> the fs_info->reloc_ctl->reloc_list is taken with reloc_mutex held and
> free_reloc_roots is called on this local snapshot.
>
> Those invariants are sufficient to prevent racing calls to
> __del_reloc_root alongside other users of the list, as such it's fine
> to drop the lock acquisition.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8076c340749f..e5cb64409f7c 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1381,9 +1381,7 @@ static void __del_reloc_root(struct btrfs_root *ro=
ot)
>  		BUG_ON((struct btrfs_root *)node->data !=3D root);
>  	}
>
> -	spin_lock(&fs_info->trans_lock);
>  	list_del_init(&root->root_list);
> -	spin_unlock(&fs_info->trans_lock);
>  	kfree(node);
>  }
>
>

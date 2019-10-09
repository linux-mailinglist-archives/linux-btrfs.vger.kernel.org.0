Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C161D051D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 03:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfJIBQu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 21:16:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:48719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfJIBQu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 21:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570583783;
        bh=oY2nFqz3AU0EpfQw+MciAKQZOckcZQzRtmxsOBGHe4c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XRy+8vQ/msadumlK4tVg0F6SAchVUh7/gbaKufSlEvxZ6jXj5/puaD6EXwkA152Fx
         PhryNHJquVLPE7TapHhIsKOQ0BEmpVCDQ+dVHXKm+FAPhG3s5JGOgX1vn4xRPSezCz
         CnxbD7eaoigDr5fh5MPaHWWomhljjLmG0rO4xDCM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAOJV-1iOrP61pxT-00BwWi; Wed, 09
 Oct 2019 03:16:23 +0200
Subject: Re: [PATCH] btrfs: Rename btrfs_join_transaction_nolock
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008174306.2395-1-nborisov@suse.com>
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
Message-ID: <b828b556-30f1-9764-35c1-b6454c1dae9a@gmx.com>
Date:   Wed, 9 Oct 2019 09:16:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008174306.2395-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mlNffc1aGxlHmavF/LGr8mxWrvoIgKtH4yNFEeFsXBFV/MT8CtP
 jSZWXNpnntNJ+cwPv4Cl/15NFUhl6UnM4uwW9gDJVi5I3HBt8KEXdhNwvZCPui4+b5IBkjE
 6+fxJUPOYroZ7JjdGVXV0JoD0cw23QEfmn+sRAVMqSVRHyxSpl3sKUSt3GJqEZ7QTmurmWX
 F6wkfKD7ecesRwQTgW0HQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Krw0qGWC9MU=:Cz9/z60FNns+VQ8tkhaaWv
 SWzzCsNCpED1wk60ytNSLMVX4shp5WJsV03VhW3nCr28520LpvmoD2dM1tasDeT/PtphIQ61z
 hAK9zPGimvhwE2PlfN9K6Vrn7ndf+OTg20hdPWpvSpujNCYO4fzQg74ipNFFab+QbXdSqAyb6
 ewfTJG+i7O7QwbF5h/r9Yt5RYhxkjwPZnS2V4nApCq20k/jG9BfXoUJdHww4hQuHzyEy50icq
 ze1jgSrAHR7mXD6HdlCY69GVPmBPvA7F5SHDwGnX4u/a1/gczio92PoPJFuOC4nynHUjWgGbm
 X+iwnSGBjvaRSfEMQ7EB4ZJRfHimOxm+3KvAL9qYg39OWcI5MKsKErlc1zbIZV2lPWZAHNGfy
 4YzUjU/dy1prWuNmR8TNQQnGNoqXYfsW1CxLnF2mQxR64tQXmxyJ6N5RZdRXtV3zWBqNAqgwO
 lvLbTWPnfnMAMyN1o+mMBE7YlTqc0hVmAAIhrzqVo/eEw3gMN/lZLLqyGfz9hSlxSRpMMDztS
 U7hJdLPI9slESn0ClbrxYHGxIlW60wBuhDRYLX5BxwWnfQ4ZdfgxSgt6KRjs6YWacSmF5e4Q9
 kdfgKjQ/AqNHqUNj58JkXCmn8eTfoWh4QNhewXqdiMOdwQlYQmECmktJMVIGOEEVdiQ0SDpbN
 nGm1QOzJgJ2UOi1XmOLKIm6zDgb4/miuc26Kl17oA0YVETOEnQZdkHvrdClXETjBARuaaUBaU
 F0VFhvRaNw9N6Jwufb2K3GtgJtS4nLzraF7XkdpP16KUcDZoWibUfnqBqNKDzSzIEdHqqJ0N1
 W3zI4QGRheIqwfexjdy4fYcUV83PlM5rwd1i+Uj49jLNSXRLytE/RGUw+E7edTGlatGJzYik7
 EPnUuInu4MkZnrbDNBBV0s0o+7WSh0lQQx8sANKGnEDRpZrvPhtSuoXrx8GnIinTZoAMMEbtr
 trX8Qbio/u3+6e6ZPHK77CDtZ61RYbN9nKT9r4k+C7DwAkzq29HfMoKIgkKCKw+g4C9ebuTMo
 3Id4B7kzbTeqTH+yKJlYDNZ56brS9zzLSDhmfHxt8GLUCN/xHJMU2tE2zATk/0S1Vjk0deRcH
 bQRFoASNdD06E550qjqpxpz6N6oPAH5CzDBP/OsmAgOgc8arc/pVoKm7hge1Sya6s0bOmjsnM
 0D+dmoibuV3ppdtmIi4gx8n5RHFqtD5g6ouruP3VzqMPhhmqtaPPj+CRO4lw2IBGz0WS7F4He
 AJTRaI3Dqj834Yus3h02oPNs6Bxwq4upHIWY8jw6PmWkJMAz9e05IUm64WVo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/9 =E4=B8=8A=E5=8D=881:43, Nikolay Borisov wrote:
> This function is used only during the final phase of freespace cache
> writeout. This is necessary since using the plain btrfs_join_transaction
> api is deadlock prone. The deadlock looks like:
>
> T1:
> btrfs_commit_Transaction
>  commit_cowonly_roots
>     btrfs_write_dirty_block_groups
>      btrfs_wait_cache_io
>       __btrfs_wait_cache_io
>        btrfs_wait_ordered_range <-- Triggers ordered IO for freespace
>        inode and blocks transaction commit until freespace cache
>        writeout.
>
> T2: <-- after T1 has triggered the writeout
> finish_ordered_fn
>  btrfs_finish_ordered_io
>   btrfs_join_transaction <--- this would block waiting for current
>   transaction to commit, but since trans commit is waiting for this
>   writeout to finish.
>
> The special purpose functions prevents it by simply skipping the "wait
> for writeout" since it's guaranteed the transaction won't proceed until
> we are done.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Indeed the old _nolock() is pretty confusing. So the rename makes a lot
of sense.

Thanks,
Qu

> ---
>  fs/btrfs/inode.c       | 12 ++++++------
>  fs/btrfs/transaction.c |  2 +-
>  fs/btrfs/transaction.h |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 16415815217c..1c6f7c0a2b1d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3053,7 +3053,7 @@ static int btrfs_finish_ordered_io(struct btrfs_or=
dered_extent *ordered_extent)
>  	int compress_type =3D 0;
>  	int ret =3D 0;
>  	u64 logical_len =3D ordered_extent->len;
> -	bool nolock;
> +	bool freespace_inode;
>  	bool truncated =3D false;
>  	bool range_locked =3D false;
>  	bool clear_new_delalloc_bytes =3D false;
> @@ -3064,7 +3064,7 @@ static int btrfs_finish_ordered_io(struct btrfs_or=
dered_extent *ordered_extent)
>  	    !test_bit(BTRFS_ORDERED_DIRECT, &ordered_extent->flags))
>  		clear_new_delalloc_bytes =3D true;
>
> -	nolock =3D btrfs_is_free_space_inode(BTRFS_I(inode));
> +	freespace_inode =3D btrfs_is_free_space_inode(BTRFS_I(inode));
>
>  	if (test_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags)) {
>  		ret =3D -EIO;
> @@ -3095,8 +3095,8 @@ static int btrfs_finish_ordered_io(struct btrfs_or=
dered_extent *ordered_extent)
>  		btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_offset,
>  				       ordered_extent->len);
>  		btrfs_ordered_update_i_size(inode, 0, ordered_extent);
> -		if (nolock)
> -			trans =3D btrfs_join_transaction_nolock(root);
> +		if (freespace_inode)
> +			trans =3D btrfs_join_transaction_spacecache(root);
>  		else
>  			trans =3D btrfs_join_transaction(root);
>  		if (IS_ERR(trans)) {
> @@ -3130,8 +3130,8 @@ static int btrfs_finish_ordered_io(struct btrfs_or=
dered_extent *ordered_extent)
>  			EXTENT_DEFRAG, 0, 0, &cached_state);
>  	}
>
> -	if (nolock)
> -		trans =3D btrfs_join_transaction_nolock(root);
> +	if (freespace_inode)
> +		trans =3D btrfs_join_transaction_spacecache(root);
>  	else
>  		trans =3D btrfs_join_transaction(root);
>  	if (IS_ERR(trans)) {
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 54b8718054ce..6f133906c862 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -729,7 +729,7 @@ struct btrfs_trans_handle *btrfs_join_transaction(st=
ruct btrfs_root *root)
>  				 true);
>  }
>
> -struct btrfs_trans_handle *btrfs_join_transaction_nolock(struct btrfs_r=
oot *root)
> +struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btr=
fs_root *root)
>  {
>  	return start_transaction(root, 0, TRANS_JOIN_NOLOCK,
>  				 BTRFS_RESERVE_NO_FLUSH, true);
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 2ac89fb0d709..49f7196368f5 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -183,7 +183,7 @@ struct btrfs_trans_handle *btrfs_start_transaction_f=
allback_global_rsv(
>  					unsigned int num_items,
>  					int min_factor);
>  struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *ro=
ot);
> -struct btrfs_trans_handle *btrfs_join_transaction_nolock(struct btrfs_r=
oot *root);
> +struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btr=
fs_root *root);
>  struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_=
root *root);
>  struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *=
root);
>  struct btrfs_trans_handle *btrfs_attach_transaction_barrier(
>

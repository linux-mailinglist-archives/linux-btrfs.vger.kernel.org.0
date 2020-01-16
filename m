Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26CE13D470
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 07:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgAPGl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 01:41:56 -0500
Received: from mout.gmx.net ([212.227.17.21]:46789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgAPGl4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 01:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579156908;
        bh=pIhLyvxD4qLZGRuCFxfEJh1js9x27lLGuMaYM6XDvjM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C/1eN/rCg5e/KkUEcF76JDIqUF//49U/F7iEj56rDBVTW/bXePHzPxNFDbC1d8QU1
         kkeQYv4uvmBccK/0FLiODw0+WfDoXTUJ1z2YBqT1nY9QjXxQEKHnpLiaPjyG/cHVIm
         iXHiNJYwxzTYBgOkms7xy9D0d7k41QoA3oqY48Fw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QFB-1itLl230L7-001Tdr; Thu, 16
 Jan 2020 07:41:47 +0100
Subject: Re: [PATCH 1/3] btrfs: qgroups, fix rescan worker running races
To:     jeffm@suse.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20180502211156.9460-1-jeffm@suse.com>
 <20180502211156.9460-2-jeffm@suse.com>
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
Message-ID: <16f05375-38ef-4694-a124-e7e83d83f6ac@gmx.com>
Date:   Thu, 16 Jan 2020 14:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20180502211156.9460-2-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eAytnY4fChF4K69sOHXwRJ58PndA0RxAf"
X-Provags-ID: V03:K1:GY4zpjRD2aPirE7LNmCyrmQhO7Hav/C7kaUuKx7droO/cC/rtHu
 YUcN/2Q2hylsDKiN93D8LrShST4qRD+Sewq3F0WZFl5WwxCmjaxtwdMbv4xP4uZhqkBu6/0
 JyMsXOPBy5taPPsHABUlm72X+5Xk02N7NZFBfJg8xbrk16bKLCpvHiqIVwvXVAf7cWXzd3E
 V0pdUtjXe7L7O1NIQHNQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtG1DPBB62k=:NHDjW6/8nEZCrptjpOI0hQ
 YTtxNv7ssE0UViR1iCjsn31OT6yD1Yu9GjHMTFc2o0UakTHpnUPKOZlheQR2GaxeL+M7uH0j1
 Vclz5lxok7lQihyh1EVf2+K8bfBS73bePbMTQQZoxcC9BH+/2FbkkYfru5IHdBr6VtIMaCtje
 yAfVooyM4TLH8HkkJX4AqMXfmN2F1COo1Zw84S+qcs1M4u7M6hE8EcfVJ8tR/y5aHqwHB6vyZ
 AoJGmIYt795QNHwSSlQGxVM2PKNLSp2MU2bpuyreMvfTimi93KOm8aRAHROIzzWkiPsYKqww1
 iGM1ER4O/QQ4pZcr8s/THmSmlFx133MPQ0E1yQsTT7vAqaNPB9axWXNv/8CCPb4Mv5QfSyLbj
 vJVL2N4iddSHvBwn39aOpVPNmdJ99fI/oej/Ji2p4YttaFDMTqvHbVjwXuCYwN5bKCEb1jpyO
 aXWVl7ZxttHIYex6UbT/VJp5WcsvO39BfvFmqUVgWEq7PBCvF0SJuZ6DBZENMHVNxDeaOm84W
 ky2KA3bRxEeWXt3/HV4wHVknfEfDwEPj+Y09UTRE9x0/DpOU0Y4tDnWegYxpiwzh4O/m/0TQU
 GJDO3mT13jYXu3OSTPTpUj8f/odTR19Z9tNEkuVwCxTXJbVSpeT+yiNu0fbzCncnz6SoXFooc
 Xpg9+l+twM/CCdA6wMPdTk1z7gOsEBBqQ1aP2+kbFbvIVvLKzPtPbVguXf/MBmju5CEt05GrZ
 pwyYSedtKlu7h2a34aXSzYdmtjJ7quG97vLIw2fDXdZgjyjY76FStOabLZB8dPKOUqjl4DjQb
 8QnOZJf6/lhU3ixE8nmkvNqLEiXtxLIeDM1/jLv+Fq1BiSfIJhS3Wk7MpdO8RPGt/evsG+qXu
 pDe3Qq0eL92eC2wz7neSx9OR77lDQEylBab8LyM6GSdlPE5HAU/ads7RmaaMjT+6gcnk4tjpU
 Pid6ngCYJ8SEvy2QWTItz6gnkHqPCvxzsJwBdkIQJH8pbQd9EtZc1QWAS1BBbF/XvR7SVwcLE
 ihdD1qJN2jcc4vON8dDoWVEi7KspJ+dydCNtjmBmlytAr5rXNppsFRsgazDeVOwVrhnb/qmpW
 uEwDhWOmtVndXS+H9UsW/rzeQIi/vh90R1DUzqODTEixSIupakHZTFAnuQ0i66dsrlafFlQ3w
 3jylfvc5ejQlXxy0GFBXYRLOcLRWe5Zn5Gq53IbvKBU8xemIQSwGduJTr2SKD3624a8SImMbO
 d2OBjgWcmo6jXqzRdkoelk7e2yMoKup/+MKsvvO3yqxv0WrKInrs+1L2cKFs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eAytnY4fChF4K69sOHXwRJ58PndA0RxAf
Content-Type: multipart/mixed; boundary="FyVl9aqpfGaxIkHH3WUvWVvukAhxPc2wQ"

--FyVl9aqpfGaxIkHH3WUvWVvukAhxPc2wQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Would you like to share more info about the how the race happened?

Some stackdump or race graph, or even just reproducer would help greatly.=

Especially when I guess the latest qgroup rescan code is no longer
affected, but without firm reproducer/race cause, I can't rule it out
completely.

Thanks,
Qu

On 2018/5/3 =E4=B8=8A=E5=8D=885:11, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
>=20
> Commit 8d9eddad194 (Btrfs: fix qgroup rescan worker initialization)
> fixed the issue with BTRFS_IOC_QUOTA_RESCAN_WAIT being racy, but
> ended up reintroducing the hang-on-unmount bug that the commit it
> intended to fix addressed.
>=20
> The race this time is between qgroup_rescan_init setting
> ->qgroup_rescan_running =3D true and the worker starting.  There are
> many scenarios where we initialize the worker and never start it.  The
> completion btrfs_ioctl_quota_rescan_wait waits for will never come.
> This can happen even without involving error handling, since mounting
> the file system read-only returns between initializing the worker and
> queueing it.
>=20
> The right place to do it is when we're queuing the worker.  The flag
> really just means that btrfs_ioctl_quota_rescan_wait should wait for
> a completion.
>=20
> Since the BTRFS_QGROUP_STATUS_FLAG_RESCAN flag is overloaded to
> refer to both runtime behavior and on-disk state, we introduce a new
> fs_info->qgroup_rescan_ready to indicate that we're initialized and
> waiting to start.
>=20
> This patch introduces a new helper, queue_rescan_worker, that handles
> most of the initialization, the two flags, and queuing the worker,
> including races with unmount.
>=20
> While we're at it, ->qgroup_rescan_running is protected only by the
> ->qgroup_rescan_mutex.  btrfs_ioctl_quota_rescan_wait doesn't need
> to take the spinlock too.
>=20
> Fixes: 8d9eddad194 (Btrfs: fix qgroup rescan worker initialization)
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  fs/btrfs/ctree.h  |  2 ++
>  fs/btrfs/qgroup.c | 94 +++++++++++++++++++++++++++++++++--------------=
--------
>  2 files changed, 58 insertions(+), 38 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index da308774b8a4..4003498bb714 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1045,6 +1045,8 @@ struct btrfs_fs_info {
>  	struct btrfs_workqueue *qgroup_rescan_workers;
>  	struct completion qgroup_rescan_completion;
>  	struct btrfs_work qgroup_rescan_work;
> +	/* qgroup rescan worker is running or queued to run */
> +	bool qgroup_rescan_ready;
>  	bool qgroup_rescan_running;	/* protected by qgroup_rescan_lock */
> =20
>  	/* filesystem state */
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index aa259d6986e1..466744741873 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -101,6 +101,7 @@ static int
>  qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objecti=
d,
>  		   int init_flags);
>  static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info)=
;
> +static void btrfs_qgroup_rescan_worker(struct btrfs_work *work);
> =20
>  /* must be called with qgroup_ioctl_lock held */
>  static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_in=
fo,
> @@ -2072,6 +2073,46 @@ int btrfs_qgroup_account_extents(struct btrfs_tr=
ans_handle *trans,
>  	return ret;
>  }
> =20
> +static void queue_rescan_worker(struct btrfs_fs_info *fs_info)
> +{
> +	mutex_lock(&fs_info->qgroup_rescan_lock);
> +	if (btrfs_fs_closing(fs_info)) {
> +		mutex_unlock(&fs_info->qgroup_rescan_lock);
> +		return;
> +	}
> +
> +	if (WARN_ON(!fs_info->qgroup_rescan_ready)) {
> +		btrfs_warn(fs_info, "rescan worker not ready");
> +		mutex_unlock(&fs_info->qgroup_rescan_lock);
> +		return;
> +	}
> +	fs_info->qgroup_rescan_ready =3D false;
> +
> +	if (WARN_ON(fs_info->qgroup_rescan_running)) {
> +		btrfs_warn(fs_info, "rescan worker already queued");
> +		mutex_unlock(&fs_info->qgroup_rescan_lock);
> +		return;
> +	}
> +
> +	/*
> +	 * Being queued is enough for btrfs_qgroup_wait_for_completion
> +	 * to need to wait.
> +	 */
> +	fs_info->qgroup_rescan_running =3D true;
> +	init_completion(&fs_info->qgroup_rescan_completion);
> +	mutex_unlock(&fs_info->qgroup_rescan_lock);
> +
> +	memset(&fs_info->qgroup_rescan_work, 0,
> +	       sizeof(fs_info->qgroup_rescan_work));
> +
> +	btrfs_init_work(&fs_info->qgroup_rescan_work,
> +			btrfs_qgroup_rescan_helper,
> +			btrfs_qgroup_rescan_worker, NULL, NULL);
> +
> +	btrfs_queue_work(fs_info->qgroup_rescan_workers,
> +			 &fs_info->qgroup_rescan_work);
> +}
> +
>  /*
>   * called from commit_transaction. Writes all changed qgroups to disk.=

>   */
> @@ -2123,8 +2164,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *=
trans,
>  		ret =3D qgroup_rescan_init(fs_info, 0, 1);
>  		if (!ret) {
>  			qgroup_rescan_zero_tracking(fs_info);
> -			btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -					 &fs_info->qgroup_rescan_work);
> +			queue_rescan_worker(fs_info);
>  		}
>  		ret =3D 0;
>  	}
> @@ -2607,6 +2647,10 @@ static void btrfs_qgroup_rescan_worker(struct bt=
rfs_work *work)
>  	if (!path)
>  		goto out;
> =20
> +	mutex_lock(&fs_info->qgroup_rescan_lock);
> +	fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +	mutex_unlock(&fs_info->qgroup_rescan_lock);
> +
>  	err =3D 0;
>  	while (!err && !btrfs_fs_closing(fs_info)) {
>  		trans =3D btrfs_start_transaction(fs_info->fs_root, 0);
> @@ -2685,47 +2729,27 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_inf=
o, u64 progress_objectid,
>  {
>  	int ret =3D 0;
> =20
> -	if (!init_flags &&
> -	    (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) ||
> -	     !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))) {
> +	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
>  		ret =3D -EINVAL;
>  		goto err;
>  	}
> =20
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	spin_lock(&fs_info->qgroup_lock);
> -
> -	if (init_flags) {
> -		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
> -			ret =3D -EINPROGRESS;
> -		else if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
> -			ret =3D -EINVAL;
> -
> -		if (ret) {
> -			spin_unlock(&fs_info->qgroup_lock);
> -			mutex_unlock(&fs_info->qgroup_rescan_lock);
> -			goto err;
> -		}
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +	if (fs_info->qgroup_rescan_ready || fs_info->qgroup_rescan_running) {=

> +		mutex_unlock(&fs_info->qgroup_rescan_lock);
> +		ret =3D -EINPROGRESS;
> +		goto err;
>  	}
> =20
>  	memset(&fs_info->qgroup_rescan_progress, 0,
>  		sizeof(fs_info->qgroup_rescan_progress));
>  	fs_info->qgroup_rescan_progress.objectid =3D progress_objectid;
> -	init_completion(&fs_info->qgroup_rescan_completion);
> -	fs_info->qgroup_rescan_running =3D true;
> +	fs_info->qgroup_rescan_ready =3D true;
> =20
> -	spin_unlock(&fs_info->qgroup_lock);
>  	mutex_unlock(&fs_info->qgroup_rescan_lock);
> =20
> -	memset(&fs_info->qgroup_rescan_work, 0,
> -	       sizeof(fs_info->qgroup_rescan_work));
> -	btrfs_init_work(&fs_info->qgroup_rescan_work,
> -			btrfs_qgroup_rescan_helper,
> -			btrfs_qgroup_rescan_worker, NULL, NULL);
> -
> -	if (ret) {
>  err:
> +	if (ret) {
>  		btrfs_info(fs_info, "qgroup_rescan_init failed with %d", ret);
>  		return ret;
>  	}
> @@ -2785,9 +2809,7 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info=
)
> =20
>  	qgroup_rescan_zero_tracking(fs_info);
> =20
> -	btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -			 &fs_info->qgroup_rescan_work);
> -
> +	queue_rescan_worker(fs_info);
>  	return 0;
>  }
> =20
> @@ -2798,9 +2820,7 @@ int btrfs_qgroup_wait_for_completion(struct btrfs=
_fs_info *fs_info,
>  	int ret =3D 0;
> =20
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	spin_lock(&fs_info->qgroup_lock);
>  	running =3D fs_info->qgroup_rescan_running;
> -	spin_unlock(&fs_info->qgroup_lock);
>  	mutex_unlock(&fs_info->qgroup_rescan_lock);
> =20
>  	if (!running)
> @@ -2819,12 +2839,10 @@ int btrfs_qgroup_wait_for_completion(struct btr=
fs_fs_info *fs_info,
>   * this is only called from open_ctree where we're still single thread=
ed, thus
>   * locking is omitted here.
>   */
> -void
> -btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
> +void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
>  {
>  	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
> -		btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -				 &fs_info->qgroup_rescan_work);
> +		queue_rescan_worker(fs_info);
>  }
> =20
>  /*
>=20


--FyVl9aqpfGaxIkHH3WUvWVvukAhxPc2wQ--

--eAytnY4fChF4K69sOHXwRJ58PndA0RxAf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4gBaEACgkQwj2R86El
/qibrggAhbA76++sxXICfTZqRwMjS1VvO8dpo/EIwRGgYFQKoQqoC2BEZ+gNreJ9
IfCh/xzRgaVmZZA9WCmb5gPg1yRQi8hIcDRXvwk0x/xoxCyDzP0pf/JMHKV33W4O
hlmRa5H6yfKoOv3DKLfrhTjR4RZFrfR9hZof86EnoJWEl5mync9fM13ql1rUxZqV
OW12zDq1JSVhNMY7UJvhLGFOneuBE9RViVikqnMb+4WmZGV/GoAJ0PO8B1AEp9jx
7A0F1hCRTZIW449ly41LZthZSoZ0zXOCqce59+9UiIaK+JR3HXgcCNFHivk/TybW
fbzHLFsSIsG+mM7UXlo8Q6wE6n5EXg==
=FtQi
-----END PGP SIGNATURE-----

--eAytnY4fChF4K69sOHXwRJ58PndA0RxAf--

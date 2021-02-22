Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749173222B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 00:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhBVXo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 18:44:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:42145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhBVXoZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 18:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614037371;
        bh=lzhtwRgClIpLKvwfqkkplg4dvuirrcvz6eXlbJ+TdqU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ec4ar/iav7QPp/kasj5jpn1FbGA1Q+NVLfR5YaCq7n9OLzo/djnETeRHf27eqHo4p
         OVeec6qHGHjywluAH4vq4P0eQBdix1IKyH+IhvDoNGRARWtKMfE3pu6Ly423YJq/Ii
         fT/VjTfKClJKI1yEFgeOWtvnBxndoSnC8K5yoZLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1lsKL40Z9t-014Tsg; Tue, 23
 Feb 2021 00:42:51 +0100
Subject: Re: [PATCH 2/6] btrfs: Export qgroup_reserve_meta
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-3-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c5936976-95af-b937-dbb8-6545bca70792@gmx.com>
Date:   Tue, 23 Feb 2021 07:42:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222164047.978768-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3SVZett+tLu3/WPM7wD8HY8kC4Qg0wqDt5v+8RyqPQNNE/kJ4MD
 qoWAx/WtO0hYxNytptjaMDUDUNbVbZW7zW5JI9tAoWftV5IXpJFMBneDR5bJ7eiQdxQeuGg
 uytJwAZnSsbW8G9UC/PjOY/KHLTi2FXuvmLNIFor2leH7258fFPFKpeTkru/TCM7iE+J7mu
 fecIiXUGVef+PoZax5mLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2BAN9PFZ5ig=:HftT45t0mjq0r9Xh+pj+ys
 8SvWwuf2I9AlJnVTtAdT5lpRIpzRmL3IfuWZ+ScU+vMojaH1RxxyqxkO8wMX61fo6UFIvXMUU
 u1Wj4/nIpiNymrufVXv0nOOpic+2SoPclUo2FCNxsk4O4XRxjzvy9VxgbP/LMkcLKwbYleNHe
 Utx6lFJrpw1V9sTbMleI83OhxSPvQI4JMc9bnFRZ+XyRje0DBik7quLj7LyivkUFhTQ/qKMKN
 siR45dBcp7jwiqfhYsTygyO+174oTd+8OwuB/juUi83Gf2ykxZRpXH4sEmPA2G+rjJzhPa0Uu
 MK8hhqQWWqL1S7FTHHZNuA50ReZxl/xm+W7uEjJSVcAnekDTZLdflmMSxYMua/kU+mS85sABX
 OBqCWio+gbeWgHCFSmHBbJpABcUGa2jsNNf/2B+PvSGL3K6+FP7qSM2dpd0DsrgUnoAugjaNY
 mOVB1S6FEcEgzGHKlBvKI4hXUCA4953pSbWGWDgLc4xuBiF3Zcnyoi6KS6rTBAcI19Q9hLz16
 lY9b8ZjBUT7ZXeFxRE+1ZWas9YWEiukTTnalL9bb4OBSnCr9W3ETf46uzVxzhORKMaazXcyE8
 knCfWqVUm5Q/nGByqQiIu+eV5LaLgrcC3paafTQPQuTx1CCfxecyRcymilZA7VTv94iXj12UO
 eQKtvMmb0Uaq5WGg4YLs++k2OmdEmeRXHNMRde4qM3LXpGpZZbQ5ukprXK9GxwjFxv7xfBi4l
 zgWIJ9msI87jfNWqWbWTauzdoqpGH1Lw4pqzGryFdjaq8Vbgj39yRIOcXJjz5DJW7cY1k1Ny+
 jGNy4IWjyQULBQnuVM33jW4ayFSExfqK+vXq3meT/DmCs7TcGLzDnHd9Q4+FqISqVzt/aGV9l
 eD8j70HzyrpiBJKZrEaA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8A=E5=8D=8812:40, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Considering how small the export is, I prefer this to be merged with
next patch, as it's much easier to understand why we want to export the
function.

And since it will be exported, may be it's a good idea to rename it as
btrfs_qgroup_reserve_meta_atomic() or btrfs_qgroup_reserve_meta_noflush()?

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 4 ++--
>   fs/btrfs/qgroup.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 808370ada888..fbef95bc3557 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3841,8 +3841,8 @@ static int sub_root_meta_rsv(struct btrfs_root *ro=
ot, int num_bytes,
>   	return num_bytes;
>   }
>
> -static int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
> -				enum btrfs_qgroup_rsv_type type, bool enforce)
> +int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
> +			enum btrfs_qgroup_rsv_type type, bool enforce)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	int ret;
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 50dea9a2d8fb..c1a3cc15dede 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -354,6 +354,9 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info =
*fs_info, u64 qgroupid,
>   			       u64 rfer, u64 excl);
>   #endif
>
> +int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
> +			enum btrfs_qgroup_rsv_type type, bool enforce);
> +
>   /* New io_tree based accurate qgroup reserve API */
>   int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
>   			struct extent_changeset **reserved, u64 start, u64 len);
>

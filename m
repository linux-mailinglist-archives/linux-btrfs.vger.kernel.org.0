Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDF211735
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 02:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGBAah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 20:30:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:60417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgGBAag (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 20:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593649829;
        bh=rbErrsRyWebtdlswTpejRF4fm1MyEGOikFCKGxkHzDo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RtmuhauXxgOBrqqLWrgzrJPGb8YYMVHGUX073MXZfZGBoD/t3lfwdsYZXILmcVFGE
         dn1LfRS0pIntWMPjKcTyjXYS54lGPdZncER2eYQKy4OxHN38QuI5Y8KeT16YEYqDzu
         r2VIo7ZvOd6Ohvt0+F9TMJxTYUVFJA4kQXtjmkqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUowV-1jQ9a91rIv-00QiSa; Thu, 02
 Jul 2020 02:30:29 +0200
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
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
Message-ID: <030acdb7-793f-0c97-b13d-22b05e7ee101@gmx.com>
Date:   Thu, 2 Jul 2020 08:30:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701144438.7613-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="15hp56d4mkCZrJu1BP7Nl69gNTIB4N8KM"
X-Provags-ID: V03:K1:KwMs9gwj0l4DSqzCl191Ih6eJb0LfPbPF41yVj6mClSrGi3MKWr
 Zjyjdju815DtPA599Lw+Q6qWWt2jp40rHUJSMSgYN0RkXylM5Uvyyya3xXkms0+0yD9RoW8
 uwPrlciSZI/TsekF3UX5BUSDxmSeWxY0+dZZVaMbf9QFPAShk/ukYADlAZxMaEzTZ3d7f3q
 26IINTxksbLSI7D5aqUIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MRVkhVK2EA8=:q5wJwEMoNe50KoPUDbpecE
 eHf/VnTpnwZcJ+WTo8gftd529LsE5ZeiNmYkfO271JojaIwduuzHObqaKdJfVTXsjKBzzFRR/
 eQXNohYY4W8VAlZBs5xPKYU53oroj0oMK2j4wCJSxfKzDprGVJc+ByqdzU3h/ffjzsWOunC+3
 m/ffwrSq+87A1zvvyGmwv3EMgiOiu6rIoosHy449/Seu0Gy/ZHB5GSshqRJQggJV/gi92mlEy
 pcrojvb0RuFfBkAkumin1zxuAlBOQtGKqxMjI8GprMzW0XOefa1Q34hd/4hiunnyvYpuSI0tJ
 sT4KDVN2XHOh3CpFZFoG8fEG8KLv+ejVrO0XpfkksjHTDDyBZaQEOKIzFejZNXFmJ4JKhyX2d
 Ewvj1QNqY07rs7SEJqn6mm84/00kzZaz8iVOkXWhaIyfM79MR53PR/7DWqW+r+5SajMPuR58t
 ogvA9TOzNmZyz1mcJAZb0y1hi6pd2lcEozVYehdPZ+xU8jTOFBWqKwEdcGrU9eLjCnk1ODf8+
 O59KUgYkciQrZjJcBcUlY2mnwDbpGG2YLNBEUKcKKyvhUPP4fFWYc1+qOuRT0Hp730SBxt6wS
 I5VzpQTz7Tk5ibKCUeVxGheHLaSG3pzOHU1CKJ5nKnUELLd+V4ZeAh4tCGOfViqSbKJmbENcO
 1GuBxPcUkt/G0YKIPu4RCRIw+UXv05gM9wlnt1EJgP6PICQRdjyYGdzQHa+ATCIujL2P0zm8x
 EpVFkbyJUIzVnZpvvCtkPqI+OrkR67ZZ/onoDwmN4CHrBmQcn4Jjua0Pu55QO+tJ5tFwRtcNZ
 ZN2HBwkYEphrOdLHyIXTcO2N0c1YoofVtrz6FNOlE1RvRR4PwW9mPdmBkpLC1uA88k4dHsb+f
 tcWK/adODuWZIBAcn/5Awq/VVFepRs5lbWHqcaTjJxIYZRgAAKGsa90PJJdVEZ88FKzZh+all
 ULwQLCv5MtMPrM2AyyNL7d/RStOvSlPqbj13jUwEruHu1N5VYOZ2AvNDbw4HvCNKonwKosebV
 uwA7+v5NigvDbig7ozbh9PgIgs5thNgElTLrpWsO30zsGkW0Dr+Nfhf/aY/zWvcazxjkkqnMf
 dnuJ0s10GU0QCUhYy/nUiWMUTuPEDpA2FeZRsT4xzs8HYTF/gLLbaJjiBMjtB1PN4YGKaRASC
 rRkbb7ALnB23yiFRYdmByYo2D0iWYZtOJXuknPy+sfJjKBxXA74r5MKNcI2e7uHqlaBH655PO
 qm6Io07ME3ZEp8U+gV1il/6udB1MePCfTE8Hz7Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--15hp56d4mkCZrJu1BP7Nl69gNTIB4N8KM
Content-Type: multipart/mixed; boundary="Slv0FM6jV1O15Mk8pkmGY1fAxCGazvvw2"

--Slv0FM6jV1O15Mk8pkmGY1fAxCGazvvw2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/1 =E4=B8=8B=E5=8D=8810:44, Josef Bacik wrote:
> One of the things that came up consistently in talking with Fedora abou=
t
> switching to btrfs as default is that btrfs is particularly vulnerable
> to metadata corruption.  If any of the core global roots are corrupted,=

> the fs is unmountable and fsck can't usually do anything for you withou=
t
> some special options.
>=20
> Qu addressed this sort of with rescue=3Dskipbg, but that's poorly named=
 as
> what it really does is just allow you to operate without an extent root=
=2E
> However there are a lot of other roots, and I'd rather not have to do
>=20
> mount -o rescue=3Dskipbg,rescue=3Dnocsum,rescue=3Dnofreespacetree,rescu=
e=3Dblah

Yep, that's the problem.

Extent tree is chosen mostly by the fact that, extent tree seems to be
the first victim for transid error.

I still like the idea to ignore more trees.

>=20
> Instead take his original idea and modify it so it just works for
> everything.  Turn it into rescue=3Donlyfs, and then any major root we f=
ail
> to read just gets left empty and we carry on.

That's indeed an improvement, other trees, especially extent, uuid,
reloc, dev trees are completely useless in completely RO environment.

>=20
> Obviously if the fs roots are screwed then the user is in trouble, but
> otherwise this makes it much easier to pull stuff off the disk without
> needing our special rescue tools.  I tested this with my TEST_DEV that
> had a bunch of data on it by corrupting the csum tree and then reading
> files off the disk.

And since we still try to read csum tree, and if it's not corrupted, it
still get read and we go regular csum verification, so I'm completely
fine with this enhancement.

>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>=20
> I'm not married to the rescue=3Donlyfs name, if we can think of somethi=
ng better
> I'm good.

Naming is never easy to do.

What about 'skipall'?

Despite that, I'm pretty happy with the enhancement, with only one
concern below.


=2E..
> @@ -2275,21 +2274,27 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  	location.objectid =3D BTRFS_DEV_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->dev_root =3D root;
> +		btrfs_init_devices_late(fs_info);
>  	}
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->dev_root =3D root;
> -	btrfs_init_devices_late(fs_info);
> =20
>  	location.objectid =3D BTRFS_CSUM_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}

One of my concern here, I didn't see btrfs_lookup_csums_range() have the
ability to skip NULL csum root.

Wouldn't this cause NULL pointer dereference if the csum root is corrupte=
d?

Thanks,
Qu

> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->csum_root =3D root;
>  	}
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->csum_root =3D root;
> =20
>  	/*
>  	 * This tree can share blocks with some other fs tree during relocati=
on
> @@ -2298,11 +2303,14 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  	root =3D btrfs_get_fs_root(tree_root->fs_info,
>  				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
> +			ret =3D PTR_ERR(root);
> +			goto out;
> +		}
> +	} else {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->data_reloc_root =3D root;
>  	}
> -	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -	fs_info->data_reloc_root =3D root;
> =20
>  	location.objectid =3D BTRFS_QUOTA_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
> @@ -2315,9 +2323,11 @@ static int btrfs_read_roots(struct btrfs_fs_info=
 *fs_info)
>  	location.objectid =3D BTRFS_UUID_TREE_OBJECTID;
>  	root =3D btrfs_read_tree_root(tree_root, &location);
>  	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		if (ret !=3D -ENOENT)
> -			goto out;
> +		if (!btrfs_test_opt(fs_info, ONLYFS)) {
> +			ret =3D PTR_ERR(root);
> +			if (ret !=3D -ENOENT)
> +				goto out;
> +		}
>  	} else {
>  		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>  		fs_info->uuid_root =3D root;
> @@ -2327,11 +2337,14 @@ static int btrfs_read_roots(struct btrfs_fs_inf=
o *fs_info)
>  		location.objectid =3D BTRFS_FREE_SPACE_TREE_OBJECTID;
>  		root =3D btrfs_read_tree_root(tree_root, &location);
>  		if (IS_ERR(root)) {
> -			ret =3D PTR_ERR(root);
> -			goto out;
> +			if (!btrfs_test_opt(fs_info, ONLYFS)) {
> +				ret =3D PTR_ERR(root);
> +				goto out;
> +			}
> +		}  else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->free_space_root =3D root;
>  		}
> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->free_space_root =3D root;
>  	}
> =20
>  	return 0;
> @@ -3047,20 +3060,11 @@ int __cold open_ctree(struct super_block *sb, s=
truct btrfs_fs_devices *fs_device
>  	}
> =20
>  	/* Skip bg needs RO and no tree-log to replay */
> -	if (btrfs_test_opt(fs_info, SKIPBG)) {
> -		if (!sb_rdonly(sb)) {
> -			btrfs_err(fs_info,
> -			"rescue=3Dskipbg can only be used on read-only mount");
> -			err =3D -EINVAL;
> -			goto fail_alloc;
> -		}
> -		if (btrfs_super_log_root(disk_super) &&
> -		    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
> -			btrfs_err(fs_info,
> -"rescue=3Dskipbg must be used with rescue=3Dnologreplay when tree-log =
needs to replayed");
> -			err =3D -EINVAL;
> -			goto fail_alloc;
> -		}
> +	if (btrfs_test_opt(fs_info, ONLYFS) && !sb_rdonly(sb)) {
> +		btrfs_err(fs_info,
> +			  "rescue=3Donlyfs can only be used on read-only mount");
> +		err =3D -EINVAL;
> +		goto fail_alloc;
>  	}
> =20
>  	ret =3D btrfs_init_workqueues(fs_info, fs_devices);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d301550b9c70..9f8ef22ac65e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2209,7 +2209,8 @@ static blk_status_t btrfs_submit_bio_hook(struct =
inode *inode, struct bio *bio,
>  	int skip_sum;
>  	int async =3D !atomic_read(&BTRFS_I(inode)->sync_writers);
> =20
> -	skip_sum =3D BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
> +	skip_sum =3D (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> +		btrfs_test_opt(fs_info, ONLYFS);
> =20
>  	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
>  		metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> @@ -2866,6 +2867,9 @@ static int btrfs_readpage_end_io_hook(struct btrf=
s_io_bio *io_bio,
>  	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
> =20
> +	if (btrfs_test_opt(root->fs_info, ONLYFS))
> +		return 0;
> +
>  	if (root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID &&
>  	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {=

>  		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3c9ebd4f2b61..7ea9f8f53156 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -345,7 +345,7 @@ enum {
>  	Opt_rescue,
>  	Opt_usebackuproot,
>  	Opt_nologreplay,
> -	Opt_rescue_skipbg,
> +	Opt_rescue_onlyfs,
> =20
>  	/* Deprecated options */
>  	Opt_alloc_start,
> @@ -445,7 +445,7 @@ static const match_table_t tokens =3D {
>  static const match_table_t rescue_tokens =3D {
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_nologreplay, "nologreplay"},
> -	{Opt_rescue_skipbg, "skipbg"},
> +	{Opt_rescue_onlyfs, "onlyfs"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -478,9 +478,10 @@ static int parse_rescue_options(struct btrfs_fs_in=
fo *info, const char *options)
>  			btrfs_set_and_info(info, NOLOGREPLAY,
>  					   "disabling log replay at mount time");
>  			break;
> -		case Opt_rescue_skipbg:
> -			btrfs_set_and_info(info, SKIPBG,
> -				"skip mount time block group searching");
> +		case Opt_rescue_onlyfs:
> +			btrfs_set_and_info(info, ONLYFS,
> +					   "only reading fs roots, also setting  nologreplay");
> +			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
>  			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized rescue option '%s'", p);
> @@ -1418,8 +1419,8 @@ static int btrfs_show_options(struct seq_file *se=
q, struct dentry *dentry)
>  		seq_puts(seq, ",notreelog");
>  	if (btrfs_test_opt(info, NOLOGREPLAY))
>  		seq_puts(seq, ",rescue=3Dnologreplay");
> -	if (btrfs_test_opt(info, SKIPBG))
> -		seq_puts(seq, ",rescue=3Dskipbg");
> +	if (btrfs_test_opt(info, ONLYFS))
> +		seq_puts(seq, ",rescue=3Donlyfs");
>  	if (btrfs_test_opt(info, FLUSHONCOMMIT))
>  		seq_puts(seq, ",flushoncommit");
>  	if (btrfs_test_opt(info, DISCARD_SYNC))
> @@ -1859,10 +1860,10 @@ static int btrfs_remount(struct super_block *sb=
, int *flags, char *data)
>  	if (ret)
>  		goto restore;
> =20
> -	if (btrfs_test_opt(fs_info, SKIPBG) !=3D
> -	    (old_opts & BTRFS_MOUNT_SKIPBG)) {
> +	if (btrfs_test_opt(fs_info, ONLYFS) !=3D
> +	    (old_opts & BTRFS_MOUNT_ONLYFS)) {
>  		btrfs_err(fs_info,
> -		"rescue=3Dskipbg mount option can't be changed during remount");
> +		"rescue=3Donlyfs mount option can't be changed during remount");
>  		ret =3D -EINVAL;
>  		goto restore;
>  	}
> @@ -1932,9 +1933,9 @@ static int btrfs_remount(struct super_block *sb, =
int *flags, char *data)
>  			goto restore;
>  		}
> =20
> -		if (btrfs_test_opt(fs_info, SKIPBG)) {
> +		if (btrfs_test_opt(fs_info, ONLYFS)) {
>  			btrfs_err(fs_info,
> -		"remounting read-write with rescue=3Dskipbg is not allowed");
> +		"remounting read-write with rescue=3Donlyfs is not allowed");
>  			ret =3D -EINVAL;
>  			goto restore;
>  		}
> @@ -2245,7 +2246,7 @@ static int btrfs_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>  	 *
>  	 * Or if we're rescuing, set available to 0 anyway.
>  	 */
> -	if (btrfs_test_opt(fs_info, SKIPBG) ||
> +	if (btrfs_test_opt(fs_info, ONLYFS) ||
>  	    (!mixed && block_rsv->space_info->full &&
>  	     total_free_meta - thresh < block_rsv->size))
>  		buf->f_bavail =3D 0;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index aabc6c922e04..a5d124f95ce2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7595,10 +7595,10 @@ int btrfs_verify_dev_extents(struct btrfs_fs_in=
fo *fs_info)
>  	int ret =3D 0;
> =20
>  	/*
> -	 * For rescue=3Dskipbg mount option, we're already RO and are salvagi=
ng
> +	 * For rescue=3Donlyfs mount option, we're already RO and are salvagi=
ng
>  	 * data, no need for such strict check.
>  	 */
> -	if (btrfs_test_opt(fs_info, SKIPBG))
> +	if (btrfs_test_opt(fs_info, ONLYFS))
>  		return 0;
> =20
>  	key.objectid =3D 1;
>=20


--Slv0FM6jV1O15Mk8pkmGY1fAxCGazvvw2--

--15hp56d4mkCZrJu1BP7Nl69gNTIB4N8KM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79KqEACgkQwj2R86El
/qhL6Qf/STWf3dpW+LYly6LwsBdSbFY5ih3jeJyCHqGHfNZmkhXGl9rrBEbBr1E5
fPY+kzVy3jGEnkLtD+F17aK8qSNrb7TdjOWaBs4EmOxwRUpPXZ6Idi7zET9dFrug
vT+4wD5d91gWLyp01Nl97P0tmvTnn7ewLeqYfBTExrDEsIKQj/NIyJQo9xBfdZO1
oMGtUpn17lpVcW9b9NRyzBjc7hKf/CbulJ4uKLuLCPaCgZTkjmQhUHi/xDv1WHlL
owPlo8FX19oWvRjI8TvzJ+bQkgrazNupI1+Uz/KsJamyZxN8v9DaIyhDil+Jymsn
wccYr3yWXYBBDD/vdvc9e9ss4sODoA==
=BpAr
-----END PGP SIGNATURE-----

--15hp56d4mkCZrJu1BP7Nl69gNTIB4N8KM--

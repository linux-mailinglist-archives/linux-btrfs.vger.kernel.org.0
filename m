Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5954913A127
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgANGzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:55:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:58999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgANGzD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578984897;
        bh=gE+ebf0eIS1lD7whIBpVXE6k+4IBWMzZa2UpAKJcXJ0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F06UD34DN/8wdbHqxms8VLwcLem21ELYjviSsFjyd8ClhC7R665F0Rq3CEHRxLcb9
         i4xsyCZWeqFlOHQdhMDON6D5vhwfwP88OTY/koY4ddQ4egRC8S306ZS21cJhbvTWfd
         sUvyc/MSR1GwsuvAUZoJOzqVAGNqqwsIDZDixIOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGyxX-1ivuwl3edv-00E7Hn; Tue, 14
 Jan 2020 07:54:57 +0100
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
References: <20200114060920.4527-1-anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
Date:   Tue, 14 Jan 2020 14:54:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114060920.4527-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CRBLcIxLDNkyzUYRpdcrKjBUwrad6KzkY"
X-Provags-ID: V03:K1:f2zefya/ok94Ox54G+xIHxsQqfZ2/BXbC8+TdGVKo4GbSXSKxc3
 MLVDF8Si/txstb3IFlQ/nbkGYbGae+MjwGamQZBMrEQ4ZZNLvAhEhqGVFeomu9QwC3fffO9
 imGR+Tp+bZhVl2V1mA1N9CNEHI6iSwvmcbkjkbduPoPcXkfjpzM8o3pKARsG4AvjERxNAza
 BNg73fgXcgspKHjeSJUdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0/cQKlIW/8=:bGbm6MhPEdGI86HnxFKtZL
 Fyh8GaEcKwaJL9TMOxeppT3jr2C9Dxx5FXp9FP09AMbZ/gOocDRYyYG5lhy93xnC149IjIHcB
 64srDdautKTI+LkQ9hXlN91AlvoeAZutIRWCfK+B9sKxhlxhJm3xRviPFSRE24D3l9uBwrb+Q
 0oZrYHnknJPo31t3R7YWkkKitA2Ro+dlmrXq9q42tBf1Wo8GA3NTLEF51FiSoPLp+u/ykGq6x
 /F2MvXXMgfn0sbBewOtDbXWS4OKucP/xGxrjes1pt9nJeOy8ePft2fd9GxPZo9E0AedH6hZEW
 LyoX2VKqNQq0rCmM+n3zFEK0eCZuQ8WfJuX0EfgGlPusbpgCe+I0Skdf6JcDU8izhQDvTP2W1
 krk2CuV0OCnQ2xtNQ49X26OYJZPcuAgr4ibMg9rp93W07jjuNySGyOHXCT1PMaTv+tKw60kxg
 Rgrfaa0o2uBUD78pOE00XBgTZ+4jmY+WOP70fKdl5LH+faSiH8O0ultp4/PYP+T81uPYMHlTm
 W6+oKwHyU6h8hq/49Czpz0SQjrIDQ2dBSqoyxrC1dqr4GpmJQKBiZFmjdapaGjdeJtzwbNpOV
 Yw5/52UUum2ExxefMUUfpTyQgRfqucNO4w3SzzRVDVdFJdz//zx4KVf4+sy/VqSeSVbjMhAw6
 yqYz80unNKfWuIZ+Yi9+hurCmEUPdb0kBwLcMOk6j84vHdRTbY/Pxn/4Xz5HbkFn8FwSBvUWP
 lGw6TwIU5cN8p78iKqw/VvQo+AcRqMO3cPSS6iB1QuyhINTNqyR5UDihU96WXKTurEixMn48y
 2/X0pfNBFle069OTosoW7jyyUc8Ex4p508FHzCUmr6J1Pbc+XrfDKPqCLhsfY6Gd/FCf3PUXb
 u2IF3GzEf5TqEVELQyr/4GisEsr8COMaixrbRQHmiAwKKL04zEdVuapcdTO6KM4I9dVlT+oYL
 zhuT/T0ggDMYqRq32K3yuNtC2kmpWKR8xY6wpHFUuy9iHBMG+HObu92cfM46/k9lZFvsNbLYh
 r25xPlBdFidyNXvrkn6d7GWAhV2uDXPrsQiC4MwUjpfq6Dxgenmvpf5mVpnUUzkeb5tfyuzp9
 AD8mcmc06LDkqb/Nty/e+sOC32A3py7rc4GZHxLTB6wqiaRTCoNMmFMVPq66zKtcwxioG8WdE
 ix2iW5i2n14S5ZjfgJAMGru3ijV2Udi2m0Tiseb1QTzZfYm6tQVqW2RLQ4qhdD+MibLZTxkLN
 RFrdEBpjjYR4AfUzH7ehoJju+dDhcUIAsicMhcn9OEZfOb6sUc3eW/n+YRCY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CRBLcIxLDNkyzUYRpdcrKjBUwrad6KzkY
Content-Type: multipart/mixed; boundary="s6x12rsZWDjYvJYpCU8OT1A3iGhfWo5ii"

--s6x12rsZWDjYvJYpCU8OT1A3iGhfWo5ii
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/14 =E4=B8=8B=E5=8D=882:09, Anand Jain wrote:
> The first argument to btrfs_printk() wrappers such as
> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in some=

> context like scan and assembling of the volumes there isn't fs_info yet=
,
> so those code generally don't use the btrfs_printk() wrappers and it
> could could still use NULL but then it would become hard to distinguish=

> whether fs_info is NULL for genuine reason or a bug.
>=20
> So introduce a define NO_FS_INFO to be used instead of NULL so that we
> know the code where fs_info isn't initialized and also we have a
> consistent logging functions. Thanks.

I'm not sure why this is needed.

Could you give me an example in which NULL is not clear enough?

Thanks,
Qu

>=20
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/ctree.h |  5 +++++
>  fs/btrfs/super.c | 14 +++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 569931dd0ce5..625c7eee3d0f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -110,6 +110,11 @@ struct btrfs_ref;
>  #define BTRFS_STAT_CURR		0
>  #define BTRFS_STAT_PREV		1
> =20
> +/*
> + * Used when we know that fs_info is not yet initialized.
> + */
> +#define	NO_FS_INFO	((void *)0x1)
> +
>  /*
>   * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
>   */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a906315efd19..5bd8a889fed0 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -216,9 +216,17 @@ void __cold btrfs_printk(const struct btrfs_fs_inf=
o *fs_info, const char *fmt, .
>  	vaf.fmt =3D fmt;
>  	vaf.va =3D &args;
> =20
> -	if (__ratelimit(ratelimit))
> -		printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
> -			fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
> +	if (__ratelimit(ratelimit)) {
> +		if (fs_info =3D=3D NULL)
> +			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
> +				"<unknown>", &vaf);
> +		else if (fs_info =3D=3D NO_FS_INFO)
> +			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
> +				"...", &vaf);
> +		else
> +			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
> +				fs_info->sb->s_id, &vaf);
> +	}
> =20
>  	va_end(args);
>  }
>=20


--s6x12rsZWDjYvJYpCU8OT1A3iGhfWo5ii--

--CRBLcIxLDNkyzUYRpdcrKjBUwrad6KzkY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4dZb0XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjMZgf/Veh3kUCRVNNJwmlQIIx5Jj4A
LVgFSY3KCCy93aAdFxfMkvhIeJYqwTYuWm5tQvdH/k8/XS6ZWTdocMwtB8XHhlkC
04xQ4Qq/O7GEufakjQdEGxK2oUMsL65XExwHQ0vZOihWnD+843WKGPQLjsbf3ckm
SzEJDcdvGZkBQCEBWtZLNit3HE11C+DRplLMOfC57ioWdtC4rUsnERh9ciXfIynY
e4DmQzjPm1YyK3+7x+meTLBqaeT3DzWUP/h2DIsfwKMIFgfUCCnKI3IdH9ScARyt
nTeVLaUZ2ikKgsAZ7ugRLqCPAvPOLeo/G6UUb7nnbM76/C7CSX8hVFbGEJeeVQ==
=49Gd
-----END PGP SIGNATURE-----

--CRBLcIxLDNkyzUYRpdcrKjBUwrad6KzkY--

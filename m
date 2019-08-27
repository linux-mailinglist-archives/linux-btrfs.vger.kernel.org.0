Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC369E99C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfH0Nhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:37:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfH0Nhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDC13B647;
        Tue, 27 Aug 2019 13:37:49 +0000 (UTC)
Subject: Re: [PATCH] btrfs: tree-checker: Fix wrong check on max devid
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
References: <20190827132206.1483-1-wqu@suse.com>
From:   Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jeffm@suse.com; prefer-encrypt=mutual; keydata=
 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
 IeaeR06KxOwgRQLHseCD903rhw==
Message-ID: <dc3f2017-8d49-d6fc-9198-f2d641ec1096@suse.com>
Date:   Tue, 27 Aug 2019 09:37:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827132206.1483-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AQ0is8WcPgXLVzoZd7aOBN76FXUUwDc4M"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQ0is8WcPgXLVzoZd7aOBN76FXUUwDc4M
Content-Type: multipart/mixed; boundary="xZI7piRYDqsyNDxdlbHQLxuNFQkDrsepO";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Message-ID: <dc3f2017-8d49-d6fc-9198-f2d641ec1096@suse.com>
Subject: Re: [PATCH] btrfs: tree-checker: Fix wrong check on max devid
References: <20190827132206.1483-1-wqu@suse.com>
In-Reply-To: <20190827132206.1483-1-wqu@suse.com>

--xZI7piRYDqsyNDxdlbHQLxuNFQkDrsepO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 9:22 AM, Qu Wenruo wrote:
> Btrfs doesn't reuse devid, thus if we add and delete device in a loop,
> we can increase devid to higher value, triggering tree checker to give =
a
> false alert.
>=20
> But we still don't want to give up the devid check, so here we
> compromise by setting a larger devid upper limit, 1<<32.

Is this really a useful check?  There's no actual definition of what a
devid can be, only what the kernel/tools does right now when it adds new
devices.  There's nothing in the format that requires it to be monotonic
increments, which makes any check on read unreliable.  Once we do read
all the dev items, we can check for corruption on write, though.

-Jeff

> So crazy scripts can't bump devid to that high value easily, while we c=
an
> still detect obviously wrong devid.
>=20
> Reported-by: Anand Jain <anand.jain@oracle.com>
> Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 43e488f5d063..f9d24f01801e 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -686,9 +686,14 @@ static void dev_item_err(const struct extent_buffe=
r *eb, int slot,
>  static int check_dev_item(struct extent_buffer *leaf,
>  			  struct btrfs_key *key, int slot)
>  {
> -	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>  	struct btrfs_dev_item *ditem;
> -	u64 max_devid =3D max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHU=
NK);
> +	/*
> +	 * Btrfs doesn't really reuse devid, thus devid can increase to any
> +	 * value, but we don't believe a devid higher than (1<<32) is really
> +	 * valid. This could at least detect bitflip at the higher
> +	 * 32 bits while still consider high devid valid.
> +	 */
> +	u64 max_devid =3D (1ULL << 32);
> =20
>  	if (key->objectid !=3D BTRFS_DEV_ITEMS_OBJECTID) {
>  		dev_item_err(leaf, slot,
>=20


--=20
Jeff Mahoney
Director, SUSE Labs Data & Performance


--xZI7piRYDqsyNDxdlbHQLxuNFQkDrsepO--

--AQ0is8WcPgXLVzoZd7aOBN76FXUUwDc4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAl1lMiYACgkQHntLYyF5
5bL1VxAAnPZxAmc1gSHm6ElLalhy9/Op718NFICI1/Rfhp0xfrFnY6THT7Twwu8R
4JOElfMCeJ8rSGLL7F0sQKzl//JxLTW8c5tvp1cSC2WF60z6n9CSYouci+6FkyCe
4KaQxT/q4iUOYDxUKbd+sgKcitOIkKH24qaxZV17qW88Q+SasqNxq5/2iETUQsfN
/i2dinyYgwjZEpI0U8fF/8ponuasxVLeNpDqBK3ngt/qQeNSSNTI3a+ZDIbhkksX
dvMQW3UM/zz9bHTVOOm5E/pllgPWzFELspFV+44ncOKtgxwFdvMnTc8onazpZ5lZ
8e69JdvuaSXtOhmwqK+O0PRbyO4SC7GJnIsLjDfor/GQI79fJAiobsbyMHIckECb
OeOtj3dWb8iUNVkShNsPD5m4tQ/OIaY6tfvbPMm9hU5GW1rnEhzmpoHqGG1CxEpE
9N0X23cdslUWti8kjwoObDT7UUt1ewj6wUngdutVPtqyd+u1tgn5ljt8M4WtFNKJ
QXKjxwSnJ4BCgoC+NAgOBwaN8aioxQN6eGYqpk/Ex+JydmsgfsuEl8FgJJLgD1bZ
YYRVkOxvJw+smNSKCT28SdAjK1+Oe65t6E0efspyp0ZhQUoZOqWr0SxtfwxiAx5C
We2PlGi3yNvVi4hkR8p4kAnTWtdlGivPx+DilZLWrmQcTThoHqQ=
=6rnS
-----END PGP SIGNATURE-----

--AQ0is8WcPgXLVzoZd7aOBN76FXUUwDc4M--

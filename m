Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1066E17A459
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCELiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:38:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:56241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCELiH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583408281;
        bh=VU5iy1XUZYlFgC8OOSI2ilBLITiGp/PptGrrladtl/c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KzchWQQ3WxTsdS1UPiRKw/n+9kX7Xu0tpgZOUSsLSD5KKEvfBoLi7dCHhscQM/Wvc
         5aQ8DogH6pJBWSh8vEOGm1GIy8+xQsOhocRnIT93zhPTVqtLZkVW35/qGawz1/90pb
         wkeAf+jSe0PDpCYLSHZAXDdGoOjqdkMPQ8aziX60=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1ipNle1f3W-00WSKY; Thu, 05
 Mar 2020 12:38:01 +0100
Subject: Re: [PATCH 1/8] btrfs: drop block from cache on error in relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-2-josef@toxicpanda.com>
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
Message-ID: <59378db5-5ad1-93cb-0053-e4bde83a27a3@gmx.com>
Date:   Thu, 5 Mar 2020 19:37:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161830.2360-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GNbXcmVExuKFfd1OkRGUwfcyeUzzUpgld"
X-Provags-ID: V03:K1:welb2MMgF5toqNs6inWOx2PQxAx9jlQ4ZnwkTxzcBy4PPG2BILe
 5LpvG3T/7QW5P/jR2GHnpiRz0XiqfztX68LKWg2xwyxcuEYgk2b9tHfGFzJ7AI7DCw0IH1k
 fCCSjo8YXy2jDY1lM3+xTe9p0CUXjf2FwQJmGZvAXK9EKxKKDymu2It1Ys2yEbExw/qpPYk
 eo4m/nNf4NosTDcoQG+PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ShIRbTJgb8=:T/cPZaxVcm1NCBL/ACIN5u
 X0A2lp2gL5e8TEnmhNfuVXMFPkXO0k+U/OIcszNQgZefQOA/WkfbeEbeTM9UXmY6wWjAHgwbC
 37um6pF6MYDNgnARhHdU1tMiWJu4DHtn+c7isRWpdI+5vTqQ7ltJAEmDk+un9Por81QZB+BD1
 T8vYhxbTnurUGlGwQltRpDZICkNAPf5TzqORoW5xZvo9SrJrtEqtKpSu52+kjFaBshqoCC6hb
 eohH9s97Fhw0qLtWcMvdSacPpZYVu/rya2+QoBpdoq4UD0baQq+PRjMSsWmIJrU+L1728WdYU
 UDkBYdIqyXaMN1sSI11iOwlwi4EHPebiZJvNjDW3MJlIQcpTujV6rjoht+IfjJ1JJJSvvGvno
 j+Q+sVGPbTZwi9l9WP/dlUU+cXtrvAvQh4djBb9UCpfrhMt6XBFqrvx901Oqr28Z+2A6NCLnZ
 gjV2jmpGwtS1l5i7bgcsDPJ+3KUurn4hXXVwrAyyA++oEO9JQ5NtWs7BcGNBUv/QUdMoHcWnj
 mi99+eajg3IkWPZ1KvdJutGz9iqbFaIR7VHJwNk4LEF5kHnnNS2Wq+XHX60VgcKXgczoBGYey
 du/jlmG5qnyHPzk4ML/Giw1NJQE1J9DajbK8CkCubSVyt96lkTwp2HBG090HtQxzh0qMGaHNZ
 NYIkFD4HwYqpf6+IRPJXsgK52ySNYTD654rT6Nxqqcz9D/XSlOJLLVwr58+0vLFRi3bd/TI+A
 X+8UheaOMLxm+YELVmjRW8ZjTqvy7nj5f7KsUx7DeaWeFldLrVS8oXWVHop4ejV/t33OMQvPq
 PEZlMKbqPOOJCJWSz8ZEYauhv/UoNMLL6g+oOMPL8Ts5aFnHGrHQEn2LPHy+p+ShnWpwmlJDg
 3g8anDr/xlykL3myLplO6d0rMrgnvhkcOOvGn4jD6ZuOnO5MTiuE0V4AQkt4kqyHSJocbVCno
 ewU57gKrmAH9McwBfyyqWomiD4DIQWtFhIjks5BzBADuhwEWZ0pYzuE+zo6hcwiwxYC39K0Cf
 /d+7tCHFWw2Y+e4vbdtbY+/9d0HXoXhpjKX8vw8q/s34CQgYFgRmtNLue2lVpls5LHumHWVfv
 omzKo87VVkCq1MfZo7SznjphdS9O3JwkLiSk4LpBlcqW4kYWeDEDsH/rQbl1NxG873+G7x/ya
 XR6rg+WRUJt/qjZVuVM3uiKMe4/b53sWwvVDmbGiZqwm44kn7y5kcogUhXhg5ypsflahLORFr
 KRcTqZevvD+ge98vf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GNbXcmVExuKFfd1OkRGUwfcyeUzzUpgld
Content-Type: multipart/mixed; boundary="cp7ZAxOJzgy5ev28sR7FDlIB9xRc1DZvQ"

--cp7ZAxOJzgy5ev28sR7FDlIB9xRc1DZvQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
> If we have an error while building the backref tree in relocation we'll=

> process all the pending edges and then free the node.  However if we
> integrated some edges into the cache we'll lose our link to those edges=

> by simply freeing this node, which means we'll leak memory and
> references to any roots that we've found.
>=20
> Instead we need to use remove_backref_node(), which walks through all o=
f
> the edges that are still linked to this node and free's them up and
> drops any root references we may be holding.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4fb7e3cc2aca..507361e99316 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  			free_backref_node(cache, lower);
>  		}
> =20
> -		free_backref_node(cache, node);
> +		remove_backref_node(cache, node);
>  		return ERR_PTR(err);
>  	}
>  	ASSERT(!node || !node->detached);
>=20


--cp7ZAxOJzgy5ev28sR7FDlIB9xRc1DZvQ--

--GNbXcmVExuKFfd1OkRGUwfcyeUzzUpgld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5g5JMACgkQwj2R86El
/qhBSggAg/uvxXgFH0U6/DZS7r4+Ni9a40/dIfoF9GIbBzj8RuCCAd2Eclmemc6h
nW9k8KhPFX59X0BHQchD9OTLVCeK9HMTGEA0KXYvMX/9VrVAIrWOMx1cd59lh8bh
tWzYRCUzpYYQRVgEw5h1onGmPbnxCzSxQIJAcaHELq8V3gxjn0mZg3qaSATgbMzx
PSmAw81wDhFKMrQ7pXkXmBD+irHUoDITO6sR42mmLLrXom2w2nG7pKmTQ+b2XL48
vq17Pyt0TIoydmrL+hxzqrBB38+mL8k9cKWFH0MdvcnrW+361Vi6niAd3PoJQ8zr
zGn9p4Yy1SBYHLS7IMezqAGbOllTiQ==
=BKK0
-----END PGP SIGNATURE-----

--GNbXcmVExuKFfd1OkRGUwfcyeUzzUpgld--

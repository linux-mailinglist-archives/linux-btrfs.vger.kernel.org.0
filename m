Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1012BBB33
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Nov 2020 01:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgKUAo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 19:44:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:48621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbgKUAo0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 19:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605919461;
        bh=A2depZBTeXHDfbTuWD+QoW5X07tXclUzRUTaMPa17hk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jFwvqvkpM1oLu0iCqWwPPbIl5tm8/tGIMn6H6PSKpqRQ2T2pXrzaY3SQzZg1OBuvo
         pUty7JXdsgu5dp7pbMTxQscr+JvTsUmfA+CBARgpESyqivSkKHqMZiFSOlep8FZIJw
         kODeXy1D/w6Yosn/2MLsuI1hgFMEv7LEWt7io6Xk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1k1Sko0FI3-00gr8Z; Sat, 21
 Nov 2020 01:44:21 +0100
Subject: Re: [PATCH] btrfs: tree-checker: annotate all error branches as
 unlikely
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
References: <20201120161023.5033-1-dsterba@suse.com>
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
Message-ID: <76e69b7d-ce38-47ff-82f0-4b18d8305f56@gmx.com>
Date:   Sat, 21 Nov 2020 08:44:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120161023.5033-1-dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9kXdOinbXUmHPtzT711hr45fg2EPN7vkV"
X-Provags-ID: V03:K1:/sG/pWg7dwCA3kq7WXPLEeSXZmfepB5gT3qR52I+NtIO41jDnxa
 o4jPZPqkgyeREPAeUXxkkV8j7rjjrROScEwvzi4Vm2MySU6i+lipGhwQuUg+mNoD/V8v/9E
 frPUFwZVjc+f/chxtqnQTVocOdT45zSQwtXOs4wn1afgYjSZjOg7P1JPc4i49/nakHOqW9T
 atD3rAh42fkGp3yaqh31g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:APna3T/+pB8=:NAbHfOnFgd92hykswBeFQD
 XgSJBYuT32d2HzXPFsiYyKzhD7sR92wuQav1t9YQYqk/jpQ2gCNgdfFYYtT2+cJYrLUj2GKa6
 S62H10eMjLQ9I0VrAj8eNu0IH3CY/LEwBK4trYNsTSZNMIVRU/ybjRvKC8ILjGqUF+NdBcqri
 Qm29DgjhIPxGWJJZ90ExtB73SjbTfRref7THEgU9zvj4er4AYKwk86pDZ7dtrX+ir/3nqF1zR
 NlcRgj/9pJBKO71xup1UC8sd20kyuOKPjS4kZDpGL/OB5h3IWClCHYBpsITJ45rzLCbED3rdM
 RV8MrXxSk0kjUZ7dLaZJns+7sOAv6ktJOa0sGQcJ6mCNsmYM+jSvdbYfewqJqOLTj8wBtEBlh
 m+zOYb2R44+1xqqQHkyDpXlKYy/KbB1kHmRPYiwza+484zOVRWVJLUvlHZJQ7BzUM52DXkV6g
 JMzYqLWQ8fvLTbb/cashY86nWnbMvJ0QWcEj5BbVPTbh5PEvNzy8esK9SoSqOWIAD09ng2ZBG
 HGhFZPYR2SIqSLsgU5jZDvvMWXGqnOj7zHQSURCJ/MSpHn0xGBIBrUkilJSvDsyyjJRHFgVhw
 Bikdyf8gbPVNDdw/UVH53WdWqvqpRx4SDQmslUu/o/s+hIhqsVWVqmZZyuv9Y536alLeqRolu
 bTJ2pIheCQX07KTFQ7cTIhU+6DCozRpCUJVJiD9s4Dn3S1e8+f8XjkyQAhcC7JrqfjFE6T47U
 rma/7MTRArKucYXCDyexWby6A/LdBuyHYEuBr/8ZjyRZel8vsO+M0XW1AN8IoBGhBIoGuddWj
 PTSNvigP+vF9G2n7Y94ySOwyxN9s13S9htCPz8vV1/wYL+ZIzu9b2/6OOcj/wrXVfoxxZKORP
 nVAPPZ+qETLffeMExaug==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9kXdOinbXUmHPtzT711hr45fg2EPN7vkV
Content-Type: multipart/mixed; boundary="eawUESDUlaom4Nh1nQS3bm1QnvBZ9VhzU"

--eawUESDUlaom4Nh1nQS3bm1QnvBZ9VhzU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/21 =E4=B8=8A=E5=8D=8812:10, David Sterba wrote:
> The tree checker is called many times as it verifies metadata at
> read/write time. The checks follow a simple pattern:
>=20
>   if (error_condition) {
> 	  report_error();
> 	  return -EUCLEAN;
>   }
>=20
> All the error reporting functions are annotated as __cold that is
> supposed to hint the compiler to move the statement block out of the ho=
t
> path. This does not seem to happen that often.
>=20
> As the error condition is expected to be false almost always, we can
> annotate it with 'unlikely' as this satisfies one of the few use cases
> for the annotation. The expected outcome is a stronger hint to compiler=

> to reorder the checks
>=20
>   test
>   jump to exit
>   test
>   jump to exit
>   ...
>=20
> which can be observed in asm of eg. check_dir_item,
> btrfs_check_chunk_valid, check_root_item or check_leaf.
>=20
> There's a measurable run time improvement reported by Josef, the testin=
g
> workload went from 655 MiB/s to 677 MiB/s, which is about +3%.
>=20
> There should be no functional changes but some of the conditions have
> been rewritten to produce more readable result, some lines are longer
> than 80, for the sake of readability.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

The patch itself is pretty awesome, but still some questionable
likely/unlikely branches, comment inlined below.
> ---
>=20
> Josef, would be good if you can add some details about the workload and=

> hw, I'll update the changelog. Thanks.
>=20
=2E..
> @@ -181,10 +182,10 @@ static bool check_prev_ino(struct extent_buffer *=
leaf,
>  	 * Only subvolume trees along with their reloc trees need this check.=

>  	 * Things like log tree doesn't follow this ino requirement.
>  	 */
> -	if (!is_fstree(btrfs_header_owner(leaf)))
> +	if (likely(!is_fstree(btrfs_header_owner(leaf))))
>  		return true;

This likely() is questionable.

Although the biggest metadata user of btrfs is mostly csum tree, one can
still argue that for  fs with mostly inlined extents, fs trees can be
more common.

> =20
> -	if (key->objectid =3D=3D prev_key->objectid)
> +	if (likely(key->objectid =3D=3D prev_key->objectid))
>  		return true;

This is also questionable, this is completely dependent on fs content.

Thus we should only use likely/unlikely on the return value of
check_prev_ino(), but not inside it.

The rest looks fine.

Thanks for the effort to enhance tree-checker,
Qu



--eawUESDUlaom4Nh1nQS3bm1QnvBZ9VhzU--

--9kXdOinbXUmHPtzT711hr45fg2EPN7vkV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+4YuEACgkQwj2R86El
/qilUAf/YbDbjMdMJGEwVQzgCoigXzZNURMSyW2yrsF0GsgMB4oPsbgterudjINH
UR7lG6mLRCI9n7aZxW1oQrnnK1BkKT4QqdDq+xcouStVZ4ZJEp/VrRh0IaZtMKvt
gZH337ZMNZC3AqjZO1k7M8enlMnWmzrzbdqY4JiUCsfQ/sqASInHghFvNJOfjlup
Xfd00IhpQpGt+VrnH/MnFMeXjsKYMLjFAdJ+ESTDSiK7imn+WESK5TUesyLjzpwS
0/atoIwM4jvYZJv+ZFkY1x3Z+cuw60fPoS35FQCU9x7uM3SXiIa0p9+eO1EpmHFB
0GI5wBm0+O0b8bk7Ci5lm3WX+mMByA==
=gnz3
-----END PGP SIGNATURE-----

--9kXdOinbXUmHPtzT711hr45fg2EPN7vkV--

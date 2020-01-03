Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541A712F252
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 01:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgACAnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 19:43:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:49265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgACAnL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 19:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578012185;
        bh=sKKZ9SAJAdg3RlZcAQ5PfUCXN8tGWnbvibkIJFU1XNg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aoCVU9HH9k403pbs8pZqNKqkeS/TcfAOs8mIbwaBbyzVtXQCU6crDavVG/EGyhP6s
         u3VOKbnrLlQIgoPAv3qFSXMeXy2tJ/mDnIVs6bzX42baJ7Xu/P5laMdDWfzn5NdsmY
         pUZtYr07xFmRecTHXUNJ49dOeZA6FPorZaUG+7A4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfYPi-1jORk02mvQ-00g3l1; Fri, 03
 Jan 2020 01:43:05 +0100
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for github issues
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20200102171056.GM3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e8398282-264a-3ef7-43d5-63f1ac0c7c19@gmx.com>
Date:   Fri, 3 Jan 2020 08:43:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102171056.GM3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CEF31QZdrJrgCdzsulk7YTHmn5jIu7zzk"
X-Provags-ID: V03:K1:6YzdWTDt90PhlKpLmGfoBcg9Thickq5n+rV4Q18iOP7tCwwRmhU
 MUxhl8Nxfn5GB/KTWXOe61FbcvYLi29+VbRIz05wcOGN/MJxyuKvcsXkKuTchdOyh83EENd
 x+s+0BcX3SaCXtnWcd0d5C7ck3HjJtLM08at6xxRlER7miqDQ+u67+vv4/UKzCAhQI/McW5
 h3ao64jGuKwPkRHLrO6/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3w7GaTpd1Qw=:f7so59yncUeBcHB8k1kIXd
 bgSl6aWkCd0u/9ZPrEiCiDhw6rovgxyp7SNCSc6xuY3Adqfl5equ+xpwSJTTx6fWdLKxVoBSr
 79p+OQwv0gCsVqo3fkXhfPOM6R+hJZp4DH0Mx6OQHZpZSe1UGFiBlCF/a3ZnBkPrMxsxF80rC
 RZz2mNhQjcqbvVUIzL8ZPRDXGvE/SePYuhLEZcAThbi7GHZZQObcenOyKAbwDxsPyLYGMXSNP
 PZUxy/a0tEnAEIeaSSF3hYZrVoVwWm/oQcEuwTjetU/MWM9N1GflcS8WshpXX8Cl6BOa3g245
 ovfJBD2UNVy+XPckRgW7KSU9La4PVmuDRRT6nGuZU7m+LCwd/+h+Yd6wyUlJvSfwm7jRJNq+9
 TzEp1G46TfjHILHLYvqXh4+pjLJShF6AAHfG15tLRui9YgIhwK8Bcn9bNYWu5IrkpRihceydX
 cGFeMT7ru4mp6ELJ+R3c0dd1cY8IhIGNgzPlthnXjlQeE74ijxyv0QLsjFdEYpLB3ONcbAvlr
 NK6HubeCnEJvO7lFrZVJPF9ADH2lHM1vIvaKGLvFZcR+GcY4gox8JXJncUyP2X06mwAwR5RyV
 zkfXST8nr0yBfDXsGAKzUXW9DMmlv/eCnocS/W+XQyVrrIN9swv95MKGnoHT37pgYQbtZM4nH
 u8LjzriEarEQYQDHTj7Gd9inTN9lPf9UU9OYIZfL1A8qtxMXhzRv31L3VnGY5PrBmBrE4i+O5
 ntpCGbtuVe5ucQ3eGhqoOUuOQHjZXLbzeDS+JaHZhUi8cGGSa+rCKGmvMkDLNH0mV4qiunIuQ
 yV1gfUp+VKlxc7bu4RQks8YQgggKPLVE/EteCyrKxFEK+g20JbNrgpQV8rSfK6RQX7bN6G2I7
 ZJEBl1uepysiQ0Nx9IvDZbfMF2WyR84tt9OSUL6j7voREhW1NT1pDbWxM88tWS9yaPcuc19r0
 M3sDBaJ0MA2Y5CKPXg+zoSdme5rHZhdb6MJqMshvhiOdP8Ceji/MHSnQx/4Fp5iWjVJ63Vjfv
 RZH04KqWHK2jpXwbF7TRC3GmE3VzIeWO77JGcJIj0AxYd2dMlw7v8qoRw1QfBE+JF1wc5vEe1
 rfsQV6MEAqsrpy2TZX331z4D2FRzS8fqAkGAeQyXZDEtiri4CDzi/FhhSylyOV1t3EzK3Ndps
 DMrzLfn/avQmusEPw6WbAaUVU7tgtDDBbXoyQ94BOIS2ajOu0oN29YMsLoBy3ZNpEqUJ9PiY2
 8Ktftm4hlpxyGu1jAPssfvXTNi89V+Pb2yJm4BC5D3tbCtFElZB3LBwAxMmQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CEF31QZdrJrgCdzsulk7YTHmn5jIu7zzk
Content-Type: multipart/mixed; boundary="aRxEUFRHsmwXUe4Pham3AL9mmGCi7Vfnn"

--aRxEUFRHsmwXUe4Pham3AL9mmGCi7Vfnn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8A=E5=8D=881:10, David Sterba wrote:
> On Wed, Dec 18, 2019 at 09:19:36AM +0800, Qu Wenruo wrote:
>> There are a new batch of fuzzed images for btrfs-progs. They are all
>> reported by Ruud van Asseldonk from github.
>>
>> Patch 1 will make QA life easier by remove the extra 300s wait time.
>> Patch 2~5 are all the meat for the fuzzed images.
>>
>> Just a kind reminder, mkfs/020 test will fail due to tons of problems:=

>> - Undefined $csum variable
>> - Undefined $dev1 variable
>=20
> These are fixed in devel now.
>=20
>> - Bad kernel probe for support csum
>>   E.g. if Blake2 not compiled, it still shows up in supported csum alg=
o,
>>   but will fail to mount.
>=20
> The list of supported is from the point of view of the filesystem.
> Providing the module is up to the user.

IIRC, doing such probe at btrfs module load time would be more user
friendly though.

Thanks,
Qu

>=20
>> All other tests pass.
>>
>> Qu Wenruo (6):
>>   btrfs-progs: tests: Add --force for repair command
>>   btrfs-progs: check/original: Do extra verification on file extent it=
em
>>   btrfs-progs: disk-io: Verify the bytenr passed in is mapped for
>>     read_tree_block()
>>   btrfs-progs: Add extra chunk item size check
>>   btrfs-progs: extent-tree: Kill the BUG_ON() in btrfs_chunk_readonly(=
)
>>   btrfs-progs: extent-tree: Fix a by-one error in
>>     exclude_super_stripes()
>=20
> All added to devel, thanks.
>=20


--aRxEUFRHsmwXUe4Pham3AL9mmGCi7Vfnn--

--CEF31QZdrJrgCdzsulk7YTHmn5jIu7zzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4OjhUXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhaewf9GXULSeQ6yEZo19Xy3ViS9X+a
sjNlKilSryE8Bcvb2w5YBQSg9vUsEnaFuhxpVLmGAqikHrkXDcVExEwg9ZjTlk9/
5yPjd9y5V9pDL9UxZ3ikG5AaNDaV/1kO2RqmDuDNxYgnVcpbSVPdH7uXMTK0S3aY
GGcKAuFDHYXQXvAMyWkMovUjKOdDhUsMPUWzBmk/o93THUdh4UBqhIaozodkF0SG
P7NNh7aZCIomILptWA5jGXO2Mo+FB41jMO7lKAktlB4Zu7iP0l0RRgB2uj3nze7z
HJ8sskgcKoAKGz2Ca1XpHYGLgXDEsNie8ebZGAWfZ0F2QCPa02qlc8Y2RIJZqQ==
=pNs2
-----END PGP SIGNATURE-----

--CEF31QZdrJrgCdzsulk7YTHmn5jIu7zzk--

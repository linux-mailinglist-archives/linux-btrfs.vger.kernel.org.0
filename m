Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91702253A62
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHZWvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 18:51:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:35599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgHZWvj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 18:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598482295;
        bh=4O2y6ZHWnw63Um5qsVWEOglKEFMiiZAP9lsyDlx7NYc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aSxaZ+IN5Pf7EqhRjqAk0RKX7D/2Rqyv66a4Ebfsb0/T5Jx4DeCWgZ0NhJHzI8hXW
         2V3l2e65YaWvM6qv67TOdsndDDBaPDL4xgw3auq35LqCPQPKRjRFc82XsACVi8mNns
         d4hFJ+AeDvz3NVwylbysIbxf27dtvriIDGVtkA7c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1kjIYM0OLF-00amMm; Thu, 27
 Aug 2020 00:51:35 +0200
Subject: Re: [PATCH v2] btrfs: Only require sector size alignment for parent
 eb bytenr
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200826092643.113881-1-wqu@suse.com>
 <f047e64f-4397-2173-148c-f2fc9d70ef52@toxicpanda.com>
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
Message-ID: <98519b6f-2d7c-15a5-3005-412bc407ab45@gmx.com>
Date:   Thu, 27 Aug 2020 06:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f047e64f-4397-2173-148c-f2fc9d70ef52@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zCYt7tDjoqFnl2tb4Ve8FAG2Y16XYRppl"
X-Provags-ID: V03:K1:3ZpTa8fyZuywnEidOPvylMxwiSSxuxzWpl4sxekBdfMuuCWvKeT
 sXJ3jBL6sjkN8b7w8qyRD4XkiNQV9kOgjUHLedsuZFh+f1ZxzolFSW7HHZd0jvDu/dLPSr+
 voQZHxs3WAge8A7BO2AIWeuCL+SQpgEUO+EVQ2fwwy8qJ5osjMcWBhTC3rZQ16+VLnkBDvz
 PvrkV51ipQVsNyb3ZZWXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PLR34paNDBA=:EijXsDnBWdxiweUQcFWe8l
 /LmwTHUmnnSe/RE8jV/WsgMMPV4YEWHCRncFs1J7yhjNLpEr5n6tuKKdXKkmp5axIwgliyObc
 9Wo2tcxw5xryqYMphmYW0f0NC3hIzvsS41ERl/H8RTkAFOI4/JbwnMxBNGVq2zCVvIaLniVcc
 Kcc1MGcNHHFPA2brhgWdbfb8V63Cg459VIf9P/jHEuyvoEYh4g6ZjlVs7OqSk0i1GdQ/9gonD
 JE/oExlqKe1xsl8f2dBcxFVmVRPzA6TRPlp0elDcRKsU2Xteo5sKYMS9aQQhkVIc/wSsq/Vx5
 KymnCRgPjreaL5g5uNbn5MLx81ZjD+5xly7Qly60WooWPZu1W6G9m/xChJ1BnRW1l7caXIQtC
 P54371ZZ0bqAyOhby7hjx03oY2qOJzEJi8cyf6TweqyNtBPzxzTzMgYaHsYGIeKcUTFsGNnDw
 q9zwOHZpngcjqd1DEMPdjB+6x4pqoZcjdrYAvHNeSCvXK18CbGrUFlwWhQhAZawy/adUhIIl8
 KEaAhwpTO2lbC3lhM1Y4YYuw3h8/MDLHivJOHbkn/tZnGC+iidKAXb/wfzhIXBZbFvV1X4Seu
 keJq/kn+VP1wCFthzdCvvJJSDVlpBlfcZvv05Gwbo5UZ6nr/kTnQdjQvlsfpJLlX6dUSvqVvD
 Yoj0o0s/QLhnXPvPjMS8INiRY0tdJi4C6mT/kOkAMsU/70JQP5waAQ/UJ/dB2zQHOrj1lnVmE
 CKckF1QnNoACD2ooBTheM+vlyZizrwI8MPSFBj7q4drnSgPEH2bo8100eTdEAB+XKHcB49uHq
 S1KcKftAJIh3qb6s8c8hGW4XsANFVrSyS1ALGvem2N+XF5tPqcTGFIXdS5jIdgwPWV47It6d4
 FWsUOP0j2E7JpvMyqcJqPLX2WCxE9m7tjE8zQKMQLAPTJQWG2exJD++5rLYH66UMJtH+nx+AE
 55snDHICbYQBNHMUfgbxfvsLY6EymqsDgqFn7EWcC47lM9uWdkEfjkXblZZnQsYUOzvIQg51B
 1Twvu51Ey6VwGZ9TPJO7ptw+npUyR9o0tKezWCeFZ7x7txgKW6kGEyYX9k0m+DFh9kyncCJ+Z
 m4pm0s2N72hUg6b+PPthSKNRJyoJU/o8uiA4axsjGGFc3ZSDtQdcRBODjafVm75GgluSYuVEf
 VAqZ7Pd2D0fCLE4Pd2yA1Gypp7z/+l3d+WiB7CepsZebcQhO0sCH7gXZDZny/EPxcNlKnMpOt
 EeJwBZz2aHnwEQUsuiUvX2W20g+3St3I5PCPaww==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zCYt7tDjoqFnl2tb4Ve8FAG2Y16XYRppl
Content-Type: multipart/mixed; boundary="thNcbBcSpp81YLJCGS82Wm5DEILtu7f5Y"

--thNcbBcSpp81YLJCGS82Wm5DEILtu7f5Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/26 =E4=B8=8B=E5=8D=8810:18, Josef Bacik wrote:
> On 8/26/20 5:26 AM, Qu Wenruo wrote:
>> [BUG]
>> A completely sane converted fs will cause kernel warning at balance
>> time:
>>
>> [ 1557.188633] BTRFS info (device sda7): relocating block group
>> 8162107392 flags data
>> [ 1563.358078] BTRFS info (device sda7): found 11722 extents
>> [ 1563.358277] BTRFS info (device sda7): leaf 7989321728 gen 95 total
>> ptrs 213 free space 3458 owner 2
>> [ 1563.358280]=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (7984947200 169 0) i=
temoff 16250
>> itemsize 33
>> [ 1563.358281]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent =
refs 1 gen 90 flags 2
>> [ 1563.358282]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: =
tree block backref root 4
>> [ 1563.358285]=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (7985602560 169 0) i=
temoff 16217
>> itemsize 33
>> [ 1563.358286]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent =
refs 1 gen 93 flags 258
>> [ 1563.358287]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref#0: =
shared block backref parent 7985602560
>> [ 1563.358288]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (parent 7985602560 is NOT ALIGNED to
>> nodesize 16384)
>> [ 1563.358290]=C2=A0=C2=A0=C2=A0=C2=A0 item 2 key (7985635328 169 0) i=
temoff 16184
>> itemsize 33
>> ...
>> [ 1563.358995] BTRFS error (device sda7): eb 7989321728 invalid extent=

>> inline ref type 182
>> [ 1563.358996] ------------[ cut here ]------------
>> [ 1563.359005] WARNING: CPU: 14 PID: 2930 at 0xffffffff9f231766
>>
>> Then with transaction abort, and obviously failed to balance the fs.
>>
>> [CAUSE]
>> That mentioned inline ref type 182 is completely sane, it's
>> BTRFS_SHARED_BLOCK_REF_KEY, it's some extra check making kernel to
>> believe it's invalid.
>>
>> Commit 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
>> type") introduced extra checks for backref type.
>>
>> One of the requirement is, parent bytenr must be aligned to node size,=

>> which is not correct.
>>
>> One example is like this:
>>
>> 0=C2=A0=C2=A0=C2=A0 1G=C2=A0 1G+4K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2G 2G+4K
>> =C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0 |///////////////////|//|=C2=A0 <=
- A chunk starts at 1G+4K
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 <- A tree block get reserved at bytenr=
 1G+4K
>>
>=20
> This only happens with convert right?=C2=A0 Can we just fix convert to =
not do
> this? Thanks,

Yes, but the damage is already done, thus we still need to handle them.

Thanks,
Qu

>=20
> Josef


--thNcbBcSpp81YLJCGS82Wm5DEILtu7f5Y--

--zCYt7tDjoqFnl2tb4Ve8FAG2Y16XYRppl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9G53QACgkQwj2R86El
/qgLZggArT2FxIIlC0Dfzrbr0UXdZ7pCNw9DIg23W/sSoEmOJkNLswjk/1/HJGjo
vFTnRnIcs16rX4VzudL5XZ+qTbwn8+cThPVB4LdjjkRAvtzHeIWvtgSpTm+wVjj8
Q2nV2A0G4T45ANtPHPXbCb0qvjkvD4B4liuoXcpz1I2x2AArnMNl7dAuaT/mm6gy
h0u0evTxbcX+iqajms5Ip0sqP9e7q+5AtBfJL1+LGMZfc3MxoZCZo8PWV6he+dTj
tzcpS/PCTEDta2YdC8KzHuspqb/f6pvmvgxmSAys465vsMFjrrjToTss0v+hriJX
N+axIhvON/QX6VB3lp5AQ4OGSHwDZA==
=aCoC
-----END PGP SIGNATURE-----

--zCYt7tDjoqFnl2tb4Ve8FAG2Y16XYRppl--

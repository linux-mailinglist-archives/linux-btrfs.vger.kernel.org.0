Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9D200155
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgFSElk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 00:41:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:49217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFSElj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 00:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592541696;
        bh=8sY0SfJiJ/MaOHQFGv7UXWeBUU8isDZHBQ/f83ATbno=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=csA2i8QhnxdoPlH5YYhJYZtFcQ9U5wirHZlqKhj4ud9Q6og7CEjED8fWUGs9RKlWV
         /MWv6MDF82YSD+L77KadqOb66wnrCjVd6QJpib2gS7N+RZhd6gpdR3Oc11YecWiIbj
         nZgMl9EOTJ5ZwZXjJKAId5rz/j6b+kAmYNCywkbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGNC-1jTvjd2Ije-00JJWd; Fri, 19
 Jun 2020 06:41:36 +0200
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     Greed Rong <greedrong@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
 <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
 <20200612171315.GW27795@twin.jikos.cz>
 <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
 <20200618123418.GV27795@twin.jikos.cz>
 <CA+UqX+Ow_FnHse5yNxZ=jntzxmB0dRPYf2wWbeGX21jujUmSgw@mail.gmail.com>
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
Message-ID: <0a6cbb4a-9ad2-4ab0-1c18-70870fe4ae81@gmx.com>
Date:   Fri, 19 Jun 2020 12:41:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+UqX+Ow_FnHse5yNxZ=jntzxmB0dRPYf2wWbeGX21jujUmSgw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lBXGP0tQoe1hOCTOh1KEvuvQIzziBHYKc"
X-Provags-ID: V03:K1:1C+//JMvb0VEJzGxXah7QJo7g68+vj3FKIDJVhmg14CAB4xlzgU
 fw+QJVSmaqacdSCRG1gcTI012tYtfBVhp/uYfQ5rvAV5wwA+Shx8xNi7fBo+TtE8W7FntpO
 Rmz0QlQnq91b+CoTRJzs9yDeB4JiKNRHSUhvXuWXWVszvGDLHLAACx6/pKREZYIeSle6qjg
 ExndoI+dqpA9/npjBeCqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9XwsuphDa8=:cuhxJN6FpM81vR9lJLMCim
 8SsLkP6qHgnWXxRmyvMi9nd/lBvRaG4Cz+eiAWM6YdvS5FECb1bSDZNnw4hDsM80rkbgrM6M3
 /nWCbGsA72l83pxDViVOIrROeJ8B7JvK8OXMUUYjc6j3Syxq/lzQJa+5M7xned1xgDSI8umJg
 rHSDu5rvizJ22J7yi55S154YPfQLst0gGqnQV4UAVHhDjcJ1ZPBThRI1XrbQWmhEw1qeR9mo5
 ApebRrlr/qTKX8EwIHTtD/V6ziP9a2ehxbRVQ0paX9MyTOykXoH/m6CbM+FgTw1kKD5zGkZG+
 NZ+iKdj9U1pkcuEmNlZeru7k8YptGMEg91/JSnH5p4JiPUOKfiExCesHLt88nLyIiRgV6X+Z8
 ug8FoljU0zmyyJUYYgDFXkSKgfm1kb8EV4OuoAZ2UwL4euV0ur5kq1nSSOzGnMRd2tWZcnS7a
 EzW8vhifwbP1jZlx5oj9i+opZf4Yb+6twaqtbdn6/UGR5PX39OoD7qm0jKxrOeX0jnDMtjpig
 5T1Vt3XUaI5ZfMVNFzHz+T9CP+4etRnDonf18mTK9zBY9GgLs01MlWGKmjkTNlM2JmhuIMd06
 t165Vx4R43JT/rZ3Cmwkpf/olmmN0eyYsmUOdZLXL2+iE9WMQIUwEUnIoVDrVQmL/Qlas0Vte
 SVehMf7IiQ4ktu3DWqTlMtD1oJnw/4DQiEN/s/W1B9Qj/D3tPExgUNTnCAXrRULx57jmMvtpA
 Na2BY2QJAoN65BXewvEaADO2oTJwnDUIbngMBZThCSi2bBcimbyaW8t3iMAJfftr/6fmlBbkK
 8fE0WSX0pnNRuG3cGVBOsW+nN1rx89EsX30HLEuFibe5vpGdGawly9mno8abrk/H8x520+L9+
 CKzFsvTqOcM1LjiO4bJnPpraOrl5SM6OkKCzR1LXVvExWGG02OWGNj5IuBIuaMBi2wb8ZsIWr
 FTyOgcfTmMFjyvGnX85jMNPoqSFwFSye+kw2HC6ZlRK4p2jgAVQik7DgX7xAxIX7N7cYfTHZQ
 fKbcQDb2ThlMhbRveqPlUUzFmmZ3z2JH2ftjgNtUI8YIA8ih/1FAlFhn10Kq90g60CmQji9oo
 ytbWmDPH+WXPc14Pdx9g4w4qv4rtk6SqH1uomZHZZNxz1zwMq5OnWm/rcjZ8B3mr75GJOuNDG
 NZ4Ua+tj0BQEFfCznHTQ0RZvsvYsKQIojKqT1JH079T1EeOxL43fsAOoFvKeu44eEMINjwfMO
 2Td4urOzc9WanLkZM
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lBXGP0tQoe1hOCTOh1KEvuvQIzziBHYKc
Content-Type: multipart/mixed; boundary="DpVaQxYatuZGTcVlkHdQKxVkHlUAJ9ieo"

--DpVaQxYatuZGTcVlkHdQKxVkHlUAJ9ieo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/19 =E4=B8=8B=E5=8D=8812:04, Greed Rong wrote:
> I have restarted the delete service. And unfortunately it happened agai=
n.
> I am confuse that:
>     1. When will an anon bdev be allocated in btrfs?

When a new subvolume is created, or one existing subvolume get read for
its first time after mount.

>     2. When will an anon bdev return to the pool?

When a subvolume is unlinked (with the latest patch), or when a
subvolume is completely deleted (current behavior), or when the whole
btrfs is unmounted.


>     3. Are there any tools to find out how many subvolumes have been
> deleted but not committed?

I'm not sure, but you can always wait for all orphan subvolumes to be
completely deleted, by using "btrfs sub sync" command.

Thanks,
Qu

>=20
> Thanks
>=20
> On Thu, Jun 18, 2020 at 8:34 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Mon, Jun 15, 2020 at 08:50:28PM +0800, Greed Rong wrote:
>>> Does that mean about 2^20 subvolumes can be created in one root btrfs=
?
>>
>> No, subvolume ids are assigned incrementally, the amount is 2^64 so th=
is
>> shouldn't be a problem in practice.
>>
>>> The snapshot delete service was stopped a few weeks ago. I think this=

>>> is the reason why the id pool is exhausted.
>>> I will try to run it again and see if it works.
>>
>> The patches to reclaim the anon bdevs faster is small enough to be
>> pushed to older stable kernels, so you should be able to use it
>> eventually.
>>
>> As a workaround, you can still delete the old subvolumes to get the
>> space back but perhaps at a slower rate and wait until the deleted
>> subvolumes are cleaned. That there's no way to get the number of used
>> anon bdevs makes it harder unfortunatelly.


--DpVaQxYatuZGTcVlkHdQKxVkHlUAJ9ieo--

--lBXGP0tQoe1hOCTOh1KEvuvQIzziBHYKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7sQfwACgkQwj2R86El
/qgatwf/QGXNQI9tCXZYnq1LO4r0/RWxsh347znwBAg5xemnpYdiVAAd439X1CaV
vduwxnuTXaFNLdU4DtaxWVhVmtleo7Z+pX/YyjEjSM6e7QmugBPVLJZzECt2Bcwp
J3VWjKx2kAEoSQ2v+zZdsdAEOfjnmQ/jYPYdkY1TSEHMZJxZaVqnm/XZhLbJXPcE
D9lwIq1YzpYJiAM4C1ZsffNmXArm7P6wYR7F+y8KOZDlggETSb4FGiSL+1odV8Zw
M09UtwQw3LZyek66HWTSQYY+ZS5qoVo8WzvpB35kX8nSyiA20vq5YfHbf4t9SBin
hTtTto+YzOyzMommsaaQPw/t2UQ5+g==
=DiAS
-----END PGP SIGNATURE-----

--lBXGP0tQoe1hOCTOh1KEvuvQIzziBHYKc--

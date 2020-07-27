Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0222FE26
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 01:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgG0XrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 19:47:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:50967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgG0XrM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 19:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595893624;
        bh=OMR3HyrKyRlJbVXE2ULLvtdXHRdpVghuU2kjUy8ybxA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KiB3ZNoei6GQXrRa85WBtRVPxHFDWlyttVJ2QJIYWanu7wJ+zMXEINrKaI4cMaDVb
         BL9GnJAwWpdIOxRWGcXw0Bci82cLNOxrKLQTavqjfjwyIErRfIOJnvtPSel3cw3fwj
         dYq2tgjFHiHUjUq7/bH5vyJdiJraG2ZO0qhcP8k8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fjb-1jttIm3zLb-006PNl; Tue, 28
 Jul 2020 01:47:04 +0200
Subject: Re: [PATCH 2/2] btrfs: fix root leak printk to use %lld instead of
 %llu
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200722160722.8641-2-josef@toxicpanda.com>
 <20200723142041.GD3703@twin.jikos.cz>
 <ce52445d-b104-252c-005f-9bc13b2141d7@gmx.com>
 <20200727140314.GL3703@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <dfdb8641-99ce-a2e1-ea4f-8489d3cb5757@gmx.com>
Date:   Tue, 28 Jul 2020 07:47:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727140314.GL3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FsalfjoW4R8icEqrKknVQfZlgLqiD947Q"
X-Provags-ID: V03:K1:ZBLqWxkrpgPhoN4qmxASiHp7vHboeH9dZMtSf8Yu4ST3f0Zofmr
 4d7XOY8sAAQeNf5RYc3dNf59n8zsfHYhg3QtRGrr8YbZf14zNYRiG3s4tCxosKPWzl0/MMg
 A7nY3urNFsl+MQWvSdPJI4cJ1woDDthN4UM5kA2D/DfZ0VssDDYJEDPNAn29gzC10FML3w+
 Rwroo0nFBeaGoPTJdAqGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zJcw9mZdu/s=:dGwvZIoOyFuTzDzJ/oaGh1
 W0sx/SnOjgFXRWL1SareCDzCAel07k88WB730JOf/lqQEkq1v7yV1QYx45ZmjQSWwPUd+rm6n
 e0DYwGJEF/pkMqYZ/vTf+HsPG8Sn80TXE8UaSJ+4RtwHV7dC1QjGR2GG5RsBfspJ3m6vfn9uc
 0ciIPgKeDtcICeUoD09bOP9boI5JMVasj9bpAzAp7QsPn0LifBxAmfwD9wfWk68TxokxQvCX3
 D3/g55EQp88r4jV3AZLjABPEKdQYZPagaa5mBKMlhWwdgafhE3Rhes0Xk6q3lSTCnvKFD2sYx
 I7d07YN2e3X40X//pw8gRbvBXnsYAo1WfYV4iLp1eCICVXaLBd87neVoAtBFsQGJO33/212lr
 kLE2avPTim/lE6Mh9VGZYkY/wRnc7xl4JHiZ7IBajXrI5P5ux56YrR3YG750Axj4reiEsH+Eg
 71b/Qovt8Q3FhU5G2k4erZ83AOLTiL1HftXH0dTikWIzQbKrHWCrhlAx0++UU6ZPMi/kT38Pl
 S6Wf+m/99N9C4OOlg6DVjmdsWZX7Wd7reBem6O7B3t9OCgfHpAIwi4KtPSPYjNTEO4KJ2FmMm
 q87F4c14woVZT7rBqwmVl+3Klgt3GRt4GA1qtHvQ4br2BwiQ18blP/UBHGGJ8IbOM6Wg81fvr
 UMOYosTxJ5xl9eHThg4ao/jdU3dvI4Y+WPLW+2x8ycIsaSceQNiD6cxAyH4sM2JlsNPEy4bLx
 RUjEU2kpvK5A2U+qC+cdgBiW4kcWiRv85FPWTS8wULmLVOaV5Q59fRnlSrC6q2ViqF8Z8/ATx
 IQoywgrgVj5RUqvrHiUzg8c1vAV8KtLsh6qzv9YdBH7ySfy34a4/hJuXLkRQRxD6rT/oCDDdJ
 K0axxEE56Bwbrcc3DQmYy5xQCCbBE+OQxV/9Lql1NN7TFMIaq/BBTL8x4EY7hc3Hhs4fjAGE3
 exkWqUqjOxPcPdXYjx1lStrnryrYUAEE537C3qhhx3/5rzZJIqqFgwak0pBnee5+nrEu4VudR
 u+7nEUI3SvhjGxbnaYn8u9m9R1YzHytFSZSW532cdkyMTJwsuW7XqzKR9su4HpLSCnlMod37F
 tYsgUdMxl6z1a8Z50t8Fyl2L3xXN9fn+FEU7VID20wX8eEnHgBxHZXmE3ViUhM9jWiYq8q9Jg
 mzdbkVcXwPMBM7m99gKyTgj3ZqhrncTYnWpkOvSebtwDzeBK2us8GUEzmNif2Wc8sYeVulq6r
 OmgFfqyzymQosrbbPX/PCIHbB7iXYz/DqVgfRMQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FsalfjoW4R8icEqrKknVQfZlgLqiD947Q
Content-Type: multipart/mixed; boundary="fe9mngPARL5fiMb5IENd9ePLN2gzCOhgh"

--fe9mngPARL5fiMb5IENd9ePLN2gzCOhgh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/27 =E4=B8=8B=E5=8D=8810:03, David Sterba wrote:
> On Fri, Jul 24, 2020 at 08:40:17AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/7/23 =E4=B8=8B=E5=8D=8810:20, David Sterba wrote:
>>> On Wed, Jul 22, 2020 at 12:07:22PM -0400, Josef Bacik wrote:
>>>> I'm a actual human being so am incapable of converting u64 to s64 in=
 my
>>>> head, use %lld so we can see the negative number in order to identif=
y
>>>> which of our special roots we leaked.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>> ---
>>>>  fs/btrfs/disk-io.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index f1fdbdd44c02..cc4081a1c7f9 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -1508,7 +1508,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_=
info *fs_info)
>>>>  	while (!list_empty(&fs_info->allocated_roots)) {
>>>>  		root =3D list_first_entry(&fs_info->allocated_roots,
>>>>  					struct btrfs_root, leak_list);
>>>> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
>>>> +		btrfs_err(fs_info, "leaked root %lld-%llu refcount %d",
>>>
>>> But this is wrong in another way, roots with high numbers will appear=
 as
>>> negative numbers.
>>>
>>
>> Nope. We won't have that many roots.
>>
>> In fact, for subvolumes, the highest id is only 2 ^ 48, an special lim=
it
>> introduced for qgroup.
>=20
> It's not a hard limit and certainly can have subvolumes with numbers
> that high. That qgoups interpret the qgroup in some way is not a
> limitation on subvolumes. We'll have to start reusing the subvolume ids=

> eventually, with qgroups we can on.

Strange...

I still remember that we put that limit as a hard limit for subvolume
creation.
Did we change that behavior in recent releases?

>=20
> Also the negativer numbers start to appear with 2^32 so that's still
> below the percieved limit of 2^48.

Nope, For signed 64bits, it's -2^63 ~ 2^63 - 1, not 2 ^ 32.

>=20
>> So we won't have high enough subvolume ids to be negative, but only
>> special trees.
>=20
> For the internal trees we eg. have pretty-printer in progs so kernel ca=
n
> reuse that.
>=20

That's true. Pretty tree name is much better for human to read.

Thanks,
Qu


--fe9mngPARL5fiMb5IENd9ePLN2gzCOhgh--

--FsalfjoW4R8icEqrKknVQfZlgLqiD947Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8fZ3QACgkQwj2R86El
/qiQ7AgAkv/fijF5rbuLn9be4IL8plJNRRHwc39ZzIgSYLVzRORq1g2UTq7GjvBs
MODIcOS8NB1TpBpUJvxtFlusLfrYgRPHgmTG2sGmf3K/jaSi7yXyKVg0USfoqwEi
6zVWJG45FfaXU+qxZTfy2EIVWLOJQpaw2ZrkW8rmtWCC8SCSzfBmCqPQ/DexaiJF
n5gGDCvFCEWfy3UbTGnQNDD3/L8JngS5hXAdexpEjNWlLkmqCFSrx3mx67rLu1I5
XTfJAVAgWH8P8pgBH0EiIsRN4h6LdgBGi0POljUiLE9WOgNOj3r73oqtj0LqzjdJ
7HZsB/RIhawLtUj3WpFQn0I9NCvONg==
=Fjfv
-----END PGP SIGNATURE-----

--FsalfjoW4R8icEqrKknVQfZlgLqiD947Q--

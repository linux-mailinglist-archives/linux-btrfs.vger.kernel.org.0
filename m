Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0BB156D6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 02:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBJBgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 20:36:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:40513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgBJBgP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Feb 2020 20:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581298569;
        bh=KVuGOaQJHTcKGXELV/ewcYIxyNji2M4qsfWle67GJEs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cjMhFPx6c/EPzHVfGi7Gh2dS5VunbBKlI2cW1DDVQMS2BjbC1ddNcw3P5969Xa+RU
         oe2q/v9WHCqX2KXEjYttO7wY9WzvWOl3oB+GRwyPiYXa1zqlVZDs8T5w9fIxuOUWQt
         KSf5iysoXSwBBZYJR3Vxm52EAeur+zlBlVhfI+8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1jMMC62Scw-00urKK; Mon, 10
 Feb 2020 02:36:09 +0100
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
 <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
 <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
 <84b66420-4c4a-93b9-52af-37e85a343773@oracle.com>
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
Message-ID: <73b9d157-840b-b93f-b86a-5041745f08ce@gmx.com>
Date:   Mon, 10 Feb 2020 09:36:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <84b66420-4c4a-93b9-52af-37e85a343773@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ahq2XgbebafL9TC7fznnMIyX3bolMdxB3"
X-Provags-ID: V03:K1:et+77KMIrXewJNvUcSHzxtRLORPf34WhAEZbIkoX4V+IHHNaCy4
 BV4Hp/uNLE7ASNdpuQit0IkWfhhsreB6YypUbhPmESFQVUjDA0IZ9EGV2w7Oq1k+VkV+WnF
 an/T2aaUTs2MKacee53gwHrOtjY8EndWTNvLmO4BlmrgM0ErqrM1EExhspJgYk8lg/7BJv5
 970M2n1KojVODrqwe/63Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSmKUcP7mlU=:u1LP5UuI4R83Mg0iqUy0Gp
 /UZXAI2GleQ4vCtVwRPPS++K8HTqQ4MKWQ7xvL/K7ykI5fxNHPcLH24/2GDNjpS85zO/4OqTk
 eY7j7w4jVYBLznJgdRPXIl4e33UWkN7yy3oCw2yh6MxG1PLKezSuCgQq5e+RgRFx8U/NstvoQ
 tiMf/BaDakfmqe2euEYwOgG2nQpLca0jL9GJy0+Rk2DvdgEgD4EfgibQ5vTGboiTNhj02Z1xb
 ZpCHSv8IqYO0gRfA6NPF6/JIJn5LgMer3K8i2REEU8pGnpmEiQ682wsHQdHdYpnohaKBHMCDn
 T5AWqzYzBQ67sqGmodNNBvXcYGcV8PAGfv78a5bxHyDBC8xbmDX0tLjVowy6d8MVhGmKG+Zm6
 BP2rA8kr1yDVMUzvIZCb5S71nbURQbX+edNcLVEMLy+78W2Eqn0FfNW45XuQmmWGAVHG+LRn/
 f4pEk/qUOpQexCBNfIkKuSRNx6f3ZWneVp3ZGPedlj4sJrnk4xOreZ7mOhwFUVPmmFAfwdP+K
 oYrNULQsJVSvFQQFyrWaR1cCemxjyuCS85+h7qOJ6U8J6rMuKXwP0hX2SUESGULJtN5p4m4Zd
 LF1/H/TAN/lvtsftf5qCH86KjNCTTh9czDhlJgEg+R881MVKnTxCACmGYIUCnm5Cig0iW0UF0
 RLqkw9j9N5gooatrnK+vznVCSYX89ieNWuG/INQB7Pu3/zJ2tbcvuTD7TipTzOmIcmG1A2Zjw
 Bwn7b427rAZYGYghPct76zQHGaR+ziWgzB1nZ3TBiva+0XIYpsDTGqRX1VxImOfKcKLz4Q3wr
 NWuXoEO9uQ7F7+TLViwP/rbCveB5qsQNQTJ+h0i1q7uTUIcL/rPeDZqSBWTPZghwh5j/k3Maz
 m/9pD29XG1oL/2n7BtTfdgh1NmStqCWtfuFHv39ioyqs42Cyw3lmSXk4bYIXQf60VZiTX1u8i
 2fWrg7VZh/fTMaVEVLg5clYm/EkuhWyI3Q9rbTkhJzTkNpM2YOT5g6825mMzWX6gRr7PLigkf
 ClUJOK2Gcl3TregHkcvstvHTyveYR/QnISU0jDG3DWlk5WfHtKGyeLes6QA2vO/bTaWRRliaH
 Lblfqji2f5WHJkuTglUXx5jOo3NldfBBIr6qBHkg2XfbaXHs4NNVC8S5AnF5rfJWJ9DUbyloz
 bjiTkDJrQt3HoM98wAdg51PV8Wj9KfBgiKmtmFrUWgYHYXS4QrZyR06lgc7kXoJ2HDRABzqEx
 8Jz6i6T2g2iAsIu5+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ahq2XgbebafL9TC7fznnMIyX3bolMdxB3
Content-Type: multipart/mixed; boundary="OFNqOkEacXwfZrsAPAyficF9oANc1isQd"

--OFNqOkEacXwfZrsAPAyficF9oANc1isQd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/8 =E4=B8=8B=E5=8D=885:06, Anand Jain wrote:
>=20
>=20
> On 2/8/20 7:28 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/7 =E4=B8=8B=E5=8D=8811:59, Anand Jain wrote:
>>>
>>>
>>> On 7/2/20 8:15 PM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/2/7 =E4=B8=8B=E5=8D=888:01, Anand Jain wrote:
>>>>> On some systems btrfs/179 fails as the check finds that there is
>>>>> difference in the qgroup counts.
>>>>>
>>>>> By the async nature of qgroup tree scan, the latest qgroup counts
>>>>> at the
>>>>> time of umount might not be upto date,
>>>>
>>>> Yes, so far so good.
>>>>
>>>>> if it isn't then the check will
>>>>> report the difference in count. The difference in qgroup counts are=

>>>>> anyway
>>>>> updated in the following mount, so it is not a real issue that this=

>>>>> test
>>>>> case is trying to verify.
>>>>
>>>> No problem either.
>>>>
>>>>> So make sure the qgroup counts are updated
>>>>> before unmount happens and make the check happy.
>>>>
>>>> But the solution doesn't look correct to me.
>>>>
>>>> We should either make btrfs-check to handle such half-dropped case
>>>> better,
>>>
>>> =C2=A0=C2=A0Check is ok. The count as check counts matches with the c=
ount after
>>> the
>>> mount. So what is recorded in the qgroup is not upto date.
>>
>> Nope. Qgroup records what's in commit tree. For unmounted fs, there is=

>> no difference in commit tree and current tree.
>>
>> Thus the qgroup scan in btrfs-progs is different from kernel.
>> Please go check how the btrfs-progs code to see how the difference com=
es.
>>
>>>
>>>> or find a way to wait for all subvolume drop to be finished in
>>>> test case.
>>>
>>> Yes this is one way. Just wait for few seconds will do, test passes. =
Do
>>> you know any better way?
>>
>> I didn't remember when, but it looks like `btrfs fi sync` used to wait=

>> for snapshot drop.
>> But not now. If we have a way to wait for cleaner to finish, we can
>> solve it pretty easily.
>=20
> A sleep at the end of the test case also makes it count consistent.
> As the intention of the test case is to test for the hang, so sleep 5
> at the end of the test case is reasonable.

That looks like a valid workaround.

Although the immediate number 5 looks no that generic for all test
environments.

I really hope to find a stable way to wait for all subvolume drops other
than rely on some hard coded numbers.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>> Papering the test by rescan is not a good idea at all.
>>>> If one day we really hit some qgroup accounting problem, this paperi=
ng
>>>> way could hugely reduce the coverage.
>>>>
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 tests/btrfs/179 | 8 ++++++++
>>>>> =C2=A0=C2=A0 1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/tests/btrfs/179 b/tests/btrfs/179
>>>>> index 4a24ea419a7e..74e91841eaa6 100755
>>>>> --- a/tests/btrfs/179
>>>>> +++ b/tests/btrfs/179
>>>>> @@ -109,6 +109,14 @@ wait $snapshot_pid
>>>>> =C2=A0=C2=A0 kill $delete_pid
>>>>> =C2=A0=C2=A0 wait $delete_pid
>>>>> =C2=A0=C2=A0 +# By the async nature of qgroup tree scan, the latest=
 qgroup
>>>>> counts at the time
>>>>> +# of umount might not be upto date, if it isn't then the check wil=
l
>>>>> report the
>>>>> +# difference in count. The difference in qgroup counts are anyway
>>>>> updated in the
>>>>> +# following mount, so it is not a real issue that this test case i=
s
>>>>> trying to
>>>>> +# verify. So make sure the qgroup counts are updated before unmoun=
t
>>>>> happens.
>>>>> +
>>>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>>>>> +
>>>>> =C2=A0=C2=A0 # success, all done
>>>>> =C2=A0=C2=A0 echo "Silence is golden"
>>>>> =C2=A0=20
>>>>
>>


--OFNqOkEacXwfZrsAPAyficF9oANc1isQd--

--ahq2XgbebafL9TC7fznnMIyX3bolMdxB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5As4QACgkQwj2R86El
/qiiUwf/Ws2gNLDluuzqhe77EzreGCYFHdV1Iq+18Lc2e4yx2HnOO3Hti4s7pxDJ
Txe02ApIiaKXzvDsHgwSYYF3UMDJ6XV6VIMflhc0pPb6zBuQnTF1RrLHmjMV2WnT
82IkrYT8WYzmShJyVMtLKZvjagP1/Oqn8DF27VvosRMeHqgQrMfajFj+tk8+txML
3JhAjTNVMZwpGM2/tDFqKLeEFNPWqW7kA1/cbgawKwz+JsP2sdOrqFJSDoutKMW2
RvbbWwr0GMJYORNs6WtuX+7gIOFbfKzkRJtjv3Wl7br7hBdKgDfIKPBXnSoCRYdW
i+bGarwbOdW0GFzTLj91X2AjS8HNBw==
=16OC
-----END PGP SIGNATURE-----

--ahq2XgbebafL9TC7fznnMIyX3bolMdxB3--

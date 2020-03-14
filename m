Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BD185331
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Mar 2020 01:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCNANa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 20:13:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:39823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCNAN3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 20:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584144803;
        bh=/6lD4tZUWF8NEVp3OlC3pK6V5nGOSP0fWWE0FFSG/pI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QoStu55dsym7Pys4Ta5YgBVcwRD9NBns5tGd07iLlYpoyFgV/fHaSiotJvYuU9oXV
         O9FzaGKq/hr6vSE2MfJcLh0P/AZDzxachIQ3gQlC7tt+nJu7V/wl4FTSRzPQmCwOoZ
         Eb423cCm45+pympJxmy+EykEpqSEMq/y6tAE+Vxg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mirna-1jpZ6U1c8K-00etku; Sat, 14
 Mar 2020 01:13:23 +0100
Subject: Re: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-5-josef@toxicpanda.com>
 <f77683bc-c644-25a8-6d97-fbe339bd5f98@gmx.com>
 <20200313151829.GN12659@twin.jikos.cz>
 <940ee1b7-a854-275e-e01f-05770435ee15@toxicpanda.com>
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
Message-ID: <e466182b-902b-2cf8-49b2-f506c35b3b48@gmx.com>
Date:   Sat, 14 Mar 2020 08:13:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <940ee1b7-a854-275e-e01f-05770435ee15@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NUtAOcYc2t2xGuVewM8SvSDlZWOE95nhk"
X-Provags-ID: V03:K1:ctOPjvjXlQfnRuU80/f91Is1kK9zlEjYOpqsdYyYCkP0rzxI2o/
 uvytx97I1t5VLcSc+/MN9XCkiPvlOA1X9/oCkV9Mr7RTfd4iJizlOuk/tzObs+hX5N7loRR
 3yCmV2x32/6M0AcFHVC4zxILSzu4qhzsK0gMPE/Buk5VKwIbpmcKxVFjAmYQhUStiXmoAvB
 nt+s4vDHcIaUVNPGfVu/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nfe42Xik27Q=:/f4AEHbP0gC6IEhhs+YsUr
 TBQiIVVOShRHGqzix41r2Mvp6e2taEPsLbZu1a7ERiJaSe9cMMBVSP2eu/dmPHmHPZH0FBtRA
 h9jQWM1jZ01OzW+AbtKdrhSRtiLpPmZnL51ptIBvBt68EDhdcaEc1BNEq0Dlc1WrfwDYdvFgQ
 722YPneWVCeu6dsh9NVVtoizXdjGyaCmZAjFqXmozidLrUdrdXVsbwa33+D4rFsxPZzC5+DXi
 0aYwov8Km1WBiY8rEA4mpKwWY2Je3BDJqqV2IGdVcUSIuNvQnU1AaaeJJU05mWLpbU4bEUXq1
 GCE8rSWgCw79kjaLXZPRdDfNAYDSWW2VxKFh/NUrF5bvaqBcqlFYmkHlNSXH8Bkn810VdSaOg
 zhQTgLjxZERbP8QWtyrBxXRRSmszUkxYzsH2Ebtxn7U7VKOTXq9slMlE03yuG+yDUhDgzmfOf
 zC45XLxcusWXuwOvY6zBhQn+6dAFrzyiXlBO1F+GY+9VrpYI2/8oSOpcFWinc4bl23GR1irQa
 725OpWqh5BW8QuXzLP1/wrQ67SvJr8Yw0ySjg/2YrVT3IC7/2PfVM0NrggksE/xqOYQJUVYg1
 M+gMHquSyvtJ1gVHQQHXY2S+73D0ZlowsFO9/jDyoo4gIIGucitM3AmxeJwB6JvQcSdnQkNmX
 qv9vCo3XxHZ6hJxPCeffuNFYOjDDReTidEU6kTYW2lc15Q5X4M2UsThc/NS4DBJMF3oHnhYQh
 X07jVmS3IRLI7MJpyd6QKNkLgO038j44vy05mSGmJW+me4NoaYTUMnrDMKQGdlDYop1go774O
 odjdd0cHHkvbjHGYOZ1np5rRWlbOYh4UsMPebwD+H07sPUkG0eN7FE6dT5W2F1dl4klzThAWE
 gy09v8wuqX8vhdnNhRxVH20/5W/v2zX63z5g4P1Q8YepQdey07ArwG7FaVHAEBaLJBdBNwnse
 pYgV4c2821uRAySsPCb+qpuI4Wju/O+ZWecBki055hT1WED2+Kx8bQprVu9Bhv+Gc2fe54+jV
 Gh/GArJK6Ab2rZgmiKlruhVxzNizRRvePzLtAItZV3/0nUwBWgwKYAozwXj+/0LqmqZRvcdYj
 cLo0mJUrptx6uoKQupW5QowASbjhER9fH6GSOgaR+jcBxD3KpeFDk0MZWfvddSkevgceCOEUn
 2Pd8n6wv1UlVpVXHbKlOZE8LYh6prWuL6u7MssT9LNy5NtsDuu6WaixzzLaA2RyCPzVBuR5LC
 N+wc74W8mYkvoqNX6
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NUtAOcYc2t2xGuVewM8SvSDlZWOE95nhk
Content-Type: multipart/mixed; boundary="MsqgclumG8ObkzxqZwoaGifF8Y0RVptKR"

--MsqgclumG8ObkzxqZwoaGifF8Y0RVptKR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/13 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> On 3/13/20 11:18 AM, David Sterba wrote:
>> On Thu, Mar 05, 2020 at 07:39:33PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
>>>> If we have an error while processing the reloc roots we could leak
>>>> roots
>>>> that were added to rc->reloc_roots before we hit the error.=C2=A0 We=
 could
>>>> have also not removed the reloct tree mapping from our rb_tree, so
>>>> clean
>>>> up any remaining nodes in the reloc root rb_tree.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>> ---
>>>> =C2=A0 fs/btrfs/relocation.c | 18 ++++++++++++++++--
>>>> =C2=A0 1 file changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>>> index c496f8ed8c7e..f6237d885fe0 100644
>>>> --- a/fs/btrfs/relocation.c
>>>> +++ b/fs/btrfs/relocation.c
>>>> @@ -4387,6 +4387,20 @@ static struct reloc_control
>>>> *alloc_reloc_control(struct btrfs_fs_info *fs_info)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>>>> =C2=A0 }
>>>> =C2=A0 +static void free_reloc_control(struct reloc_control *rc)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct rb_node *rb_node;
>>>> +=C2=A0=C2=A0=C2=A0 struct mapping_node *node;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 free_reloc_roots(&rc->reloc_roots);
>>>> +=C2=A0=C2=A0=C2=A0 while ((rb_node =3D rb_first(&rc->reloc_root_tre=
e.rb_root))) {
>>>
>>> rbtree_postorder_for_each_entry_safe().
>>>
>>> So that we don't need to bother the re-balance of rbtree.
>>
>> I'll update the patch with this
>>
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4240,15 +4240,13 @@ static struct reloc_control
>> *alloc_reloc_control(struct btrfs_fs_info *fs_info)
>> =C2=A0 =C2=A0 static void free_reloc_control(struct reloc_control *rc)=

>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_node *rb_node;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mapping_node *node;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mapping_node *node, *tmp;=

>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_reloc_roo=
ts(&rc->reloc_roots);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((rb_node =3D rb_first(&rc=
->reloc_root_tree.rb_root))) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 node =3D rb_entry(rb_node, struct mapping_node, rb_node);=

>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rb_erase(rb_node, &rc->reloc_root_tree.rb_root);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbtree_postorder_for_each_entry_=
safe(node, tmp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &rc->relo=
c_root_tree.rb_root, rb_node)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 kfree(node);
>=20
> You need an rb_erase() in here.=C2=A0 I'm updating the series so I'll f=
ix it
> before I send the new set.=C2=A0 Thanks,

Nope, you don't.

And that's why we use post order iteration for rbtree.

Thanks,
Qu
>=20
> Josef


--MsqgclumG8ObkzxqZwoaGifF8Y0RVptKR--

--NUtAOcYc2t2xGuVewM8SvSDlZWOE95nhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5sIZ4ACgkQwj2R86El
/qhYAAf/Z1+BqWe7744v8IWgd0NU5V03M4Ikw71/3NS1IJVxLNEgzJvnh5BF41w0
jRuygU/RtGvy0m3ijpwVUsD3oAXlopefU5M4xGHL/sCYpgeD0KYmV6qxmSnh91u0
HhpdHvQUdQdF96LMfsRaLEJBw5pdUgpDG3sH7HieRS8+KDRyATRCbm1cxqYH8dLl
hh/rQHfwpGCilyeF5Gd4/brPNMcz9NXkGjGG8NK0r+7p8fNAKi+udxfLMLMca3up
Qc73PDbhcZrqs4cuhiVn8WnNKqNV+WW+dWSt3px3T2QOSqwv/+scIBMsz+Blg3Fv
n4p2Wlr9KiaZoIvTujtKO9P7nMzK5g==
=gVCZ
-----END PGP SIGNATURE-----

--NUtAOcYc2t2xGuVewM8SvSDlZWOE95nhk--

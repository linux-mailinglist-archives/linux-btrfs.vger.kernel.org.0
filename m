Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99AB12FFF8
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 02:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgADBcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 20:32:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:44733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgADBcq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 20:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578101559;
        bh=2AZbKMFo5ggv4FJBVJxquFGD7p72cnhsH33ah3rLY24=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XIPiCtc8IDBVqyjMopP5WU8UBjTl+GTR381h+PMubEt7+LVilEza/JxfqWVrCS+BP
         trlFDwgoGnCjoX2OgLmbylo0QGEm6nqVV14l9ZrHtqX+ivUlLeFAqsQ+Fd+6JRFKDp
         c2VNvW6O5QHXCND90JYomsnPE1ab6WJDYLs2dByU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCOK-1j8P6Q1UKC-00N9zb; Sat, 04
 Jan 2020 02:32:39 +0100
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
 <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
 <20200103155259.GA3929@twin.jikos.cz>
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
Message-ID: <faf8956c-7b03-f3d7-4d4e-b67347b1770f@gmx.com>
Date:   Sat, 4 Jan 2020 09:32:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103155259.GA3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E3BUwnto89aV56vNJvx76nv4e5ivs0YTa"
X-Provags-ID: V03:K1:PW5agUeNtDBLm1UhAMha6S+fUsg/MH/81mRNPZRDetqiebQ0HAJ
 qiYnGNUiYa/gobiNsUdiZUtlkGAJJm8jrzv3xptGFd0zs3BwHHzP+JKogp/2LG4YS9Oven7
 jgQrl0U/xf3i0bBVYm534GQh8LHSVpZBbk/dDsFa4xfhbr2vABLLDbVvtuvFeK0IXhG1KsE
 VQK4oUEeEi0CztlRcKt3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PU1oksggyks=:HUHax2MDgSi0vUR44oeRT1
 jsHbMQVgJfhEz7pRznlLCtTFFD5WwED1ELJaDsSEZqyKQqmqRVRWugnjQD7C05k1PbrYnwmvL
 nN1u6pQbvxAqzDgnX4IbaPlBQ0FF0BI/EIM+dNPEmp5mqMfx4fmyFu4UndlbKus2mP9c8VSzK
 wnQdSB3PF2zu1YtjTytH7E4Nfd0/DugfWdlruk+dGBO8vqa1HfrPj8tDpN72tWsLaXPr+vH+U
 5yMmRAPGpO6lzH12RlrDmfo1x0UN8Zk6odENdlvM0qLCgn/bPwC0bpxPhTxXYYjBETsGZAp7k
 H2YNdnNroecd1QcNOU5SaKt9tvIsEYBvVriJzoSj2gfqfm11dljXXgnXQdIpMl+KlqbOw7FbT
 lRlb/PcBdwmt7eFH/SIQa/TmXnV+5Pvpa7Kb57C6XDB04P9tKxirv4qNjC+5BkFvpOX6niwr2
 qepVrTQbKlWV8T/JPXJXtKJ3oN0kwILjI1/75ZQNrflVwnAKoB656Mfd/NtNDMXnlWIk+NJeo
 ZoGZDKHVhMCH9Ljd4MGu2kgjE0eixNDLXfEFXQeQAiN06KbsgzVI9zTioK5yWjNOfNAXL7z8E
 7NQdnwfk2sc5l09XGRjCLSGKiRQVKo/UemiM7IJNnwJKSMioVQ9tj8I4QHd625gKd0BAj1DD5
 2NgXBIaRssdr/CRG25Az5pmvYsiVwIwUE5ugJYV2Iam5wjR/nTS1HZnfEk1lFdjf4svs66DwX
 HIwbgk5JFjuYjE4coQmfm9hYM55s/uoaU1HzpILrI4wtYkPO7bskZussPMLT4P3LAXABiDTOI
 ej92QnPUa5Wmkzn6K8NFn016XeKmu5ccwrbnpxT1OqRJYrfccg/EukbRrWgC3Wdf/uKk4e/Zd
 NZka3QZkNcS/pd0UYmpvy4P7toPZ0Y+KWqC4FFc0wXSywbodbS6nz/vqoqWGj67qQIJNFWrN3
 3RVj3MB2ewGVngoLVxLXbSvCThZ8HdU4DCP5WKvtz9+p6i/LI0d2L7s0MOCQJRt7KDDwwZOJm
 zrKxkSZsTGU/htCvEAvmD2BLbNoPD5VE0EOkrFixROdnxj2jgh2FH4snMET6XKhE8Jd7hYms2
 7i8p2GqzOfZzzTqmu1otzWoclEjxssC/aE/gSkgGeSH6Vp4hs6kGVAvSz3LbQMTPYVfhQXDVF
 M6GxVi0Pwg48eyempqabCRYW7G1GAX9y2AnXLsrP4haMmQnpIiK2ltIptFUrVD1eTlcthC0/0
 zSImCU67g/kLQWmFoCMi1SaQHHfPOMXigQjKYm1OIJats9M8jy2nFvliz0MI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E3BUwnto89aV56vNJvx76nv4e5ivs0YTa
Content-Type: multipart/mixed; boundary="Pj7W1ZnEJC8XzqsCw0EJI22GWndP8eHgO"

--Pj7W1ZnEJC8XzqsCw0EJI22GWndP8eHgO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8B=E5=8D=8811:52, David Sterba wrote:
> We need to get this series moving because the bug affects a few stable
> versions.
>=20
> On Thu, Dec 12, 2019 at 08:39:43AM +0800, Qu Wenruo wrote:
>> On 2019/12/11 =E4=B8=8B=E5=8D=8811:34, David Sterba wrote:
>>> On Wed, Dec 11, 2019 at 01:00:01PM +0800, Qu Wenruo wrote:
>>>> Due to commit d2311e698578 ("btrfs: relocation: Delay reloc tree
>>>> deletion after merge_reloc_roots"), reloc tree lifespan is extended.=

>>>>
>>>> Although we always set root->reloc_root to NULL before we drop the r=
eloc
>>>> tree, but that's not multi-core safe since we have no proper memory
>>>> barrier to ensure other cores can see the same root->reloc_root.
>>>>
>>>> The proper root fix should be some proper root refcount, and make
>>>> btrfs_drop_snapshot() to wait for all other root owner to release th=
e
>>>> root before dropping it.
>>>
>>> This would block cleaning deleted subvolumes, no? We can skip the dea=
d
>>> tree (and add it back to the list) in that can and not wait. The
>>> cleaner thread is able to process the list repeatedly.
>>
>> What I mean is:
>> - For consumer (reading root->reloc_root)
>>   spin_lock(&root->reloc_lock);
>>   if (!root->reloc_root) {
>>       spin_unlock(&root->reloc_lock);
>>       return NULL
>>   }
>>   refcount_inc(&root->reloc_root->refcount);
>>   return(root->reloc_root);
>>   spin_unlock(&root->reloc_lock);
>>
>>   And of cource, release it after grabbing reloc_root.
>>
>> - For cleaner
>>   grab reloc_root just like consumer.
>> retry:
>>   wait_event(refcount_read(&root->reloc_root->ref_count) =3D=3D 1);
>>   spin_lock(&root->reloc_lock);
>>   if (&root->reloc_root->ref_count !=3D 1){
>>       spin_unlock(); goto retry;
>>   }
>>   root->reloc_root =3D NULL;
>>   spin_unlock(&root->reloc_lock);
>>   /* Now we're the only owner, delete the root */
>=20
> So it's one bit vs refcount and a lock. For the backports I'd go with
> the bit, but this needs the barriers as mentioned in my previous reply.=

> Can you please update the patches?
>=20
Sure, I'll update them soon.

Thanks,
Qu


--Pj7W1ZnEJC8XzqsCw0EJI22GWndP8eHgO--

--E3BUwnto89aV56vNJvx76nv4e5ivs0YTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4P6zIACgkQwj2R86El
/qjJ8wgAhwGA21qLIE0eMVzqSmxUOpKVp3i6NgEFS25VdO3z2on8d9fOXo+2x+yR
RhoRQkApfYAY+QEdrki/9/7dTx2mClImSYY12t6UyrxWYyNBCPPKFjV2yXz9S2FG
gOJhC5YeSob+xdcyqP98S8ymr2gTCmlSQ5bdnP49qH6MpLFX2Dk/mWNSvEJ/z67E
btu9ZK4h8K1KYqBO3ln3lb8zuE2zR9Jje+D5xvDPoYWZjB9LR8PBFGniKzcFPGEY
8gMia2gbzPa29S0ZGUU9UPslGTmpVgnPVYEP8LtJ388KIwxmqE+i4RMpV2pXrzOt
ghnaRRqQWeop4ABBx8sij8JxL/IwiA==
=oMyn
-----END PGP SIGNATURE-----

--E3BUwnto89aV56vNJvx76nv4e5ivs0YTa--

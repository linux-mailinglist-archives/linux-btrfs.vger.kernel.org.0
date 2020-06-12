Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5391F73FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 08:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFLGlj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 02:41:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:43967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgFLGli (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 02:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591944094;
        bh=DPjYgGfU7EBZlxM8+hF9UJyxXh6B0UCAYz6TKrVXkZg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=W9tOBa32eGtnUacY8yiMa85hV82qnsd3D7buN5ljSuVZc6aLHlMI7+bVrl2T/8AyQ
         yAMdjAdf3vNB2PH94rfE9aUjfJefL3ffDyoMkDWzaZJydfwY9ejcH0C2oT1nPmFog2
         IsWySMZVxq+uzSH3QOj3TuqO4qH74jsD5DcunR38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1jVPub0Sr6-00KxOq; Fri, 12
 Jun 2020 08:41:34 +0200
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     Greed Rong <greedrong@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
 <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
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
Message-ID: <5e343cdc-de83-9273-6f68-1a4dbedf4a32@gmx.com>
Date:   Fri, 12 Jun 2020 14:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sGbmUOjweH7cHz5hkgJLaEF7YTaFPr9qJ"
X-Provags-ID: V03:K1:0qs2PvLz0MOEN0HWo7lLWdn4TJm6yI7R4cGJfwastxQgy7S/rQg
 hjWxz2J9XoKVUuXOyDkNWcZi0ZWev08bjDJRtZfEpqLL41Qr/U2mzNRifUdeHJMDwheJTG6
 ay3Yd3a5LjngMwMXJOq007JRT8GQyNinPgmMTSZYDbNbf69TjT26bO1jeIq+ALVMWX0Kaj0
 ROwx2AK1xg6jt+IHCohGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ncZtmr4prc=:FVpfStveyIMqABu8OjvA+4
 RvDj5aDjb5yMY1Q4jXIfoMYHSyn8IlV3eGn4mktazlb0AAqVEUx/GYI53eusX8X2KDGCjS5UW
 OjhL61lFsI0dKIcDxOmmmFkXC3F2tY+QadVAXvZ0oaQ12UprLldfbVhpzPUVlPp344dYIfpod
 9WKhdCPx2B6BNofRF4I8NKk+iTJaXbq5/scLRAwEzMqtoQ+g1QFDeqBLTiqRQ7lfTBC7J+871
 PtzJV24927v1h3RcF52QaTDRdw/S5lg/J1UFbtI9f5Xda/WRg+3I9AWFRXpD5Ls01xWXKUCL+
 T0dhQlThouTavT1IGA41/sRrj6iP4CwhigCSYSwjFQasG7rxdD/Ftvj+q34K5okMdF5o/itX7
 GayjBnXQWYZ2RNNdNGZfnzLzY/GC+UvfyOpF8AIn5oyKCXgOTOFUXGGLHWym/SgRHiBM1iZ1/
 rKxQmTZ3q2b9/+GjThte4pmgoyqoR0mojVRM9lrAqTc1suIt400WouoCY65mc35HHMWBrGFOR
 9QfuqIPxj/oSmueIQ26XlJ0cs5NrmQAETgJnXkSVVaDNqJtBWH2Gb7P464xQzQ2IoSsOe7son
 XPXgLxEefjhKzuLDAt7hpLo0xrsIoPwLOZYBtjaGDXVdczF+bO7y1DbAtrj0XfyJawe3IhK4r
 D762j4FBUz6v6Wyjar/VUUupgdgTe1V/8aHMq3sJ78iQpMTCcmu+NmfVRjRPzGIN6bE23aUem
 FNBEFwHftnjn2oVkT3HrrobbXyuav7GWTSslRq7z66sf4X5Zh9fa3wcXcBTilOa1oeG5ZnXID
 yYj3ONpUbk6MfKmG8kTvxt3eOgyCOagfUK6+XrvYmfndKrY5CJUENYdX+HxEnK3L0PV6m9Pam
 5LQp51c88NUM3pFuzkH62WxT2neIRhFTEGJ+tgHXaSmgx2JP6M2hIvlpDrSHonwEp9B20ZwZS
 DyJWfnC/uPPCpKcfNYkyPFYVUeCSzMUQbp6aC4FL8Ao3NScW0g82X5FCUlbWYN1rSCfTCO1u0
 geT9q2FuRXinnnLmxXdZF7TN4zWpAHgyjCFAmfggIiun+p4mZXdEhSQGZfay4hEzQngyilIpL
 VJ3bOGYgxumXLgim0/IjksIHJeaXYbRWHdf0XswJs18TYKhDFKjnbVDbbnxWMyFv00FiiDqT0
 U9bmrMVj+19jEuuRex/B2kNoY0TSYl1wzPH4DLtjgu326yk8LMGhjGVrxZnaCYWDMUZD9/Lgu
 NTf+iSyYlp+QRQw5o
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sGbmUOjweH7cHz5hkgJLaEF7YTaFPr9qJ
Content-Type: multipart/mixed; boundary="oGT9088RKY2m7rjCxcFksJmEYRLJhfLZi"

--oGT9088RKY2m7rjCxcFksJmEYRLJhfLZi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/12 =E4=B8=8A=E5=8D=8811:15, Greed Rong wrote:
> This server is used for network storage. When a new client arrives, I
> create a snapshot of the workspace subvolume for this client. And
> delete it when the client disconnects.
> Most workspaces are PC game programs. It contains thousands of files
> and Its size ranges from 1GB to 20GB.
> About 200 windows clients access this server through samba. About 20
> snapshots create/delete in one minute.

After checking the idr code, for anonymous block device, we only have
1<<20 devices to allocate.
Which is not too many, but should be enough for regular usage. (Can
maintain 12 days for one snapshot per second).

But in your workload, the snapshot creation is not that frequent, not to
mention snapshots are also deleted.
Although btrfs snapshot deletion is delayed, unless you're not deleting
snaposhots for around a month, you shouldn't exhaust the pool.

Have you ever experienced strange performance problem like creating a
snapshot taking too long time?
Or see space not recycled?

Anyway, I'll send out an RFC patch to explore the possibility to use one
single anonymous block device across one btrfs.

Thanks,
Qu

>=20
> # lsof | wc -l
> 47405
>=20
> # sysctl fs.file-max
> fs.file-max =3D 39579457
>=20
> # sysctl fs.file-nr
> fs.file-nr =3D 5120    0    39579457
>=20
> # ulimit -a
> core file size          (blocks, -c) 0
> data seg size           (kbytes, -d) unlimited
> scheduling priority             (-e) 0
> file size               (blocks, -f) unlimited
> pending signals                 (-i) 1547267
> max locked memory       (kbytes, -l) 16384
> max memory size         (kbytes, -m) unlimited
> open files                      (-n) 102400
> pipe size            (512 bytes, -p) 8
> POSIX message queues     (bytes, -q) 819200
> real-time priority              (-r) 0
> stack size              (kbytes, -s) 8192
> cpu time               (seconds, -t) unlimited
> max user processes              (-u) 1547267
> virtual memory          (kbytes, -v) unlimited
> file locks                      (-x) unlimited
>=20
> On Thu, Jun 11, 2020 at 9:52 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Thu, Jun 11, 2020 at 08:37:11PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/6/11 =E4=B8=8B=E5=8D=887:20, David Sterba wrote:
>>>> On Thu, Jun 11, 2020 at 06:29:34PM +0800, Greed Rong wrote:
>>>>> Hi,
>>>>> I have got this error several times. Are there any suggestions to a=
void this?
>>>>>
>>>>> # dmesg
>>>>> [7142286.563596] ------------[ cut here ]------------
>>>>> [7142286.564499] BTRFS: Transaction aborted (error -24)
>>>>
>>>> EMFILE          24      /* Too many open files */
>>>>
>>>> you can increase the open file limit but it's strange that this happ=
ens,
>>>> first time I see this.
>>>
>>> Not something from btrfs code, thus it must come from the VFS/MM code=
=2E
>>
>> Yeah, this is VFS. Creating a new root will need a new inode and dentr=
y
>> and the limits are applied.
>>
>>> The offending abort transaction is from btrfs_read_fs_root_no_name(),=

>>> which is updated to btrfs_get_fs_root() in upstream kernel.
>>> Overall, it's not much different between the upstream and the 5.0.10 =
kernel.
>>>
>>> But with latest btrfs_get_fs_root(), after a quick glance, there isn'=
t
>>> any obvious location to introduce the EMFILE error.
>>>
>>> Any extra info about the worload to trigger the bug?
>>
>> I think it's from get_anon_bdev, that's called from btrfs_init_fs_root=

>> (in btrfs_get_fs_root):
>>
>> 1073 int get_anon_bdev(dev_t *p)
>> 1074 {
>> 1075         int dev;
>> 1076
>> 1077         /*
>> 1078          * Many userspace utilities consider an FSID of 0 invalid=
=2E
>> 1079          * Always return at least 1 from get_anon_bdev.
>> 1080          */
>> 1081         dev =3D ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORB=
ITS) - 1,
>> 1082                         GFP_ATOMIC);
>> 1083         if (dev =3D=3D -ENOSPC)
>> 1084                 dev =3D -EMFILE;
>> 1085         if (dev < 0)
>> 1086                 return dev;
>> 1087
>> 1088         *p =3D MKDEV(0, dev);
>> 1089         return 0;
>> 1090 }
>> 1091 EXPORT_SYMBOL(get_anon_bdev);
>>
>> And comment says "Return: 0 on success, -EMFILE if there are no
>> anonymous bdevs left ".
>>
>> The fs tree roots are created later than the actual command is execute=
d,
>> so all the errors are also delayed. For that reason I moved eg. the ro=
ot
>> item and path allocation to the first phase. We could do the same for
>> the anonymous bdev.
>>
>> The problem won't go away tough, the question is why is the IDA range
>> unnamed_dev_ida exhausted.


--oGT9088RKY2m7rjCxcFksJmEYRLJhfLZi--

--sGbmUOjweH7cHz5hkgJLaEF7YTaFPr9qJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7jI5kACgkQwj2R86El
/qhiGgf+MXCnmCVmoiuu7EqCo+31R4qXqTPSt8NRJbwLK5f3bAvi40x+X4lb50y/
OE8WOlqQLFdqQ1HJdPgetdSw1IzVx/x0vObOhdyd0aP7K6/8v7cM6YjFEBfHXmUv
u0jmnKNegWAKAAaoz7JH5WEtObC6QHsKiUVjsjjODSw8wMLZcVd87D95FeZEQgGI
v8SSnwC3pGQnfKXBIfzChSmVI9hjjv7pjq2HrJi8B4cvB/2YEGIno/mlO6I9PgHk
21ZetaKdp3HVGbvL5Dthda20OCez8Q39c/HGAbfbtNltp9s/PykKJLR/6VlC9NxD
oK7rp9ECDwZH1AjObvcA7oggTSdISg==
=9qR9
-----END PGP SIGNATURE-----

--sGbmUOjweH7cHz5hkgJLaEF7YTaFPr9qJ--

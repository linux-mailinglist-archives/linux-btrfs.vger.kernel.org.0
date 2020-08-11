Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6302414CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHKCGn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 22:06:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:35237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgHKCGm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 22:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597111598;
        bh=TNYx8VhIoaczniLESXDawhbc4c+u1a4RfTT37NjWcRg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=K5COz3OE8CWK/scPSQZcW9mNggc5pVYSnnFlWVc7Vh7iCRvNOxNtt9pNanHyssA8e
         5ND5QcHHq1TFXYh2qzLcczaXPr338JcvgVDN8cM7KW5iR2LNKJynb/1hemHo++vYlA
         662SIUdDzxyl6fhtFKFh5cO3bdqwBIC7U6/bchuE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS5A-1kYHpu19Io-00kvrB; Tue, 11
 Aug 2020 04:06:37 +0200
Subject: Re: [PATCH] btrfs: sysfs: fix NULL pointer dereference at
 btrfs_sysfs_del_qgroups()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200803062011.17291-1-wqu@suse.com>
 <20200810170255.GF2026@twin.jikos.cz>
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
Message-ID: <5a2bbe37-ddb4-ccd3-8d43-49bdb9697777@gmx.com>
Date:   Tue, 11 Aug 2020 10:06:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810170255.GF2026@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XiBC8HRog7y3gBNVlN0SKDmKdKO3Lnmzd"
X-Provags-ID: V03:K1:OqVCIJGov6iL8OLhhhX1eILuGSyyuHCDDLaWicpHnKM1M9FLiIF
 pn4VJA5wW17hhYfACH7opm7Vv4oOAKaZ3zd7PwW0eSeYhg7mvD2osgk9lmCGKLH72lAbukc
 aVfNyGl8+cSl+DIp6k80qePyEi7lcbV18RSmuUDKoxDHErG5ev0CVb06t+CMVijpjSZpD5g
 ILIBNlxc04gfwdt0Un8JA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jT4kXYE5uSA=:36qt8AyRiOOW2BcurzDHpv
 7eu1sd0knoBzXTBM19K1KrVTck0q6Tvv0ONuu1BdeGaTcUw0i7R3e8Vg34DsEije4MNKCR1kG
 i9ZcZrwp4E5K/eSDEyFz3Z1dK1fr3LtEaVeU8qX3aGyTZly85aL7Y92pjnMcKYe8VBZ5MFEP0
 a+x9zJ7m2n/xwsqc9CCJK6PLK5EIF32WFPKDAiwMWNVx+BBY5TaOR/1QjdEsF8AtDhFrXTovb
 m/vmVxyQZ9GDEdbTwcqrS+vyWFQeQF1Co5VDa7qUxXcesGfFS2R9ubtlEWsIPzarVfhB+tlsq
 LFCesAjLe0r3oINNIu1XA9+y8t/Rwv4lwCRmf+ZIuWb0lJiBDmZmR65I5wrKLFoLqvcdPDD7d
 SDpb/NTplDkWE/xGFLL9DGpHW49ogs1tZuL+hOHsYhcGeSU6LQYYojfrhzjaLwER9u1w1PUjE
 87NZOrYPegiSY5QePhyTa3DpXANgU+QY0IM1C1AZMRDeVXXfts8iFjfL4EZPCcb1TD/76UEci
 Jssd1C36j3/Kag47LAqeu178NBM9CpVK7WNIlVAaiKf9n2PW1nWxAeTk+vgDdDQoGUbW7uSBn
 AHm7O2jRzfhPTDKogV8gWTlqSHMfnEfixqZcZtTPmiEbZ28FiJ61dLCE2P8cNXn9fJcB9jy7H
 rNHghygx1Aw4Se8qbhRUVz+BPzsL08bXPJoN70rA5E5dt8IG0sLncE9B25reHhC/Xy+AuZNs8
 DSimkJXNot1OGwkoAWO3EtoDuNp5zwQcMIRu47YVUUnpd4qXbGn6U0wTp+3rhAEkhgcyLsQ/5
 xeNkMeH2JlZhonWOWX5mM3/ipZnkOlolaEo+TZPOjERvvldEiG9DF95N4lBT42/bB5cySNp3p
 9nny52gA1x1ve6rbeGdJLj+8Dcb5yceQ4fb1pKsrf1OAt1xbHzlDP2dRaUvuWQfYB3MTqvhHq
 z6IlAbM7ep01wQptYzIenYvhtq4BkV1NT8mmfmhVbeIC1lEmyCH8wsO9cZeWULDHpGOKtKvLs
 loTx8BgpJxBzO9U4JiqJL9z89HrdcbyV8HFaHruLSC2tgCFyjHjexNbV70oGIOLbsETAtuzWL
 w728O2kyJhmhkvP8Iju5UonhhzmHB4E/5i2A3hE0y/kMk6QF12uTMCPEFxg46frFqlPhxjJHu
 07FwEjj1+JIyfqQrmVXFmCpyFTyhgZDg36eH8T8IAm4Ia7aB6qMfUj1IJ68y7wDRGcjaqy+vn
 DEqWxMl6CR8FI+Q+RD3Ptb36msCiBHQf+ymN6LQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XiBC8HRog7y3gBNVlN0SKDmKdKO3Lnmzd
Content-Type: multipart/mixed; boundary="qlkTomUy4t18LX74anMhQEImRZNVneca5"

--qlkTomUy4t18LX74anMhQEImRZNVneca5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/11 =E4=B8=8A=E5=8D=881:02, David Sterba wrote:
> On Mon, Aug 03, 2020 at 02:20:11PM +0800, Qu Wenruo wrote:
>> [BUG]
>> With next-20200731 tag (079ad2fb4bf9eba8a0aaab014b49705cd7f07c66),
>=20
> I don't think linux-next commit ids are useful, even the tags get
> removed after a month so the exact commit causing the crash is what we
> want.
>=20
>> unmounting a btrfs with quota disabled will cause the following NULL
>> pointer dereference:
>>
>>   BTRFS info (device dm-5): has skinny extents
>>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   CPU: 7 PID: 637 Comm: umount Not tainted 5.8.0-rc7-next-20200731-cus=
tom #76
>>   RIP: 0010:kobject_del+0x6/0x20
>>   Call Trace:
>>    btrfs_sysfs_del_qgroups+0xac/0xf0 [btrfs]
>>    btrfs_free_qgroup_config+0x63/0x70 [btrfs]
>>    close_ctree+0x1f5/0x323 [btrfs]
>>    btrfs_put_super+0x15/0x17 [btrfs]
>>    generic_shutdown_super+0x72/0x110
>>    kill_anon_super+0x18/0x30
>>    btrfs_kill_super+0x17/0x30 [btrfs]
>>    deactivate_locked_super+0x3b/0xa0
>>    deactivate_super+0x40/0x50
>>    cleanup_mnt+0x135/0x190
>>    __cleanup_mnt+0x12/0x20
>>    task_work_run+0x64/0xb0
>>    exit_to_user_mode_prepare+0x18a/0x190
>>    syscall_exit_to_user_mode+0x4f/0x270
>>    do_syscall_64+0x45/0x50
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   ---[ end trace 37b7adca5c1d5c5d ]---
>>
>> [CAUSE]
>> Commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing i=
n
>> kobject_cleanup()") changed kobject_del() that it no longer accepts NU=
LL
>> pointer.
>=20
> That commit reference should be sufficient.
>=20
>> Before that commit, kobject_del() and kobject_put() all accept NULL
>> pointers and just ignore such NULL pointers.
>>
>> But that mentioned commit needs to access the parent node, killing the=

>> old NULL pointer behavior.
>>
>> Unfortunately btrfs is relying on that hidden feature thus we will
>> trigger such NULL pointer dereference.
>>
>> [FIX]
>> Instead of just saving several lines, do proper fs_info->qgroups_kobj
>> check before calling kobject_del() and kobject_put().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Added to misc-next, thanks.
> Just to add a note, kobject guys are going to restore the NULL-awarenes=
s
behavior, so the patch here is just to be extra safe.

Thanks,
Qu


--qlkTomUy4t18LX74anMhQEImRZNVneca5--

--XiBC8HRog7y3gBNVlN0SKDmKdKO3Lnmzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8x/SgACgkQwj2R86El
/qjJGAf/U4tyAnQX37JRn1e2/B1ogIQ8KDlcdk8dPC9yevAG0j65VHig8ZwZUpNL
zAmHJ7N8V4s89B6LiElEXfBkL1rVF3W1Z9miVuo0t31lhG7b5lIeMM4V7uxcracE
s7NVGO+hwR24ZUeKm2K4G6Q0L8XQXkogsK4wBztn3RZ3tPXeJK8ueUvIxDprEv1f
c6NGftOYYV+xoyxfE4J9gmsCa7SeTI/XmabY0xBaCkH2yyYoCCC3/UEsYNaAdWbP
VhcLCQRQyCq1Dyuz0TDvvzE3Eh/IAUShKPfVynSx+5EpRhncD1oeUrQjsLghxMPO
+X5uU17Z0EcCQ9Jd6hiiVHOinU/tMQ==
=hcFI
-----END PGP SIGNATURE-----

--XiBC8HRog7y3gBNVlN0SKDmKdKO3Lnmzd--

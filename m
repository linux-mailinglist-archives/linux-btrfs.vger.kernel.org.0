Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A271C9F71
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 02:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHAIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 20:08:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:58933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEHAIo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 20:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588896518;
        bh=GxRiHUxYrUSzw429CSMDt1JvcXCWICXdTiVHpCkBuO0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IfwIJO0LMkwCUyuDVuOQCk/0RvgoOZ0IGIWuY19NiP8WV54sGBuJp2xfzB3p8493q
         TQFBb+6aw7H1wKzvpsWUhJ8Jxw21Ae0b5WoYgnWpQDik+FCtuuhpoIPDMz+Sy8GvQm
         XiSNWosrcIZe8S8sudQTf9tdcqO2QnYL68zAoWQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1isr7S1hSh-00fg3c; Fri, 08
 May 2020 02:08:38 +0200
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200402063735.32808-1-wqu@suse.com>
 <288d0020-380f-717e-ab05-3fe6dbc64cd5@suse.com>
 <20200506150448.GH18421@twin.jikos.cz>
 <c3c68cb4-4d7e-33ae-54fd-b4202148689a@gmx.com>
 <20200507205110.GM18421@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <397ff8cc-af58-6523-b2dd-d67474ce7d38@gmx.com>
Date:   Fri, 8 May 2020 08:08:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507205110.GM18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VXZGIBnQG1hyVFHh4SuETXOmD8wriZOFH"
X-Provags-ID: V03:K1:kBfaFnTzr0MUyTQVLcijTW++vXOx22BEBOIPspuGDkKBSzniBey
 PRtZNQmZ+sJgVHWmdiOEStH9NO10+eEfICQG165hSDck7snKM9hjmG1SPXOjsDUhiMkObZV
 H9AJQB4FcHAXZDngyZIXWP77tjzjlRuo4dXmI0gB56cGSZDzaok/w01F1xfGVa8XDTskobG
 WS9QgwdNL2/MbpQSQ2+Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0+3EmvLAvAQ=:rHnJcfU8FKw8HL9hL1N6TC
 MJ15eIrmDkytXKjugOrC6a1ZSI63Ggw/6EViEA+inEgyt+PO83zvd8aKz8KwiVw8QPR9mCMgC
 Rbvh+DZ0yPCZpIAzKoEKjRRr4RLiJ/VyhYAc8uLmWkFnHTd/+wS0rbfuRlZpHF+HkQwdFPohJ
 Fdl6k+Sm//YY/vIe4lWWF/Jnslgh1QIii8NeNNq6I/R7MPkbwb19295qYBr5G8TTF0hWn1fCQ
 6DCGp4Y/Yp66tFl9s6CCSbCNFkoBvPQKJYXo0OABEJkfp/y51HigiUKBN39sPJSrLrmnx8U/r
 x3F/l/juvrWUDWsM2zwZhbia4OkHlO/lBVoUKxER05fMTQryx6WYFk8cJZKtkNO0uRQbY2S3Z
 RmeCLg1K5djO75GrL3jYx4mPnWovCXWDas+2UzHbBTyAyRVpGbILkV6I+pyQMt7XZPDKdUOla
 ZkSrrprllGNi7RrR8JCen6DSOA59ihFCDbXLvwLJwklWejBN6xcYiVoPT7i68+GIFbm0sbWqy
 ohsfFquGs9DmGNQdZL5yxx3cAG7fwRoAGigv4os//EluDEXiG+2yjuxhrfWyfUmVp+TE9/rUm
 SAtxvEbiFUiDOtRkciYiSHvhDxSrNe3rL7V1V2V1WYs2p+T+dVSdQcIpt2yTQFVuwbcxlnDPb
 niFXN/hxe3Qj5sv3aeqIJz9x9P4PgJpgHxFcxWQe1x2I7l/VELa5w1HV3o3M+7nEVVdUKsMFE
 CwpTSdpfmg3UagQs68Xz0OVGaq4qwHYziIuAIpX3C1MadUDwvqTwVTYhztZGDM0CA5i88oNM/
 ZDjWtBktB1aFGWi+5HboYOQoNJKdltfS/Hx3G+UBncpqVCGQgL+oy2VWfVQfMC6edWOlEHNNu
 ZAHSZUTwu2WniKok2rTRknGR1/qufGfj+zENDsAeQDpYE3OLwudm11/tEYSiS7FxAGiqyvIle
 +DmkZxnE6sNIsH47kWiSSUxfySMrpIslmPwCN7BdR3vthtNwmQ4R2epcwb6cevizStz5viR65
 BApeY2JjybPc4H2D9yy10Twr9nsbpmAvrS8Kd37QOrGx4Sonv1gpybGaMjO7VyChlG1IfIgNj
 kKziRXUDGw0I3M9RNogcsu2ejZLvQa4MOgD59+30mjK4f0bi4G6iC+GXkGcodxd4f/83pBwhv
 Adx7punBvDwFKDjOTESNnNrbxBOkF5ukP6k0i5ak4gFuhBzIq475GcMT66Fp1AN5Uf5hVfx96
 7x42DhNILJmehjwjH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VXZGIBnQG1hyVFHh4SuETXOmD8wriZOFH
Content-Type: multipart/mixed; boundary="NkKsAjPR69kzKYGFHG0I0C6Nwxiv9IImN"

--NkKsAjPR69kzKYGFHG0I0C6Nwxiv9IImN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/8 =E4=B8=8A=E5=8D=884:51, David Sterba wrote:
> On Thu, May 07, 2020 at 06:48:24AM +0800, Qu Wenruo wrote:
>>>>> @@ -2809,6 +2821,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_h=
andle *trans, u64 srcid,
>>>>>  out:
>>>>>  	if (!committing)
>>>>>  		mutex_unlock(&fs_info->qgroup_ioctl_lock);
>>>>> +	if (need_rescan)
>>>>> +		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT=
;
>>>
>>> This got me curious, a non-atomic change to qgroup_flags and without
>>> any protection. The function is not running in a safe context (like
>>> quota enable or disable) so lack of synchronization seems suspicious.=
 I
>>> grepped for other changes to the qgroup_flags and it's very
>>> inconsistent. Sometimes it's the fs_info::qgroup_lock, no lokcing at =
all
>>> or no obvious lock but likely fs_info::qgroup_ioctl_lock or
>>> qgroup_rescan_lock.
>>>
>>> I was considering using atomic bit updates but that would be another
>>> patch.
>>>
>> Isn't the context safe because we're at the commit transaction critica=
l
>> section?
>=20
> I don't see why, the qgroup_flags could be changed from ioctls, eg.
> adding a group relation and other places. Without protection the update=

> can race and some of the changes lost.
>=20
Oh, you're right.

Do I need another patch to address all the inconsistence?

Thanks,
Qu


--NkKsAjPR69kzKYGFHG0I0C6Nwxiv9IImN--

--VXZGIBnQG1hyVFHh4SuETXOmD8wriZOFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl60owEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg7KQf/UJT9EjxKLNeVh+evMKms4s9g
VfhF+uxUpQH1MSGTZJMtGn7AcbUdoRi6zPYYS5BsSHG9+2waH8dHDDaV5ryCez/R
HOiEhBC4tVMabJgkYfKBWbhvVnF6GkSt6v4ZHCYhxrfNExiEtN9V2M5QXbP4qPKR
Oq+ltGkVbtsdknsn3aBSS7sOUqUEGKolaHwA9/ziuyllXhX5tQUf6Rh5FNc8b0l8
t23w3hri+OlN61kU10uHG2eNXfc3PI/Z2X0frLrQeSaEzsoSkSsyNkK8t2KlTJoi
k08zbGDKJIr+9EsrT5FFkQZT5F55I1qT3S9SrW2LEpWxrvWIVIQvEFPflBMnuQ==
=iGic
-----END PGP SIGNATURE-----

--VXZGIBnQG1hyVFHh4SuETXOmD8wriZOFH--

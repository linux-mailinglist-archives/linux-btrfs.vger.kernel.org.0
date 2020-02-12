Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08683159E14
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 01:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgBLAiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 19:38:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:39531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgBLAiy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 19:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581467921;
        bh=Y8UocVLRWU4qWrC1WpnYhMhO15eZ4SnheWYy6JFQqUU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LA5FJe63iT9eEd0pxyg/eR1dv9gpIj9k6ozfedsCoY2Qa4LGy6rIX5McfADejNAhE
         Ebyn5RLG04VqWmnFEKa3WUwgKFOpZIcX/x0hfYq+j1MZbZkcKwxLISN7MsC7nJAzXC
         TSaUpPv4ICxVwuVIGru+ghEQMlSI232YUlRyV4SM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Il-1jVCP73TR7-013RUF; Wed, 12
 Feb 2020 01:38:41 +0100
Subject: Re: [PATCH v4] btrfs: Don't submit any btree write bio after
 transaction is aborted
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200208100740.81762-1-wqu@suse.com>
 <2f566d7c-73eb-8545-7c33-5cc1f6fb52f3@toxicpanda.com>
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
Message-ID: <2750a118-7c40-f62e-7898-6bf263162b19@gmx.com>
Date:   Wed, 12 Feb 2020 08:38:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2f566d7c-73eb-8545-7c33-5cc1f6fb52f3@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5uVahTn2KXF6JCvkAFCwLJNufArRBW5X4"
X-Provags-ID: V03:K1:bRwu13wE67JbeQy6423JzaT6xqzUzfh4WrV3zZgUZwL4utp1Bvn
 XPdcTBrkeWt4R79TGjlQamlPX4A12XhVwC231vAyu0XY2VfXeUHzG13hlVEKybfHyexk8sH
 RUL8hOhMgpYI3ino3gw9kQY7lbVvjNpfeuLwe1q6W6ZJuMmU6n1ziI3+v1SD1C9xrIP9TRe
 t5p76OmtCmZgAc11YmEZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LhGgT1Nh+4Y=:+EGMaeUx5dblop96PTt6Ga
 eDMzaTMgq5JfMqG/82F36Pu4F0PzspmGLDk7kKaxNC5XInaYQ1PArBzPEFqvt5mVB2acmn5Kg
 8FoHY4VoG7j9N7e1Phl8Tvmk1SEaLsLJvEXA0kSrtkufJA0SE99hnXq0KuvxdpMI1/2YbNHHq
 R9TQ+RcL/e28/GSRyfaNQDaWX++2YPSYmPF9DzjzxK0mmitt8EhV9C9h+4oCnYQLpB0dgOm+N
 9xzO9/WBiQHufHAwHdw6Reuqh1KZXYFD8lc7VJvC2y38w0i5jLroENXw9ZOHpKPcBtvCsDOSz
 pVvtGby6KJkNXYkaC4eLMLyr/ZNA9ukYMMvnARBrr0cdRao/JCgC/J0cYLIyqrouAB+a5jfYr
 i9ckvL2+3KCOLiEtd9YDJ9974kZ9F5Ln//Vgb1DkHIIQDp1aFRH8BuIKSDj/4ACBsEu71NG+G
 +I22zXOgtIFEhY700MQLsHer1A/1D97f2AnYmOoEqCssmI5mXlip0TgI4zOnVmiI2h8i4/Rzz
 KcY7oOt4eSCwft7W3iG1BIGldlXauoOAcnmKwdjBPECnvZvs2lnTQvPTEZVBOVM7MdYBhhcLW
 IW0RZTAQ3ArwBpfYAbknkPFUmCgBAGmWluzAZikmZWwxKwxsBhvqWDgjI90jmsDlaUi+q8nVP
 fGeVU3UQnJhklW2vjvSE+b0lDQ4k6LhWLp0N78vgOGwFISZaie6aVaLRoS/l78a+Qv0QsEHDP
 9ODq/4W0xd9au99hLNHGSbQtNuIV67nP2apMk7SzWWQwGdGx0oywUxEU0VuT+4rfiXKRnTmi2
 Sby1z17zF2QSlm5Iemr4z4LzCjnZwxuqilnmWyNGBC0xtNdS2lSUIcWvW9gOPtwSc+nw8YwHz
 O7Tvwsb7n1OTXTWuxYxmaVGZ17tdeLVbZ35/emLrJUVCylp+CYWebqix+VMyT1u6q7IKEEWyL
 9KNobgZRAYv0a7RZ2jdmpwzaiqQfVkcuapRne/I66lcbXg8pZJ0MljTVidxyE4yB8AmwskBu8
 mU4os6a4zDklm7H5YxMDX6Ft4KLwQb5QQnecx2SjprsEkmkjASUjxeDeC51A3lm/JhskSHxkK
 RIJVU0UmhcnHjRktApQQdylwlD7vneWsoMlAAbe6TAOJIBph4+w02pJX44B5ihX7TTROwkoSy
 nl/2saaowglCVX/oHv5PHdNLNy3m/AdgBFVopGLRJQ50+HfalQv9KDWoZ+nz7tlu8MR1njI+S
 piw39wo8r794wpZt+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5uVahTn2KXF6JCvkAFCwLJNufArRBW5X4
Content-Type: multipart/mixed; boundary="79RI4odgG9lCFxvPiEju8IGjvNYMeIGLO"

--79RI4odgG9lCFxvPiEju8IGjvNYMeIGLO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8A=E5=8D=885:55, Josef Bacik wrote:
> On 2/8/20 5:07 AM, Qu Wenruo wrote:
=2E..
>> But that would cause ASSERT() if CONFIG_BTRFS_FS_CHECK_INTEGRITY is
>> enabled.
>> As described, the offending tree block is completely empty during log
>> tree rebalance, if it's COWed for extent tree, tree-checker won't
>> allow empty extent tree at all, thus we will hit ASSERT() in
>> btrfs_mark_buffer_dirty().
>>
>> I'm not sure if we should go that direction. So I only go the
>> last-safe-net method.
>=20
> Yeah I can't think of a better scenario here.=C2=A0 We're dealing with =
a
> corrupt fs, and trying to work around the corruption in this case isn't=

> super clear-cut.=C2=A0 If there was flaw in how we were handling blocks=
 then
> I'd be more inclined to fixing the problem more directly, but this is
> just wonky and we can't trust we'll make the right decision for every
> type of corruption.

Another idea is, to check the eb->refs at btrfs_init_new_buffer().
As we're expecting a completely new buffer not shared by anyone else.
And it follows my old idea of rejecting corruption as early as possible.

But IIRC I have submitted similar patch before but didn't end up too
well, so I'll leave that as another patchset.

=2E..
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 Now such dirty tree block will=
 not be cleaned by any dirty
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 extent io tree. Thus we don't =
want to submit such wild eb
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 if transaction is aborted.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_in=
fo->fs_state)) {
>=20
> This needs to be BTRFS_FS_STATE_ERROR, because we could have tripped
> over some other error where we didn't have a transaction and never
> gotten TRANS_ABORTED. Thanks,

Thanks for that hint. Indeed makes sense.

Hopes next version will be the last version.

Thanks,
Qu
>=20
> Josef


--79RI4odgG9lCFxvPiEju8IGjvNYMeIGLO--

--5uVahTn2KXF6JCvkAFCwLJNufArRBW5X4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5DSQ0ACgkQwj2R86El
/qiL3gf+PaGAktGbhTrkUx83xYkJKDfRSO13C5wYFqZ8g7VFPOc57qiMBfiyd4c4
cf8v+iu/Z7VuBLf14osIu0wMXFbsTBsV7OGyL/cfOO458jhAeTwKbjeSoqjIo2Qv
xE2e6TjA+8TLWhxhuIReXF9l8prjqJ3ckUiWAUWV5MGwT0lIEltYQYgXuaAimt37
rp5szzeyDmFx2RWyQ6MzXS6d0MF6W9WRQcsYbmJTOauE66Ta+7oXaqrYKTqC6JVo
ju58i2+G+4F7vW7fDSa75VAvQ9CNO267cKzQ15+hbFIVTP4B3WcBJ307rclPy9oU
XfyNhjnXYVSsNVIbzYVMYZV4zNlmwg==
=g7b/
-----END PGP SIGNATURE-----

--5uVahTn2KXF6JCvkAFCwLJNufArRBW5X4--

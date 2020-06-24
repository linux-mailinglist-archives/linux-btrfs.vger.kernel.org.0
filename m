Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760E12071C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbgFXLGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:06:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:36415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgFXLGn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592996799;
        bh=iOjFPeLVFCyYS/kg3kfIXnkhXWqd3NZ5Z8ntXKfVkLE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N4aKn+L1hg8SxC0yMzkhsM247IY2rSBLjVwYE1dhErCiOlRN5EJhB18h0ExYBgNLX
         m6l1yWMZYSESOOvwqUa6TgWCnKI//Aar3sI+VLC7XUNvyivkNTQcN3P3CTQNK7ZMKy
         +QIruDu0THMhj2/ui5P3BT0Pc85/n7Ex9/Cr24wI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1jCmXO27dQ-00fynE; Wed, 24
 Jun 2020 13:06:39 +0200
Subject: Re: [PATCH] btrfs: start deprecation of mount option inode_cache
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200623185032.14983-1-dsterba@suse.com>
 <b8fe50cc-02ed-4170-c84c-d994fd489a98@gmx.com>
 <20200624110019.GP27795@twin.jikos.cz>
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
Message-ID: <78e85a4d-2484-3e80-0347-85f7658f3a29@gmx.com>
Date:   Wed, 24 Jun 2020 19:06:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624110019.GP27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PyB4svim17B56OYyxE6pDU8nmMqQzLfqo"
X-Provags-ID: V03:K1:tPpKisiozOiix2z5m83u8+Se/lnkx0cgi2qcI1wS+mbwLreP1R9
 ldAJwxE8VeQuyP4EmBthBLIk8NEt0Lshe0ZnJNaJc2ELAP6hJKQ05gO+ki0wpkdkFa+6Vrx
 HQXAVoP0TLHsGb9lzVcOQgZhX6gEW+2QB0hOlLigdaLiYPnyIXYFx8USmxvlMRc7YRifNtc
 PdnRX0pcdREB6ewzdem2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HDLgR/9voFQ=:kqMcA2sG43IP0d1ZXviQ/l
 EC0/NPg24muGo25x69NiC5Jhp5nCQfD4c1asq0Y+IwPx7I0VtWzB4c64l6gpOeagSlem5cA4f
 nK3Xq32pIPwTUBzdbdRJaaQEdDP/GpDBq6JS9RSQCd2CccI5j6Gkd0WJVkAPeb/RbqvOTuGf5
 6Lqi7GijJyE7CAAQqG/g2hlxWVRIP0xg9+6yEEDvYo1OokOp/bdHY1PeqQ5PIVRCg9FinRnhK
 ynxZ8OS2Y1UzoI3RnDJ8xzpmMIEQJIkEm4Uf2gUvbqM+EJTYBidL2jU5UboXPBMrwWlhXftYY
 VzlT/8J0T+yhweULAPI37D7nd8z0RG+vcjTH9Jurjz1UGOxAuLXjg81tJ/OxX7S3cC6QGAKex
 bUNG8vFA7TPNygqAXPgnmLh31EfFKqa2e87L2a2gpjQbpQhMDzvxhNYC+ABR4Pqdh0DGirS82
 skX9y6GLvHhetFK9pd816oonB+iAEYczZLWTAGqqIehV7GyV42dpwF2ftehfsUoyPFboeVMAB
 Ss2y+i+3Tc33UvA14cP6ENHaBipNFkSB6wjcS2XMUHM1WhLka5bG2EDOfc7l9J42hRgMBgacT
 sKzgoQ7xt+plEgsiv3yG6fsy0/HZexnPviIVMxWSMTmGLafsTCfGgR7Pc/cT0KUqZ5uINSz7F
 TgBxoJSVp8CC/q5Ju9S8BPsHokbmcwCOM4L9YZ+hB8NjFNa715HFOU856wnTkUB4apRy8g60/
 hGXzbo7+XnqeJl7SLLNvlG7TZQYy7T1FMV03TQLsyjMp9y9H9d5idmQgBbZO2w4qoCRjcSD88
 8lN40O4PIPPg4IxGE7OyXo0WOH3c8TTVosGim4x8I62BdzHzYS9gaIdB1TFrxnmvuXSVBUjWJ
 b3RolQcAOpyKkBJhfsjWCHE3KvpEX44T2+BgGR7SQSwOKuEifLFn6bag7W0DAFhemqvCTxviw
 l1zbfnPfYfuCiSCVbya3UKI8z6epaEv/YNnP2+1v3UNLRn8MLgzA1w77ekSYQLy93KAsmanUE
 9QADIvIzIAnwM6Pyxq+kqch4vnJoDxfBqFd3YsHTm2HHbvbKwRm5ur6kSZ4jkdQHyYyxwxt88
 bIS7Om1zwdahf10ozllOQ2je2k1I7N9Z7O0cPnjkLBB6Q3zmq0r0g6QKWYRqUWFlbSALZxDmX
 eyqYTLY4V7S/x1OjTRWUh8WI11YLNkV0OblDFzbqMYQ0BmrI4BeHGqnXKD1VFNCuu1+Yoz995
 vA7CDQdfqwUB7XRp4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PyB4svim17B56OYyxE6pDU8nmMqQzLfqo
Content-Type: multipart/mixed; boundary="T9iPvF71UB5Dr91zKfeU04GKWdlOfd5q8"

--T9iPvF71UB5Dr91zKfeU04GKWdlOfd5q8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/24 =E4=B8=8B=E5=8D=887:00, David Sterba wrote:
> On Wed, Jun 24, 2020 at 07:27:46AM +0800, Qu Wenruo wrote:
>>> Remaining issues:
>>>
>>> - if the option was enabled, new inodes created, the option disabled
>>>   again, the cache is still stored on the devices and there's current=
ly
>>>   no way to remove it
>>
>> What about "btrfs rescue remove-deprecated-feature inode_cache"?
>> I really don't want kernel to do the hassle.
>=20
> Most likely we'll need both, the kernel part is for cases where it's no=
t
> so easy to access the filesystem unmounted to do the change. Like a roo=
t
> partition. How to do that to be least intrusive is the open.
>=20
OK. Then what about do it in btrfs_orphan_cleanup()?
It looks like a perfect match.

Thanks,
Qu


--T9iPvF71UB5Dr91zKfeU04GKWdlOfd5q8--

--PyB4svim17B56OYyxE6pDU8nmMqQzLfqo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7zM7sACgkQwj2R86El
/qi5/Af/VZsknBhvEK5zjB96E4FF7/PPOYnWN6Cv5JOwlmuBqh1mChPmz5w95grA
vMwVI4WU6HKtbJz8RgcBTsNNQ1hxhtm2Zj1mOy9BZwnEs64cD/7NpzHC63xjLDoE
iq6Z0Sre2uEJuIdMcFEsJKsgVPIZVD8JrRp+HwYSlPN0n6WpgmD4TJ8r++J/54yQ
4DrgNpf/MhnFFovuy196NgK/1Jl8RsI0glZT6HbT4Cbce5htWLQ/9opM70fBp0LA
v8pYBJHtPH0T9ak5sVNm9MvMI5UmiJTViUZEQrM8nMHfsYECsYUccR2HFmx7Nv07
pEDXGEdq71RLl3eyTWvaKZy9tUgcNQ==
=JNub
-----END PGP SIGNATURE-----

--PyB4svim17B56OYyxE6pDU8nmMqQzLfqo--

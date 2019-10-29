Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260CEE81DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 08:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJ2HJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 03:09:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:43337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfJ2HJz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 03:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572332980;
        bh=E9yS9xiIohHXUUaON2izs3RtZ2M7RuDppHB441rsC0M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lDEsOk+UvJ6Gu5IQs6bPpER6W6jP3RUxbHc3xcES07p8z7QLwjWHE9s6eWeCgQqiF
         qW1SKPyPzk4AHKnk1pN2TSxJ4spHabRtWKcP3dVvq0zEoPaiX/TIS/WTzKfxtFeBqJ
         yTUdxb1rCpgCG+/Z380cKjbTHljuoFVcbtpK7kfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7iCW-1htmJF1wji-014iNM; Tue, 29
 Oct 2019 08:09:40 +0100
Subject: Re: [RFC PATCH] btrfs: rescue: Introduce new rescue mount option,
 rescue=skipdatacsum, to skip data csum verification
To:     Roman Mamedov <rm@romanrm.net>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20191029062149.217995-1-wqu@suse.com>
 <20191029115317.03b43d94@natsu>
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
Message-ID: <7136fdbf-364e-8b00-c078-fb77b1b9d751@gmx.com>
Date:   Tue, 29 Oct 2019 15:09:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191029115317.03b43d94@natsu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cHty9Egu3BCZwBp1OYTLnvOLE4PPaNJjM"
X-Provags-ID: V03:K1:8s+ooiBKcrrmYfVgnvQRlHJ0cuNdI5qLlrEhj1XdvFEWUbXrMR0
 wWtJ8gon4UiYC+Q9wWOCaZpfYH/x9Ac6TOyFGIRHbKipcmFM2pF4mmovAXynsnEbxNVT2+O
 Pke3OlVWQZhsZX4JcXdHvmHWbT40LyZ7qC1yNYlYT11t7icWZhzjMr8fnKHVnxlNIrJ4SIH
 635VSqNs/dKdQ9vLoIdjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MdtTfVBK3zE=:zsQkcG3k+ILspoO9mW1MMw
 D6Yb8dxr/LeRYVuLLmSUfBVQdyV4xP9xB7EyZPPpFN3Q8HO2ueFgUFSlN/yT4LT5dOQygPE8F
 qxyOaQvDfMS+wXiOs/59ntjMv3mrSeSlE+3kD5AEUIqqwdeduyshwJAD/1ich5mdU/cwzdjjz
 sPmQJXoOuvy0WTaaVNlbD67LmJjVZ5oF5AXuGhOKxPsV+56IJc82h3hwHvcoznjIiUnBvNRWM
 Q4FKzlFGIDa1IhbmDzuIvGG41nbxSuV0fmN2zRDmj/OMcMVvVlRDIngYEAuPWWgHWYcSHHi4a
 27VKwEKJQD9FcfyO0nw19BrKQmjXtuhHGlZ7psjB1cYSm781fCt9ZByRF3Zc14BRnWtyY6EZI
 CaXlpHwRCUcMsx7TmQCn5zOE3oxu7ZQ5Ip+zk6TiyREXCFsG4f6HVB/l8vXHeY5SDCD9rNlGK
 wPo10nr+o6vw0dPvki4/XlY70CkV2FzOLsVbSPLGBxjEd9PQdRtnv108u3eWAEOIF3aYQ36e5
 6w/NdV8LfIEr2exHAtidUJl7x8iXt4/8R1iz+kfjIRV/DbnGqIiqQqOyA63tmVnSKVNG5aSCN
 V9kwJo0wfHcQ95elaq3vujG+JiHvZDivO2USClorPJT/wWERSBVyjBIXyeU4u33M/OEpKDsVK
 Oyy4atqOIeLD8lhJOopyal6M73L+5BiFG6OoYiahOwmSqgJvQgbTQl+uRognAG+uZjBbJ29W4
 ED9cv7BHyn97LXpLpS1GhOFTwWdFn18l2VTJuhwqABvmmrLy+jaZ6QHHZnPEJDaYHDMa1z7Lw
 qGUMbItMBJMbOVtwEdmxkaax7+zfBIsowN76ypDVhZulnLGEMlEfAyQc7FJhk9uDDuO1dT+xY
 ai/yT89/LRj/AMo4gOSiWPLhvAWfte65ZPPL91axi1PleEMAEkCdsmve2wk+FHLLkGKolk7F9
 PpUFpn7cVM1a464iITknPShrkGloqwKJfD39P0MBUjXCMTHNGWNM7Gj/XNsTsWxhfD4FCn9tJ
 5Ucu9ZAy4tMUJtDJWWGmmSOjTqRrLogqqq4ExTH9cUA2RYY+t+4g5COJsV10CUzBKa5OXlkfF
 G9F0y+CuzLq/ZW/0NK9R5rhE3Zcsnvd6UiTkwZpc3P9ARdAfzgAI/pz8DwGrs5KX6fYDvMiLL
 Yy+yXIBEniMXcncLXtmkelEzMLBAzfG+kg4419kAW4t4tNv7/rEauq8M2WBBfnmJ6UfROz+7b
 UtrUNH1LBVX99Lg0139flGTr582vc1v/0zi8WDGD+6JbOgx+6/13+8P8sfSo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cHty9Egu3BCZwBp1OYTLnvOLE4PPaNJjM
Content-Type: multipart/mixed; boundary="qE3BmkCpG93t7Y1pR6quxfiAKsJ2D5cDK"

--qE3BmkCpG93t7Y1pR6quxfiAKsJ2D5cDK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/29 =E4=B8=8B=E5=8D=882:53, Roman Mamedov wrote:
> On Tue, 29 Oct 2019 14:21:49 +0800
> Qu Wenruo <wqu@suse.com> wrote:
>=20
>> Here we introduce a new rescue=3D mount option to completely skip data=

>> csum check.
>> Since data csum check is completely skipped, for profiles with extra
>> mirrors/copies, it will return the first copy only, which is not
>> optimized, but should be good enough for rescue usage.
>>
>> This option only affects data csum verification, doesn't affect data
>> csum calcuation, so new data write will still be protected by csum (if=

>> it doesn't get affected by csum tree corruption).
>=20
> Maybe just make the "nodatasum" mount option skip verification of exist=
ing
> checksums as well? Actually before seeing this patch I believed "nodata=
sum"
> already does that.

Nodatasum only applies to new writes, doesn't affect existing csum
verification.

Normally nodatasum is just considered as a performance optimization, not
something we would like to use for rescue usage.

>=20
> Also for consistency note that datasum/nodatasum call it just "sum" in =
the
> mount option name, not "csum".

That makes sense.

Thanks,
Qu


--qE3BmkCpG93t7Y1pR6quxfiAKsJ2D5cDK--

--cHty9Egu3BCZwBp1OYTLnvOLE4PPaNJjM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl235a4ACgkQwj2R86El
/qhREgf/YWRy1FY5CF7mRWHR79R/97ujpEHJu9GK/yqpOehgG2O84VfSe2um2Nps
CfzcXPpRoAz+49QJsDZH7xs6Sfd5rsU7dIwzprKfsjxmiqupbJbsn3aItaPDA2nB
aDNGJSrTV86yehb3JUWr30tdbz4CqFcypsc50RFQVsbwsYq9+OnbgFF9+SCJnf2+
ZpR48tUsj78LtZPhn02JfDrCeILs9sUr4SdOsjyuymXvk6QfZJbkVBGI0+fISG8R
spO+BnK48Ia6CG4/YpomGGopz5G/ptwk60N782bMeCVOCqKwtjGtvNwJ0Bz4qbl+
h20UI95pt2fVtYw4yuykzbRRGLZ8jA==
=KLV1
-----END PGP SIGNATURE-----

--cHty9Egu3BCZwBp1OYTLnvOLE4PPaNJjM--

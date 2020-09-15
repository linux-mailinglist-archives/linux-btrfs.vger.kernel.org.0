Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB626A2C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIOKIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:08:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:44207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIOKIJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600164483;
        bh=i5vo4cUTeV4qevUsaOoWddZSH+Vl5QO+92c5cN535Vw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QYdyvqAlAfiF1aIC7SoW6GONi/FYNMpE2uCgRKlFHbLo5xw/4VwcKn2X9bX1ZhsGZ
         JIFocgi+Yl+QNYPt+MRYiuxNsICI+yaaUUki3Us7+9Die79i7GdY5B18FV/dO173wl
         ycv9ClbGQC13CenXF4aHUvMxZQUT6GjqatV4jKQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1kqONj1YDN-00q7G9; Tue, 15
 Sep 2020 12:08:03 +0200
Subject: Re: [PATCH v2 07/19] btrfs: update num_extent_pages() to support
 subpage sized extent buffer
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-8-wqu@suse.com>
 <DM5PR0401MB3591309523CD789D48387C8B9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
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
Message-ID: <187cc0ea-99e1-fbe5-19f8-b6b1b1898d4e@gmx.com>
Date:   Tue, 15 Sep 2020 18:07:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM5PR0401MB3591309523CD789D48387C8B9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FaYY8vMDGhVGv2hjLAronTfEutkAnlne7"
X-Provags-ID: V03:K1:QTwW1+BwXTVjeQ5L5wJGiI6bpeb6y6reNVqeu17icUYnJaBWeCd
 HPa9Acs6uF8sO7Xreao+ch0ink7Lud5XZsz6k9LjfHWU339ohroq9vhZqFNWLxleIE7OFk9
 JLqjxiF6QHr+8X85CkBZfB5TzMnPoaCPVEMYR/RmGkDipeUNfTcFN5pzf1RD+Xw1/5/SLED
 wr0g6hHkVGB5ByJZHA06g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K7OlrVua7hY=:HCIWa+of6n40enPqZjPv+m
 RiqyGAzrzpxdFyG8bfD7+cJ6oShFW/yb6LuLFM34OwZX0xbk3t8HfvxCMrJ0GDFFmLenJVjVC
 OEIixy4iIAFvJ7Ucs0/WsbmYRIfdRLaAy2Fd3pd7++UMLH2q3/1jaZW8fDOxHX9RoVmaZNU7Q
 lmClNdu+ptoF8PKHv9YOLYT5ZwznTyvSugsCl4yNW0vgRn5K4KNLlf7Go4ba4G5k+n6t6Mh7o
 tIAg+zdWMaQu/byNptG6QvsdoJaquDXnjNDD8Ts56KmtlYUsXnUCvzQH/e7QWarvGLK9n9JWU
 CDV97+NymRJJEy5NnnIgrtiGCSJCJjGmZPMV/ok99mjlGv9GFYq9dXpdhALsHX8Y9AxM4ba06
 VaCX4WE0i2DW8gAfIoSoMPg3s+z3u+AjdosjuRnK0vadooGkh50qPc5R+rQSW9hcRxsJKIl9L
 BBwU3VlKQtY/XrbYic/NntWL87MEy2xNnp148RltdNd4dp5Af6vAonZX330C9VaX7xF3vABEt
 3PZvDdDIcxW7Y5NkZwa3Ij3lPkeT8XikT5M3BsF8tC0+FCFd9b/Rxq2OMy20YAnRzYiiLCmWI
 +ejZO0VL6c5mh+dkcCFZBMy5oAhc9+DruRczOD/ymOQ9/RF41cBPhMK0EamuCnNnfZyYDJCOJ
 8AhzL0t2gIVT7WnNXabfZmY5PcVkucYbXb5FZXpxtOeMF1KYf1UG/ibcyG9D6Vstjb5t/Fzf8
 s5CduodDclZs6AKu/PNuzzsFX0PbAr/xz+22/U8e/R6WBr90KTL/s9o65alJ/6+nqG4qYus2g
 vdT2K4MoskE6XwOzI8jRX3tYz3DvymNPKI9LHLuPKPt9s+SLGhMXFqvsuU3UlAafSj+VLM2eN
 TyCyDiqdmAz0Z/62c9J57yobIAdz62liKULtmpRVQU+NG1UczgCcR0lNLNIWl5nnJTeqJpdhm
 lVN3W+vySnhijP/wbzKYtDhUtRpkih0qRFBTnAA+n4yD1C6SudQa8orWhllUT7Rb+ny9dZvP0
 z4Pc/+KPiL+sfV+T74mKpueEl7BpQAXwYdKdZ6zcYIsZH8Q9sPNZFQyjvEwkZbC9ZYvBmqQ8Q
 XoqSQV12pPAR+q7PheJvexHzbjwrlwHyl4F0D+aXDE8UCOHC5mYnM92dfgofPzw0MHmOeyzbq
 bEShTaJXew8x+1uuKQBEIej4IaED25OzQYoyhgiZcl1K5mjIROEg/BmKnIAEi8kbIKV0r8zb2
 DvMk9dc0F+RzRS6GP7DPOinL7KAOYubV6D/cF+g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FaYY8vMDGhVGv2hjLAronTfEutkAnlne7
Content-Type: multipart/mixed; boundary="zP75XCMTlha3TK9SWQkFNU0wHaObP9IWy"

--zP75XCMTlha3TK9SWQkFNU0wHaObP9IWy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/15 =E4=B8=8B=E5=8D=884:42, Johannes Thumshirn wrote:
> On 15/09/2020 07:36, Qu Wenruo wrote:
>> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
>> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.=

>> +	 * So in that case we always got 1 page.
>=20
> Just to clarify, does this mean we won't support 512B sector size with =
4K pages?
>=20
At least I don't plan to support sector size smaller than 4K.

Thanks,
Qu


--zP75XCMTlha3TK9SWQkFNU0wHaObP9IWy--

--FaYY8vMDGhVGv2hjLAronTfEutkAnlne7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9gkn4ACgkQwj2R86El
/qh+9Af/XTZNHZiprSOR/yDuNjT3fdkKyph6108dCa5ZqEGlrPNdTYvM3IT0WEUl
JIrcCT/4g2VS/ZwSecunZmSW3+YzN3iyLm9dETvkoGUYPlEJGM7nV11ZSrfGsfTo
2vdNYdnBmxj1S/rBNlLa/tWP8ndQAEakSY4cWOnCARpSekIZ65+3WWs/TwzWG/ss
ZDo8rLLB6xPS2g2zw3LeVsnKkoQP2Z4M7vyOVQxQfH7MlGE9WpYSJbYQJqSOVGc/
sl6Fj6xanyqY50L2H59AZn4LaAf8xGWIqveJV60veFm2zW9zxE3ZuBNPKDUmaCRW
7U6cNoAjiauknC1z0OjwKZ8JTSoNbA==
=qxO5
-----END PGP SIGNATURE-----

--FaYY8vMDGhVGv2hjLAronTfEutkAnlne7--

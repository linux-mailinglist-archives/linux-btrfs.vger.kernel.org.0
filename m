Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A012F25F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 01:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgACAv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 19:51:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:53139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgACAv2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 19:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578012683;
        bh=A/BrP6nydkpSXQ0nNaCQIKWCE2UiYgK+RV8mIXtd4CE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jTQNgZ2nBHWL3Q0ZeO+TQ95gxe8XL7SpApvO+wCIoe/CIJt+f3NDlGRrgLJ3Czobb
         JwOoImM9BPFJS2aeOOMnqDUHGui5SnUI5UVKBkykm+J0MfxklI8R2JsEYx9pVLbeMW
         Ihfl214w2arzOTxHajlcOLxrtMrDnNwQoAf/26xg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQIv-1jY5bJ282h-00oXue; Fri, 03
 Jan 2020 01:51:23 +0100
Subject: Re: [PATCH v2 2/4] btrfs: Update per-profile available space when
 device size/used space get updated
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-3-wqu@suse.com>
 <c4f6ddfb-c52c-d376-4cef-26aebec4e288@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e3204d1b-dda9-4f9d-759b-0e1312b5a6d6@gmx.com>
Date:   Fri, 3 Jan 2020 08:51:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c4f6ddfb-c52c-d376-4cef-26aebec4e288@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qsvi6BicIT0J6iTrVDftDvrlr3MRYSmjI"
X-Provags-ID: V03:K1:LLlsc+OLwe9lbfz5bdTJjRYEF70hbKER6J7nYClKaqQRe92POeW
 PRUhtVeuCMqcXkgVv++BeQsGiOpE9OnkJhVke0srSLho0WcS8w6kN0uO/XVlEtlmtYBG91l
 vuCoyhiFgKzGinlpKTxbxcRiwhsGnrKCbMSjWqJzYUrr1RVddbNnguGWkgBMO+KRyTsVNRL
 7vLdMf5ZfelfoyV9d2+yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x+LzCILd8yI=:7zhh5LIdeMyCr8QNczLmE3
 hgdFpWcen7+JDQv+xf7jD/n/T0zmD5zL/II/8Fb1/W7ihnMSbUIO0a7J6sp3XeuNagLbsTC1F
 6yj2UPfMpuoGXMJ03Z89Y9K2BaUAcwu7mG7owsUKjQdITv6TXKcCWJwj+9mSkZZ00aV8yw88G
 Rw1qFMizmYAVuXiuad8b5bSmNhjG9bhubdM2e5rPVQz8r4eY2MfvBjc0DsGwPd59A4BB/0XqP
 1xmpFPnxXFKiO5PVNq6dgKArDlW/umCV6HqRMi7PdXsdjLS58RT3ETApdn7vM1TBiHp86pmeV
 /+B4ToPZY8C+BzcKYLtktRGWWGjTd+kc+W6oJDsNyI9vTxvMqKZQ2cKyAK4ekQsBQaLbtf0vd
 o9OFFvLoQ+K0ki9gxAmEADuvc/MzZTiD/pDAD/xl8WVVyIACl4UUaJ/6ZCCzjkhFK6b2Xmfq6
 XmxvrsDbSleGsqajPYahD30ZtCdIij4xz7jkBGoGxF52agLDjFpiq1YXuHMLiwYgsm77NktR/
 Hy6tSpXvyrBpYns+w68vfegwRXB32xHl8qZ8r+sBkJ7hMeAe2air4SYO+OXh/vjJOm5ZpanMN
 S0FUfEAbgm4CDK7qJ8ETlEqycrqBE9n+sYvFgOjuaFpIj7+CMCuNCdof5/U74MnFbJbPzrYGl
 njjRsL9ri+MrLWx2wxG2RGsNVRo92tqCMDzgGFwGG4uldaUx395xW5855bIfURCZV12K0m3+v
 vECif2W7BgcZkvzF1h0GbzID0vJH3AOfZ3wsPOAdXHbnkISACBG9EPhqLD+xsMsofjs81Y4jM
 S9glUZdDXWk6Jj8rUrfF8A7trA5kb3xG+jLJh7shxrNU60DlN5U1wBldWJ+RsdnYuvZupy5GE
 lPXIUMFPbnuKey71PtJFC63qDGJFDrwhKb2EYXT4FDbeXFlOqqsSB6+VOMToz0F6OfzHWO/S5
 ZX/IcFKfNZTKbzkjQPvJt40AT70Ml0DBdvEUfm9nUChfTy3rb1bMnGGUhSr9Ha1S2K+igsaGG
 +2wHmBC3lZ5cZmEvKBbczfUv72PG7ywzSr52o4WsVtepjz5T13bY91WX1IIV76X4p331dkaQs
 V8E3U6C33oVR8F75OJG8E0eFlNGnLOOGVgBIQlMgWTE7shNPPO/0NzD2k3U1JkI8gD04VR5A1
 iV7zXUNlgnNrGpoktETogo9jBCFBe7NaomMQJc8K1Sx7oQTpc/6CrQZXmxUqhuVTqqTQuWA5x
 FuH/x50v7eZkEz6SdtEnGM1vh5J8Vb2EIP8wuhKChUTFZp3txsH18oiK7JZ8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qsvi6BicIT0J6iTrVDftDvrlr3MRYSmjI
Content-Type: multipart/mixed; boundary="MXCef3KCMZTng0D3NbOpLAGyq9gxj6BsU"

--MXCef3KCMZTng0D3NbOpLAGyq9gxj6BsU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8A=E5=8D=8812:17, Josef Bacik wrote:
> On 1/2/20 6:27 AM, Qu Wenruo wrote:
>> There are 4 locations where device size or used space get updated:
>> - Chunk allocation
>> - Chunk removal
>> - Device grow
>> - Device shrink
>>
>> Now also update per-profile available space at those timings.
>>
>> For __btrfs_alloc_chunk() we can't acquire device_list_mutex as in
>> btrfs_finish_chunk_alloc() we could hold device_list_mutex and cause
>> dead lock.
>>
>=20
> These are protecting two different things though, holding the
> chunk_mutex doesn't keep things from being removed from the device list=
=2E
>=20
> Looking at patch 1 can't we just do the device list traversal under RCU=

> and then not have to worry about the locking at all?=C2=A0 Thanks,

That's very interesting solution.

But from the comment of btrfs_fs_devices::alloc_list, it says:
```
        /*
         * Devices which can satisfy space allocation. Protected by
         * chunk_mutex
         */
        struct list_head alloc_list;
```

And __btrfs_chunk_alloc() is iterating alloc_list without extra
protection, so it should be OK I guess.

Thanks,
Qu
>=20
> Josef


--MXCef3KCMZTng0D3NbOpLAGyq9gxj6BsU--

--Qsvi6BicIT0J6iTrVDftDvrlr3MRYSmjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4OkAcXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qh9zgf/Ve84hULg2AyUsQRuTaAFqijE
gPkUpWWDTVUjLpHrYE45Ne4xB3azHullsOSSqKxMOMnexufcthofJ/wZJIoFa2vD
IdD7UiOhFphzB/SZkL9iGjJoa4YpBXnrLrmiZpEg3sFGl8GAF8lMg25PmfMOg6Z7
sUJDOwuDjKRBpT/S9y4HB0I4V1o6xgrtPNlfeClXJeb/jj/h71F5fCrIyYATVelE
eNYABbrlDXc/pMevTgvcWjV7sf4KTeqn3jFkTATeNPLfoADQjw/48UB52QQhw4Me
5EJGC+9PAziYH+SLg3ki+c1MwKrFLJ47cYn/e9iiQ5pF3QX0C5KgM8XJ5BaRPw==
=lyN8
-----END PGP SIGNATURE-----

--Qsvi6BicIT0J6iTrVDftDvrlr3MRYSmjI--

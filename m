Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642A9270146
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRPqB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 11:46:01 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59581 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgIRPqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 11:46:01 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:46:01 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B6FAEA88;
        Fri, 18 Sep 2020 11:38:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Sep 2020 11:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=0oSwdB/jCkAvMcg9Ki2/NtWZo+5
        f8Oun9+HHfbVXQm8=; b=Zm4EN9pdDfAbmrU5JqBGh21ujr4al2GY7E0nkxoC8Qr
        EQMUSrKaS/kvdXalbOzoCI7fBs5/KwzN/2dX1OUNgVfcK791uweWmto1kf3+rTnB
        yLXWCwoMQKeXXunLWs81x+n4xXVt0aenWvgK2JGDLPk55oK2wnUZn30iO9Flq9Aj
        Of8HbyNZWdjQJ9hnITpzObj2fLf4EmK73r8LwMhiMg6tH+FAefy8tHYZ/4s6cliC
        3omc/E2h5p6atDQvVB052lWWyHf/H0V55uqh7Qb70Oc05pR5NOyB59vB11vNIUnT
        RMwl6ENAUAhQAd5K4WfnduJ7pw3tg3bajnsHDxiq53A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0oSwdB
        /jCkAvMcg9Ki2/NtWZo+5f8Oun9+HHfbVXQm8=; b=Vyth6iNMXEScsfOUB5/KuC
        kFEnLLVPRIF+zvacoUgOafX17vsYySZ5ocqX8gOnGIDA+aQRprHD9sJ6YJ6lU+B6
        a+Qyis4564Ufs4OCaILXjdNtZxTe3Bl09Wo6shfmlZdPxp3yhUC1ZvdwCoIlG7f8
        ajG9R9tw/mylPKJiDGl0BAd1BY/NPEQtn34pISndNkH58953xfhxFuKjmK02rigs
        mLewp8QkZj+rcrfjCxhosq2PxWeEpZ0iaJyf4Z8H1paSBzKufgiF7OXubI2+kz/k
        GRGze463hz9sQG4p95z4+zBp+vOrb4mm3anvSthQSTvHnef50B/04zF5u4HXUtbQ
        ==
X-ME-Sender: <xms:kdRkX_YW4A9WDPicTsi5Kktne-lMkDqM9nrx1krrClDND6u_nIE9cQ>
    <xme:kdRkX-bmyN3bHnfGmTMIW2nHsuQ_UTWLprSkOm9TlfVTVkUJZMfVuFMGh82_H487B
    TzOETrUiPdS_Rl43g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecuggftrfgrthhtvghrnhepgeefvdegtedufeduvdeltedvledvve
    fgleejvdettdeufeeufeeivdeludfgieejnecukfhppeduledvrddtrddvfeelrddufedt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmh
    hisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:kdRkXx9MZTVKdIknkTgFNTWdoYMq9Wa3stn0npIREJYDmlYi7d3fgQ>
    <xmx:kdRkX1qv_BGpaopnotLrunQMl9sq_8WA2Kis17J7kJY9ztAR9KBsuA>
    <xmx:kdRkX6pJXZ1GLEd906zp9C_pFlR1jOHhrAh2qcqf-ak0w6kBVBLzjw>
    <xmx:kdRkX4HQUAcdauhXIh_qNmt6y2PKnOHhazaZlIBSU720L3lh4KaPHw>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id E4F16328005E;
        Fri, 18 Sep 2020 11:38:56 -0400 (EDT)
Subject: Re: Bit of emergency, btrfs cannot mount root
To:     Mark Murawski <markm-lists@intellasoft.net>,
        linux-btrfs@vger.kernel.org
References: <59845114-3277-86f7-50eb-2b7b2b1c00b8@intellasoft.net>
From:   Remi Gauvin <remi@georgianit.com>
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBTwQTAQgAOQIbIwYLCQgH
 AwIGFQgCCQoLBBYCAwECHgECF4AWIQSSAGs/9alRnpiyqu3vU5/yR0VqbQUCX0/x5AAKCRDv
 U5/yR0VqbQ7KB/4+uGx/8cGdUrEhF3z6uBzvGrEfRoPLC6rLzjYntv9WC/s5IvaN1JY21D0e
 eJ69jh6tWOUCsD9X3J2tqGGs7LoRsK7UASFp7yYBVAvnjk103rZur7whHiT57/Oc5DEghXHK
 xs6w6YW4kPlJpe4SiPKK99f3PoZKthCdmLApUGHz7ROCbOXumpxZR3Em2LaGU8MI/R1eMCwK
 agzPl3dQGxcVlerDyCAtF1MzMw7LS/pAT/jxuEoq6hbkZ9/ZnCQomQe4CgWkmoD5Ec7p1FCI
 jqU5RO467uF0vkeTU6F+n2/qA38M0FAhYwZU+/hlqP8OYey2X0PuHDzw03P95hcpEi52uQEN
 BFogjcYBCACjRjoVfzhCwOlHyQUSoyGmSN5VClvBiGoGAgUlPlwExClmweac6ClhTQmjw/ej
 AdQW7nr2DqPj7BK5tuHb5u1YvRCgVlyeDRrb+Peof3yD2UCfxmCiHFq+bBgg23tv4sR4OgG+
 rSz/Rl5fHjsw6ZuNE6rwv+BA5hshagks7Z6bLGZWjUWDTQUqRu4ISAk9bxT/tVfgQVhoiE9C
 /8reamfJZcirmW+KIwIfPESPMGH/fkNMvDKYN2a3NaBy7WvNnqPaz7htPETyZhd3iXZeiefu
 /jjyDC9CZknwQ+mU7+lZ70WghLKI3FmdA0JUQ72Uxqco8WmF9UeonVYS1gyIvFORABEBAAGJ
 ATYEGAEIACACGwwWIQSSAGs/9alRnpiyqu3vU5/yR0VqbQUCX0/x5AAKCRDvU5/yR0VqbdSW
 CADCAV68zw465qHEouJbrMLlm6jWFM7qNt0/us5KyDmxHm64x0dzHWNtlfklZ2OO3llgem9V
 8JqVU335usScXKfp9PERa8MfK06XCYC9+TgBwsH6N6XM3HuWlvRQctqg/tPj8JGvo+PnOnB7
 OpLaIsONJXJApKNKcQxu5ZazZB4Wa5MTgqta6A7Ue1zVkoIPI/fQXlIUuWLaL+x5SMisHeLr
 MYwpA4h8UI3Wj8m1uO8+GKcwe8O/77o2H6PufoLHc4/MmODExRgxNZ48F2DZFopBT8RQO8Hv
 2zadWA60y8/LX84GsNS7IPYrYZ10NCXOt8a1+wcSaCVYRm24Yc1/Fktj
Message-ID: <6da791b0-ae10-bbd4-b242-dac5a6cfb76b@georgianit.com>
Date:   Fri, 18 Sep 2020 11:38:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <59845114-3277-86f7-50eb-2b7b2b1c00b8@intellasoft.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="atY74tIMhzjWrkGyBmrqK8JgFGA39EGBD"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--atY74tIMhzjWrkGyBmrqK8JgFGA39EGBD
Content-Type: multipart/mixed; boundary="U8ZhloeHzo7SFigDqd8umdKyvtrh7828s"

--U8ZhloeHzo7SFigDqd8umdKyvtrh7828s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-09-18 10:43 a.m., Mark Murawski wrote:
> Interesting parts:
>=20
> [Fri Sep 18 09:58:17 2020] BTRFS: Transaction aborted (error -28)
> [Fri Sep 18 09:58:17 2020] WARNING: CPU: 2 PID: 1 at
> fs/btrfs/block-group.c:2128 btrfs_create_pending_block_groups+0x1d1/0x1=
f0
>=20
>=20
> But!=C2=A0 I do not get this error on debian's 5.6.0-0.bpo.2-rt-amd64
>=20
> If I try 5.7.0, 5.8.0 or 5.3.8 or any other kernels I have handy.=C2=A0=
 I get
> this error in btrfs_create_pending_block_groups.
>=20
>=20



> [Fri Sep 18 09:58:17 2020] fuseblk: Unknown parameter 'space_cache'
> [Fri Sep 18 09:58:17 2020] UDF-fs: bad mount option "space_cache=3Dv2" =
or
> missing value
> [Fri Sep 18 09:58:17 2020] BTRFS: device fsid
> 20916588-dd3c-41da-8f46-7521d263bce1 devid 2 transid 334922 /dev/sdd1
> scanned by init (1)
> [Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): allowing degraded
> mounts
> [Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): using free space t=
ree
> [Fri Sep 18 09:58:17 2020] BTRFS warning (device sdd1): devid 1 uuid
> 1f49a809-96e9-4f81-bc73-504af4b0d13f is missing
> [Fri Sep 18 09:58:17 2020] BTRFS warning (device sdd1): devid 1 uuid
> 1f49a809-96e9-4f81-bc73-504af4b0d13f is missing
> [Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): enabling ssd
> optimizations


> [Fri Sep 18 10:01:33 2020] BTRFS info (device sdd1): using free space t=
ree
> [Fri Sep 18 10:01:33 2020] BTRFS error (device sdd1): Remounting
> read-write after error is not allowed
> [Fri Sep 18 10:01:35 2020] BTRFS info (device sdd1): using free space t=
ree
> [Fri Sep 18 10:01:35 2020] BTRFS error (device sdd1): Remounting
> read-write after error is not allowed



=46rom the kernel that works, can you post the output of blkid (run as
root) as well as the contents of your fstab?


Judging by these error messages, it looks to be me as though the options
for different file systems are mixed up.  Are you referencing devices by
/dev/sd instead of UUID?

It might also be the case that your new kernels are not able to find one
of your SD devices at all.






--U8ZhloeHzo7SFigDqd8umdKyvtrh7828s--

--atY74tIMhzjWrkGyBmrqK8JgFGA39EGBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkgBrP/WpUZ6Ysqrt71Of8kdFam0FAl9k1JAACgkQ71Of8kdF
am3kaAf/RMr1sFTRsgLIw2DdbGC9f4S2q7Ge8PLOr55GcKDcAZjzuFNFsJqpUPnc
CX14v8OqZ2bqd4hjJC0i2l4/zWu+SdUeZz4rlLbDq2bZRZ8/9kOhdDeFZTL/zlBo
poJHbbEZYRAwK2J457oarKBaf8iU8z44WSW5S+a9SLluap/ti2hah/RRmMPPGnyW
tKOom3e4a+ywqUQU1l9kpPdIBRewBBkzZlaf59DFAZNpAzlpQ772QCybxI5MMf3Z
Sx5OFbgufIvruCKxcL/yxkPHMtjMNVCoq8WS65dGFvxVvRb4d+ASnFvgypn1/n9r
5VVdbtrcqpt4q8KF/+4C0ZmEooQndA==
=Kh84
-----END PGP SIGNATURE-----

--atY74tIMhzjWrkGyBmrqK8JgFGA39EGBD--

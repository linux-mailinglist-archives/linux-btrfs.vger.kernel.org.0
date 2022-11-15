Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1662A238
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 20:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKOTxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 14:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKOTxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 14:53:10 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 11:53:09 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E0167D0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668541988; bh=1kGJVIOT6Z93FVptjIz0ky6ZHTEL5Jq7ddFb95c/VIE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=mrfi21LSxuK7LlVZGpEah7NJtn9EOM/IGAGH92iduAsxs5LIiAhZD5YdRaBxo0hS1
         z0gEcxjV13p4+u9wAczoa6E4CpryNe56JCBoEZV+p4pA+ZXHi08kdOo8XjG5oajZsU
         hy1YDDy+OVHVuaEXakRLtKEA8krfhiOMDiP0zsA/wwIr6hcEEEphY4SwEPGHMXNNcp
         PixIPSejsTkk2Ig5igXnS3TEUzIWu7+CzyiXyhdMDoNBjmHPlC17GqZ0OQRMiLVF/T
         5XaNdN2J7AVUohNgIRupdePZxeTjVbuZTtQXuGvPcThLwYldmz+ig1blz4fd4fKhYl
         2/bRmsOjierog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from gecko.fritz.box ([82.207.254.116]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqXS-1oXGcp1c3a-00UMuB; Tue, 15
 Nov 2022 20:48:01 +0100
Date:   Tue, 15 Nov 2022 19:47:44 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: separate mailing list for patches?
Message-ID: <20221115194744.6a343639@gecko.fritz.box>
In-Reply-To: <0YIELR.GA2T7GBWR97P2@ericlevy.name>
References: <0YIELR.GA2T7GBWR97P2@ericlevy.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SIti9.596DffjlEVDHs+UWG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:9H0IXwZZnnJw1elXkMcWU/6L2MuOuAGIMhDEmJdRU5/FOkQeVqS
 jVsAJW986qhnIXSwGOn98dvGtQKenjTSetf0ZEtW0hb4hA1UpjbefsrYTPYc5VYXnVOLrH9
 YATgMMtqdWZJtfnN9XwZB/ZdSiEQp2LL+C7tT6mJDv/c5GwIMvNgxZPgk44j4/NIrM6geig
 uYMIDdjgUYTpPHCnIf/Zw==
UI-OutboundReport: notjunk:1;M01:P0:WqWJkRBCBkw=;G9OVE+abo1TmjG5kxhEpdXxF4fT
 skPS/u+6NsstPwOQ+xJf4jtOxAanttBwqDSTdAY5c1FzibI8WT7kg9l19voSIev0xnD+skRyl
 bLerJwk6S7xd6qNrPEoPVTqo49TENLBJuj/3hlYlrNY2MbagV0Gb6eO05qHZbDCXd0BzNHEoe
 SAI6wPC45A5n+n5VGuLTli1oku3zfZ7aZN6ZTzYlNwFofxy/W3yLbZIbfSwWqAPXPxm21bv1X
 J203zRLqD1NfQF7Rlf2k8ktHfLwLkHe6rpEjno7vDUmC1wNw0nevyKphjayG0QMq0rBmCOfD6
 4Dyrfo+n7Ejl9Al/h8zp7CIA9kEVIfAntqf8TSukYMVzLINd4w4kHeii+YlspKgYQw1csFpG7
 jXY1pPFVlRI/OZJWo6PRFcuxWBvvApVbGwEdU7hX++xTcNqrRetWXlejxXrBspiGwTCXrL9rt
 PN3SmvIu+8XFqzkkjotjywj/TCOlF6hyfNZ2eR1MDILVAL6RqMFAVrPNsKjtqUbYIoiT/+n0W
 dCHufKhL+MK2fMVB/9JN5iGSzzG6Jk937tCKzGI9MJkHQT/9f6YufCcDOPOqYc9wCiYCPx12J
 KxjFL8GYC9KhrfB1s7T8/h+Ko934WExFvTl1AgocWEhbPf/5sGOnPT9ZFt5wLAdgHs8WTIBac
 AIklezZUC9MQqKXrg3Js1so0gXtLGnhY+GlH5lzMeiAkoMHFAVcknqkSe0CgwAdyY45VFLeHv
 ZNM4pZR3qCJ8sNeqVyAvlOnjQztUB761n2oDgrkp3zFetPOSz3bu6CZxu4xjsKYCZTxCheGX0
 ER+GBMtkBTKpMh3uiaTu18KDCk1IFHlJhfB/iMTRCX9SZXRMb0rJqabE7Fb/CV8yapDA8+OaM
 PYWe+XTM6LvRrgyuBIBW69J+HJNMdML/FViv4k87xHP/8BoqMwX3PYoGRwIM+VjHl3MDDpsGa
 /cgtsXwp9Rc4DCByY/GiJhowtcs=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/SIti9.596DffjlEVDHs+UWG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Nov 2022 13:20:24 -0500
Eric Levy <contact@ericlevy.name> wrote:

> I have subscribed to the Btrfs development list occasionally, for=20
> seeking support and raising issues, though I am not involved in the=20
> development effort. Currently, there is no channel of communication=20
> more accessible to members of the public, yet, the list is often used=20
> for patches sent among the development team. For many of us, it may=20
> seem cumbersome to be flooded by so many messages carrying the patches.
>=20
> Perhaps it would be useful to consider a separate mailing list for=20
> patches, or to open a web interface that is friendly to those seeking=20
> to interact with the group for more occasional support. Hopefully, it=20
> would not much affect those regularly involved to subscribe to two=20
> lists, using one for patches and the other for basic correspondence.
>=20
>=20
>=20

By the way: You don't have to be subscribed to the mailing-list at all.
You can just send emails to linux-btrfs@vger.kernel.org. The implied
reply-policy on pretty much any mailing list is reply-to-all so if
anyone replies to you he will send with To: You and CC:
linux-btrfs@vger.kernel.org and also CC: anyone else involved in the
discussion so far (Thats what the Reply-to-all button in your mail
client does). So it just works without being subscribed.

Regards,
Lukas Straub

--=20


--Sig_/SIti9.596DffjlEVDHs+UWG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmNz7OAACgkQNasLKJxd
slhq8xAAh65Xau6CypxAndqii+twAGhAh+wwguweN3xzp5CXms7yz1IozCe1VeBT
nwDTBYUAXeuhSkfVJzfAxpRE+PpYR8TJi8qDnrz+JNWnYMkn9ohDDWfqjmQNAeWw
Vf/Y468SIRc8OdcD/Bxryj2FF7Tz9YffOG6VUG9mWBBh6WOpy4u67qVZQB2eU23v
v/tPfZxGbbGGPixkPrKzbPP6xdkqTfTb8O2VNYY9pQ1jYIAdGhh3YRhrKu4fsqhs
uZxfIrGakORK+pjAkFVkzZslKP7sTx5V6TQsPD5iEUyB5AKy2nYNCCC+scJwV2lr
fZ/g87uSQ4dIRGcjzTizQlf2bfQKs83mriAWRSMEn1lsrNIWN3Ar+m2pHZFPtyfm
14U9xRm2Gjg3IwrRnlzw5KRzsZelotByaJhWubPFcq7OHNWKgjzIb3YSJhjTJYQI
TLosjpf5w6r7hPG0ag94ouD7GJxctQuB9TsJWzd8vved3ZLcdFR+7h5c1EjTX4cu
O/2w2oSvcaym9B2s3/RfUQ+T+uVvVyFvdGV7YuIbRyB9vdsMG9LLyHCAH352eUnW
4Ex2JW4HiPROs4MWtSIsLNNV3PomXbDWPpq+sz+/u7PphfR719a1nZp0WMBCcpbf
iAK8J0WbtsG3jvA/EwvhI941d0CEZRkqmMosdvcsCzcfjesZN3I=
=Uext
-----END PGP SIGNATURE-----

--Sig_/SIti9.596DffjlEVDHs+UWG--

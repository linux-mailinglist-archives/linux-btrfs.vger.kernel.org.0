Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10C55D94D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiF0WRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiF0WRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 18:17:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6BC64DA
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 15:17:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 81F165C014B;
        Mon, 27 Jun 2022 18:17:21 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Mon, 27 Jun 2022 18:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656368241; x=
        1656454641; bh=Mn6U1DF9y3oYRLkB1yy02BqmW+CBNaB1hOiQrT8ULMo=; b=d
        0Tqvmtap6dgQlVWRpyamz//xtVfWHI+IAbJDqepcC1ZopAqlBW5YTvRLyJ/G1PS3
        U1V1vIpwToOOBqcInz6o60mavqNCf/thrbQ05ins7ql+JUud4cIjdWQ+2GbOSNbg
        Lg97b6YW0xxKC26LRHAft1NE27Y0MFehSI+RqZTzdeJLFL96GEkT0nlrbJqPdE4m
        alPLWqLJXvnxi41JLHAEE4+wX9AgRTQB6a9YKX+vTZkh326O7Fks706mi4Y0blKD
        yN5XGAVAxIt352KMv40EtzWqoTbd+AIwDMezzwHZbQaj9QracR6YXJ7NbIgmkkMx
        Mj1fO00IYb6nly1PeMNRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656368241; x=
        1656454641; bh=Mn6U1DF9y3oYRLkB1yy02BqmW+CBNaB1hOiQrT8ULMo=; b=e
        9Smv/I4mHfXFElfhQjMVx3UmZ5dECoevb1mRBlKhkdGu4zSBchZqslckxyI7rZ9S
        KWW3G28QrCFX/nV10MDlO0LldD0qur5TQz2S46ktl0jQcSMphyO0MkNZi/2Fn4qu
        JUd6qFQupe8BG9VIAbFuR6Ch+T/w6IXonGLGj2uAr83ZFXzwCxbmuZq+6TY3b74n
        MWLOQ/RGouzIoGxitqYVRrzpC6IyBky9Etn1Rd1YzkZ/LMqzok/JyiIDGDColGYs
        jmhq9zJJHw99JD/vYPd6Uf1lrfubz3/ZTwXIm2VXRcktpsvITHC1+TFc8K603imN
        8ynhcVuA2PLvoSJDYsN/w==
X-ME-Sender: <xms:cSy6YkvkOIjAj2wZsg2hGedkDJyo0v4FkgfoicAGUjdPRjcwvFRMGA>
    <xme:cSy6YheybuSthodkBrthzWUZA189--D762PhSSWcfe2xB1qV2KV2_qlbEgMosotOU
    Spd20u2OxhWtN0xUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmnecu
    ggftrfgrthhtvghrnhepfeffhfevkedvheevvdefudegffeluefhvdetjefhtdejudduff
    ekfedvtdffudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:cSy6YvzVts0_1fgeztptTaoq_LB7LkoX_-Vbtrt70pC0ZFdTiOxIvw>
    <xmx:cSy6YnPwTOwvDpmZclrNUuz2KZZHLbVg7I_zfdyOQEgtWRbJD6PYIg>
    <xmx:cSy6Yk93EV0oKwxIMBWHpChCK6ovgk5kbJ_hSo5tIlRKJekuXb0TMQ>
    <xmx:cSy6YtJw-KjZYyJY52RSVQegfVYqH1IOHdhWM7aGDJf8uN3ugQmqQw>
Feedback-ID: i10c840cd:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 518E42720078; Mon, 27 Jun 2022 18:17:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <610c0202-f904-4caf-b5d6-4070bc827832@www.fastmail.com>
In-Reply-To: <CAJCQCtQ3qrLTbbXx7KiiU=ZH7NFTFsJVZA0fbKf+EHyCDkJ3Tg@mail.gmail.com>
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
 <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
 <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
 <CAJCQCtQ3qrLTbbXx7KiiU=ZH7NFTFsJVZA0fbKf+EHyCDkJ3Tg@mail.gmail.com>
Date:   Mon, 27 Jun 2022 18:16:28 -0400
From:   remi@georgianit.com
To:     "Chris Murphy" <lists@colorremedies.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Question about metadata size
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As I understand it, (which can be mistaken), the files in question are V=
M Images, which will have a mix of compressible and uncompressible data.=
  BTRFS however, will mark the file as uncompressible when it tries to w=
rite such, and no compression will then work on the compressible parts. =
 (IE.. to actually have any useful compression in this case, compress-fo=
rce is needed.)

On Mon, Jun 27, 2022, at 2:12 PM, Chris Murphy wrote:
> On Mon, Jun 27, 2022 at 4:23 AM Libor Klep=C3=A1=C4=8D <libor.klepac@b=
com.cz> wrote:
>
>> Yes, we use zstd compression - filesystem is mounted with compress-
>> force=3Dzstd:9
>
> compress-force means even uncompressed extents are 512KiB max, so this
> could be the source of the problem
>
> If you use just compress, then uncompressed extents can be 128MiB max.
>
> So it's a set of tradeoffs depending on how compressible the files are.
>
>
>
> --=20
> Chris Murphy

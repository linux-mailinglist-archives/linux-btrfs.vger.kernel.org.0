Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3521C60E89D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiJZTJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiJZTJI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:09:08 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77085B98
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:07:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 280B42B059E0;
        Wed, 26 Oct 2022 15:07:26 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 26 Oct 2022 15:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1666811245; x=1666818445; bh=cKu5uWfwQDc9Ovj+CCZ/q6ZiI
        EY8JarB6V2fvQCPsnU=; b=c6KXFL0SdKao+qhRNynh+hpQ2mhSL8GzchNhMffKO
        83ioMvJT+pJvPzpbEQ4dchqiDHNGFTxXjWq/9qBB5J/uKyXY72XavZ0EKrQUI8AS
        GCXYf4I7+2tkbNRjCNHp9UL2fUSw5K80tfiEDftbI6fXgps4kBJRRy8zCJQjaXrT
        GuyY0SELL14i/t5Qn2RMEQKTBIDi1633KuhZXPLSC0XBGablflqPTGsdTQ5fqwLE
        YG58SS/kWrYCbcqC1eG/J5vYyUYTL+yxMJviwFmTI3m/Kc0eDhYsP0eP1LfXC1ya
        iJy8g+YDXb700QK6k4zM+TOu5i1lgouI5lctiJcOVkHiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1666811245; x=1666818445; bh=c
        Ku5uWfwQDc9Ovj+CCZ/q6ZiIEY8JarB6V2fvQCPsnU=; b=H0xLuajte4SCCx3g9
        mqnEFqpsVbX2Pi0JDvQAHgdBugcCQD7R/KCK1Yy6cmkzqAWFvJuxzPN9EFlQ4Nus
        1PZ8RpXEyE6FGbL2Zr3tU/evownp2R/y1o+6JBU+f0bPcT3ExOQ6s4XAAULlqx0b
        1mzpiGtjsg9MlozIuUrBHjnF60nPQQGu0+Brl/arGAT/DkMR8wLZ9yMIgpvp/BOi
        zZ+8nhI7KbGrz44baSEJ3noqP9BAJNxZutxNvJ1fbNW+1ei2UVO2ysH83zdoXxdR
        2uWd9nm7ROhATlfCkVh/HACT1ZkNGNCOWe4JXfcVLu8/CvhXme/dkFxmEfoD2/Cc
        z1N2Q==
X-ME-Sender: <xms:bIVZYzn7Tc5lm0t490HLxbuGAvjx-WkAaaG7FcEPwIHQVr67sNvBWQ>
    <xme:bIVZY21JazVe6-R1Xo1Xgk2-A9TRQuhrkjHewVChr8GBAjoYa0mbd0j4VfsLa0imH
    aol6nVbJ7HXbfxNR-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeehvdeiteejhfehgedtleffffehleetffeikefhfeeh
    keejhfetueehkeevueeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:bYVZY5qJglAbMA2Kr6e2YOxcXyxdIJZX2gGSHc-Q6n1ENDQWXhaxVw>
    <xmx:bYVZY7leEDrKwUeBzWuG_pR8t77ZFKBYtXAjjJR6OIuJTFRRPLwpew>
    <xmx:bYVZYx1P4mpMbTcf2MCxxxwCUgQ3j7a_ZIP5pxRDYKDFfsxioCUvsg>
    <xmx:bYVZY-hc9ESh9qi6VRU-395wzu10Elhn_8CTu9-pv3VfcbZwS9lARpdMqVU>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9CA9D1700083; Wed, 26 Oct 2022 15:07:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <eee8a8e1-8e54-4170-af44-a94c524c37ad@app.fastmail.com>
In-Reply-To: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
References: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
Date:   Wed, 26 Oct 2022 15:07:02 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Nemcev Aleksey" <Nemcev_Aleksey@inbox.ru>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: compsize reports that filesystem uses zlib compression, while I set zstd
 compression everywhere
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Oct 26, 2022, at 6:21 AM, Nemcev Aleksey wrote:
> Hello.
>
> Recently I decided to compress the existing Btrfs volume with zstd.
>
> To do this, I set property `compression=3Dzstd` for all subvolumes to=20
> compress new files with the default zstd:3 compression level.
>
> Then I run `btrfs filesystem defragment -c zstd:12 -v -r` on all=20
> subvolumes to compress existing files using zstd:12 compression level=20
> (to spend more time now and save more space later, but don't want to=20
> keep slow zstd:12 level all the time).
>
> After defragment, I run `btrfs filesystem balance` on all subvolumes t=
o=20
> make Btrfs happy.
>
> And after all, I run `compsize` on the root subvolume to check the=20
> compression ratio, and compsize shows me the following:
> Processed 1100578 files, 1393995 regular extents (1649430 refs), 66631=
2=20
> inline.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0 Disk Usage=C2=
=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 77%=C2=A0=C2=A0=C2=A0=C2=A0 169G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 217G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 226G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
99G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 99G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 100G
> zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 52%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 54G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 102G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 109G
> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 12M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 65M=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 66M
> prealloc=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 16G
>
> I'm very confused why almost all compressed data is compressed with zl=
ib=20
> while I haven't used zlib at any step.
> Why do compsize reports this?
> Should I worry about this? It seems zstd offers a much faster=20
> decompression speed than zlib.
> Thank you.


If you use chattr +c anywhere, it uses the btrfs default compression alg=
o which is zlib. There is a way to set a compression algo property, but =
I'm uncertain if the kernel honors it.

So you'll want to recursively remove the compression file attribute. I'm=
 not sure it's worth recompressing but you can use defrag -z for that.

--=20
Chris Murphy

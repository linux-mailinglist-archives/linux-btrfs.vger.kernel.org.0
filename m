Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E67637E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjGZNoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjGZNoQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 09:44:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C826BC
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690379044; x=1690983844; i=jimis@gmx.net;
 bh=qURlJKBMekw4I+2pWN3Vh/w1ZB1NJP/1Iwk0osJDkug=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=oVxeivph9DrYZ51TnrhGHxJE0AMIzAUjAVlVgQc2EWJxEnLjRvO8y/P0dDqu6ZTW4bla18R
 SdPwUlbDfPiC755dYncM/pNMzuD2WgzFG0cjnD4V48UNP+QD9tNqGu8PJa6I14xc+do4CgM6d
 VBfM9+olG6/HnfkNfVNUKXbVcaorFIWZ+uH6uVGlmuiJfImgWnGBG7/3R+YKuFFExLaQN1RaI
 WrpUseYKCO4lsP9K9lUT/VAComyKZSmsnWReNfdLkzuKMhxGwZzj8svWglGxvpqg2m/FKru3V
 8aVlwLHrmPXqmFHsvARPM3mz9gx3yF2QwWeKHaZ8Syvpws/3DrBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.65] ([185.55.107.82]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1pzBsP1Y4j-00jblL; Wed, 26
 Jul 2023 15:44:04 +0200
Date:   Wed, 26 Jul 2023 15:44:03 +0200 (CEST)
From:   Dimitrios Apostolou <jimis@gmx.net>
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-btrfs@vger.kernel.org
Subject: Re: (PING) btrfs sequential 8K read()s from compressed files are
 not merging
In-Reply-To: <ZMEXhfDG2BinQEOy@infradead.org>
Message-ID: <26628d70-a4c1-e380-303d-9ce55a8ef3f3@gmx.net>
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net> <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net> <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net> <ZMEXhfDG2BinQEOy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:GB4PbkYmZw9x5cFKYAjajYTF4yaK+DpjQNZwudaEYuGEfjMhxgu
 /AATJ9ZV5bNQyWXTwQD7kke6oNQWWrmKcF4yv7DXpGTZ+BWd6F86xmt4GAsQ48bxiwdf13G
 85nfB6yV0rAtaxTMFu3A5Y7KEZcUp44zxAq0657cAOV/q4nUY0D9D3jAe1ErZ+BEuL9jkOA
 pCyra+daxhBTwCdDpHa5Q==
UI-OutboundReport: notjunk:1;M01:P0:IwVjDhHEftA=;6HdnJP3zcqyCELIMOddfoFHK4jf
 2KVT/J9zVzAeNB4dlftql+5c/U6iB6HjUELN7x7WpEH+hQKoPcRf3TGkHYlwhzw68NBGMoPV1
 r2lkpnkoLLd7hwalOInTNNWSw9y+yLirGPfdV9u4hE8UPR6xwRKEV2cIkSbxCmeZtdJyZ5fIx
 5fU3UVM/beav2I/obelBJyFqa0SF+NEApYDDjR9fPyy/oxksx5kpCPgDm48glpt+D1MU+RDYf
 dA8Ywkwj/s5N8IzJ8xmonI1Yi1UdL5YzFnGRr5RhvOX6RU4k9ZOLbu4cn06lw7cNaur9Pb2JU
 JVxaGrfMcFxuB06lSSlylMPKL1TDuM1c6T82zXWy6zgMezT/aUcY3vyK1ZlPGdoSjsmOYg2Kv
 5IkWow3E4zmtZmdfpJjrLRhZAbPcXsyV1QjffODrAIPYmz8sPSKT8+lQOfeKBLe1QhmIgbpYO
 EkMd0/KhzXF7xkRKtz3dMx2PIJlSAHVfPpYfSBGQUClA46a3Ps8+my69T6MlNB2grE9VfKV24
 aRrkjNX3G/rBHJfW6QnX38cojRySVtqDIOSn7774ftCdoG04h91QPQt5YsEvC1JKu1puChKT3
 SAPcKLE/ddnGwK4jt+PPR2n3DzRI7cgCb7mSpyaj6YB4Q5eHK4LPedSz5hV7sLP8hvvnVCm6x
 xfYsICgA2r0jBH2c1NUyVtUr0WBaavMdb4mN3H/IHnZf020E/MjG3T7VT3khSkYJWGPDUigm8
 RShJFcgBEa5r3eF4JqR5tFHhYJ6DRs6Wfvme7FlwfjqbOQbDdEREsGrLsb+t26HS/x1ceHDpw
 U2zJfR/gvjSccoAQocHdN7+ahwkrSlS1uK5Tgm8TPz11UqWhHkHs6Pv/ZMqVNU12F23WpCEYX
 jdXBI1L14ZSOFfrGtBZvdKSwDkvnPCH2Qy4HtMerM8VOEjcmOdPl4ERSk6fUBEB8kjKDeIyJH
 Y0vFvA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for responding while travelling! :-)

On Wed, 26 Jul 2023, Christoph Hellwig wrote:

> FYI, I can reproduce similar findings to yours.  I'm somewhere between
> dealing with regressions and travel and don't actually have time to
> fully root cause it.
>
> The most likely scenario is probably some interaction between the read
> ahead window that is based around the actual I/O size, and the btrfs
> compressed extent design that always compressed a fixed sized chunk
> of data.

AFAIK the compressed extents are of size 128KB. I would expect btrfs to
decompress it as a whole, so no clever read-ahead would be needed, btrfs
should read 128KB chunks from disk and not 8KB which is the application
block size. But the data shows otherwise. Any idea about how btrfs
reads and decompresses the 128KB extents?

Also do you know if btrfs keeps the full decompressed chunk cached, or
does it re-decompress it every time the application reads 8KB?

Dimitris



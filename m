Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8B702061
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 00:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjENWPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 May 2023 18:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 May 2023 18:15:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE910EF
        for <linux-btrfs@vger.kernel.org>; Sun, 14 May 2023 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684102520; i=quwenruo.btrfs@gmx.com;
        bh=npSh6QhMIFaXwQZNXOCbLhgOPEDlADOMCfXsdXouEK0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=hbiMPaYKNFmAFHM9Np/FKluLWjWQAf7JqcA6lA9F8/hgRELM5Zoqu8t5xAWIRTh+Q
         o8JM9jfsqyfPhXoa9pQwC9IdUs+RN/z6aFWEnYcEfZl80+b/rFsGT3SUR3l68QJhR8
         ICJNnr71XAd3RdxMWYOPrp4YgS+OQdfgkPd7T6xLz5GKkzjsTxDOKM8Qdo7mX0iLtf
         y+dhZgy/ge9RLhFddOHOnVZ60J6/mpCPue4qvEoOXnYvY/ftqKRXQ0kyYk3VEMHK90
         jsRY3vlZmVzPkyWfR4stlSnLRRh/nSTLlnN0FTPgVDzQpEFM/rfn4ELvOuQoHOgB1n
         hQ0e2PaXiI05Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgvrL-1qf3CU1X0X-00hQ5x; Mon, 15
 May 2023 00:15:20 +0200
Message-ID: <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
Date:   Mon, 15 May 2023 06:15:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 6.1 Replacement warnings and papercuts
In-Reply-To: <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NrW61s6gQ3Ft0eatjgMPL9suysuDw0yXkxjWuTdOrNkx62og4uf
 C6gCvd8GrMoEhoABPLhz6/Jlql8rkerJGPYVMhd3KmnGaEsiS1oybpPdwLFxbOM+LKsttaE
 gDWAOmnky6KxpYisScNt8WUT/cktz55ZMCNoX7z+kKtLvl2JsLNi+DxA3ziAqs/eVtaetTM
 RJ7HDhIOgWf0cx5b4jjoA==
UI-OutboundReport: notjunk:1;M01:P0:q2UX5NAmmvk=;qQRggqjGOPPWBbBMLNCwKv4qOqP
 OQu3SPFhrpZ18RQ2O+T1mXP4HwdJee5/G5UrgNncez2eXMBjkp0IKmBMwADRpbD9dK+sdYD60
 +xOIUjNHSlFN2/eHXZbjZNqW2eSjBZv8pSSMsTm6wDSfzWwa+5fjUvgfJEqtSBYXIGNHbGH99
 TL1fUCtULJyw2Y/ZVpom6yBi9dus3+t6kcwm8OLtyr5gi7KrkvD7Ow8/H0R8+TFuHTTJhWfTg
 s8raO9BSw3TfbWZp4juz9bbZTLScXLSufVshcS+9eaaHTr9qQfPAyeVqA+3kksuy9QCkvdHXf
 AumVejG+pgKpk0Fw9T7RnIb1rGB90blsdpmRx81IZXIiQxjVV8+91vWf4Gy1oBmCMhzVWQtFj
 9NdnKG0SK1vbRszzHz3zqpiLbK9IWjAuCGzbdDP2qOVcD8DR/GvvjQQV/QuTcDLn2Afs+ZEq/
 Hi9J4oEJ9fsyKEvudScYGOyleLNlvCy4bN0vRIBfp8HxSljzNoIBZWjtowxqJCyxMJLLSGfag
 HHJXFfOqlq5gZ3LghLfK7NFrPIAmibfIVXK9nvT+izChp7uzqyOa+mqCS6Ad3ixQOeurf8nAI
 uePyEcxZafnp4LlQ5YsRZGzLUjDWryxdE9xSOvZ6gBFXUZ1LtlZzAiHvoCRiCYsxHGvt99cVM
 q0A1FkRUn3t8F+Qsq7xkPnnKEFiivpXgk9xiq78QF5M1hhzrzEp6dvTQV45emviXc6i9Mkk7p
 MK512bvVkpFGAX1TMk2Rs69AiuZ1Ap53VcLypYXKDKNkcZQiLfgKQvHW4A5WCzYgQ1xuJDfzb
 vjee8unEHqsrHqsmovXXJ6VIXwvsYIiLbrPUdbezRr1VIp72ijPrAAp9GYBmQE/3OR9PSrBr1
 Ek7+iPRjU0QG7J4wgFrixxUjeB/WOwouDw/78f3uKsFVsvwI5soItav3sz/BQiUsEnmriY19R
 c3CIBg==
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/15 05:40, Matt Corallo wrote:
[...]
>
> After a further powerfailure and reboot this issue appeared again, with
> similar flood of dmesg of the same WARN_ON over and over and over again.

Sorry for the late reply.

The full 300+MiB dmesg proved its usefulness, the sdd is hitting
something wrong:

Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 FAILED Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D7s
Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Sense Key :
Medium Error [current]
Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Add. Sense:
Unrecovered read error
Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 CDB: Read(16)
88 00 00 00 00 00 1a 20 44 00 00 00 04 00 00 00
Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
abort!scmd(0x000000007277df8f), outstanding for 30248 ms & timeout 30000 m=
s
Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#307 CDB: Write(16)
8a 08 00 00 00 00 00 00 00 80 00 00 00 08 00 00
Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: task abort: SUCCESS
scmd(0x000000007277df8f)
Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
abort!scmd(0x000000007d5b5b6f), outstanding for 37624 ms & timeout 30000 m=
s

Then it explained why the warning flooding, as it meets the condition to
trigger the warning, a subpage bug where PageError and PageUpdate is not
properly updated.

I'll double check if Christoph's patch is the only thing left.

Thanks,
Qu
>
> Matt
>

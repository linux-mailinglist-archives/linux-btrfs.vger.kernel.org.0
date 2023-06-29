Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614B47422E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF2JIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 05:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjF2JII (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 05:08:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC571BF4
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688029684; x=1688634484; i=quwenruo.btrfs@gmx.com;
 bh=S/wdXoA3D/gg1kCejZzcrbKEhHUTYn7UAzuYjZKJfdU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ZCf19CC+Z/9teA+IBvW9dR+B5QzId6xK+v4SaDHwLQzTqdABx1yWHMRUr9E72eoofVtt5lG
 Fgkbyj3MUbI5iPlW9tRc8KkJm414TU/Y976QT6++JUK6v7QSv92Ldv/jMpj88OXHoeiwpG1+8
 TzVERakrRZTTo01/l3z/F1Q1njNkU6mvqZlo54C8GEvpvTSP49GokJmVUYbc0TGJiDalHnSLu
 pRugggv6cK/WNBb4qACByQh5bSsCCcphXMv3qnD5jn54mJ3Y1hCzlHpYdRKPNP9bwMO0ZVJj4
 7jrabQr4nUkmXYNPv4+udZ4nsEWs+VypJQbHI6OjNwrLKhqkBF/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8obG-1q1Ayz38rO-015oMf; Thu, 29
 Jun 2023 11:08:04 +0200
Message-ID: <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
Date:   Thu, 29 Jun 2023 17:08:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GmElcomke7EFqcFYikB1YUw8x2cSyDrSXlJUvM/em4zSzEmacqu
 7NmzBd7bAGibmuk6rNlzfA3hHotEWLFBWXxBelaop0R/BiwUSHh418EUQ3YMp1Mn8kwy2mc
 cnVsrNcxTtgnb4NxFfb5vPTOJpWh1d0aBlddQUh9/JOZL3PfR4x8WKTwT6CZVyGt+5THZqv
 dLttOFsgCTF8ZxSijZ5LQ==
UI-OutboundReport: notjunk:1;M01:P0:JHKRhW28VlI=;HKBz/7QYd1gGV+BHVzANTQ3v6UR
 ejnTy3aKAi0c6TUGoAanzU/uJCmcT93RObFIF+d6iuhWt/9+CKyu13Sa2dyhwAgswqbQc7ts1
 gwFmt2KYf0gE675C4VsEK90LsigYRwXuIcaFbuAWlANhvOzmbjJWlp8c39yb8q+6gx2OHAo6r
 PctZe3hB2mTerQP03CQJaRbU1PlYH1cZuxhIW8XzEhnjCyti7r7Yic8dt6pSinISCXyLGYw28
 56Ich+s3ImxnV9FpXMnJE9QWc9u7kiW8GXI4igxCe6GseiKY9Pw/krYRhk9lUhKYWXLK8S0qF
 C4LgahdzAiilwlKGxykFv+6ViWd3wJOnHQxGKrXy/aCUaCJCW3fDkw8NDKbVe2+uvMsP1TaJM
 xXbIRF8jmuOsCzHY+BU4oPmEh062kBUbIKLarcDdPSRJ5AvO/bBws9xfkh7Zu2f35ZvdsZUX3
 zeHQXgafYDT5crD4PohsGNY7F/9Yu0g8PAQSodobqhNRJgFtNyRsesgwumjMYargywdgNFlNq
 hqHv8Nx/vqGDazZjHZ8jBCVjfsRl8CA6T9j41fGW5BIJFpAiT+nvQYaFxKSLSr6k2EUOBM1Xt
 CZhR5Y1YUm1DZ+9JVhV+V+bfyUQjZrAhqBETfgMcMEnerxtX+H042WqTdYbRw6R2Ivy7lf+r8
 b5miAIYv+5Xw0VdGas0irkFPDiMZliyZP/YW8nNlx8VPZae72K4UQN4ICB9LmZUWC7LH33NCi
 TjFqZRCeoFLA8idTY+NEEyZZLyy869fhKkmEN0GV3dcet7W4R3mQ9EyIV4AX5nirb4D2PVRP/
 TaMXY+Os/0QcTx90qt0Iig8NhHci0KDBJsYKBW2r6kvcP3P46IJYIF6Fai0a8fncYFWHiA3ax
 MOsVIrcHvGGYBTzFePPTghcM05xoR6pRXq5pLsKiFfDyNQxS1JCz1yWFJplAA7q/DZuGMTHfr
 XMLfmZ1r7HbTFadB5q9U9YBZKw4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/29 16:26, Bernd Lentes wrote:
> Hi guys,
>
> i have a BTRFS volume which produces a lot of errors in the syslog.
> Here I got the recommendation to start a =E2=80=9Cbtrfs scrub=E2=80=9D o=
n that volume.
> I made an image of that volume (with dd) and started the scrub on that.
> That=E2=80=99s the result:
>
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # btrfs scrub start -B /mnt/image/
>
> scrub done for bbcfa007-fb2b-432a-b513-207d5df35a2a
> Scrub started:    Tue Jun 27 20:47:26 2023
> Status:           finished
> Duration:         35:39:48
> Total to scrub:   5.07TiB
> Rate:             40.16MiB/s
> Error summary:    csum=3D1052
>    Corrected:      0
>    Uncorrectable:  1052
>    Unverified:     0
> ERROR: there are uncorrectable errors
>
> 1052 checksum errors on a 5TB volume. Is that much, or is that normal ?

I believe it's not normal, but please also provide the following info:

- Kernel version
- SMART info
- HDD model

> What can I do ?

You can check the dmesg, which should mention the file name of the
offending inode.

IIRC there used to be some bug causing csum mismatch, if it's all in one
file, you can backup and remove the file, then set nodatacow for that file=
.

> Start a btrfs check ?

It would never hurt, but if it's only csum errors, I believe btrfs check
would not report any major problem.

> First on the image before on the original ?

Yeah, on the image first.

Thanks,
Qu
>
> Thanks.
>
>
> Bernd Lentes
>
> --
> Bernd Lentes
> System Administrator
> MCD
> Helmholtzzentrum M=C3=BCnchen
> +49 89 3187 1241
> mailto:bernd.lentes@helmholtz-munich.de
> https://www.helmholtz-munich.de/en/mcd
>
>
> Helmholtz Zentrum M=C3=BCnchen =E2=80=93 Deutsches Forschungszentrum f=
=C3=BCr Gesundheit und Umwelt (GmbH)
> Ingolst=C3=A4dter Landstra=C3=9Fe 1, D-85764 Neuherberg, https://www.hel=
mholtz-munich.de
> Gesch=C3=A4ftsf=C3=BChrung: Prof. Dr. med. Dr. h.c. Matthias Tsch=C3=B6p=
, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir=E2=80=99in Pro=
f. Dr. Veronika von Messling
> Registergericht: Amtsgericht M=C3=BCnchen HRB 6466 | USt-IdNr. DE 129521=
671

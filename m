Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DD5918D8
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 06:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiHMEpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 00:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiHMEpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 00:45:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CC115A02
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660365918;
        bh=dVdDsvGapwF0LB6dy6vmrwDTOVU/krNSvTg97+lCnzE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MQ3eogXbX5ZbuEyK9R5VgE1EurvALBoFsOjx21vE6azSazFgMKWs/d6yvoTTqEmNB
         fu0pB1xYFIhfrYyj1Ruzf/UPrBzKi9WI1L6FHdIxVPROh3cxHyeCmIoU+3s0F5LPyW
         Y+z7k5NzfuPoX1jOw1r/KYZ/VSgpDLb66NRfLoV4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1nboow3PYp-00pZek; Sat, 13
 Aug 2022 06:45:18 +0200
Message-ID: <0b4a3bca-cafd-b47d-d03c-a97922e49228@gmx.com>
Date:   Sat, 13 Aug 2022 12:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Corrupt leaf, trying to recover
Content-Language: en-US
To:     Ash Logan <ash@heyquark.com>, linux-btrfs@vger.kernel.org
References: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FdQuWAaq/3KzBCFTZN4NhJXg6eu71PcFo1CG0YUZTEjUCgoMgmx
 HHyYnzSVKKVjY6EGxyO84XgWuGkaeUaE25cL7+aNaJR+6yl2YFSVDkYAPhk6bEZDEwSK9U2
 CPGqnyS3ddhRO67IujOW0JfnzxRTO5LHc1yjKMwImUUzO4ljy+3PNhDJ3FmYJX2f+ePy4ex
 m0j6IhzXF5LzLUg1X0wIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pg2tPoFzEQ4=:mBlOp2ys9Ryu4BfcpADCVV
 aaimo4T5GGtjrTtFkB68/uamThKrwPjjNVoSrXAxjtqgpdv0aWF9V51UdPNdtQvYR4kWvlajF
 oGFMB6cyvxIJlhwSpWd4A7W57A7xhuTxWl+Z7xvrXLlh9IzN3a01OcXy/0E4yoeVcPAW61TeG
 uDG5bDwTA487obMFJND+7UmfgJPdT4vu9UkalMMxqd7Kcfpsbj6XTpfk1gd9Lkuj0d3IB8hrk
 1RFHgM3/i5ulTR0vV8HGFpiyufbn8evrWufUTuwrv0kWwthHZPE52VIgCi9DoJwA0Lbi+cfJx
 HYHmq7MsLg/CcBSFm8qE/IQTb0/VwOOw0PF3MyXhplAFo+TNIn4To/dE+8oEWBMBHK6F2tyud
 0LdtEorgtRHyTK8Fm4fO1bhGgGPVkyovXlL8Q6aIVDnYUNyzIvlg8jSTko+9MRICXcyP19jxi
 MqwF89EesNScTG0uRMY4tb0gwgmIUlrO6e5zWIQgkPmlyFG+lQEby4xLbmWNeYLsTGag3jFR0
 Q8Cg1/1yQtLMb9oeUhl8XQPbKSGYY4FdEvZz/Yo6Zm8fFxMRrVjW+wYE09X/dVY3mMo5+WDZ2
 re5aZX7vQGFGF40dXfgEIwYFG2amfHoRVCoZ5luWC9ycSQm4nZqEK/94OKOs8ktz0N3hm4F5O
 fKQvEVHFsYjyIuocuk8ZFy4g0rpj9AFHsWtaKowT0WJBrsoWvT9GRMvcU+rxGYYDd31IdebP2
 buCx0Ggu7KfxHhpJ7wVs0mse35Uo5sk7ZMYLT87SDUvLsQyS8STWWF8NVCcwCaucjBrIgmKNR
 qkFp3ph4vmjjO2fkkU+swwREwcWZH1cTomu8HyLQmV4NtOJCZD2+dlS/E23q2Ccz49svIpzf6
 h3s7WSFsiCbmqKwFrYtL2ltxeRw6VRu8GXzbUWegbc84aDmYC0xIqHT3AVBfKivi7awK4q8OF
 lz+I2MMMRQ/R1WEEgK3fRdp/eY1ORUl5UBfwsPss+fqgKjdi8lAIH9AEWO1PQ5KzWrBe4viwT
 54zRRqUGv27JluLn2uDN0RjElRfPTW5VehtiyklNwpvpTuyeVlOmmXTsDgcyFuTWOjRpqwVEn
 J1sTYavr/1cJdk5nUPoPfR2ibwolu469AprvrPb8kGz/OPhRpVG2Ac44A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 10:51, Ash Logan wrote:
> Hello!
>
> I upgraded to Debian 11, and I think in the process it tried to install
> GRUB over my btrfs partition? I'm not sure. In any case, I now can't get
> it mounted:
>
> [ 1692.811909] BTRFS critical (device md127): corrupt leaf: root=3D1
> block=3D35291136 slot=3D115, invalid root flags, have 0x10000 expect mas=
k
> 0x10000000
> 00001

Please post the output of command "btrfs ins dump-tree -b 35291136 <device=
>"

It looks like a bitflip so far, and if that's the case, I strongly
recommend to do a memtest before continuing.


> [ 1692.825324] BTRFS error (device md127): block=3D35291136 read time tr=
ee
> block corruption detected
> [ 1692.837448] BTRFS critical (device md127): corrupt leaf: root=3D1
> block=3D35291136 slot=3D115, invalid root flags, have 0x10000 expect mas=
k
> 0x10000000
> 00001
> [ 1692.850876] BTRFS error (device md127): block=3D35291136 read time tr=
ee
> block corruption detected
> [ 1692.859688] BTRFS warning (device md127): failed to read root
> (objectid=3D2): -5
> [ 1692.869075] BTRFS error (device md127): open_ctree failed
>
> btrfs check and rescue=3Dusebackuproot,ro give no dice, either saying
> nothing is wrong or repeating the same errors. I can't scrub since it's
> not mounted.
>
> If it is just the "read time" that is corrupted, I would have no problem
> losing that, but I'm hoping the files are salvageable?
>
> # uname -a
> Linux LogansNAS 5.10.0-16-amd64 #1 SMP Debian 5.10.127-1 (2022-06-30)
> x86_64 GNU/Linux

Newer kernel (>=3D 5.11) has the ability to detect such bitflip before
writing such metadata onto disk.

Unfortunately since you're upgrading to Debian 11, I believe the damage
is there for a long time until you have upgraded to a newer kernel with
such sanity checks.

Thanks,
Qu
>
> Let me know if you have any advice.
>
> Thanks,
> Ash
>

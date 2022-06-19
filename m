Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FFB5509C0
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 12:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiFSKko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiFSKkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 06:40:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7B101FD
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655635241;
        bh=Vpx4VnvwgdHFP41ly7/1inJnBp/KIr9FxgKvrRW87qY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZwIg8gZXcjuizdmtcvvrutx71wMxUFZmoneT/4xCJTUEiWwhHQxxY8aeKAkr0OJQh
         ksDOskXsIqSPPKi4kfn1D/i6Eg32zDRns7edkAcffqPzQXQ5/vxVO9oJIsuXkZlqb7
         vin3d4epI55l4GzDPdMdoe8EOpuvm6dNp7iksrXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV63q-1o9v701RCQ-00SAmc; Sun, 19
 Jun 2022 12:40:41 +0200
Message-ID: <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
Date:   Sun, 19 Jun 2022 18:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Problems with BTRFS formatted disk
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
 <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
 <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
 <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
 <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hFzHtX81xqvN3VpQOMuSkwbgw6CDgl3dkiN4UUbyoXDWtEQ2E4T
 D72Xxj3bp8KAxZHdBCiJp45sqEFi3rP72qz7pstJwIQf/uag+QuYro0Z1gynDHWtWGaj5Ke
 z397om0YRocfHZ7xSqov6enOugWc2z+WCRA+Mfs8DCwcNjPiINZ5EPjWTZd4uycN2pTlmeE
 qvhp2kzOEi9/KercFea/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eqCvwbrmYCc=:RqvPqwwAXGvdPE6MO0ViZZ
 NG9xszO9c++XUgKw1Eg/lnpoHzvHGk6BIw6GPYZ5V3+D0gNxf5n8ubybGoFfZzFgcJfkUWAjf
 ZesmQB4ONFIgYUPeniEd5xlqKObM9O//YXHkwBmM1J1EoYWOccl7SxqNf1YDkAsBfxWew/ldz
 sieezDg/d1BJe90s/CRk2KuqR1fIyQHmtLj6qgLj6F3YF4sGGF6QwMrK2f4Lj4o1RTh3brY65
 yVgrnKl7N3wB1qJRFtzHVHjFwyM6T2bPuhQHPepijYuPBcCujI8UstfIHkuqvVF+qe/7JnX13
 yKQfIoShb0+jb822t7wCeuHtlF6s0T4XPK8lSE6L/8iojJqmhUMxPcxblPj5CDDmImCLr9ShK
 GjbvKN0unUGGMDYdYzBRZliNQhNadAx1qemNcLtrB+IcgaKliXYcudJ3wX+YSk6pHICX5AclV
 Ha4f8ndvkyztIOb29LUh2PvsswkGUAEsA7mE4Zkgwf7Dmijt/fnT/+3sEu+FYkyErt0Ff/s8t
 ZUK41PpDa86dhSBCaiKi0vvY2tNcM+qv+Xf9s03KT82DUYObVI2rMHd9GZMrY5YxCFz2lx7h0
 puzCoOCy7cQF9w54rzylwD8rIOPFa1nGTiCoi860nvmiqNPTpNNhkQQtngPpzopwsxN2G6LFi
 cFNPIvV219tBx4WoGVY5S0uO1TjljLWjanC9Spt2UEN8Ocz/RUKkUz0tthcuSgIoeRLCAqdlP
 S1XTso1xkJuWCk17v2zyUEh2dxggSr0ih0H9vDR16qq1rLM2ay1NLDuR2ZTtzIvkprNRaV7Gj
 YIC8uR88udWK+3qkiTcChH/NEkbY0mPOsCoew7levdaPzgoH21wfTWqlNW4gYQknQxj2h4VZj
 A+uRIwbAfcs45JmeXTCRmMjIj8WDdOvNZQfyuUasm/aJoPuCXJZJe73jAsBpWR0ojzR8U3n0R
 /uW6gRTj/adE5KWq+eoKewv07t31fcOf6QN48ZlIH6ZoECDo+B+mA1SOsDAq4ECustTCLOq4V
 uWd8R0Smn/+ZSjfEQAlcTmTnEI5mHA0gJyMv2YjxwpP/QzXHojFVk9xFaf1mSQDTSH3Ulafxb
 qSUP+BrQmFJx+dc0ehUcpfelFLHbi5oSQYntOA/dNGsjcsrjj6wAJoCSA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 18:29, David C. Partridge wrote:
> Booted from live USB 22.04 LUbuntu.

Ubuntu kernel version doesn't seem to be that consistent even for its
LTS releases:

https://ubuntu.com/about/release-cycle#ubuntu-kernel-release-cycle

Please use something rolling released distro/branch instead.

Thanks,
Qu
>
> root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=3Dall /dev/sdc1 /mn=
t
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, mis=
sing codepage or helper program, or other error.
> root@lubuntu:/home/lubuntu#
>
> Content of system journal
>
> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs wi=
th big metadata feature
> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space cac=
hing is enabled
> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny ext=
ents
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transi=
d verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transi=
d verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to rea=
d block groups: -5
> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree fa=
iled
>
> David
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: 19 June 2022 03:02
> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger=
.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
>>> You can try rescue=3Dall mount option, which has the extra handling on
>>> corrupted extent tree.
>>
>>> Although you have to use kernels newer than v5.15 (including v5.15) to
>>> benefit from the change.
>>
>> Unfortunately:
>> amonra@charon:~$ uname -a
>> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC =
2022 x86_64 x86_64 x86_64 GNU/Linux
>
> Any special reason that you can not even use a liveUSB to boot a newer
> kernel to do the salvage?
>
>
> Thanks,
> Qu
>

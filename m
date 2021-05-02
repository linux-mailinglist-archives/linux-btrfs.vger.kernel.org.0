Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E243709AC
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEBC3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 22:29:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:36663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhEBC3L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 May 2021 22:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619922499;
        bh=tKwa+b2InquzMdR3MX1ISQQ/1B+mwpjHOaiTss8Xigc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k7M++Gqa82uWKpXnj+zgY1ozzcE+a7JFKbMjXuAQKhSrA28c//tsOYoIw9nw0P6Gq
         EBUsMHNN6PgXwXy9ELH+HpE40L/Yk3FGxekbHr4OOfF9JWl/5DmuoSdH0QtWWWXPef
         uq3Ap44NSiDFsHBy3NkZ2AlXWUOBQBr1fxIu81g4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1lb62F2Fir-002b6R; Sun, 02
 May 2021 04:28:19 +0200
Subject: Re: "btrfs replace" ERROR: checking status of targetdev
To:     Yan Li <elliot.li.tech@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
 <63953997-7b50-0daa-4a16-d78309136b81@gmx.com>
 <CALc-jWwuTDO9LdX6Rgu28pkmnVWbgHFuRDZb+16_Ebs--2h=CQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8ea32dcb-cb6a-0988-150b-0858bf1374d3@gmx.com>
Date:   Sun, 2 May 2021 10:28:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CALc-jWwuTDO9LdX6Rgu28pkmnVWbgHFuRDZb+16_Ebs--2h=CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rRUFnXaOc0XADEFR89HNfeQmVgFVmEohfpjOowu9Lj8A8e51Uwl
 42PBxUW5p3v1cbNFLR77riS3RT/RWA9kUFYGdiH2CPuoEB5uQTPMdE9+d+G+pxB8Nt5PZu0
 LvVrAA/jm3cRWTAjNvnrG2OTyP5PDh8d/+tW0ldT8e3nUJ8iOmWVTDo8SjQSNPfBWkjlMOZ
 06TO/nyfqGmB1VIPwwIUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aV6rzp+h6KY=:B3VMzvw2h7c551mgB8pnDa
 pk8J1FiJGU/OV11H+eGsSNIqjF7j6gVUHoJx9zGejc+LAXnmpFHt1nqqjfs/zBdV1f/4VJneV
 NZdjtiZLnWHErb82pcFwADlNSOY9s/g/tkCk9+f4YjCAYKRxVnteBwp4VJFpFN+MljeBkfapd
 huR6MjATdcZOnM0bDxBZdTl5OWB2D4K7BgxGO4DlJ+lb39NdnQ2mBnx9vzWZBRkgNDslMHHwE
 f52awYnRkTv+Q7WVicbzmkgOAnJVfnpL9YrwKRx54afiIbNqoSivSN6zkRKQoCZbrp7ISaiB3
 prHlCv1dQmBYvIC2tcIK4DHOFzlZXAngWYvTFRaiDUMs8KfYBzGr962jhrw1PTERaem7hmWH6
 0iYuW84NMBsSXOt/hvv3GsLrY8NWXF61Yl4upKqJLldElcDU0smhn0IBcVmB2MaUJwQ4/6ahh
 B3RYETz5kJUojON/NuetBJqqXD78+wKGm6354O9KMGeACynhQOJcs8TYYVlNFk3GY5r8t+4rt
 sxLfP8A+jXQMBmcO+a64FOPwYw+W29GuoNHPcV3CXlLFRYsLCWNvo4XCbkZCThsZ7H0FjYN+B
 RKGT0AeeYR8sQCsOfBp4iSklOqT3v4jGUAjIeg0oinfxVRDd1sGBmtsk4FuvyMLHXFEtAprbv
 K/2ufR61graJrWvlIn/HfE0du1litMfK3oKtDfCvgMxkNr0XoCe3wckDw4dbADRSKwZZyMBpX
 Cvx2B1IIpLxN74/ujU8+dbx0KRP5vRRs1KU4Uc+dna801AmEc8Q7rtSxrpJaOhX4q2DO2Q75W
 B198jUzg/FCPaqVj5yyK7POgsuiXABlxwmrnZKRlw3MGMemAI1mezhOZR+crtP2cGQLtnik6j
 A+mUYsXBv2Lc3jCNrdvjqwP51+gLuJdgXFjFswVaVeoPO1ZUdnoP5XiCT1rH9xvfW8BuMEZfK
 WoWoezAl3uyc1NGb16GBIjCIHKynD9rWaDSoGuTy8QEuprnTXJXo65e4rZHxzontG5CLOJY/Y
 ojSBg41RfL1taZ+Rwc2k//uPnjm8lhr2HDzNhiEsd4yRGj7t/rQQD/507MP4ACreSMGRVKwEV
 eFXIoYvyc+RtxuvvlR/ZO9ds2roHqaioP7EFHai1QHfUJez8jf9mPUdTX2nvkmyjYkkIscNsi
 bkAT/1wAxz6huDkhp4inArsiv+EyBUIDs21XYX2GHxDRsFwvYf1KQl7fYxbj7UUq75JpbPcys
 0LNORTx33vRmAPTSV
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/2 =E4=B8=8A=E5=8D=8810:08, Yan Li wrote:
> On Sat, May 1, 2021 at 5:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> It looks like a bug in btrfs-progs.
>>
>> Fixed in v5.11 btrfs-progs.
>>
>> Would you please try to use v5.11 btrfs-progs to see if it solves your
>> problem.
>
> Indeed. This is fixed in 5.11. Thanks!
>

Just a note for anyone maintaining btrfs-progs for various distros, the
fix is commit 2347b34af4d8 ("btrfs-progs: fix device mapper path
canonicalization").

Thanks,
Qu

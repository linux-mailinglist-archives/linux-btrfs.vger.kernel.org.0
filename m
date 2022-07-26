Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D958090B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 03:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiGZBgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 21:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGZBgH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 21:36:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480F1F2F7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658799358;
        bh=yxJImkNFC3yY4rbUn5Wc51ssWB9ydGySkwQIqMiTuuA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=fu1bhZatFGnIMmwOjDTbtjGcCmQGcMqcmwrpZPHCjJT0Ss3loVEXPt6MKVl09OmsK
         9iTXG0szaXemNlsvcT3m+b5KS1Xx/5PH+60p+8YuSQKOs0Ipv81LZUYoMVmpyR1W91
         Lei2CPQ9IcTtMLjZpXO4pbt9UsYu5OK+p0y0le9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1nrdW02A9J-00OUPe; Tue, 26
 Jul 2022 03:35:58 +0200
Message-ID: <6271e1a2-db85-fb20-6ea8-d23afcb6bc69@gmx.com>
Date:   Tue, 26 Jul 2022 09:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Tom Rini <trini@konsulko.com>, Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <cover.1656502685.git.wqu@suse.com>
 <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
 <20220725222850.GA3420905@bill-the-cat>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
In-Reply-To: <20220725222850.GA3420905@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wH7FgsuLP+zatFMlHw0RaVgx39pJ0K6uTTnXvRelUGG3vOCo39J
 sJ6cbsMz847SEFasSI46hig9kugBIFJ7iDAL1QPYd/2QTexV+wSzgELRUtW8a3U3Zd1TsuO
 U1EbFmqgb/xeIdQtLCgT5xYaDaWIIXIJ/dBLK/6yI4VSNlR0ASis0Y4w85s+OCDRqHtSZBI
 8GiOEpeAmio7QFUD/OXMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jSmGu9NDuEo=:HJLgf8uEkvgge2LHSCn0T7
 SB8O7h4bRm38/gg2Se5pxiGDW6BE+uDFvsvx1A7nDZzzPAk/aQT/vcYpjq6OtHYMDocCniIO5
 iFzpWz5H4MXo36tOqcQVuIQ2LYWbMCQRFyWR8hhaFlIYkQMx5D99PdphAOf7lBN0i1Y3i/pJF
 2SRPP3ul1WMVinJlRjLNdLUhuCc+rtrTuRkRrOapbBoYqHRYuAPgsl4PkTBLnD66y4MIQ2z2U
 H6f34QMab6q1w/XBwqm9Z3dAVytYKHNlM+a5gzGbmW3pk21IdduWNzJwAfjS3hBunsY2xIeOu
 iyDuOYaOf01Ar6oRPc3sDQAG95x4P3z64S4snn2BDGjQRucvhiCqDoX2yDCOyxb9uiPhoxL7u
 cQgsaKxxbVDJ+1xTSnnZLoq4aKkiRx9ZY9/uVNwcVE0dRipUXMc6bYwdsonzG3bmNyjO5mgS5
 fK6mnnxmFjqytP4MXNbGL7k+Fxz1AxYUDWXt7Z7GxoZ3D+FjgX+6KXwkHNPMHNv2JcKhSFPud
 PQRSlFf8J8fJ13IufkGGsTkuUguq5ujLeS5USTcKCFHFt7zdkwIoig3CLmGj5Eau1QQYCwZCy
 JkGOTn//J4wNri770rsLyD8pAPir+ZNzMChkrM7IqZwJO9b1OJmeJcJjqG3qUnikb5ZM8Pndd
 We32z/O0GTR6SWiefDXRWVFBC1d+1LcMgyBVy+3yZR/Prv/LY+o5QER6SN2x1rPleXftgxNyg
 QbbF9krbQSgu6Ff9bBcm1eJSArpjGtNnDao+YblnTB0Wb5ao1SBnwail6ZY9FzsBsnimeIo11
 GttSGXTamfEZPzBBmRnVCGez1EmA5FOOpTPeTeQbHp/HFKe5/XRp2+xWUVGnCK3WyKAJThv5x
 KeplemRhcMFgduWFCVTUZGc1/avgA/8ZVVpDk2DNjBzjVnZhEA7KR5a6/03562L6G15vYGjkz
 uNgHXDURGLyz7miuGA/OiGbWcwSRk6q7Au8JxQK16FvU0UMwiJRQXyqwH/q4Qf9e2Stl6bdkg
 7jXiJk/V9Y4/bKqJPqDYXo0f0wOZ9EK/RqlEgMuSRH+od772OYbpRm+JA6hBUbt01pno2zePj
 6C5M0bgUhrqSW39ihMK9VvCvgiXUk0GuSS7zrm9uygRZoLlRf2/7biUhg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/26 06:28, Tom Rini wrote:
> On Wed, Jun 29, 2022 at 07:38:22PM +0800, Qu Wenruo wrote:
>
>> That function is only utilized inside fat driver, unexport it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> The series has a fails to build on nokia_rx51:
> https://source.denx.de/u-boot/u-boot/-/jobs/471877#L483
> which to me says doing 64bit division (likely related to block size,
> etc) without using the appropriate helper macros to turn them in to bit
> shifts instead.
>
Should I update and resend the series or just send the incremental
update to fix the U64/U32 division?

Thanks,
Qu

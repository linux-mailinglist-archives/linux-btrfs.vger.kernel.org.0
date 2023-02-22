Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A169EBE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 01:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBVAZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 19:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBVAZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 19:25:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB0311E1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 16:25:37 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiDd-1p9y3s10Yh-00QEKs; Wed, 22
 Feb 2023 01:25:28 +0100
Message-ID: <d4c6e5e2-023e-415f-0eb9-5086c43de816@gmx.com>
Date:   Wed, 22 Feb 2023 08:25:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: something in the last misc-next update made btrfs/261 fail
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
References: <Y/UvMqKqO1Wpy39l@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y/UvMqKqO1Wpy39l@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1SohnZzXUieXiiKiT0vUJgKKsvVaIaMuImYnvFOeEyeyEfVVVMC
 7YcEMmmft92DmT6Q3qzGB4nALobXCb9fgVFkZDbTCm7CIN+xuNc2Sz95I9372Z5TbmWgwJ5
 6huYP64XF0YdxmqNnmJqU/3gpka+j3QSIHKNKebS/s410LveBQy129IL855+fJHSG/cJj94
 ggNLWoHihwqMBiX9zEjsg==
UI-OutboundReport: notjunk:1;M01:P0:cbiHjgPudvM=;3qAoKexEpAk2dr5aU8sQyOxhADy
 iCABfx1ES0fR9kp0ljbdk07g41QzBf20sbh4NI236lYnDHUmPJmTiKUf/kUne/hXXlpnXJAbs
 jFIUMItjOnJlLB1wHgGP/Z35NrWi5A0O3s6c9MYU4CNUwptQvs96XqEABYwhzmph0yDuYixs5
 YXB5cd1cm6x8Mo6o02xIfaNSJ6YJD5tbAUXJUb7B5tC4J97P3jdRH/R9DmnNwhIp73yG6maGu
 LDxJ9lUmS6TVHAVk4FkQpf9jSmJNtPtHTrdRnZXrFCaqZdbfMQoA7v9+6J2+sEL5N7fHmRErd
 GIP3+nmB4rOf2yFjs5f9bGk1AcifceUOo/92LhXJpFkMTlTgKVpm53C2VcgXpm8EI4KDOWkPM
 X8v/tf6cRtcVpXNRDNp/b96Ry0A6zlWd+kzXak6O5kPWioC7tBCmKoj9LO+yiIMUlqESjKNR5
 0fSSf3/exGgbX5pIce/CMiAm6L0hS99G9/c513IFNZhOsnM0WpZiNLhunHoQrAHOA0R4iBchg
 FXIPiVUENm95kakcM4z2e/66drefWWVGXO+sCdQJftw3HHsGYO3vKf83e/3gczXtLdCNjRuHt
 O8DkaT3CEIjDZHjUEwCyiPVKZKow5Vh+XRMIA0urF3N4VHAuD/xhVUeDMWiGIlS/FqNUEeLZx
 6MnT9j+WuRDsYx+TYrQ5fdTqLQR94bV1IRtDnigBwx6UH0n+usf84cuCTCsp0my8IBd4U5gkk
 gieBxa0WwnzEgpHmv2g8MkL8x0pyLJyYlkRPVkiPN1J+512vn0mdkWldVzN33hXGXoEa54Wt7
 RHw89L2gxxDjUo1+/bWrV2sYE8olLAscC0cjDWl3vBlpK5PeDfZkFRc1fa0epXe7KEoN1NckY
 9Pp5ZNIV9i5Ri3EGbIIterqVdA14UFJjimBbFEvwVwId49sBIh8t+RjNjxzDhtYvdwqorjBaH
 8Hdu26VrQUhSHEHN8Qu4owB9bc0=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/22 04:53, Christoph Hellwig wrote:
> 
> --- tests/btrfs/261.out	2022-08-23 16:09:54.526648628 +0000
> +++ results/btrfs/261.out.bad	2023-02-21 20:50:17.796750095 +0000
> @@ -1,2 +1,6 @@
>   QA output created by 261
> +ERROR: there are uncorrectable errors
> +scrub failed to fix the fs for profile -m raid5 -d raid5
> +ERROR: there are uncorrectable errors
> +scrub failed to fix the fs for profile -m raid6 -d raid6
>   Silence is golden
> 

Also confirmed here.

Bisecting.

Thanks,
Qu

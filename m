Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4300B74C0F8
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jul 2023 06:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGIEoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jul 2023 00:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGIEox (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jul 2023 00:44:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07521B3
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Jul 2023 21:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688877877; x=1689482677; i=quwenruo.btrfs@gmx.com;
 bh=gGi0hiRzdLJlCMKgXzD+Xw0RHhLNY1Ba7Ldf/8mpiwE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DXhioBibbq5VdwnlhTvRHV24deUQ05DvEuCVTgwk1q8ZtquLparH2ihnMhDNNcrM/1o+5KZ
 r3dJql5KqZo3m8SUd/kMiO4RK2NnAWlCIWMyNxwSr8OiB30EYQAchRo/0kmrt9RbvliQb/c1H
 JLnLheSRu+tG6O8a0vQG2osBas6vdUE/IJCvuCUMBU1n5WntcrSd1hRRxDbgU9VcXPWoqy/ib
 gVlTEfuzX/jpHvrXVA+qb3TkqQSgU2qc5tueP8L1RzmXlC6kRg48YYhn+hAMrphVPD7NwGhvI
 M3SNxg2TQsUoLQRwTcxAQT/JIPHZ5Wp6+T+PSdhI/F7V22i7jPnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7QxL-1pvgWP0dxN-017ig2; Sun, 09
 Jul 2023 06:44:37 +0200
Message-ID: <11964cc8-3415-74d6-a099-23ac80e34932@gmx.com>
Date:   Sun, 9 Jul 2023 12:44:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230707084027.91022-1-wqu@suse.com>
 <ZKf5dDGx0S1YAT6/@infradead.org>
 <6ce97a6a-7068-311e-a63e-c6171321101a@gmx.com>
 <ZKf8Lf0iz2gDSZXg@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZKf8Lf0iz2gDSZXg@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D880DM+1LwyJOa3+V8te1N4YAur5mjMA1hYZMIHJ2m+JoXJPTgj
 8DOYL5IMUWrN4GSZCqxLnza6bfJt4XjeTghSEir7wsi4+HnkYWYX644dnvE2HZi9qA2X21d
 0ZSmbWMJhB9rO8/HL+CVIJBdg3UA3fKNoz/KCa9Pspl3j5k1haJAd7VYnJUccFeXh/8/ook
 b6Z0NDCVFOaxOdJAYo70Q==
UI-OutboundReport: notjunk:1;M01:P0:saMg8Sj4SrI=;muK2KD6u+bin6yISz47Y+4W2ty+
 LkBRkQlDnNodc3edY2Alp72eJHhBHeE4wXVtmQQD1qmSSONmX9KepH1ytsuE2JtfuwhrSqZdn
 o5uo0yLi0cKJolEWtDWDpybj0mYOX9RNkD1JNbSfQFAmpMbTDvKDc7B/s3XTfy/qwXqiARhzR
 WzdYqQFxlmdy/paoVoIPJIam1IixD2Yive2Q41/UmhJQDsxCoee31p2eRXEkKsepERZ/wgmiL
 grX9Nx0GgE6oxR8GUZvJi/XbdULCsAbjq2JLBLZJg5LbCaG66wGw6YWH88AbY63krr8XvluIe
 pUz0B/ZY8O9PKTMJUoFw3B2q++xlvaFEn8OwppV8LCie0qCuv8wSIsn2Hu4KUi/uUhYyBebbP
 q757fd5uGjKYikc8xpsK9iKeVMyoWIka/+iTwnwr+IVZcssiMlgInPlB07NpvQZxCBq3GQUtz
 l+wTwFSt4dkxXSAetn/70LYdGM60OlpQNW1JHwZpFvTXuW9Nz9EJvI3aDOkY5vQzTWluehU6p
 PE5SPKGtlaX9e/qgNh+8Rx39IOWXnsMYDLZKXIUX3CxOxlJ0z7e+6N8ugI0JhFak798n6gqt2
 +e0h+IcVQLfCaGoIU+J/gzvcnoCHOkY1YhOwtUxyRfSbynn7cBISjrDk9fJ8afqu1FPkA41hZ
 wmeJXZ2X1ub7rFudl8H7zod1RXd+fuMtG0DPaS4qonca0wi2Rn8eD548hXww+LVyliszMRUv/
 H9WrUVsFzBCUQSwQtAF24H3LT1fsJPPSyIl288xzWEjlfO8OCV2cEHHvkW9a2ORwCF2R+mq4B
 dBj5VUUQYLXkmzK9cihZZxlmIgRg1GcmUfe/3poZgia47UuDeoMH462qPwisRwmHLV6/qlhoF
 EvDfC/gWDu2/Ggtk9QJnG8f8teghmBo2HXgRf2B+uUSG5yz4y5A+LRJ8v8af8XJ45rshkSC0S
 surmOxEkCaWfcSb6ofQZuCGolIM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/7 19:51, Christoph Hellwig wrote:
> On Fri, Jul 07, 2023 at 07:45:41PM +0800, Qu Wenruo wrote:
>> I mean a multi-page/folios version of find_or_create_page().
>
> __filemap_get_folio with with FGP_CREAT.
>
Unfortunately __filemap_get_folio() is still only creating folios using
order 0, under the no_page tag:

	folio =3D filemap_alloc_folio(gfp, 0);

So in that case, it's really no difference than find_or_create_page()
for new pages/folios.

Thanks,
Qu

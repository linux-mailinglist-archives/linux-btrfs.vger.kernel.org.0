Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2898E54DE7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359560AbiFPJyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFPJyC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 05:54:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9BA5B3CA
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 02:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655373236;
        bh=QrRdTVUfQucCCnV1ZtlaAfOE6+V41KGbPrQh5pmVfQc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YXUHAa6C5/72Kqsc1oCPtVe/Zg8ni+JpuwF9KWDbU74HKZN+8mrwm2eiB0/IhfijF
         fFohtLHIq+ncob/pkFL0qYVv/wkBpjyGfptlw2MmGSAvSDcfCMrgayvJaXvZu78FiT
         5Tncja3RFP4uk+2lDTl+2x9XFSLzBvOH9ANjhp2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1nU4Cn3Ed8-00gWvz; Thu, 16
 Jun 2022 11:53:56 +0200
Message-ID: <63bf9e04-373a-0bee-5200-c843f0490f42@gmx.com>
Date:   Thu, 16 Jun 2022 17:53:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/5] btrfs: remove the raid56_parity_{write,recover}
 return value
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-5-hch@lst.de>
 <281a06be-aba0-bcce-5681-dc81b0245124@gmx.com>
 <e2d5e49f-28da-95de-20b6-b29c0ce00cf9@gmx.com> <20220616063618.GB5608@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220616063618.GB5608@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3B46VKtqCXFMBuwajJbEuuwO0siMWqlw3feJy7bfmwMZtsClFfI
 +fTuwNdIl0zh4QaXcXCYyokokKGWeUNfIQJoP4fgzb5gGOzEB929bJGcHxOxcaySnuhibXi
 PuooQKKWQ8CIIZTQ1mDSb5j1Ip/NvJJc/uFqfMzJUOrKla/Ts/Q1zZMe596qe2NXU1TZ31N
 DHrU3DslPhK25Sn59H4Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YxagJxTJZgU=:ZhgJ0CbdJu0W3q5IQutFFd
 IyHt/E6S8I0N1jzspCp8CjeSLb/WOPUuxlRKWY0AbYbaBzTZoMKlMQaFCLfu620nQBM24H+AJ
 Hr0k7mfRmkQDzwzzQDGOhR/oPvfrsfSU/8HMtvsa9kz/X7S8uQbpyx7cNirjd8uO6p/4/kNZL
 A9xvfKxDjHEa8STJ5uhyZfT8ktl1WpOJAVVTKr1qtauaDpYFRG5pg6TNC18UlmcDFJ9XcUoHE
 V7PwSEpSmu/JntnJjCY0qKqnndkm84ul3JTjxNIP7Tm+UNGDDnWzfTx6VcwgkTIipOzOQf98a
 lv5fXFKzPyCofGzXU1Q5OK1oyrQYVxUFZ26R9/R6GlyDeclzXQ+s9QylqDfeHF3cc9WXrjG7a
 45yNjUuvp5/nGBk3jbAcPv37PF6LJqFuqf26wSm7x88f5p/x5H51Ya2hLoSakpMZk2SbomU9z
 nZH5mpbhYktVIEYJKMKmBjChaeOhb91CHBlm7AvIqcL+GqWmqz93JR7FM0MlUwRd7Y+w84y+t
 27/9i5hDgD3oq5eT+DsFeWfOKqcoogmR7SPBq8YMfE9M4Tunh6a7FFaCu8xTU+wAnH1svXmFH
 NV/Sw6yvcQuZ+Iwc1DljVIvJZ4V/qnPtDUzFbfvFfAhIO4wQVHB3fISOVr7I0b/ECzxNi+5gE
 MKJ61fN+7FjSHm6KjqRwIODqg8YE76xhjKeKGPgjurgi2GD+I54ozU6BtSVnfwdEQ0aZ4aRP6
 QgyznL8GdyHtlUMjYdD/xcLits27AMTPV8uCab1UGdHt7Ah4ItwVJJkMu3TghNkE8eMTtuqtS
 JZaSVEpPZXq4YM2Q7I1RHqwQSLxjD3ZypZr89tXv28D4XrZCN189QIxSSUbqG+EnvIh3/9xuu
 TCGMvyQMHvo4yKPV5+Ha1xOeZvVFY+i4WAURX8VCnOOeIBrg2mWUYydhRNW7Y5HbmDdgfcANH
 GPE/ppwf5+jI39FwQgsW4KmNnzC0HBFK4O1oWLBQ21JSIS4rLQTmxzdBY6zU6rtQPjW/43XCJ
 Upxbguppz0Tvm1ovKpuqC5s1owYF1YPq1rw3B6l8Q9JXI+w52qGRKKRfLyTfYYwTd/B/MmI+b
 q39r+tqBIODsSDetEtUMVwoz6wJRMMz1N3NNedZqkB0e7HjVeJYe+OEqA==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/16 14:36, Christoph Hellwig wrote:
> On Thu, Jun 16, 2022 at 09:06:50AM +0800, Qu Wenruo wrote:
>>> But at this branch, we don't yet have called
>>> `btrfs_bio_counter_inc_noblocked()`.
>>>
>>> Wouldn't this cause underflow?
>>>
>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio->operation =3D BTRFS_RBIO_WRITE;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio_add_bio(rbio, bio);
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_inc_noblocked(fs_info);
>>
>> And this line is removed completely, any reason for the removal?
>
> This is all part of making these functions consume the bio counter
> as documented in the changelog.  But I guess splitting that from
> the pure prototype change should help to able to understand the
> changes, so I'll do that for the next version.

But I didn't see the caller increasing the counter either.

Or did I miss something? (I expect the counter inc/dec still get
properly paired at least inside the same patch)

Thanks,
Qu

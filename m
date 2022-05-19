Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD652CE6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiESIg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiESIg6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 04:36:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8B71D92
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652949410;
        bh=af4L7AKZT9zNFtIoaQQqPY6fW2W4dwIXBVv6LRFomJg=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=FJsFZbXbZfPx7RRDhBY0VHF6oHutjfh60ok9i0ubn1rT6uGGxwHb9jyVlmYsqHnc5
         6W9D9BmITgC6wsOo95wyHTgOnrOeR8m2k+20Dqi51I+65f6XSASgFHb4pGJMqrrsu+
         DbvBJQs3nfK/Hpwwlq9rbHcTZRn6lQF3u2PsDqOc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1nlWsy0KEr-012Hb6; Thu, 19
 May 2022 10:36:49 +0200
Message-ID: <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
Date:   Thu, 19 May 2022 16:36:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
In-Reply-To: <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zblI4JBKBEwdKO/R1ZLrjiCAHWo7MRZwH0AFW1xA/hJ9Zq9bEel
 IyXCV7c0Xrf030kAplTXGthUi4MdQULabxvXXRWA7s5RwDMAiGS/lgPUlV4H8uWf97EIPyG
 LCI8HHHwRyXsdKtdrvKkrjgpD+/cxP6TKXubD05fGQJhw3nulZi6kZqrCVNcWVj7SEImhw6
 jF2RwUZWvP4+N/L9zUi3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x9SEdo768fs=:4g3snWv+lSVmcKFnlxtgQN
 uULDoTAsm1+CVp943CaDrKHym1npvA+jNL5IGu6IuEcZHUNiWDY6pcRTgNo46oURhO+LkgfOZ
 giSlOky8CLBH0osVwZJujWagSuxRkCyPbOn23qFXlAfVhzFRgZnos7rGDXtT/8Z8UD50Pn595
 yAl+7wMoRDY1cW0ZxtvCPy/ckxUIGwW+PjHUVTN98TRs+7Oz7PR5VgJnzAUM5mc9ftI2W6FEL
 0C3fjbOTye5XiAafJOIj1w04nrHGWt2oEGnapuQpw7uc77VRk7XLNSVPSjZLQPcrBuPiB15cL
 emPYvt7eFeyHj+8CAo7TaAAyrAM3DHKrQHAOy68NFTyWs2ZXlw983FkD2Yw3qHKmp6XuvCMMF
 90WD2vZETfYCBnXy8UHM6V5D8ZlQ4+dOZcxwK1NfDmQ3aQrqZDhD+f3yhLvKGpqVwlhkiTk18
 9uYEevNo7lGCyMWd8drlXGTmcPgOYebjSaBULMJCv0niTbNsuQTIRyYmblNwbxaBnPNteo+aC
 LmPjWF0RiXRXHZ3mvtuKuY90BqyQluAMv33rA92mCv/O8cpxVEvIgajEho+IqOSmdy3X5L+kn
 w2OetWhq5ELx29Kt3E1C1RA3PPj+4wR/wml8gNsUqepOnFT09ZB5uCpRvDkzmK/HQR7mWsaik
 ZmX5t4NnsoLU1PVdh1PngiXafVLdEo+hIkdq+INd0ILtgoWpfbJSLkfQnL1k2uWZTLm8I0u6s
 V25fmdBmViVs31Xxn9R61B2vK0xXBAP3YgcTAODtBrUp59E1fMIJ7QvGxhIlXo5Si0sZ1QwgN
 sMWLjRfItXjkP+k8cKiW4CDRGWf6H/RMIbnMw/TirPo5gWBq8S3gqiehQyFI/Y8PKwmTE+BYT
 T1fTC2cpoD9nKl2+SfDfGBaoozblMiOFxbs8gRKpMqNO8P6WK7hiUN44ZCPxUaiNO/663bKh6
 LHU3PPiFVgz1K219n6aEymGnKAZu7o4QztwpJa7pV7x3f2aOO6zTAFzLplapyzFtCXpO4xcp7
 poYvUTh+STuc9aoFBy0nghiUzZ/U3bTPdryDD5zhPztHlVwIYmr1Xxy64P5a+srg0kXa+FSi5
 CLMs+ca7jfsig8mvxiMsFnj9F30ryq7AIJKoHlvu0SOEkT3Ydijx6sGVg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/18 19:29, Johannes Thumshirn wrote:
> On 17/05/2022 10:28, Qu Wenruo wrote:
>>>
>>> Metadata on the stripe tree really is the main blocker right now.
>>
>> That's no doubt.
>
> What could be done and I think this is the only way forward, is to have
> the stripe tree in the system block group

This behavior itself has its problems, unfortunately.

Currently the system chunks are pretty small, in fact system chunks has
the minimal stripe size for current code base.
(Data: 1G, Meta: 1G/256M, sys: 32M)

This means, if we put stripe tree (which can be as large as extent tree
afaik), we need way much larger system chunks.

And this can further increase the possibility on ENOSPC due to
unbalanced data/metadata/sys usage.

Although this is really the last problem we need to bother.

> and force system to be RAID1 on a fs with stripe tree.

Then the system RAID1 chunks also need stripe tree for zoned devices.

This means we're unable to bootstrap at all.

Or did you mean, make system chunks RAID1 but not using stripe tree?
That can solve the boot strap problem, but it doesn't really look
elegant to me...

Thanks,
Qu

>
> Thoughts?

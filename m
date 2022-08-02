Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E82588418
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiHBWSa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 18:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiHBWS3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 18:18:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EA643F
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659478704;
        bh=BLCVTNkTrgSdcQBPYnPzyTLqPMV7RdnlFjBqgmg8poo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ilwfMrBLRFnPZeQUASzDRniKJYKJ7MqLQ1xv1WyRwADncLYwBK7y0ACADvlUsvTZN
         SSxO2DTx1TJ/CjkpiHOhJTzcKfEujpgcYxynXnmfFZQ81i5gsBiPgsHrVM6vg5v998
         j0lHUarPQWCzLekn/JiXidz0/OSr48rwIgIs6UiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1ndtAI2Q1d-00q6se; Wed, 03
 Aug 2022 00:18:24 +0200
Message-ID: <6c1700f0-7389-268c-1d15-4f35288a2b9a@gmx.com>
Date:   Wed, 3 Aug 2022 06:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] btrfs: scrub: small enhancement related to super
 block errors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <20220802142234.GL13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220802142234.GL13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L0Un34utDGywv1VIewEybncnP/Txf+cJ601SB2eMysF6pBAIW7X
 ALcMozwceO9gyUiwi/hXnM1dTg9SM0YcF+TH8l3agDGusmTAEKHUHxjfRvPfsqslQOy4f+J
 8Nvwssb+uRwyRaCCyaJdmADJVv2LYeN+PwOqiAsiWcTp1QHlPGU1NBzsktk60TTnNGOuM1z
 ERKqTriGadBmDd5lDPuRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWRd7iIuZ2s=:qaLBnpwbsjF8ZV7B6mXYRN
 gtlxvCivuHIF0Aitl5v+D90Dud/CZPRRRKdZCXYU1otzwBYVxmJZ+UoCU6Vwq+aZRoNSnC142
 dcfTxokpmbCd/9AXM/5YL3RJ0FNSd2Upei9TdiUNSy74NyRYcADCdnS7vyXzZE1yqw/RW9/Co
 Or85TqnB8cO7ut5lirwWxWWYDC5lKyTA4GCPSsyeDCEmuP5PGvKXQppAyqB2HSLPh/o8cL4zB
 P045a39CsHbOONfn078dOlLRTHvd95xf9sIkFPspvGtlDeTonRo7P/f8gxQUXjTfMBqf973Mt
 ostA2xWqk0j8Xy4GzvHi52RoEKAhH8KCQq3yRQnuZnaLIQ/G97fvoHjVo1jjHCLZkIL0BHmBF
 m3GCevX+DuUb+2M0F+pM1gjrZI8Mz2xS8CGM6bYInM4pX60sD5kXaCkQ/AWC64B9F2lIiPPWl
 VPtjjy6iCFvz3t+QuHOG+z2c4XyHnqI//w1OKhGq4VKqJMaUKHhn5R+R1c/zirjpksG76VD5g
 J6/cTjYUAOdquS4rNWWhyoZ+aYhYZVT8Sr3UiPdpP48J0CPHE7DLbVbHjP0MBb0fR63W3d6Js
 c/otmoIN+4k2uC5TgwuE88eupJI8v2rue7r1bznjY+kadUkLEw98RzjDthia6AMD1/ZzG0+xk
 E9N27dBoQCtxPUqKSlh8kaDczDmGWKRyBnUaIhi3ALje9QCXO10+ex3JXqfSbiT8++1pNUbpL
 bFdBavL0+wH83WetEYpp1yengWFMNfmkwQMbevFAlOzQKW9NKMYBty2VgU9akWJUMdDncELWN
 pWSu6n0hP77SzZ+on/sgvjZPvLcT9rZRWptW2yrRkfj36t9UVlhWbCAjU5sYWzPCNuLsDUDKc
 nFVBPTBBOz1smECl8IA5UYxMKaA91bPA7qXsl/pq/kjVYLQ/4zIDMY4L9F/D/7caDNLehEBOl
 8NbyMyKk1GvL3wvDIxNkWMkbpy5AWdjNUPh6Rm30C6b3p4nduWktmnBCTmJjiNf3z1MJFTWqN
 truNsmjnV18v4H2WfFhMZLd90nqnvUtkj+HtcRKRilziXMr8B9KLt2TLhHdabE1kp3xluyahw
 LyI95lWzcNRHtuFsPKYkeQkQDWalhdvuj3htS4I+/50XibaQOoiePM0Ww==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/2 22:22, David Sterba wrote:
> On Tue, Aug 02, 2022 at 02:53:01PM +0800, Qu Wenruo wrote:
>> Recently during a new test case to verify btrfs can handle a fully
>> corrupted disk (but with a good primary super block), I found that scru=
b
>> doesn't really try to repair super blocks.
>
> As the comment says, superblock gets overwritten eventually, I'm not
> sure we need to start the commit if it's found to be corrupted.

The problem is, if someone like me to expect scrub to repair everything
it can, thus doing scrub (to repair) then scrub (to check), then the
second scrub still report super block error is definitely not expected.

Furthermore, just committing one transaction for one device doesn't look
that costly to me.

Thus the choice not to do anything looks pretty weird to me.

Thanks,
Qu
>
>> And scrub doesn't report super block errors in dmesg either.
>
> Yeah it makes sense to report it.

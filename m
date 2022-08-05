Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30158B27D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 00:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiHEWo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiHEWoy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 18:44:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD21DA73
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659739486;
        bh=EZDEeLHDCHT05JeDxPkGDFiOONLqP3koUfqpjxms1WM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gQ3fGTxxmy1cemWYxA4cRJLv4+ADLYFHoGYAvRNy+NqbjCNL5Zb3GvBOUTah4NnEA
         Kdybhkl7RIDdoV0yWW1nZbxOdiE7+XMyX1yX3w5spFBVxWTxNzCkNxj3dwdhjjWotX
         6odr098paYBfVeUE6tGGDKaWRAmfUJdj1re3yvKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1ntWdI0ICn-00Qmu2; Sat, 06
 Aug 2022 00:44:45 +0200
Message-ID: <99d73f60-868c-28e9-e862-04a934e741ef@gmx.com>
Date:   Sat, 6 Aug 2022 06:44:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] fs: fat: unexport file_fat_read_at()
Content-Language: en-US
To:     Tom Rini <trini@konsulko.com>, Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <cover.1658812744.git.wqu@suse.com>
 <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
 <20220805211420.GA3027583@bill-the-cat>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220805211420.GA3027583@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6fHU6tg0nJ2s08uFblW8t60l1ohZpMVr6Bpr4V00P/yhoCy5qfS
 SzIPnQkUcphor7fCrVjeZFBqSvtSsr7TmWci1SKkU1C27wdXxZhkVXsj8C5WjKPbC2l3YCh
 iXokM+iF/M0I0MbQ7mCkSmkXEEKJKe4uKcXvhAORBi93zFNJked1jzLcW8e4Gn7s3MPAvq5
 q4x8/uStHaGoQ3Qq7MpyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zaZGEnTNer8=:CADUofRyEbnLnZdbMz7KKA
 olt83JhXTzhPhq4X6PIuOqrj0+xNVt5jtSBZNpJ7mKPXpWhd7phsV5RiQ5IWrpFhTQjFAm2Mw
 NjIeb4/S4ZL8F6Bv/ZpBH/kwFmnmIgRJTobO6Sy1uAwxpZgSN6MYJTSNohyLUXE+Gyns+fEP5
 Cp8gDdK9hQA/uZqSfeGNls8Vh0FQT8kdCE03QOloLZvB2FA1ZO1l0BqKOfRWLwgpcBIwWUA0T
 vlrNkMk4akqVpuZ0q9+yIlDPnKGaA4mx0nQYhQ2zmCPYE0S1mjIPo3S8CMhJeJey42LFxQcW4
 q6h1V1ElGV5vUwA7D6NiZXMlJNkpgvv9i1br5ZAqmagYqqopzfZfaExqmX2SDEDd68mDr8214
 DiPJMmDj7LC9b6KNxq9GldN2b3pSVUML9kUDCzkPzbVjfp6OLrTQOLxVPmGELdhzB2oS8anTE
 n0wTdJTafhTDlAvMPPzr7NMiHsSvXSQjPNJwGXKWV+ltmIgEffMTOGsaG33w1BANLBXS+sOHT
 8dtsNI2r3+yQ5sXbaxh75g9n3Rru/OJCiv+VuOQAsWmY7qYT12ntvHzMg7RxBXvoczL9i7HVT
 pmv63e668325re4yNJ13ZbKEkPPFZO9EOZ2tI6SEPz5UV32vcYqFeqIVeVnRDvYnhnTJ1exGr
 EnTtpFLTS0ZhbZfBrTWqLxoIvEG5qz296f9BQZGAd4mrnSQdxRvB51VT3Ggynjpw1ORQdnMny
 /XLXqACKiNDXAtuE3ZZCbLQqa3jT3OxWTxbuBonrSYPCcjvPe/kAVkRYOAgzmM31vf3D2a4lh
 ayMDir7mC/klnG4YLC9+wPjb2zF8GV70sdHIPurmSLW6qDwuA/Bhh7vFZF2WdsARUf/9h0mXj
 uFpw+OeiZSUNG+cOEmDQPrDvCfGmbsdy/OGSHQZhljKgGRai+k9GznPaQ0HYWEk/CDOFJ6BKX
 8A+krGqRTvFdrC45KEvt3q03kt/e2ctiiMb6UwxXtZXWwm4MtFgcwWpv7+47m3on94YZm3m4l
 CvEXJlhewGkc7kP9GYfLAuTdY3sYUgXO8PA3ksant42w3yvpI1IWRDM5At6gn2NIDpE/AHRFn
 Q5x0agEmSzB3ALWdNBs3IZc1Mb+hJXcl9i/u+vahIcx8GaC8VfOgvII/A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/6 05:14, Tom Rini wrote:
> On Tue, Jul 26, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
>
>> That function is only utilized inside fat driver, unexport it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Unfortunately, the series fails CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/478838
>

OK, it's a bug in the unsupported fses (which squashfs doesn't support)

The actual read bytes is not updated.

Sorry for the inconvenience.

Any idea that how to run the full tests locally so I can prevent such
problem?

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8ED72D9E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbjFMG0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbjFMG0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 02:26:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98015E57
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686637604; x=1687242404; i=quwenruo.btrfs@gmx.com;
 bh=cYCt6em2y41rljFuYCFNXBvZq4YMzhezbJRf25h1aZc=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=rYtN7Hk0dR/Gy0bwkxgJfaX5yxrE0s/nIMOBUbMpOfTXw1OKwupXXhWPlPZEnC9cfiPCha+
 /ZiKGLNLF/NgVMDhhmH/fOl+WGdghUw/xBnWC0StsjM0sm7HXM0RjgpwiOKciu7DJCU8RPA/3
 4CsP8NGqRUuSJAWBVFkzfb9RVPNLAENFH0vn0UG+2Yr330hrzM68nYQvBPxCHqrFo3+NzmH45
 FXHURnPZi6+RDIpCq4+uQ0x7TssiQVhYi0JMCwysVrO+UgmGOs+aXArZRJRCmNix3g3bb1JwY
 +CHnRixfG1rMMVbNp/62kwgZb2tT5LF0S11IoI2PfX33yVEEvB8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1qIcWO3kMl-009gxS for
 <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 08:26:44 +0200
Message-ID: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
Date:   Tue, 13 Jun 2023 14:26:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Regression that causes data csum mismatch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jxfv6dqNJNhYZnKtnqfiJCxVOvJ5TB3TGkScP8qgA0E2wcNvVDA
 gV7ZVeN8icSl2WYlSs9pCUBy1Pgq/19Vt7acv35Xe7+q49achfvgorcStLDWVmebgvXzU2V
 uPEDPmIGwSBU6Ypzr8vlI7G7umFjHh1SLVF8ie8KvD+bmOrS2tHoTtv2b9KWYihuvGjtJTR
 aySVpdd/5kDPvP+ejLfpw==
UI-OutboundReport: notjunk:1;M01:P0:xKcrYrSGTs8=;aDfgE6JqUursp2rzP/Wya2WvgyX
 sFX/oGtsx4DO5Z8LmBUlaqoXp3Q4+9GYu8kJQeWnsk5NHkIqQxlKzfBY+iMEqw3xIr0J8Fxtb
 67TAr8Lszgt38Rja1QbPGbpLNvJ3HhtNZPwwqYCvC1CGPJK8vaPnQ94q87lbgFBz7U7WzJPrF
 5q/mpY7jh7Cn1RPgMUDLTUONKa2jSZR55eMbyE9EVLxal8rM7GciY2r9iFkGbuR8ifc5rG/v8
 52dt2QFJqAZr3UmSxD4u/Y0KIcoFR6/ElnmgzOu5v98Jvmc7y5Vnae0P8fN7scyrv8pQyylbu
 4G9WY7Fyg+KfpvlKlN9mFL1IEwjeir8MqSTCchYIwxBdMmGQE8WjYofEwIr6s0XDJm7G69QRX
 K51oMNUdKHK6cixq+LjBUNgpP4XyVY4mwZc0bm03NFe65ijWahs15PEH154tvmoilmomwcfzF
 uCMrYQKK9Pyy+dcv5GnT35ErT2ADTYsqM4mLPnRsJs3ZxZX6Sm6QO8qP8yUr83I5/kjB6p2z/
 36XZ9hKXbm4PE0pAHmrvlE2A37Zsv1PQQQLT/KgiNXejGzHCAlDIIsagifwPtpOGkqXV16zDx
 qP1cFkKYqoRnfopUNvL+rUBVlYgKtyppKRNhDzxmFLwJBXCvV1usDFVXkm+GZbPLG/1CTwPRM
 3nG791rK/IDSRyk7LCRnITBnfPlZb5c4/mNkAg/X3hWw+zNZtO+WOhkynAGnCgHbTiOfae9DL
 4zMN1rJoT31efVuOvXW9t2bW25ka2uSHk8UBVSihTZCXkPsQ9XKFFsojPNenUv4xhpwr++O6s
 EZkeK4QLQa1k83Oxsx3oEilfQj6CPdv2ZjRnsAYYIEpdrCaOLZ7k2plVOlb3T2BGKdKMzZkMr
 dZ95SKnEEpH11zoSSwG/m1oDhILGH4aOPj1rOf3XO+7kCY2tWkxynCOeh9vZ8CCPcADfpk2Fq
 tvXUv4oAteXP1bcycv4YGtS1asI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Recently I am testing scrub preparing for the incoming logical scrub.

But I noticed some rare and random test cases failure from scrub and
replace groups.

E.g. btrfs/072 has a chance of failure around 1/30.

Initially I thought it's my scrub patches screwing things up, but with
more digging, it turns out that it's real data corruption.


After scrubbing found errors, btrfs check --check-data-csum also reports
csum mismatch.

Furthermore this is profile independent, I have see all profiles hitting
such data corruption.

Currently trying to bisect, but 6.4-rc4 already shows the bug.

And I can reproduce the problem on both x86_64 and aarch64 (both 4K page
size)

Thanks,
Qu

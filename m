Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980EA578EA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 02:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiGSABn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGSABm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 20:01:42 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD72DEB
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 17:01:40 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id Dag5ohasB1SPADag6oAxNt; Tue, 19 Jul 2022 01:01:38 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=dKK1JcVb c=1 sm=1 tr=0 ts=62d5f462
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=lZFbU4aQAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=Xe7UgJ0w4vn_hh0pY4cA:9 a=QEXdDO2ut3YA:10 a=yKZbCDypxrTF-tGext6c:22
 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Chris Murphy'" <lists@colorremedies.com>
Cc:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk> <CAJCQCtTAx=82boq175vtAu1Z_S9D1tcNSErir1wTK8MbtMfsvw@mail.gmail.com>
In-Reply-To: <CAJCQCtTAx=82boq175vtAu1Z_S9D1tcNSErir1wTK8MbtMfsvw@mail.gmail.com>
Subject: RE: Odd output from scrub status
Date:   Tue, 19 Jul 2022 01:01:29 +0100
Message-ID: <009001d89b02$b7f2eb60$27d8c220$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0I+mo95iLQgivBE5YQgylXxMxEwG/+wJwrb+9o3A=
Content-Language: en-gb
X-CMAE-Envelope: MS4xfL8D761ga0vdlcCmVpgbQyx26VH4f8zOguOJfwgNKXVwDkbNzoG2+xXW7ay6IzjuXm4IEIKOm9l7Xep7gxue1/Sm/tNnZhZVPJ6oakLDhHJMML5c5pZb
 eS1NJaTwAp2nMetUL1PtvWle5adexR13gZLBV99Aan28Kc7HSM/2wyWj4wvj91JxEYvPYjtrxo0Q7pFXwIXq1eCDJz9dfHDntB8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs 5.4.1-2

-----Original Message-----
From: Chris Murphy <lists@colorremedies.com> 
Sent: 18 July 2022 20:51
To: David C. Partridge <david.partridge@perdrix.co.uk>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Odd output from scrub status

On Sun, Jul 17, 2022 at 7:28 AM David C. Partridge
<david.partridge@perdrix.co.uk> wrote:
>
> root@charon:~/bin# btrfs scrub status /dev/sdb1
> UUID:             f9655777-8c81-4d5e-8f14-c1906b7b27a3
> Scrub started:    Sun Jul 17 10:27:39 2022
> Status:           running
> Duration:         1:59:29
> Time left:        6095267:46:37
> ETA:              Tue Nov 20 23:13:45 2717
> Total to scrub:   4.99TiB
> Bytes scrubbed:   5.48TiB
> Rate:             801.72MiB/s
> Error summary:    no errors found
> root@charon:~/bin#


What version of btrfs-progs? Looks like 96ed8e801 fixed an issue with
ETA reporting, which I'm guessing made it into btrfs-progs 5.2 or
5.2.1?


-- 
Chris Murphy


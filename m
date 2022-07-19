Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7357A435
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiGSQc2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 19 Jul 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiGSQc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 12:32:27 -0400
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26DE550A8
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 09:32:24 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id Dq8zoHwNNiXxBDq90o2lgr; Tue, 19 Jul 2022 17:32:22 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T+Gf8tGQ c=1 sm=1 tr=0 ts=62d6dc96
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=lZFbU4aQAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=avuI7u2LPdAhfE06yZ8A:9 a=QEXdDO2ut3YA:10 a=yKZbCDypxrTF-tGext6c:22
 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Chris Murphy'" <lists@colorremedies.com>
Cc:     "'Btrfs BTRFS'" <linux-btrfs@vger.kernel.org>
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk> <CAJCQCtTAx=82boq175vtAu1Z_S9D1tcNSErir1wTK8MbtMfsvw@mail.gmail.com> <009001d89b02$b7f2eb60$27d8c220$@perdrix.co.uk> <CAJCQCtTV4gSBXCmqVG-6dqEC151V=MWRatrTX+hthur_PLT4eQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTV4gSBXCmqVG-6dqEC151V=MWRatrTX+hthur_PLT4eQ@mail.gmail.com>
Subject: RE: Odd output from scrub status
Date:   Tue, 19 Jul 2022 17:32:21 +0100
Message-ID: <002d01d89b8d$1f8df280$5ea9d780$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQG0I+mo95iLQgivBE5YQgylXxMxEwG/+wJwAf9OapICzoQXRK2aY/Lw
X-CMAE-Envelope: MS4xfLtskthhDSWBG8sxNuhVf1i60EntfS1997UE1IzXOZG95hse5Am8Z/08M/Av6H+BJ6oidr3dqSQlmjHT84Kt/NvsrO3vnDRw+UHNPI1xNGdPif8CD2Wp
 rpfY0qSSzQYSvY8F0M097JWZMnMX55eOVLZVX4ejUFw2FD4p6hOD+wGl9DAswuXsbAB2W9OgylKFxWsAwrdP7XxUcRjqSBcaRdk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Intermittent problem ...

-----Original Message-----
From: Chris Murphy <lists@colorremedies.com> 
Sent: 19 July 2022 04:35
To: David C. Partridge <david.partridge@perdrix.co.uk>
Cc: Chris Murphy <lists@colorremedies.com>; Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Odd output from scrub status

On Mon, Jul 18, 2022 at 8:01 PM David C. Partridge
<david.partridge@perdrix.co.uk> wrote:
>
> btrfs-progs 5.4.1-2

Well, if you can find a newer version that'd help determine if it's a
current bug or one long since fixed. Current version is 5.18.1.



-- 
Chris Murphy


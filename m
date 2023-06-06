Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30942724D72
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbjFFTq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 15:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbjFFTqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 15:46:13 -0400
Received: from libero.it (smtp-34.italiaonline.it [213.209.10.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900ED1FE4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 12:45:31 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.140])
        by smtp-34.iol.local with ESMTPA
        id 6cbiqBMf8bjox6cbjquPPI; Tue, 06 Jun 2023 21:44:43 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1686080683; bh=/uN4cGDtzvUvzK/VqUPn9hDmC3UbuUNbzNjrBiNAcOM=;
        h=From;
        b=rAPydNbIFH11kYz8cSiCbzFHmnZsft3rI9tN5Bi1KdWkWdO88JxmctFbgqEREhnxM
         pkE7bLbi9BjOJWxjwdR0wfb3GBMd5up/Dxhigxvz4JVMSoZ0TEg2pSZPfVo2OUtJ+1
         NkPpP66+r0aOuRUq3yPhvUKiGBTfweRPMMQPXJQoc0c7t/HmOvKpSBKm/VI4XhruYx
         wW0oxRUpHvxZ4YIzt2G67iJ12FAXULCJ0BNO+uhjiQcidpdbSq6C6SBXHD8VDvaowt
         jQozk7isccmm+u2/9aZUrdAo5se0ZXvYTLPN4IHFTOzDAvIY7AsTv18LJPpdpHJAHz
         v7BK97eZEfIhg==
X-CNFS-Analysis: v=2.4 cv=Q80Uoa6a c=1 sm=1 tr=0 ts=647f8cab cx=a_exe
 a=SDvFMQE/2DkMPFoCQNiONA==:117 a=SDvFMQE/2DkMPFoCQNiONA==:17
 a=IkcTkHD0fZMA:10 a=RjXbjNkwAAAA:8 a=xXlogzR1vBUuTfcnFhUA:9 a=QEXdDO2ut3YA:10
 a=mANIQKooQi_kqgsJAms8:22
Message-ID: <f5dbba3f-169e-993a-7428-484eb6cb98b7@libero.it>
Date:   Tue, 6 Jun 2023 21:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: can i delete a snapshot with rm -rf ?
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB73408FC92E78BEFF8E85C395D652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <PR3PR04MB73408FC92E78BEFF8E85C395D652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOhxd1YhVf5+OJE5ciwqxug+xAyGtx8G2fvQX6JL6YQyyqTxrGSDjUR4rESnrp18nWCsAP+a11Rmibif9mVHtaNsiR1PH0+ifM9TQAHCtHFLQqkvxEeq
 UWT7CmD3Mz0EA4NmDaJ7rLyGYTLSF3aSw6SmJTEVJtN1oAJFD5vBb0/1oiZhaPqn8HPepj9pT3uiCjbD4r6PtrdT443vusoZVmVUaMorm/4YmgE/tOlyKvka
 VdxIc4KjJ5yTCnGhcc8ccA==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/06/2023 21.34, Bernd Lentes wrote:
> Hi,
> 
> i'm pretty sure having read that this is possible. And in some scripts i do it this way.
> But now i found on the net to not delete a snapshot with rm.
> 
> Cab you help me to clarify that ?

I think that the biggest drawback is that deleting a snapshot with 'rm' is slower because it
has to remove 1 file at time, where doing 'btrfs sub del' can cancel the 'fs tree' in 'one shot'.

Of course it is not so simple because you need to remove all the extents one at time.

But beside the performances, I don't see any drawback.

> 
> Thanks.
> 
> Bernd
> 
> 
> --
> Bernd Lentes
> System Administrator
> Institute for Metabolism and Cell Death (MCD)
> Building 25 - office 122
> HelmholtzZentrum München
> bernd.lentes@helmholtz-muenchen.de
> phone: +49 89 3187 1241
>         +49 89 3187 49123
> fax:   +49 89 3187 2294
> https://www.helmholtz-munich.de/en/mcd
> 
> 
> Helmholtz Zentrum München – Deutsches Forschungszentrum für Gesundheit und Umwelt (GmbH)
> Ingolstädter Landstraße 1, D-85764 Neuherberg, https://www.helmholtz-munich.de
> Geschäftsführung: Prof. Dr. med. Dr. h.c. Matthias Tschöp, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir’in Prof. Dr. Veronika von Messling
> Registergericht: Amtsgericht München HRB 6466 | USt-IdNr. DE 129521671

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


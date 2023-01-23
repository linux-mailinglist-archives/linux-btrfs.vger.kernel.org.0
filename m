Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0A677C40
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjAWNSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 08:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAWNSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 08:18:01 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42E126ED
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 05:17:58 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so9031565qvq.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0spJQthYFX641DXWCbRs/pUSIAMVaDLDkRoN3enm/I8=;
        b=j41ACNnQ4G5wizP3yxtE9dc34bRInifg+77noc1kwzXoyr4NGiXyjztgSxLguG/OQb
         52rSYcL7RSCHTAvGckxDlfkD0c7vHBhftUb1RVdcApvw9lTBVywlzj6rFZbyTFjXfeDf
         hDWDjerQbAh7QeIrL9rWUPCYaq/cMsQhvc6ShZBlO9yYfhVJBENBc89RsfwdqbJ3AnNJ
         tkr1Preu4dODNGRrJG4y0umBekjhEypQqo40iAR+FZ5d2VI3op4uVtTWMoMf18/6IS19
         aGXhZTmhJ/BcHEvCuFMntEiOpJYWimTbwGzaBR2lxXtPv40ULh3d9L3xizdSnSomEI1n
         5qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0spJQthYFX641DXWCbRs/pUSIAMVaDLDkRoN3enm/I8=;
        b=WBF2Wxb9UkvH8dIIWBdMvt5tdPoGiZAjoXIs4YnyzSz5crRW2XAsSi9kdt5C1UcQ50
         R0FWNvO4Bi8g27qc2YviOG5i7y+IZ8A7TF3E9u+wCZTNWR/uhQ8mMMr07LE2porHOp6X
         PNStqqScUNKtY6a4HxVfsPWJfeoUKb5h2GZB9bB/Reylo/Q1nvZhLk5OpuLrICSacJM9
         znzO8dyKaJECT9QE2p16QV6AFerDZmgH5MqC27CXduE6A7olXe1q/Lgyrii4vtEu9uyw
         qDo3QaMEXmBJBXiX/Pau/p8Rkt8kKQ7SMD4J0sCMX+rjxCsnrJCDmeDd3QM8Ta7JBvRU
         2GOA==
X-Gm-Message-State: AFqh2koWtbMiIgb6/jtJ2QCe/6gJoQmFHINDK6ocZ6+SF/4zKpvRdOHG
        gYAhGXhf9s69bhiJue1CwGSV3Pk1PPwPQ2lbVA==
X-Google-Smtp-Source: AMrXdXtgGTpudmbDBSt1cXCmlXvQ7NnPYGMUMdAiqwnBGoWC77PcVFusWRwJrDMAWY93P74u3ck9sS7WoOtg0J9+fZA=
X-Received: by 2002:a05:6214:5d91:b0:535:5cce:84a9 with SMTP id
 mf17-20020a0562145d9100b005355cce84a9mr659537qvb.117.1674479877451; Mon, 23
 Jan 2023 05:17:57 -0800 (PST)
MIME-Version: 1.0
Reply-To: unitednationameric@gmail.com
Sender: aryaeefaridh@gmail.com
Received: by 2002:ad4:58ae:0:b0:535:29a9:2f3b with HTTP; Mon, 23 Jan 2023
 05:17:56 -0800 (PST)
From:   UNITED NATIONS HEADQUARTER OFFICE AMERICA 
        <unitednationameric@gmail.com>
Date:   Mon, 23 Jan 2023 05:17:56 -0800
X-Google-Sender-Auth: 3h578BKloKKRNzGVUrCXn3pPp0U
Message-ID: <CAK_p4p5pw1BpkoQ++A6ZOOuw9gZmdTxuBV068jP13ogbYUOUhw@mail.gmail.com>
Subject: UNITED NATIONS HEADQUARTER OFFICE FROM NEW-YORK AMERICA,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_60,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2f listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6690]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [unitednationameric[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Official Name:United States of America
Capitol:Washington
Population:318,814,000
Languages:English, Spanish, numerous others
Geographic Region:Americas Northern America
Geographic Size (km sq):9,526,468
Year of UN Membership:1945
Year of Present State Formation:1787
Current UN Representative: Linda Thomas-Greenfield
Email: united.nation.america@usa.com
Wedsite:-https://www.un.org

                                             23/01/2023
ATTENTION:

This message is converting to you from united nation Headquarter from
New-York America to know what is exactly the reason of being
ungrateful to the received compensation fund, meanwhile you have to
explain to us how the fund was divided to each and every needful one
in your country because united nation compersated you with (=E2=82=AC
2,500,000.00 Million EUR ) to use part of the money and help orphan
and widowers including the people covid19 affected in your country for
our proper  documentary.

It had been officially known that out of the (150) lucky winners that
has received their compensation fund out there worldwide sum of (=E2=82=AC
2,500,000.00 Million EUR ) per each of the lucky winner as it was
listed in our list files and individuals, that was offered by United
Nations compensation in last year 2022,(149) has all returned back
with appreciation letter to united nation office remainder
you.Woodforest National Bank reported to united nation that they has
paid all the lucky winners,after we checked our file we saw that
(149)has come and thanked united nation and explained how they used
there money remaining you to complete the total number(150).we need
your urgent response for our proper documentry.

You are adviced to explain in details how the fund was divided to the
needful as the purpose on your reply mail.

Linda Thomas-Greenfield
PRESIDENT OF THE UNITED NATIONS GENERAL ASSEMBLY
In New York, the normal working hours are from 9:30 am to 5:30 pm,
Monday through Friday, with a break of one hour for lunch. During the
period when the General Assembly is in session (1 October to 31
December), the working hours are from 9:30 am to 6:00 pm

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF705836EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 04:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiG1Ccf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 22:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiG1Ccd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 22:32:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560481C12F
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 19:32:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t1so896201lft.8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=JaYppaBYvyfdmz1MNr/HK3KvWm9Sz+t/YuEOuPFu2OqjCyYQemk8TTaIhD7w0V+Qwh
         mpEk5a71C+P6aWgpwNqPV3GYnDJsUqXoMekAAXm0HABUDlt4Y5lsaKG/JCQB9QPfU+4x
         XICxS8dO5M7eAtAnktXGKksLDJ68WPet/1Qgy4G3qjtDgbtdo6QSdRC01xUCd2GQfuFa
         21JyIa7jI6+MYXsMaijiqQt4zpNMnduA7cYi+x4mwH2pF3JdD9Q32HBy4XLt3nsrNIJy
         kOYmtCwMFtJtCZqpCOSX8jHQbkQ78YHf+7b/zVc3Zjc4E1JqmbDqU/FMD+bdzLJL5DBR
         xG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=L1SEl2L3ZOqbPsx5+oceAAgvg30IbE4/J+wYlGMKa6yDNL53gL9Nfgj2n2lgchlUl2
         v/BakChywFtTl/aPhnT2WbkvT2bdtJ6BmqzNqBsKR82rBICmnt8TRjo3bTnFx7cd8fTL
         lCbZiYaXZejjynyRru9T/g86TPB5et+jA++E/FYNOG8UukHJn7MOqx/9yWPe2AlfFuUl
         0ADr+azqODUe9gIV7fpRbtaAAXy3M0sT9QOPc16XnhmhfSOUQ3HSZjA2joFAGDuUSOfR
         a5aQ1L0dMMAqL0qxDAiFCR0EozzpTw0N/lOa7n/+XVD8FRuO3sjFYy+uX3YGb8gvsTa9
         ETqQ==
X-Gm-Message-State: AJIora99GIkUNab7BZCCEJQzPzt+JCHxc3nGcSG6c/FMuMeiZHk/qiNL
        ZBLosx0OhCcAKhpJcfulM0h0sO4t9M+cwyia5nc=
X-Google-Smtp-Source: AGRyM1vtAZkIDHO+C1Mp4SQzIV9nIO1IXCu/+FniG9e/EuX/gIsuq9pdAB8I+Ja8/rwQGvj/fHwM07zwvYp7QuPCQtY=
X-Received: by 2002:ac2:5f6f:0:b0:48a:be19:8be8 with SMTP id
 c15-20020ac25f6f000000b0048abe198be8mr1709533lfc.595.1658975550594; Wed, 27
 Jul 2022 19:32:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:9ce:b0:1d7:f59e:4751 with HTTP; Wed, 27 Jul 2022
 19:32:30 -0700 (PDT)
Reply-To: drlisa985@gmail.com
From:   Lisa <hwaldean@gmail.com>
Date:   Thu, 28 Jul 2022 04:32:30 +0200
Message-ID: <CAGpHGUFzWiTrMcvdDV+OZy0C0i8SEH5aayChcUbAbpFNVrYXDA@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks
With love
Lisa

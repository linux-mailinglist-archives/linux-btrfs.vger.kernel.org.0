Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A6585CBE
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Jul 2022 02:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiGaAeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jul 2022 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaAem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jul 2022 20:34:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE462F2
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 17:34:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i13so9743215edj.11
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 17:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=dZoKSq/8YO/dCUCDemsKnPSTlJJ/+rex41/NfTqBGPu4aDu0LNafL3VzC/MhnYZqPI
         gVN5RzTTEqK4GRqexAYOTd1wUvTKSx0KxN91v3HWZ6jXdcY6oj4gc+c+S28fgDnOA9el
         XU5os1bRKfp0LUiAkuSSxs8cojbuPCzgjTTA4VZfsElj9VAQihmQPT4V6ofdCLclAD/9
         oBOV2j2KHkSLLsI3cmFznocZlokSelIDBnVSk12SO6Cn/sLD1YoUDtoAHBlS5qpadK93
         7F1KY5Wf6d6f4UbnzQSAex5Tj6DIdccc9qkmt0XhimnEKPjldLSFbIokcerAaZvYL7Lt
         u1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=dttVkNp4QqoK6ax+mKg4zx+RfrvRf9SkdFfKldy3uPg4tsVLHOmhcVh6JHZO6qEcNB
         v21CMAmGEsxIBa56ZRp4Uy7e9ROrtMGwHGF1o1p59siPeR60RWq8drgiTbzoyKpx9pHO
         kECv5I4QTY0bBBUJi/XVeUlDmxlwvZYb1yZkoXKzRrY9q0UyFY7iOCYbAvIELU5JNiXv
         tjmA948KdxHloPxpRbg+J3EFGE2CrMvTxvz9JqOct0gXsTGzlcTwO9q89bTSltqJgvAW
         FhQWYPBP10kahdzZECX1486+HcdhelFxeDn15qTIU99QB9SoygF0t+naFsxMEfB0V/N7
         KwWw==
X-Gm-Message-State: AJIora+S9K+WzQG8409/ydjCQNsemTYSUH1e7zHlFkEolNDIoR1HYtAX
        8myLFJafForFqelW3bB8aKFjTvbfSsBqdBBdZRQ=
X-Google-Smtp-Source: AGRyM1vzhWGJ+WzJfulYH/NBkz+hornrxB+htalg7H0DEi/d+Kvfou2G0/b81PE7zYgezDJujc7UnF5aNKjQGjbtc0Q=
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id
 et15-20020a056402378f00b0043ad3f579f2mr9553517edb.338.1659227680705; Sat, 30
 Jul 2022 17:34:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:d543:0:b0:43b:c4b4:6d19 with HTTP; Sat, 30 Jul 2022
 17:34:40 -0700 (PDT)
Reply-To: Drlisawilliams919@gmail.com
From:   Drlisawilliams <helenaphilobrown@gmail.com>
Date:   Sun, 31 Jul 2022 02:34:40 +0200
Message-ID: <CADCWihX5mCWNWsOfOQ-VeqVRccNdrJh2FbuMkSL4SiTEz98QuQ@mail.gmail.com>
Subject: Hi.
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

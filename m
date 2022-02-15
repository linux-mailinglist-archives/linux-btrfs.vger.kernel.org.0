Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DD4B77A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 21:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiBOT2p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 14:28:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiBOT2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 14:28:42 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC02AFF43
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 11:28:32 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id v63so32148823ybv.10
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 11:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=cGw+0zAzYgdSEm8/jB83LaKWv2AwaI9npCvBn4MaEElLoPyHt0PDJ4AHY75GS+NGuI
         53jTQC2JiE9oCHDxkj9F/ReD8kzh6NdwPsYBuW6kk0ivAQOSMedx0s30A0QJwjK6kIUe
         E1O471jP16O6KSy0GZfoJQG9/FsRi1NOwGg2NQW7R501kpSaOt20r6L3+VjRkD+yIQtA
         OmLbz+Dsv1nZ2lvWTrqnNoh3vBHRv35MLYZ5+q1n5Q7lzqUfqwwirQoTPv3TeB3SL5vf
         KFeGPk2oss44JMF0YBWtdwNd/DgSHmPyl/wslh9JEdbMXZy2qz22DKyBzT2U1MVUdxlV
         ES9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=ABbqLIcPCkxRIlnp8Y7m2QWi0H6O+1yTAVc41iwLskbSFOrLkOxpXOo6nu/MKenDcG
         aHZ5w8ao9wFXjHx3KUDa7QZCgryHzHdcWqVs3Ee0qQMpLz5TzfnkMSbhNhlM4AZQi1vO
         XUTGNDmGGFSAYik7iONGkb5ZIaXUtCbGTRmPWHVRL58eMwyIMN3iAKfzvWbL1wu1UEYz
         drfbi9z+5pG8dnLfn1UF24OFf4VJ/kjOGntdHnOHqVGRBGkqdSKdtW3PXoT5DKlxmNd4
         0HOR18BjoYu5luqktRy8+lTLLF8QKDAuydvNdOAkaLiUBsgkK2CbnuMMBp1GwjkjbVgd
         0D+g==
X-Gm-Message-State: AOAM533v2PrPiVCNUGyyv3nj9uqOno4+Ef3+UZwWQoRBbbgMlcx4bJt8
        snWFto9G0E0qHaELGTLSh47WRDvVFz/twn4aBE0=
X-Google-Smtp-Source: ABdhPJwdyBbVwsfuEgoHheXtlOWCBCs3P3JJthH38ZXUBWV63WN7yxplFjdgjCqpSFETWgRKoqvRik3Vnh3qYt//S5g=
X-Received: by 2002:a81:ae07:: with SMTP id m7mr368993ywh.269.1644953311381;
 Tue, 15 Feb 2022 11:28:31 -0800 (PST)
MIME-Version: 1.0
Sender: iqbalfarrukh60@gmail.com
Received: by 2002:a05:6918:718a:b0:a1:351c:4bc2 with HTTP; Tue, 15 Feb 2022
 11:28:31 -0800 (PST)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Tue, 15 Feb 2022 20:28:31 +0100
X-Google-Sender-Auth: lrDGu2X-wn5cLGvUJg6bYOL0nWs
Message-ID: <CAL3Nt6hBYeCzeBjV_uiR=YHsj41oyHQXEOuv0QDjC9wHw=Oi+w@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [salkavar2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [iqbalfarrukh60[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  1.6 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

Thus i humbly request your assistance to claim this fund. Upon the
transfer of this fund in your account, you will take 45% as your share
from the total fund, 10% will be shared to Charity Organizations in
both country and 45% will be for me.

Yours Faithful,
Mr.Sal Kavar.

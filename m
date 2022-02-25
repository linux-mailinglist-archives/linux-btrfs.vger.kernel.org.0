Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BCE4C4F44
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 21:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiBYUIF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 15:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiBYUIE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 15:08:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539A3981F
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 12:07:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x15so6064249wrg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=05dGa4MbTCy/WXdqLtbI7pzY1vM0ArO1qiihvnFVgHc=;
        b=NwTmMacSXOXkOkSZ1Uapi2r/4Wiy9sWkLwPgnQALLukq5o5uH0jE7d7IglcfHZyWl7
         VrB9a+TK/q4xDeSDsOKfsNjwsQEsZWNdUBTZSwMtrtEaLdOZ46WXnAXXPF/0bAN/ny23
         Eb9gpDqr7Z2E1aWcGFIr8t2I2uAocRzH/1z/e049CKPbLhwdk/wW5U9ukeFqUainazBr
         oaCYXbBqcEmZR4RIxL+/wRHe9qt/8R7GQIHVBfVLEh7PcnkAfIqHJ5yUi0RHHSqSEbNM
         8uiz5K/D/8JQTibk1JR0G2hq93lo/Km3BWRHPIECll8FO5Q4ehDU0OU8LhGVG14CGRMk
         /4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=05dGa4MbTCy/WXdqLtbI7pzY1vM0ArO1qiihvnFVgHc=;
        b=XZYHSiG3LcBSrqfDwaw8elgNhlj+OD4CjF6qvCpcIGUOF4MlPTQl9Uw3xRBh/xXLBB
         t3/2ZSHmgehfWtydfSLJJdQGuwO/wYt8Am9GDt22+ZFUAE9OuQ9P5neStzUF0hpQL1HE
         Q/GFe0GQ/VFTxzU99VVvaO/yC1P9Q+NNl34ZYzVJKrYUc4E4qjIYMuHsHVQcvXh7Bh1h
         hGVwErXr1YQlc5m5zrsL+ZamXEVPxaMevXfj5u9IitGjMybh3nwnr5ITwqxX6P7fv9Iy
         ZOrHfT50++iqDTC7Rp9C8rEsMkZeYceCS4XGnLF1mMg3niZjaCgGxesxpszwtV9L+A+F
         7H/A==
X-Gm-Message-State: AOAM530LjkgUnGFId8tyUErsJbW9i5xkp0pdY0X4jSfVgsUyRbB2z9Yd
        KF14K18dUH3tlaizAuEXdrM=
X-Google-Smtp-Source: ABdhPJzqkPXkuoOSE6A9Ov9qTUqzcWFPh0pK4+Y87wTxZi/UerECwyDs5DRCHdb3Bd5W0BPKEtvxgA==
X-Received: by 2002:a05:6000:1847:b0:1e6:2783:b3e6 with SMTP id c7-20020a056000184700b001e62783b3e6mr7253080wri.163.1645819649853;
        Fri, 25 Feb 2022 12:07:29 -0800 (PST)
Received: from [192.168.8.101] ([197.211.53.19])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00380ee4a78fdsm4354252wmq.4.2022.02.25.12.07.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 25 Feb 2022 12:07:29 -0800 (PST)
Message-ID: <62193701.1c69fb81.e5a36.0056@mx.google.com>
From:   Roy Cockrum Donation <eseloanscompany@gmail.com>
X-Google-Original-From: Roy Cockrum Donation
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:Hi
To:     Recipients <Roy@vger.kernel.org>
Date:   Fri, 25 Feb 2022 21:10:59 +0100
Reply-To: roycockrum550@gmail.com
X-Antivirus: AVG (VPS 220225-0, 2/25/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Roy, You have been nominated to receive $450,000.00 sent in your name.re=
ply for more details

-- 
This email has been checked for viruses by AVG.
https://www.avg.com


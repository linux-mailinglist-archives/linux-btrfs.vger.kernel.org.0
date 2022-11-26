Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C76396B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Nov 2022 16:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKZPNT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Nov 2022 10:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZPNS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Nov 2022 10:13:18 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D15017ABB
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Nov 2022 07:13:18 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 128so6681921vsz.12
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Nov 2022 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=W/MGn+KhfKSBqcLxWmThpVfazD53VN7SksjKk7v0hDyWpFlvnNPKcV9/CbG6FkFaT/
         5Gw0brM3YMDO17vq54xveSYfhUvpz9u2Ao4PjQzYYzl/9p88Dyrx7RLvktTQRMs+rZH5
         0ViFa0oYYp23qghhSiYIMOVdTh0k4mTyuDOTCtIT9JTsuCSNazZ/DOtlHGFwf3rvREyN
         ClRX1lEg+4m1xWZvps8AV/326/gRvhKj9WGWuDRuSDMW63XccHvO2TF5aBK6BeEEhTzc
         GPRTv4tF8nKveglKgvskMrQh+sMKHEUFea3dEtvytVjc/x/aMyKmf6x/0LY+lIll6TyT
         RztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=oEXLhqONI6Bfl5XqxRazv27piyA5sgDqoohHJ1TQA8MK7D68yoNYp+1RPmSQLIYvU/
         FDa6TMZXnPDsLbZLEeYpGY8EMBRpsH6RBp1Tmbh1mRw+XOCOTuc1I/mjvQh82JVST3qF
         KwIBuSz6Tw1TXCWv5cavhfVCJdGBybJLe3Hq2Km1ZEQsNzngzrJ+RIkaq/dTJrbgHaun
         Zy0K3iYZS0U/5zHQGRoQaFMbMrf4mnpbZAvgRmC355zlJNgLOD2rnFLIqo6JMeu5BIFi
         TdNCIVYov0+HmsoliCAG979rKoJny3zv7Pgoet5/lS92KpXbsXnaE31rsMqdXLTbYNWZ
         7efw==
X-Gm-Message-State: ANoB5pmSR4sQvQMVWULjAJn0pYvMLJlca1+QjRA6M3Hva1AcFVl+soHv
        0LtzsE4RCIqUP3jp+zmhO/Vl9/JWsWDB9V86cPo=
X-Google-Smtp-Source: AA0mqf70746gm+1gdMJXxU0ELS5sgv83pH6UR0BA4ftKvNb5+N5UIheefVT2PpEO808M14HMakcjUmImk8lw+peGc1Y=
X-Received: by 2002:a05:6102:5785:b0:3b0:7178:7fe8 with SMTP id
 dh5-20020a056102578500b003b071787fe8mr10317754vsb.38.1669475597184; Sat, 26
 Nov 2022 07:13:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:adc3:0:b0:2f6:3e67:f4ce with HTTP; Sat, 26 Nov 2022
 07:13:16 -0800 (PST)
Reply-To: halabighina00@gmail.com
From:   Ghina Halabi <atchoukoumagnim@gmail.com>
Date:   Sat, 26 Nov 2022 15:13:16 +0000
Message-ID: <CAJqVmgC2Ya2T0PnDpfK6665vVvWk8j=Qc4Mzt5q_RajKsSLHEQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello good day,I am happy to be together with you, My name is Ghina
Halabi, I am a military nurse working with  Israeli defense force.
Please don't let my profession, race or nationality enter your mind,
there is something very important which I would like us to discuss.Can
we talk about friendship and partnership? please if you really want to
have a good and prosperous communication with me please kindly respond
to me positively.

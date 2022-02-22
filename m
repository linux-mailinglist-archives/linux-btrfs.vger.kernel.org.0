Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8244BF75F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiBVLkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 06:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiBVLkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 06:40:45 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A9136EE7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 03:40:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso1572829wmb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=zncUP4k0qWTkrruw/2Qwtl328+sz3ixjRaMsIKFNcuk=;
        b=Z4zCVhXxZ1HZMkqOGwjU5egUexg0MyVddItCmOwd+6enmyf/Odtled2hI1fXhE3Cjj
         k06bEOLAD0WOZ0G4rD/Rg2rwvOTsRZ0lfbSSSBYETnm9uVKsd0t8eB/wxizt9eyG8xSC
         Sa+ycOdg1QhJixAUy0KFXQkZsbKuYUJhFrt9KlZIYATVsWdEPe6KOY8aLMkjs4HU14DQ
         1sWvhXYE/MRarvsLL8ZuWGNymjHqb2jUdQULF5kbCc3IF+aOPgzllhuETcwV4N4av8/a
         EEjucXx6RLraG0GXMZza7+pjqY5/HfUjLUU3Wkctzi1wMXVfQr8SiFystFjkTu+N1djl
         t3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=zncUP4k0qWTkrruw/2Qwtl328+sz3ixjRaMsIKFNcuk=;
        b=c6nWHW2VNBUzkVnewt8427xonLpWG1CA9uOP8Va5/lfphT1s0Dcc3VYrH/8lGDhM7V
         mIrzU5gxjYgssldp3CnOzlBcpa6QLEk/jfzXWDjvSxJcywjYpHePwLonKk/sqEhbRfOk
         8+dHm+cyQBBwAJa1yJ0JXTxnYVwJG+6uKWmfd0pnQvovECmt60pcBwLT/iiuXR9ces/D
         O8UZQV3rfFY+D5LEfVtKfCNeMR8TQLd5Wj4ejdqKSdiaAUnD+ZTmCN75qEhDnZjou+fV
         VkKuFB5qMeRbHPxAvC1zEYcGtQaIrroRELQhqso7TrBNpRoj/iJ6pk8BK3kuHwCZn2jW
         v6PA==
X-Gm-Message-State: AOAM531JG1ju4mK4aVHfqSnmGTPqknlQPNRqP/MhTFAxSonTL7dxDCE1
        dkG+vfAGpGy0qntyAd6Rdjo=
X-Google-Smtp-Source: ABdhPJwN4CCv0Kn2r2NjW48h4yRuvyfrolrjYS17m1RpFM/FEQ0ujPhvhSK8khd16rP7LC+kCB1UNg==
X-Received: by 2002:a7b:c3d6:0:b0:380:e3af:7f72 with SMTP id t22-20020a7bc3d6000000b00380e3af7f72mr341725wmj.163.1645530019385;
        Tue, 22 Feb 2022 03:40:19 -0800 (PST)
Received: from MACBOOKPROF612.localdomain ([102.165.192.234])
        by smtp.gmail.com with ESMTPSA id q13sm53921017wrd.78.2022.02.22.03.40.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 22 Feb 2022 03:40:19 -0800 (PST)
Message-ID: <6214cba3.1c69fb81.67cad.1eab@mx.google.com>
From:   Scott Godfrey <markmillercom322@gmail.com>
X-Google-Original-From: Scott Godfrey
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: CONGRATULATION!!!!
To:     Recipients <Scott@vger.kernel.org>
Date:   Tue, 22 Feb 2022 13:40:14 +0200
Reply-To: scottgodfrey.net@gmail.com
X-Antivirus: AVG (VPS 220222-0, 2/22/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: No, score=4.6 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,T_SCC_BODY_TEXT_LINE,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My Name is Scott Godfrey. I wish to inform you that The sum of $2,500,000(M=
illion)has been donated to you.I
won a fortune of $699.8 Million in the Million Dollars Power-Ball Jackpot L=
ottery,2021.And I am
donating part of it to five lucky people and five Charity
organization. Your email came out victorious. Please contact via email: sco=
ttgodfrey.net@gmail.com. For more information about your claims. Thanks.


-- 
This email has been checked for viruses by AVG.
https://www.avg.com


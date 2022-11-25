Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83E26385AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 09:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKYI5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 03:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKYI5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 03:57:30 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B810C4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 00:57:28 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so4403963ljh.13
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 00:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzxRVQ9H4CsgyNS8nd+5HOgtj3H4ny5mw3wCLstvFi8=;
        b=ed3nGqk5wlAj6LLpg/23l6ufVUDLP84obrhQEi+FGwuUGBmguZboC/9axPaJJp3hoX
         6qkVIM+EjupnYlb5OeI7J5WMzI7HxoG1a9YDTsas48XbvdGuJUZVhd2RYYYbTFQ+bHoc
         MnUhaYA/Bar7Uo+8JT+lf4a0YAL0akwdhXOxUPYQPj67NDc9O5O8tap4N0oKM5s9Vp1G
         xgBOKExsqJa7Y27sFxf0eAiDenMGZQQgzP0BAvtgDp7SHDeL98gbspPcna5lLEpjR8jL
         BlRTFOD34tz9eU26BDoyVpmWwyTvqILNfTt9ZAl4R0uecGb7VmVQRDXAjsOp4Lpzwq0/
         uAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzxRVQ9H4CsgyNS8nd+5HOgtj3H4ny5mw3wCLstvFi8=;
        b=LbsIHyHbSbGN+7IPfkq0SUlr2voS3+h30x0l/aeTWqvrHej2m95wEjPiaraxRecdNE
         eRCG9IhidRJC3FQYs5cUjmi22xUQOS8IVyAGVV7i46AmkWi0sXEn1Ok5BP0yjv4FU6Fs
         1xGN+opA83DnW2afFY+i8PsuXPhfaC6YQaDB+lVk43f9sO7vQ/Zr1/uWpVeqA/9McArM
         9nJCPds2KDLlz0lpn+QJBLxEKCoAeGuo149lBgtjShQDS2mLOYcLpdNfjrNP+21JrcUF
         +wE0UR4OJKNqsOiRL8uvoXvvxJwVx8mqSVeU/r/4pWSYb1XhoQBSFdQh7Ziabv5u+Tip
         03vg==
X-Gm-Message-State: ANoB5pmUFWPaTKW/k6tcfr2VPWORY4u3TU8q3rh/2RsJpgHLAHul8+eQ
        oOBW+9L6kD5DjpehjuYOiCo=
X-Google-Smtp-Source: AA0mqf486B2ImINWIdb+Fls4V3OWZ4aKxBSThxkPpIgMQ7KJICAwudSAphqWN23hAeSItY4MEyANow==
X-Received: by 2002:a05:651c:154d:b0:279:5097:21ff with SMTP id y13-20020a05651c154d00b00279509721ffmr6732502ljp.16.1669366647206;
        Fri, 25 Nov 2022 00:57:27 -0800 (PST)
Received: from localhost.localdomain (fw.storegate.se. [194.17.41.68])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f46000000b004ac393ecc32sm444117lfz.304.2022.11.25.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:57:26 -0800 (PST)
From:   Joakim <ahoj79@gmail.com>
To:     rm@romanrm.net
Cc:     ahoj79@gmail.com, linux-btrfs@vger.kernel.org
Subject: Re: Speed up mount time?
Date:   Fri, 25 Nov 2022 09:57:13 +0100
Message-Id: <20221125085713.292-1-ahoj79@gmail.com>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221124030150.0b064549@nvm>
References: <20221124030150.0b064549@nvm>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for describing, now it makes sense.=0D
Regarding LVM-caching, I will keep that in mind and perhaps try that=0D
on the next storage cluster I deploy.=

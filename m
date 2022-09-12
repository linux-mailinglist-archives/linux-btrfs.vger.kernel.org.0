Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134C5B5733
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiILJaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiILJaP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 05:30:15 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00431274B
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 02:30:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1279948d93dso21725578fac.10
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=+qVy9jR729xM0bLj1boh5gQKwr/6ZMFvkx06/gpD9sE=;
        b=ErufAgW11G94Zx/wrBG7q09Llsiwq8RoQ6reQGG0cPq0Z2E58IIAZXnSXnDcG5Q1mQ
         8gxQq1IK6clNizSBWREOchSPyuT/A8tFktaGYmkgnoQbJv3MZbP5lO0MLYmGwlDxbSWV
         cbXb/uQBmrZGT65ZKtgy+MA0gq8g6kJJRR7Lrzx93Ljdk5bLjnPPZ4FUUNGM5gpf8zgt
         ZREepcf3MZpcma0wP3zbnVJE3/ZqE5RevSZlutd75R1r7McjS2CkpDqFD9kFs0Qhqs/l
         BpwWMxmsXhQiue9nQrx81dwPoGk1AYLWTSrHakyWiiZ8GZJF2o6urN+xfimZ0PlMWYMO
         MJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+qVy9jR729xM0bLj1boh5gQKwr/6ZMFvkx06/gpD9sE=;
        b=Pi/+xVtqQp02YkltLHdtQWTGpakNd8FQ80YDIm535iRo+0RkYl4iL0wUdSDmoFE71i
         WgfFyPRT1vy83mmxMftbXKd2GSWay9x8MC4b4B3pI0sgZ27sjFUzq0X2RP3EYtC+Ti2E
         FMJA/J56Fjj0vhGOkjYykE3g85B3egx+VTecgPW0O+9kS+n/0nF5VQDnhSoXUxY/2kiG
         qNJ3FxoS2JYf8PzkRwOPUxaU1ubyLaUz7/s68CxVHQoC55ZbQV15agI+m+KJP905ecI/
         VoufWxjwZfdZfX9FUmLeZrCo+gJ4rp5/7RgoCVa65aqBtLlcMi4Xu+LkrAnyh8NtAXQS
         jnxg==
X-Gm-Message-State: ACgBeo1YN0ckDR0CjBS3oWrBLd585sR+f+e8GgGxk5mxIsRuu515AS9m
        ZYqh8ybBj3mdTwjYoTvPFwJSZ7eNQwW4pEa/+84=
X-Google-Smtp-Source: AA6agR5aV0t7NqZG2JVnuPvha46K5+T2KqVi9tycBBhQb/dJQ6V6xvCXA7386fzKKED+XrenQNXppRFanJocGTMXGPk=
X-Received: by 2002:a05:6870:d390:b0:127:7213:37b7 with SMTP id
 k16-20020a056870d39000b00127721337b7mr11900218oag.298.1662975014097; Mon, 12
 Sep 2022 02:30:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:e02:0:0:0:0:0 with HTTP; Mon, 12 Sep 2022 02:30:13 -0700 (PDT)
From:   Mukter Khan <mhdmkhan.uk@gmail.com>
Date:   Mon, 12 Sep 2022 10:30:13 +0100
Message-ID: <CAOv06TYWhNxgzn_ECcLdCoxm7Ho=Y1ZO0=pbadtw210m3tvshA@mail.gmail.com>
Subject: Fw: Franz Schrober
To:     TheHavermayer <havermayer@gmail.com>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Jesper Juhl <jj@chaosbits.net>,
        Jean Marc Valin <jmvalin@jmvalin.ca>,
        Jonathan Nieder <jrnieder@gmail.com>, jw <jw@jameswestby.net>,
        kim phillips <kim.phillips@freescale.com>,
        kovarththanan rajaratnam <kovarththanan.rajaratnam@gmail.com>,
        linux btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,BODY_SINGLE_URI,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mhdmkhan.uk[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.4 SCC_BODY_URI_ONLY No description available.
        *  0.6 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://8bht9.app.link/XNIiYQ04ftb

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9B5B5998
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiILLry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiILLrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 07:47:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B691A3A5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 04:47:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y17so14467803ejo.6
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=ooS2yzmuD7QaDObpfth17KYf5k5R4kpvTrrT/KvH5ns=;
        b=poeT8QG4ZTeet1WB9UjaIUmqgPvL3Jq7xILjY4YUIpiI75Ux9ZesvJ/0/4RgdnTytj
         hAVXZnvBaoalRTagbiRLg1NCrm30UBaokT+ePaYwlXZGS9w2HJvkp3OS5nCgmlSruURP
         tt0i7CRlXdes2i1QUf3znHlwa6YzeCrCDn22RfIXOtwHQqVPErpie651YY18fbEsbBmT
         SXhz1w22ZvLs+LTuiCb1CdRl95YSHOy4xiKQ7xX/ZGXnlcmMHJ55N/vSDJSJuF8CFZIs
         ukBc7kpQC2sGadjFl8HCkaOcoF+rM9vrRt3tFeFpHp7WNTS0aI51R2qG286zi7QS1iIr
         oAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ooS2yzmuD7QaDObpfth17KYf5k5R4kpvTrrT/KvH5ns=;
        b=Cyo8TZ199bvZg/tg0T3673lrZ+S/KilQXsHyC2BG+613j1iS/KgwhbRfIqUcGwCgtZ
         KmwHt3Ue09oo0+Jax8hChdj/poHD3kMpws/B/ufJ+w15vVrUtUHNW+4VhGBGfz18Bgs2
         lawrxDhVWTHH/FIOTOTznNklo9iSlk6tjA6jl4MltOdfLJxZHn9MJa315gzsSnYyDsCb
         Q0+cXFGHfXDZj6IdlKg8DU1ogxR3opQrXLNzv6azxeh+Vzkn9y3bFiurFbITmv53Clxy
         Da3Ozpkw0jjqa4dUByPQZk2XpgGA8C13CDT6V3osixNV+dTBq8tGE0zZjIEqbBKqPynn
         v6GA==
X-Gm-Message-State: ACgBeo0ArbNni2IFM6MaV6mOQByyDZK18PUP+ZlGaalw7khyqMs4i5Dp
        3WplgQvtyFjgxrl0WaeYQsEdY98Nb1FdaTTv3Mg=
X-Google-Smtp-Source: AA6agR4c5fDXotSLrX6ZQr0l6xEHIENu1UqocjWetfIjnvP22G4bh1sRunLJvprsZkZVQBp1K1tm/eETQQjc51dE98A=
X-Received: by 2002:a17:907:16a5:b0:77c:e0f0:1f25 with SMTP id
 hc37-20020a17090716a500b0077ce0f01f25mr4086037ejc.217.1662983270328; Mon, 12
 Sep 2022 04:47:50 -0700 (PDT)
MIME-Version: 1.0
Sender: flanrodolphe@gmail.com
Received: by 2002:a05:6f02:ca18:b0:24:46bd:f03d with HTTP; Mon, 12 Sep 2022
 04:47:49 -0700 (PDT)
From:   Hannah Alex <hannah.aalex1@gmail.com>
Date:   Mon, 12 Sep 2022 11:47:49 +0000
X-Google-Sender-Auth: 68o2SL5wxkDym9c5XR9J8MGYhNs
Message-ID: <CAPF29TJQy31-Q-AROEbeCF0La0o8vx9wPKc68ZOFYMyJK1h1UQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_99,
        BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9998]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9998]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [flanrodolphe[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.4 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My name is Hannah Alex, I would like to inquire about your services to be my
foreign partner / investor and help me to transfer and manage my
funds by investing in profit making ventures like buying of company
shares or Real Estate in your country. I have a reasonable sum that I
inherited from my late father, which I would like you to help me invest in
your country.i enclose my personal photos,proof of payment of the fund,my
international passport,my late fathers death certificate and a four page
will from my late father.i am sending you all this so that you can have
confidence that you are dealing with a real person
Note: below are the major reasons I am contacting you.
(1) To provide a new empty bank account in which this money would be
transferred. if you do not want us to use your personal account.
(2) To serve as a guardian of this fund since the bank insisted that their
agreement with my father was that I provide a foreign partner before
releasing the fund.
(3) To make arrangements for me to come over to your country to further my
education and to secure a resident permit in your country.
Please reply as soon as you read this message for more details and proof.
Kind regards.
Hannah Alex.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142975BA302
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIOW4K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIOW4I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 18:56:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1354660
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 15:56:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h8so26212754wrf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=V/nIhXRBT1A2wzKeDfWK4R9H8lrNG6z19UeD0gFaEww=;
        b=MB2BRhkP2ag8v3N14kqmV9fIdyMhVfvjRMOCLhSzzXScYsOi2ESU1hkFMsz/s8Fbzr
         zOEgTaXZ/CUqKqiQXe5GHOUp0IcoeN3Zx9Bnu2XvTMYGnvK86p6QHzMWYWkEbzQgMpFt
         IriK9M/zXZ4uOhuFBfB895BrN5Uab+xYRHpagRT+3q76Q79ETLx7R4/eseyHOOb5WpHF
         Oq8jDk3qcq3yrRwQtCGwBhGAbpeF6rgid5i6WGo0CrHJ7e4HVL8qf7l/ichnP5raouLU
         zUcbwbu96Mq8kjYkoyaEjGSxyh9YvzOuBkLXiWN9kBDTpm8GYxEVwMutgC/CFOpAzCAd
         zx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=V/nIhXRBT1A2wzKeDfWK4R9H8lrNG6z19UeD0gFaEww=;
        b=25q19VKYCQbZJ7L6hxOLdmswGQvKpdlm2V9w4ECKSsgeHK62zZgbFJQYZ4ex6VGVrW
         bQUzDhGwPs+LCfQLIMveFUiRjncsTt5JN6oTYKfznZSYVuxZwhuOYUu2LK39fcfNNJzu
         kmrZsNzTelgf0vkVtqNJtdSUMAnsQOQguD7Oc/Etyfg4FjIEDhXU03x/AgtnpwZEp2a3
         pUDCf1haXahavo+ltmNfvLF/7v2dkj8hYTFVvmf8va94KksJH3LoTxIR/L2VqUKkzfBB
         Xz0kb9kkqm0W8gqoTJhdGkjBQvoRNxhagvZIwKjWX4Hwbm68h0g16q8t/64bvpb5lpME
         8f3Q==
X-Gm-Message-State: ACrzQf1B8JREtKRJtMvRZc+Kdz+tIy17U7I+AkK5YfvK41eJaZq4+D3A
        /tKrVALgJhfWeL0dowuj5twr5KzB2+48txm74J8=
X-Google-Smtp-Source: AMsMyM4JWXbuOGQDF+2S0LN8vZtTPDi3nchL/Tv2LH6kzHAhQNhm+PrK/CYV8ka0emyMa4iURiKSB5EFSisDKxigsMQ=
X-Received: by 2002:a05:6000:178c:b0:223:141:8a14 with SMTP id
 e12-20020a056000178c00b0022301418a14mr1107996wrg.629.1663282565824; Thu, 15
 Sep 2022 15:56:05 -0700 (PDT)
MIME-Version: 1.0
Sender: unura67@gmail.com
Received: by 2002:a05:6021:2189:b0:211:62eb:6d76 with HTTP; Thu, 15 Sep 2022
 15:56:05 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Thu, 15 Sep 2022 15:56:05 -0700
X-Google-Sender-Auth: lTUyXcA_jZc-mi9wR-XE8IBrVOE
Message-ID: <CAOuvuUE27rKOgzm8Y1EpC-MtK1=B9Cf4A3dgUxTsvr=UxQNX4Q@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Yours Faithfully,

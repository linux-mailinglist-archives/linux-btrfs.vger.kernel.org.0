Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB157D38A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiGUSn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUSnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 14:43:55 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CFE8AEE6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:43:53 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31e7055a61dso26584037b3.11
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=J24sayFlM/4fkcNovjLr+Y8Aq3Ei7msGqGU8dh20wB0=;
        b=A9kw8s63in6htVKU+XX6dJx028gslRk/Z4NwlsZ0Q0Yd8nnm7oP6ulbXp8bAcDUv5P
         /HS8/YSuUX4YOFi+0waYnxH7W7oLdx5KdpOvIJOQkKHigZPxheq3i2qOpFJ55G/gCKFl
         VomP4FvuehvZ5Yl7jO9nNkvepdHG688FlxQuglq5ZUTWcCLKqhLhsN8e/0BwCI3U/Afl
         T+goz+NTUcCagKY4r1+2Jgud7lvjaXeUowZskTOWtEocv2xyuw/bNv+nZhPoDgoN8s9G
         RWnvVnEcKXRI+syPimOKwz/oxATtuylaM7NkPs0U20XYbcQFbI2aLFNrC0lky4WBcC1o
         BFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=J24sayFlM/4fkcNovjLr+Y8Aq3Ei7msGqGU8dh20wB0=;
        b=N4c5FPToAHjLY3JlZVP8tujYuUIIM8aUqpyb7cy5VjiH8N7mj1iKj72640nbWrMkYd
         CwLnZkIZ6xJQvqK3OS5AdE9/ba+ETtmJK5of56HtDLdb5H6Du3j9KAPSBd8FIcfahIdl
         snTbrKYPM1H7J0Rg7BAjQ/lCAB5ZVyijN7Ov3RdplSOnuBCjxGbccYBo+bVvttq3/FE6
         Cfbkig2ymOIJPS9++mHJCecLDeUQKJ+sbRP+iAX+e/HVkC4HkUraSnn6TFGPEfps11v4
         F4zPE6jnhuOFwRFcvG3bDQgATeebSEEoJQgfEzMp7msVOXdTgjE5nIh6RQBaKq3HGuDq
         DJCQ==
X-Gm-Message-State: AJIora+jcb5byy2D+9MPmxjngn4cCKw5cUx4WONV0PbkZS/wL3w1sSbh
        IK0ojLQXeBs7XWoAvOzDHHNN4LXSETOPyHp+2p1Pri1N618=
X-Google-Smtp-Source: AGRyM1uwqLMU5jTGQXqg8OvO16duRl+mKJPhCLwzniKTlmzdWjFyn1b4g4oUEyByYUJsnX6h4K0UkFPqkGocckY4Dwo=
X-Received: by 2002:a81:8481:0:b0:31e:67d7:c5b5 with SMTP id
 u123-20020a818481000000b0031e67d7c5b5mr10693698ywf.300.1658429032368; Thu, 21
 Jul 2022 11:43:52 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 21 Jul 2022 14:43:16 -0400
Message-ID: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
Subject: Using async discard by default with SSDs?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

I was talking with Chris Mason today at a Fedora Hatch event about
async discards (as we were thinking about doing this in Fedora some
time ago[1]), and he seemed to consider it reasonable to make it so
Btrfs uses async discards by default when being formatted on SSDs.

He and I couldn't think of a reason why not to, other than the
potential lack of "discard=3Dnone" option to turn off discards if the
user wanted it to. Do we already have this option? Are there any other
reasons not to do this? Or is this something we should have changed in
Btrfs so everyone gets async discards by default going forward?

Thanks in advance and best regards,
Neal

[1]: https://pagure.io/fedora-btrfs/project/issue/6

--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

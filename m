Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48F17C5F3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJKVmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKVmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 17:42:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2C9E
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 14:42:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ad810be221so42950866b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1697060535; x=1697665335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3x+4fo1FQvvp7MsrCakfZv3GSfVAekp9vggTyPc6Qc=;
        b=fGDK08kfb05NQeUoxJkLqTQO0oL0XhG9XQWMI7DNrGaXzzIGxZuRFXyoZtXGvylOqS
         aHY518FwRl1ay/JAJrde3fKr0uGVs1u1R4l22tLAKK8J80SGNOm9REvxzOwvgChUckxe
         B8XWuyNbsQ2JYNQMIAaEu5f/EJ8R4oIZCxwScf8an52UpZyU/ZhzCxgwfTB24KZeYU6/
         6fvS5adYnxiOXXwRv7i3Gcuvn5w1oOIFnnukAhyETlyQiHUOulk4CfDjd9YKQkwUD7Rk
         mjxWR+1q6vF29SYWPN2uPbdCzRMLNf6bdkkwySR37KDuFwM0Ym+XKtIaBwoGezFVHc+K
         38Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060535; x=1697665335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3x+4fo1FQvvp7MsrCakfZv3GSfVAekp9vggTyPc6Qc=;
        b=nqpy98ETpHwk2LdMn2BFx4u3MZIqWH8D6+G7PJHqU6/JI+cRraXRqlcTx9vVKKzqMH
         JIvkar8+0Z56RdXgkpw8E0vHHuZum0/zViXJG+5puOVYtsS/FPS22Slnm47fBD+ivMo0
         peQ5tCp0dvLiB4Ta/h7XTm92QzYya3p7JYzEjO2hwDbK7A3xBKuVWyzPm8+1UDLPBL1p
         RHoyaegpy/1Y75DusToFIxfbXMAvM81pNrhDnMFMDGctr5FQQfwENvbU+GY5q3K8r6MJ
         Sg36LW/am7uvzc02o+g/orS3d98GCDm6yGVNYWhGtP1HAxxWdOgjoOsPMsEQ7T2lEwr/
         UN6w==
X-Gm-Message-State: AOJu0Yxapr8ENH/m96O4c6aJDNISQcWBPPALh51lVNjMYCpGrvIRUOz4
        t+4IDrmFT7tRq4zPZ1coBRPufBqiHMnsgCD2/2el6ch1Bt0rlXJI
X-Google-Smtp-Source: AGHT+IGE9h2KZa1hQ0kD+g04xUtSNn+/+9z2PshPMC6PhMk3bdGjCwOsmA2j3ogFpfq1gstZuX78qQzaNFP1NUn3ym8=
X-Received: by 2002:a17:907:1de6:b0:9b9:f0e2:3ef0 with SMTP id
 og38-20020a1709071de600b009b9f0e23ef0mr16965367ejc.17.1697060535263; Wed, 11
 Oct 2023 14:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <937af4c3d97d4c3d93721a08029fa7a4@grupawp.pl> <65243B1F.6040302@o2.pl>
In-Reply-To: <65243B1F.6040302@o2.pl>
From:   "me@jse.io" <me@jse.io>
Date:   Wed, 11 Oct 2023 18:41:39 -0300
Message-ID: <CAFMvigccqZ_v9aHsYcK3qoP0F7iDyB5CjPtQTq=bMg5ba4eNoQ@mail.gmail.com>
Subject: Re: BTRFS /dev/md0 recovery - mounted RW, after being hibernated.
To:     "pe3no@o2.pl" <pe3no@o2.pl>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 9, 2023 at 2:47=E2=80=AFPM pe3no@o2.pl <pe3no@o2.pl> wrote:
>
> Hello Dear BTRFS Friends, nice to meet you!
>
> Would it be possible to get BTRFS Developer/s help to recover my
> important data from BTRFS /dev/md0, please?
> By mistake, it was mounted RW after being hibernated. I was not able to
> backup the data before, so I strongly need to recover it, with your
> Great Help, please!
Could you please post exactly what issue you're having? Are you saying
you mounted the filesystem on another system, then resumed hibernation
when the filesystem was already mounted? What kernel were you running
on the hibernated system? Please post all the exact errors you get
when attempting to mount the filesystem, including from dmesg
especially.
>
> I would  also like to ask a new BTRFS Feature which would prevent the
> possibility to mount a BTRFS partition RW, if it was previously hibernate=
d.
> I can specify it in more in detail and get involved into testing, if need=
ed.
>
There actually is some protection on this, at least with more recent
kernels. Knowing exactly what you did, what kernels you're running,
and what errors you're getting now is crucial for narrowing any of
this down.
> Thank you in advance for help and kind regards~~Piotrek~~pe3no

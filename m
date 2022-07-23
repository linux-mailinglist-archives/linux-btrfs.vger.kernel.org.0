Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB557EEE2
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jul 2022 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbiGWKuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiGWKuL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 06:50:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF3E77
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 03:50:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bf9so11216766lfb.13
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jul 2022 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=OGXuYghdQjEIvgRHGvRkS3l0629MpqLD+zvowX7PrNM=;
        b=Kgl3jhREOutxSzRc57tlRtWP72xGVlbyQgvSH99Gcrp3IoKjw+vldlRhRgR0rY9EbK
         Koo52irYbaG4650x+U6eDML4Q9FF6fu+2FjcMuV+oVeDhqkVZjpjYjxSOdKJQptdL3po
         MzogzD77CiSuqO08kf+jEXx3izfctuX1F563Fc5zmyfzFoAZnRSzbk4QdXjwvPxCPMiH
         UWRGPJsNW30Y9Tr1qkaieEwBk5Ag+37NLlnb2Ihdr1MrndKqfgB2oC4V3pA//CcrzL6g
         M35D4wqI6Kx7mlXo+HcYafXkuKxijJV13Wj9ME9hOEYj9v+0z//4ypO4I7R3JiT8UBQR
         hcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=OGXuYghdQjEIvgRHGvRkS3l0629MpqLD+zvowX7PrNM=;
        b=M2K79VM/SZxcGfKAEjwK7QkAISGCIH3HeeygPwZztFPI946wRvyJ8n7f3BZNTQ8q3U
         iftYOuvg5pTMkX1Enc2vKxUe578g69Yw6pweHQFD1iv6JDOaGkxN23eT1Ycy3dfv0isB
         g2J7pAdu+g9ZqIbegeOaNgQzq6McAoZ1CtxrH07y6TGf2yrHAhnG0UwrQ5X3d6eUtdX1
         zuftt8AO7klTjjJ5iNC6HudNN/4w2ECQOEjv9MEpcLqIbNP79kRSBecUQrp1P8lUspbL
         YpMetE4DmxecQZQTYRFw6IvtHPqGzVtUZwObHA6NXFCUsjmWcVXJfSfbQRo0FkRmyBTh
         qQvA==
X-Gm-Message-State: AJIora/MoekJOfpiPbnBIDWig0heXaxur1Wi52VjSDJ6w/NftdK1rOYJ
        1Aej128oaIWVcQnROlrZkzomHSPl6oJKKZ/sJAE=
X-Google-Smtp-Source: AGRyM1vPdmYSugir4tDt/6DvBwSIRMFTmpmjVCzwOgJOpmUNm8K50O3FVMKZktHBYBF7GTkCnTRYN9asDhZuU7Lz2IU=
X-Received: by 2002:a05:6512:ac7:b0:48a:834b:7c70 with SMTP id
 n7-20020a0565120ac700b0048a834b7c70mr445259lfu.151.1658573406607; Sat, 23 Jul
 2022 03:50:06 -0700 (PDT)
MIME-Version: 1.0
Sender: missmary.kipkalyakones01@gmail.com
Received: by 2002:aa6:db8c:0:b0:1f9:c0b6:c0f with HTTP; Sat, 23 Jul 2022
 03:50:06 -0700 (PDT)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Sat, 23 Jul 2022 03:50:06 -0700
X-Google-Sender-Auth: 46hJuEFB42af6Y-quwaBshEeR_U
Message-ID: <CABGtNUurh2q6ejbXhGieZr3JLyc-8wdHwE5hCBcvC=fcxnoXKA@mail.gmail.com>
Subject: My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Assalamu alaikum,
I came across your e-mail contact prior to a private search while in
need of a trusted person. My name is Mrs. Aisha Gaddafi, a single
Mother and a Widow with three Children. I am the only biological
Daughter of late Libyan President (Late Colonel Muammar Gaddafi)I have
a business Proposal for you worth $27.5Million dollars and I need
mutual respect, trust, honesty, transparency, adequate support and
assistance, Hope to hear from you

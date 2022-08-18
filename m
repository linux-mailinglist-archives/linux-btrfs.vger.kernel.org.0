Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A168597E89
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiHRGVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 02:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiHRGVs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 02:21:48 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B803A5998
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 23:21:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3246910dac3so15379607b3.12
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 23:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PshH5q33q9WiWTMbRMEXFWoYNXBUm8NoU+IdaIyzskc=;
        b=VI+vDhL+2F2LZpV/aURqnYI2R3e7+IBt8s2Pxy4OIlGEaatvqBtXV0Rik/ffWuPw6m
         qIH7f3kOn+R6f+uVgztKwlB4kd3xWFSinRYPgMDYEE4qdvUSMQkrHRb3YBGhvPTxnn9/
         gCY9hawXioZhvZweKhPLgageavUWArKbmFoO+FQpJi7vZJT5lAJGD4G723jTOetEN9PA
         cvaX4MfcLFmhaDLkdF4xAI2eYsjQF/b+L7937LnOQ2P1anashjOR8OcplJa25G83T9XD
         xx2nyDkHvxCRc8dYcNh9R3+dxupLdj5jl3bKL5XPqc9BydomNpctAH0O5CEmcg2JVULD
         RZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PshH5q33q9WiWTMbRMEXFWoYNXBUm8NoU+IdaIyzskc=;
        b=Yn+/q7ysg6yu2FvgK+/g8xchNwl/OmC2U6hykMti0XXG4ovWzmuR1orJIG/fZVeiR6
         UdLhV25/TejM6POk13liB+2n8OBpkFPr3hlZ7zhi47vaYd9Q0sS8LEcziqhgs7PGVrD+
         QcxOZ/1COtxf1ytGU3v/coTAUUnvCF66koIs2Y4OaNo05LAcFW7tNTOStn384okjuC5R
         M29774/3+YkzB5DweQn2byYvo3FjPZFdDPtywkcVx53IOlUr3GqyMih5NxGQWxqC45O9
         SbCyEp+htd59fGMMuANHfNyqiwUztk9imQWZ8/zjWrnV2iEPF2716nyPsJ+anj0i8+xa
         HIpw==
X-Gm-Message-State: ACgBeo2n1DuBwffZE9ovAujcV2dtP201jZAC3BZdUHYJVwCCp7F+2mlr
        eqfAt1S1i35zo+SuY3NdyZXJio6jgYptOzCkWglx1gIKmF9o2A==
X-Google-Smtp-Source: AA6agR687QAIhG5cMumQK70UvPX054Rw8Dt1bFgS4Dgbf+c6g/S8G4hAIpUKGfM+B/96Q9i09/xBz6gKVuDYfuZCQ1U=
X-Received: by 2002:a0d:f9c4:0:b0:32f:dfba:ac10 with SMTP id
 j187-20020a0df9c4000000b0032fdfbaac10mr1468017ywf.347.1660803706610; Wed, 17
 Aug 2022 23:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660690698.git.osandov@fb.com> <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org> <Yv2A+Du6J7BWWWih@relinquished.localdomain>
In-Reply-To: <Yv2A+Du6J7BWWWih@relinquished.localdomain>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Thu, 18 Aug 2022 08:21:30 +0200
Message-ID: <CAK-xaQZh4DJf=6oxK2SVuodxE_bhUxEjAJXmYd6KfXGdg_9PEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno gio 18 ago 2022 alle ore 01:59 Omar Sandoval
<osandov@osandov.com> ha scritto:
> From what I've found, it's much more likely to happen if you delete a
> lot of data soon after boot with space_cache=v2/nospace_cache and
> discard/discard=sync. I can't say that it'd never happen outside of
> those conditions, but I suspect that it's much harder to hit otherwise.

Thanks a lot for details.

If "discard" is a necessary condition, does it mean that on HDD we
don't have the problem?

Do you think is enough for the moment to disable "discard" on nvme/ssd?

Ciao,
Gelma

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC677D09A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376423AbjJTHlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Oct 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHlx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Oct 2023 03:41:53 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E193
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 00:41:51 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d36b2a247so3325486d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Oct 2023 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697787710; x=1698392510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa0xa/eHNcCLSN4jU5w9L+UgbLX0/qpCkz9jorDITs=;
        b=AvAcrGW5aY1lChxIAg/NbMHQ3hA8v4cgab7mfBDL4APx+gjN6uvUBsgeNoU/Bvh2Y6
         nf0fIgpZF0y6jfzKhI1uhyGuzmG148xrvklISNAYk6zwEWveZqKz4oFvDMPRidT7IZdw
         nhckKrrAWYxW9G+zgFFX6JCI3/Hvrf6YK8n710rdNHmDYh4APf7KOUOEi6GSGam+RInA
         yocUWPBUf7p+M7kzj/BP07qylEu60z2U9vlSgW1AxkANHQM3AuOZOcLnhQCyC7Q+WGUn
         eHVdE0zPK51YZvVVHJPZxeQV+SXVORm4TLLXBZbtJPCKevpfdt/6wRpjmVHVzzDTndlm
         +QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787710; x=1698392510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBa0xa/eHNcCLSN4jU5w9L+UgbLX0/qpCkz9jorDITs=;
        b=U/1eQMg95cbc9+Pb0NyndL0e06II3aJ6zjpRZkJWN3pHgTH4RE5JgkrN9enGP0379D
         bM0GYsMHjUpIVfXM/lzh2wgV5JGDa+nMyt8MIsax138bDCY5AfBg0wvPKNvJ9YxIatWN
         pPG+nKZ8dFu0IF7bht4In6JlI59226IJWupn4MXKHdhLDGA+sfL2/kb1nZtg90PKWNLb
         R3jMN5owQ4e6f9eJ6uGy2TnKjlfAptzD0okB2/w1y/5qbnFiVOFfCXrRWoT6JQPXOo0U
         VyTYm3s8AmICZN3EXM1beYs+5utggza7EZR17oA0B+clFo8qIbvQogUG4JWrxsWnZnyi
         +iXg==
X-Gm-Message-State: AOJu0YzY+8Pxee2c+TLb9yjqurEHrx4IhKSkSTW/NaME0nUqjVkaFxaX
        3Tr6gayDFmYzOw3Z+zEjqC7uVCkP76pwqo+Z6I+tb9ai89lDk/I12w4RbA==
X-Google-Smtp-Source: AGHT+IF4DP8EnmUuEgxb0AWEosQEB3fTMTya1XnxFLtaGR6STLfbHmgJkB9SCGKsieIg9mX9CbrMN19r3UImMJv5EAs=
X-Received: by 2002:ad4:596a:0:b0:66d:1230:9682 with SMTP id
 eq10-20020ad4596a000000b0066d12309682mr1436777qvb.62.1697787710110; Fri, 20
 Oct 2023 00:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <20231016165247.14212-12-aleksander.lobakin@intel.com> <20231018172747.305c65bd@kernel.org>
In-Reply-To: <20231018172747.305c65bd@kernel.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 20 Oct 2023 09:41:10 +0200
Message-ID: <CAG_fn=XP819PnkoR0G6_anRNq0t_r=drCFx4PT2VgRnrBaUjdA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to bitmaps
To:     Jakub Kicinski <kuba@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 2:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
> >  40 files changed, 715 insertions(+), 415 deletions(-)
>
> This already has at least two conflicts with networking if I'm looking
> right. Please let the pre-req's go in via Yury's tree and then send
> this for net-next in the next release cycle.

Yury, Andy,

The MTE part of my series will need to be reworked, so it might take a whil=
e.
Shall I maybe send v8 of
https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com/
(plus the test) separately to unblock Alexander?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

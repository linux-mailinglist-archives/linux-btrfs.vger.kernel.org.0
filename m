Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D253C957
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiFCLb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 07:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiFCLb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 07:31:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3D3C706
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 04:31:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a15so1498658wrh.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=hXFVfWKbPfYfki+hUST7d+qwEdq4Sx3ikymQJO4qfRWAQ6NCVrdv1fSJ4QVqwgAe0f
         TMe65h/Z/A0v0eui4IeucF8U/cfFw0uwn558o5kzLpsaaJZecMKeK5otpPfoogPhH+0I
         VnMFGCtFVBykiDLULnLuYg1tXddQ343r/N+Aa3Ii+HXUUyAe0YXJjrkjNZR4mS7znO6W
         F6qfQL+MVj/JOW3VGNo/jEDGj9JKAX2WHRFCQoIhEwcJEvHITAvOHo9B9A4PFHREZ4Dm
         y9sVIRZ94sMCPPaJ89ZeyRn6WqoSwJTz79FrYmuYZTem9PoUO/hgsG/YdwsmQPZ8aKJQ
         3cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=yCd2M8Lt3hvYAJ3HzXPrs3XeVNHJn/nzzA0p9ncznbEkEZjWkhZW0/SLL314QAJEHJ
         juambmy+fHUdrZCnExnD2RJ1Y/in6BOTnwUCFUYyfq6aeodQCzSDjd6wibU9QzClgF9I
         gQ3exKzg8Jo5v8qlPEIhTV7ziS/Sz2psl+HsPG0bHqwl2BBN/CnrfXPUuU4WiTTVeQYi
         4NO41CmNo3aAt/cMBhCbLN/1NUaAoLcnwK2WKh76RJa8QxtO5zPKizaS8jfVlygzfkVP
         CV4+Ti+IkG7pUT7COP7qO72VlDNQeC7YFVO4IrkewrVbs/xeJcfTouF3MoC5NFLHz9Uu
         mNUg==
X-Gm-Message-State: AOAM532jPARfkh2aL6CipdICvaLNZXz3SrR95FNqnlgRXszvM72JDc8p
        2s+KF0oq8dUkc2Xs/7u0cQ1rCUB/QmZv0LccOOk=
X-Google-Smtp-Source: ABdhPJx486ILrdBUP5bAy1h7RazRYwtM4CtJLDwu0GW/xTWrFd5GDqz7CwzHP4b+0PodDQj8+3N3jF6HhQkTP6hktHs=
X-Received: by 2002:adf:f543:0:b0:20d:80e:dde with SMTP id j3-20020adff543000000b0020d080e0ddemr7676879wrp.269.1654255882747;
 Fri, 03 Jun 2022 04:31:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64ed:0:0:0:0:0 with HTTP; Fri, 3 Jun 2022 04:31:22 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <mariamabdul888@gmail.com>
Date:   Fri, 3 Jun 2022 04:31:22 -0700
Message-ID: <CAP9xyD0a6Ba+XbBpVm3S4O1u9OyCTTFzE7h7XZ8AOSADgU2hrw@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Good day,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark

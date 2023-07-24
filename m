Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E97175EBA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGXGha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGXGh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 02:37:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8DE42
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 23:36:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b73261babdso10591851fa.1
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690180605; x=1690785405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nM1on12GTUpS0KCmK/oXjYx5XNTLuVNnZ3uIsBpws4=;
        b=sqfkOZslhlDM2xYZAwP4sgdrFZ3gAgYHubuRUJfUZZ+fKoKO2QbD9cH8+ddfiAaSKJ
         o7QMGFDBXyqJH/oHe/cBxqjVhMxuFG75wqUkRvcuC6ZutR76+ifZEl8JIDSq2Po6KjVu
         LdweUwBYvI5cxCeZZhAGjp2URVCHCx3CD9JVRLmOkSMYYq/rM+BNjwpOXBMQyloe8kHu
         /II/Lf3g88cHpxlf6+CTDbJrCGEVv4z8dVyTYchVcCr8Xli747oqOJCFIMsEz0JHTttB
         /VpJBgiD8zXoUHpO89QjKQQJbpIVw3lDh22YrN1Q8ON/eVz2AiTjl6MvOFsMvsszPrOS
         fjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690180605; x=1690785405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nM1on12GTUpS0KCmK/oXjYx5XNTLuVNnZ3uIsBpws4=;
        b=NAirw1h5vfHCFBnwneulSJ9bqbW6eczONcr7CStOUC+Tu82kjjSbNJR2dnE0TSIQr4
         0A0wagGBBwCmRDWi6JBKKuJvg+fuROe4+1BqFzVPz/t90uPALvJL0dT6AM8XaUDX2tM3
         +HB9NMQGDaylDhyi/Bxl+MBtkg4IkGNXMjpLsqlk/eU53AaGKNXoRVKCom04CN582wNe
         bAjp0qx9WdbSwPK3NH8mikShqQ4x04nukdNnJjKa6/q6RKOFQt5gL/xMdnYiLz8lKqab
         Rsu8ftiHV1pc4d4TySJ+uwYv/P0Oi8x2ahsLo5AN3aQTJ/JvGwUnpp2nGeAqzwMxGdBe
         9F+A==
X-Gm-Message-State: ABy/qLZxyVBbsjjwwS8dzy1h5JSTmxq8B8qgPHzeACGu1KG/aDpjicup
        cCNHpR5VSr+hcUTmwfFkMoJ6/Gmv4rCCeOEi19JCyhyP
X-Google-Smtp-Source: APBJJlG95AkgZsWLBsApqJonNeENUrjdr9lta4iw/xR+IO/FFSWAJcDiKqVUG86wAyi9epFpXn2e8usl3255Kyvbuc0=
X-Received: by 2002:a05:651c:626:b0:2b6:cd7f:5ea8 with SMTP id
 k38-20020a05651c062600b002b6cd7f5ea8mr3899518lje.1.1690180605207; Sun, 23 Jul
 2023 23:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
 <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com> <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
 <86568e50-7dac-2c1f-c678-4b63ffa5b1e0@gmail.com> <303f4dab-1143-0ef8-444c-ba57e13b209e@oracle.com>
 <RU8AYR.9BP7K2RWK3SZ1@ericlevy.name>
In-Reply-To: <RU8AYR.9BP7K2RWK3SZ1@ericlevy.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 24 Jul 2023 09:36:33 +0300
Message-ID: <CAA91j0X4iKcAoUak48zV1+kzhofS+UcnPV2MtkONvkRFQ0qybw@mail.gmail.com>
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
To:     Eric Levy <contact@ericlevy.name>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 7:38=E2=80=AFAM Eric Levy <contact@ericlevy.name> w=
rote:
>
> However, I think systemd should complete the device scan before
> clearing the units remote-fs-pre.target and iscsi.service.
>

As I already told you, that is what systemd should be doing by default
for mount units generated from /etc/fstab. Or more precisely, the
default dependencies used by systemd should make sure btrfs mount is
not attempted until all devices that are part of this filesystem are
present. If you have evidence that it does not work you should file an
issue on systemd github.

If you are using your own mount unit it is entirely up to you to make
sure dependencies are correct. Do not blame the messenger.

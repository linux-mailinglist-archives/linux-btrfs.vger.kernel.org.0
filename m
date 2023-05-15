Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A0703DDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbjEOTyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbjEOTyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:54:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FCE718
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:54:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so20278246a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684180465; x=1686772465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QGh19zyN5Rkzx94pjyeGMgNAq81Ur8Pxi+5gzJkcTs=;
        b=XaV3MDfMmtiA8vLDPJEV1X4G8ZlCcQrkXf8Bxaa2pmaijPxXer2VvMX5SJovuW5Ulw
         tevhPfhyHArodEdHcApWcJGVlSqlawHZPuZ0AMwcKezoGMlMgTkOwcGn5lyYWyeKIOXO
         WicMkLcsmfhxGFIbxp8ZNMpxo9HQT88teaIrm9WRGuTQjW4GNrv5PdSqZueuB+n/by+s
         l0UDQHMdJBgSeXNW982l5tt7ddBf79SVbcMB143YSI/h+FYGOcgDN4j3K8XrwKN2DgfT
         kNI7N1oxDqKnbBvd91uu88XpjjDYlLiGwcgqbjdRRD2v4dzlgQknLj1FAUq/gXRUUd3U
         OK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684180465; x=1686772465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QGh19zyN5Rkzx94pjyeGMgNAq81Ur8Pxi+5gzJkcTs=;
        b=LMRAwyBhS9kGJzhyWZc2Pl7eRg4N/LvGXZfMAyvzql1RXQxr8LZXUipB02pcJ9wJET
         PEgfM9lfuS2WKB5NT9BHE1QuS39lBUI2188fGUdf4l/UMF8Ml75zFhkyUQRqHL2F4135
         Jv6grJnNuJJc/hmph2Tx1Auq7ioFOppxOnULYFS7RWjrOm2rsy+DCTE8x01Ab8nbGhv8
         wteGUNQYsI4UP7YDc9znepnJhx2UhUnknj6lt4Cqr9K2EcBsQWfwPiwtJqD/NVqLCJZ0
         oXRq5CTb2uxc/w8JAIIAHTEn2GIXDHpeyLR+po+C8mi0d/SVZ3zYQdWkgZAl8EObjCGW
         1uzQ==
X-Gm-Message-State: AC+VfDzxMbYKhPxgVlEuumd+a8W+8NdZZfRO7eq1f5MU38RwBj/PQgA1
        1rfGqhIluleXdxne3rTT03yafT6+BY8nJg/JQZU455i7yZVH0w==
X-Google-Smtp-Source: ACHHUZ5JlVIPCRWZ5W2PpULNQ9bfoXIOn9ar3RHiFMknDFupLvpi+faPWqFFC1gFSBCj2bGkPEb9LOGwiZliBIg1Kdo=
X-Received: by 2002:a17:907:7dab:b0:96a:4f89:3916 with SMTP id
 oz43-20020a1709077dab00b0096a4f893916mr14521789ejc.58.1684180465268; Mon, 15
 May 2023 12:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230514114930.285147-1-sbabic@denx.de> <69df9067-3986-b818-bba2-868946a039e7@libero.it>
In-Reply-To: <69df9067-3986-b818-bba2-868946a039e7@libero.it>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 15 May 2023 15:53:49 -0400
Message-ID: <CAEg-Je8of_psB==V+PH0rpDi6FCpvuKHFBz18qprx4m-y0yZ4w@mail.gmail.com>
Subject: Re: [RFC PATCH] Makefile: add library for mkfs.btrfs
To:     kreijack@inwind.it
Cc:     Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 15, 2023 at 2:05=E2=80=AFPM Goffredo Baroncelli <kreijack@liber=
o.it> wrote:
>
> On 14/05/2023 13.49, Stefano Babic wrote:
> > Even if mkfs.btrfs can be executed from a shell, there are conditions
> > (see the reasons for the creation of libbtrfsutil) to call a function
> > inside own applicatiuon code (security, better control, etc.).
> >
> > Create a libmkfsbtrfs library with min_mkfs as entry point and the same
>
> Really a minor thing; instead of libmkfsbtrfs, I think that it is better =
call it
> libbtrfsmkfs or something like it; so all the btrfs libs are with the sam=
e prefix:
>
> - libbtrfs
> - libbtrfsutils
> - libbtrfsmkfs
>

I think the idea is that we're *not* going to do that and instead look
to expose filesystem creation features in libbtrfsutil.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

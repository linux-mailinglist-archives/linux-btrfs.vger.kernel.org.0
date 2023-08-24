Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96A787C02
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 01:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHXXiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHXXiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 19:38:11 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC8FB
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 16:38:09 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d31f142eeso5000157b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692920288; x=1693525088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4mITBHFp7t0t6+tfZHtfvQ+GqeRTkB0SGprfb/kupk=;
        b=K+AlCYHA8xnobfcAs2HbwV1oFvta4iVT+l37Ink0cSe5UEX8xZ3HpTmO3WWG+AyZV5
         LpDEWWIkdMcZLb4ia6mh4isahLx7LMjksLiZ6a10e/r+KjlM7MLsu/5wmEOR+Ds4G8Fx
         L521ow8MkFrK/Wi72fecemcJo6ZC8dFfKf8Qge/GJHsY9TDSkO2hxzXNDEHKKFyvzcT2
         3NPOlFyA3dwOerjHwnsN4AYj72oLd7GWpnUIGfHYDJ78YCixI/ktBbLZmrHra0tL01zr
         LFbhqIXjt0pX71/SgAxfC7Ba78A3q3oIPErSg3CtkO+MRU+A6QwA+qToTIl9IPtlxTFa
         6Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692920288; x=1693525088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4mITBHFp7t0t6+tfZHtfvQ+GqeRTkB0SGprfb/kupk=;
        b=ZW3i9xRiPC6Xkw4Syt5C+YmjvPLMUKjFiYHMMsteTX846fL+qWG4JB6SfAw5EQ5tgQ
         jNcGtDOJF/8Po8D3Qwki3VHK/pLLEZl+/1Dzdau1nMFXuxugGJVhYXdTj29lIfuQYJlo
         D0hOn4Uj7KsMYdafSd/+EMEOPnV6qP3FDB+uD7V1SygR0hAlwoNnJMODTBH3psMYoDig
         puM/u+xyVZzGbHotnXz/a34gGeBK3t/AM7yLukOD3QhUu8vr58lMdl5zLF1UqoSku4lH
         4G0FUmvUmeWqz+dCvWaZhkiW5nIpx5ASTclVJCNNK9K9KrMVX+GqY6f9Dk9t1vVN6t53
         8i1g==
X-Gm-Message-State: AOJu0YxbqPOkJeHFe2j1iwgO5OL+pXQgJjqOlKBmIfOs4bj9Xy8Z+uq3
        v9mF3Fjz8+FSeAw1T/K2ak2elDYGQzYDig==
X-Google-Smtp-Source: AGHT+IH1WbxHt+p1Q8ZWBLDbCd/JXc64A+6v2n0nSv1oIHvUNQ5Tpogbw7Qgp/znkeK5r+Pz4ShBjw==
X-Received: by 2002:a0d:c947:0:b0:589:fcb2:d57f with SMTP id l68-20020a0dc947000000b00589fcb2d57fmr18527516ywd.37.1692920288277;
        Thu, 24 Aug 2023 16:38:08 -0700 (PDT)
Received: from ?IPv6:2603:7081:3406:8f26:cc85:48e1:2259:9b56? (2603-7081-3406-8f26-cc85-48e1-2259-9b56.res6.spectrum.com. [2603:7081:3406:8f26:cc85:48e1:2259:9b56])
        by smtp.gmail.com with ESMTPSA id d4-20020ac86144000000b0040ff25d8712sm172259qtm.18.2023.08.24.16.38.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:38:07 -0700 (PDT)
Message-ID: <3dae04d3e9b960c06d9870db1f0b272914389d17.camel@gmail.com>
Subject: Re: btrfs check: root errors 400, nbytes wrong
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 24 Aug 2023 19:38:07 -0400
In-Reply-To: <9d3f9b12f9512586c0bfbe42e730e4304a540127.camel@gmail.com>
References: <4a18c53b36e312b3de3296145984ed74323494ff.camel@gmail.com>
         <04b21f25-a80e-4e1b-a70a-3401ca3c2af2@gmx.com>
         <9d3f9b12f9512586c0bfbe42e730e4304a540127.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2023-08-24 at 19:32 -0400, Cebtenzzre wrote:
> On Thu, 2023-08-24 at 13:40 +0800, Qu Wenruo wrote:
> >=20
> >=20
> > On 2023/8/24 08:38, Cebtenzzre wrote:
> > > I am getting these errors from btrfs-progs v6.3.3 on Linux 6.4.7.
> > >=20
> > > Can I safely run `btrfs check --repair`?
> > >=20
> > > root 258 inode 123827824 errors 400, nbytes wrong
> >=20
> > Just to be extra safe, you may want to run "btrfs check --
> > mode=3Dlowmem"
> > to get a more human readable output.
>=20
> Here is the log with --mode=3Dlowmem:
>=20
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 76721faa-8c32-4e70-8a9e-859dece0aec1
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> ERROR: root 258 INODE[123827824] nbytes 1777664 not equal to
> extent_size 1757184
> ERROR: root 259 EXTENT_DATA[1522634 4096] gap exists, expected:
> EXTENT_DATA[1522634 128]
> ERROR: root 259 EXTENT_DATA[1522636 4096] gap exists, expected:
> EXTENT_DATA[1522636 128]
> ERROR: root 407 EXTENT_DATA[398831 4096] gap exists, expected:
> EXTENT_DATA[398831 25]
> ERROR: root 407 EXTENT_DATA[398973 4096] gap exists, expected:
> EXTENT_DATA[398973 25]
> ERROR: root 407 EXTENT_DATA[398975 4096] gap exists, expected:
> EXTENT_DATA[398975 25]
> ERROR: root 407 EXTENT_DATA[398976 4096] gap exists, expected:
> EXTENT_DATA[398976 25]
> ERROR: root 407 EXTENT_DATA[418307 4096] gap exists, expected:
> EXTENT_DATA[418307 25]
> ERROR: root 407 EXTENT_DATA[418316 4096] gap exists, expected:
> EXTENT_DATA[418316 25]
> ERROR: root 407 EXTENT_DATA[418317 4096] gap exists, expected:
> EXTENT_DATA[418317 25]
> ERROR: root 407 EXTENT_DATA[420660 4096] gap exists, expected:
> EXTENT_DATA[420660 25]
> ERROR: root 407 EXTENT_DATA[420673 4096] gap exists, expected:
> EXTENT_DATA[420673 25]
> ERROR: root 407 EXTENT_DATA[439382 4096] gap exists, expected:
> EXTENT_DATA[439382 25]
> ERROR: root 407 EXTENT_DATA[439383 4096] gap exists, expected:
> EXTENT_DATA[439383 25]
> ERROR: root 407 EXTENT_DATA[451252 4096] gap exists, expected:
> EXTENT_DATA[451252 25]
> ERROR: root 407 EXTENT_DATA[451264 4096] gap exists, expected:
> EXTENT_DATA[451264 25]
> ERROR: root 407 EXTENT_DATA[451265 4096] gap exists, expected:
> EXTENT_DATA[451265 25]
> ERROR: root 407 EXTENT_DATA[452326 4096] gap exists, expected:
> EXTENT_DATA[452326 25]
> ERROR: root 407 EXTENT_DATA[452332 4096] gap exists, expected:
> EXTENT_DATA[452332 25]
> ERROR: root 407 EXTENT_DATA[452339 4096] gap exists, expected:
> EXTENT_DATA[452339 25]
> ERROR: root 407 EXTENT_DATA[4293157 4096] gap exists, expected:
> EXTENT_DATA[4293157 25]
> ERROR: root 407 EXTENT_DATA[4293570 4096] gap exists, expected:
> EXTENT_DATA[4293570 25]
> ERROR: root 407 EXTENT_DATA[4293571 4096] gap exists, expected:
> EXTENT_DATA[4293571 25]
> ERROR: root 407 EXTENT_DATA[4293572 4096] gap exists, expected:
> EXTENT_DATA[4293572 25]
> ERROR: root 407 EXTENT_DATA[4302136 4096] gap exists, expected:
> EXTENT_DATA[4302136 25]
> ERROR: root 407 EXTENT_DATA[4302148 4096] gap exists, expected:
> EXTENT_DATA[4302148 25]
> ERROR: root 407 EXTENT_DATA[4302149 4096] gap exists, expected:
> EXTENT_DATA[4302149 25]
> ERROR: root 407 EXTENT_DATA[4302150 4096] gap exists, expected:
> EXTENT_DATA[4302150 25]
> ERROR: root 407 EXTENT_DATA[5970391 4096] gap exists, expected:
> EXTENT_DATA[5970391 25]
> ERROR: root 15685 INODE[123827824] nbytes 1777664 not equal to
> extent_size 1757184
> ERROR: errors found in fs roots
> found 2324685996032 bytes used, error(s) found
> total csum bytes: 1812599528
> total tree bytes: 12918194176
> total fs tree bytes: 9882157056
> total extent tree bytes: 836272128
> btree space waste bytes: 2041051573
> file data blocks allocated: 25781547192320
> =C2=A0referenced 2545608298496
>=20
> Does it look okay?

Whoops, I forgot to CC the list.

>=20
> > But it's mostly fine, a btrfs check --repair should be safe if and
> > only
> > if those are the only errors.
> >=20
> > Thanks,
> > Qu
> > > root 15685 inode 123827824 errors 400, nbytes wrong
> > > root 15752 inode 123827824 errors 400, nbytes wrong
> > > root 15760 inode 123827824 errors 400, nbytes wrong
> > > root 15768 inode 123827824 errors 400, nbytes wrong
> > > root 15772 inode 123827824 errors 400, nbytes wrong
> > > root 15786 inode 123827824 errors 400, nbytes wrong
> > > root 15798 inode 123827824 errors 400, nbytes wrong
> > > root 15814 inode 123827824 errors 400, nbytes wrong
> > > root 15818 inode 123827824 errors 400, nbytes wrong
> > > ERROR: errors found in fs roots
> > >=20
> > > Thanks,
> > > Cebtenzzre


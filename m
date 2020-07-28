Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8347E2310CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgG1RZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 13:25:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37267 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731684AbgG1RZF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 13:25:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 49A9F5C00EE;
        Tue, 28 Jul 2020 13:25:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Jul 2020 13:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:subject
        :from:to:date:message-id:in-reply-to; s=fm1; bh=TVHW4Yzu5y8ZEU3/
        zWhzLSsjif6OERBdpdBOXAJIVJ0=; b=HqAA/xkqsV5dC/Wz/rloyj9lV6/LpD/a
        aWAem4BQ2lSVG1PMCMgb9nCwwoRfYoq9ppddmEMHnD9GdFfSyFKkGeuh/a3eQdXK
        ADFK7oIN89zKir7NzkVtCxWKtRPV7a+NYAguVIcWJDTtugMYWVFHcf2yePjnYe9t
        Be9s88Y555EFtFxdc7ggX4brydoXsdzuVZTStn8LpsyxhEh1jTXGO6wljMAJr2sT
        x0yUQUtKscj2R0HqtSkkFRrtn/ah7shsJMBtyze1MtS/L9666ze38NFryMO/09qn
        j/4v3+FMQKZgd0O4dfZZv7Qfc8Ej4FTVZW62vHD2QaYedVq69k69FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=TVHW4Yzu5y8ZEU3/zWhzLSsjif6OERBdpdBOXAJIVJ0=; b=hRwdwqpD
        W3vn3E/SV9K9A9Y44e45ukaommYns8UqlHX5zqD+MwW6AQY3MrRs2HxiUg2brv2j
        qNnNtscWv9fuHHYGrIkfsrN41bug0z3BD686GLkDpu/JRWE3Rv2jdrL4FeDmd7yB
        JI1bU1QLbtJ+sS6Mt1hU80ViW2iP0Lw0ijvpPn0PXsGJUCrXJCr0CKAMiO6YlqK7
        6oN7o9DfSweyKlEnEa9f79dQkAjF+f4CPjxgJNPyLN50lXzJQlZpIQjOaD9vkgVI
        cGV/ZzJuCBV3FkDLOX/rmBYNS8iLCTAlcavYfBI22+3URpZKB7nqC17IBmStnw4E
        DaB2DHmvRcuWxQ==
X-ME-Sender: <xms:b18gXyzqp6x5UgEz6IuK0MQK7IeWIlyHooj0kVpMWmWwD6JCRkTYVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpegggf
    gtuffhvfffkfgjsehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfffleeuveeghfdvve
    dvvdelieetgeehgeeuffffgeeuleekueektddtkeeivedtnecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucfkphepjeefrdelfedrvdegjedrudefgeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:b18gX-RYaLDWzxRYGnG97UG12Q4i3C8r9lnb4hlHhQPD7AirubGW0g>
    <xmx:b18gX0UJ233kTpQnfkakCr_wF2QMWL_y-2sUtJuF4_eDEb4sqKGeIg>
    <xmx:b18gX4hcFgdUAim0O__vMBLFMn9mzjlUs0d2IBeJDAzyO9AQlLpf9A>
    <xmx:cF8gX95wWcDJ6B6BOlGW_5GxdMI2FLjC9PI5d6aDHRmz-YYD7li-IA>
Received: from localhost (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A18430600A9;
        Tue, 28 Jul 2020 13:25:02 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Daniel Xu" <dxu@dxuuu.xyz>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     <dsterba@suse.cz>, "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Date:   Tue, 28 Jul 2020 10:24:31 -0700
Message-Id: <C4IFKD9DTBS7.15BFX5LGQB0O5@maharaja>
In-Reply-To: <20200728125732.GS3703@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue Jul 28, 2020 at 5:57 AM PDT, David Sterba wrote:
> On Tue, Jul 28, 2020 at 08:12:40PM +0800, Qu Wenruo wrote:
> > >>> +trim_trailing_whitespace =3D true
> > >>
> > >> Does this setting apply on lines that get changed or does it affect =
the
> > >> whole file? If it's just for the lines, then it's what we want.
> > >>
> > > At least from the vim plugin code, it's just for the new lines:
> > >=20
> > > https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5=
ebadcba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494
> > >=20
> > > It just call the replace on the current line.
> >=20
> > My bad, %s, it replaces all existing lines...
>
> So this would introduce unrelated changes, but it seems that we don't
> have much trailing whitespaces in progs codebase:
>
> $ git grep '\s\+$'
> btrfs-fragments.c:
> btrfs-fragments.c: black =3D gdImageColorAllocate(im, 0, 0, 0);
> crypto/crc32c.c:/*
> crypto/crc32c.c: *
> crypto/crc32c.c: * Software Foundation; either version 2 of the License,
> or (at your option)
> crypto/crc32c.c: * Steps through buffer one byte at at time, calculates
> reflected
> crypto/crc32c.c: * Steps through buffer one byte at at time, calculates
> reflected
> kernel-lib/radix-tree.h: *
> kernel-lib/radix-tree.h: *
> kernel-lib/rbtree.c: node =3D node->rb_right;
> kernel-lib/rbtree.c: node =3D node->rb_left;
> kernel-lib/rbtree.h:
>
> filtering only the sources. So let's keep it in the config.

Sounds good. Should I send a followup patch to delete the existing
trailing lines?

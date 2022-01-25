Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF049BC89
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiAYT6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 14:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiAYT6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 14:58:16 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0DCC061748
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 11:58:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k17so2868475plk.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 11:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hoTam69rBWlqTjJaJ1lUJdo50MmvSCRM65Q3As4vc2U=;
        b=MWKWqIP1eZSIxZeuNLLEtSXlXQBXquhm4pT6OeNA7x7NJjTox77RJpXfAN0GvnzXTg
         /WB3Ry5e+8e1wg4Kt7Fa1sJuHlYQ+jF/GOnindQWj/hJeLVGQ6E4QKZCOzN/FXki/de0
         m72X9x8iJW9Zr4QWAb0igeNoq2CbqVk5VAl8xfGefs/7Z9N/Ih1OI7ZT2EALV8bkXk5Y
         2i9ELlH66JpqxdMHZRbtMXuGTCAv7q5iceCe+A3VxBPB9YP7QX9Gy1F3pjFk5HvMCT26
         bhFOR7g4na1qoAICOg4tMcOSlE9DTIfwe4fidNQSd2TZxmsPA2AKIbguvpaWBvE8Vdnt
         S0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hoTam69rBWlqTjJaJ1lUJdo50MmvSCRM65Q3As4vc2U=;
        b=sWINPks8gnXja+rFMFZh1k7asuC4Omf4QEO2QMo3nIdQzElCoJbUqG3I+bXrJgj5RK
         F954bt+ObGeFkjF+49opkqrWEoqMcbO2uPuCeIMUYjXtDHaCXT8Uu5Af+/Rc/RE7jQUa
         KwZWG6vV1zS/hlKqkzRWxRWvGgTBTTyWQVchZCPEkEssxkY2xDApdWRjHEbogU71YZfw
         gyX2222WMnhWR8f8Z94CQxx5+/dIBggnfzTgXKq4QRe3mxWzrqmupFpsuloBER41tZ9N
         Cf+BV45ossOkThBU4rySzJWv5ohOAz6l1xy9U3YGLO+uNDLvCJ+oJUJmmArOVMOotYwK
         YO6A==
X-Gm-Message-State: AOAM53068jIL8vMbJiReG29QNjVRehWEaH1VL4R4adzJ5RDimicSoKHR
        Uak+YEpLKbs29kLCEGccKa7o7W6C4fMSMA/doaeUEq0ZOb6yXg==
X-Google-Smtp-Source: ABdhPJzvxzwumOo/ubqf3SDNIpWSTyPWBBPIZS+kvhsPZ77gBcqgPCWPnSiQf9mXqvqbcAra701N65fQU5kG5iOHtsY=
X-Received: by 2002:a17:902:7844:b0:14a:9cff:66c7 with SMTP id
 e4-20020a170902784400b0014a9cff66c7mr20207276pln.14.1643140694982; Tue, 25
 Jan 2022 11:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20220125065057.35863-1-wqu@suse.com> <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com> <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
In-Reply-To: <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Tue, 25 Jan 2022 20:58:02 +0100
Message-ID: <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu, all,

> For the real world proof, Fran=C3=A7ois, mind to test v5.15 with these tw=
o
> patches applied to see if there is a difference in IO, compared to v5.15
> vanilla?

Sure, I'll take the last 5.15 I used (5.15.13) as a base + the 2
patches from this thread, is that good?
   1-btrfs-dont-defrag-preallocated-extents.patch
   2-defrag-limit-cluster-size-to-first-hole.patch

Will post results tomorrow when it finishes compiling.

Fran=C3=A7ois-Xavier

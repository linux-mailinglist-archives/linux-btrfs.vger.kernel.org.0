Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E075B00DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIGJsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGJsO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 05:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC079D8E3
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 02:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9DCA61847
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 09:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A979C433C1
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662544093;
        bh=EhsM04o/EtOaqcgLsC+uPMD4qMRCKqk8AyPJBMMpkBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r90yFRNBOH8+mI6uEqt+xlrAovbuGJOc6Y/sv98+z3O7ypmZAVVplmEcxM1E4XefU
         ysXb3aAy33DHRRDs4hCITrvVhEsyfHfs0ez8hzo+zY4+ftPnv7YnuIVd+ZWL0Zipxl
         Sby6XVJF60ay4v/EE5ViWQzG6fOngPfWFKRidhKc6yy2jRNRpNmR+t+BavvHwkwFQu
         qcF1r3ys4OZxKff/xVfKqdZAgawoVeghtgRgVE7QRffR1hB3BPqF11Qj1yKivyAS10
         n8kb2BIywEnLX5a8pHY3WhYtdxrwdfrUfWiwNI5YMZJ4ld1troLxmHZy47H1WC7Jd6
         CVwVHbe2yCpkA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-127dca21a7dso7379945fac.12
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 02:48:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo1y7JlqMJVOlMcbDK4g/5Df7aFgdejU8MfXcStWEVzu3tcAyhU7
        nWfMWgpV99AxUgtSM+Bht0+vmOcmtDwGdKE5gPU=
X-Google-Smtp-Source: AA6agR4GLJ6aucwk0KukqahxXUliQ0mEv1Ep2rLSVaudM2lryMnctyPHBIhnBYyorvyb2ktTIk1yvD8Li3GK1TJgNUE=
X-Received: by 2002:a05:6870:ea83:b0:fe:365f:cb9d with SMTP id
 s3-20020a056870ea8300b000fe365fcb9dmr1373796oap.98.1662544092298; Wed, 07 Sep
 2022 02:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662022922.git.fdmanana@suse.com> <Yxhgl/p7xF1UfqHO@infradead.org>
In-Reply-To: <Yxhgl/p7xF1UfqHO@infradead.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 7 Sep 2022 10:47:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4X994Vjia5NLDaS6XsnrQvp405CC71f2TMriWhzY6zmA@mail.gmail.com>
Message-ID: <CAL3q7H4X994Vjia5NLDaS6XsnrQvp405CC71f2TMriWhzY6zmA@mail.gmail.com>
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 7, 2022 at 10:13 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On a related question:  have you looked into using iomap for fiemap
> seek in btrfs?  This won't remove the need for fixing some of the
> underlying algorithmic complexity, but it should allow to shed some
> boilerplate code and reuse bits used by other disk based file systems.

Yes, I took a brief look.
But that would be something to do separately - right now I want to
address user complaints
about too slow fiemap/lseek (and a bug in fiemap with shared flag
missing or incorrect).

So yes, it's left for some time later. Probably not before I work on
the next set of changes
to further improve fiemap's performance.

One thing I noticed is that iomap always sets FIEMAP_EXTENT_LAST on
the last processed
extent. On btrfs we only set the flag if it's really the last extent
in the file, so the results are
different from iomap in case we have a ranged fiemap with an end range
that ends before the
last extent in the file. That seems like a bug in iomap. It seems it
can be worked around by returning
an artificial hole in the last iteration, but that seems odd.

Looking again at iomap/fiemap.c, it doesn't seem like it would help
reduce code or make anything
simpler, it almost doesn't do anything except combining the delalloc flags.

Thanks.

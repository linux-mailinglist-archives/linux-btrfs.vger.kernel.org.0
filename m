Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0634BED3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 23:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiBUWbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 17:31:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiBUWbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 17:31:48 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E7240AF
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 14:31:24 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gf13-20020a17090ac7cd00b001bbfb9d760eso480316pjb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 14:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gc2BxJNHs4AehMGMdzImYsncC61UZH9Br3hXky2F8eY=;
        b=fzX079dZUwKyXirzaU4lWVYIy3/Rnxj3MPKfoKP9X4Esv7WVOh33lrGmCaEPfCKHt3
         kIicA9dDO5keMBXo0o5e1QpJFTSalahRySXq7njm32SkXAWRN+ftVHuWq3KMl7UwjZsH
         hVzK+jnhwG6h7DnXTX2AXoDeT8r5TYItY3tPqzw9KFlgQKvZi67LtzIihuL39mdVChPR
         TQNPcdGQPrZaI8C6xYhUHoqJ6f1bj6+1hXexebPnf5N3LI4FbUk5iwflhgQAoz3JgHyT
         LTW0crz3rAjj8jwnhsA6YXP4keemltuZHAaW+vbhiOBhkq+aAzFYSvKtEiqPls+aSEDX
         J1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gc2BxJNHs4AehMGMdzImYsncC61UZH9Br3hXky2F8eY=;
        b=1kS0kDy7Q6N45EmLN4OL7FOxQ3C1BA7o/XBE70e8MvVgAI9DVpIJdh/gKJJhX17ngH
         dtvmbReCWIQvIW0YOpClspJdi8lPgSeeQ3BqAzFxo/VPA2eHn6hAd3Rh/z36FqEDjoIh
         KEsI7Cf1Wdi58WDKbycu6pDXn8ekWGUd298X3uEmK/GXFhHx9A4rqqSELL8FCXaGxYAz
         FXU7qmI86vVj1m4biaPw0pioEk2f30t0N/6DOoFEYUNZgtGd/XuYaRutcb3DsGLd0MIv
         NZS19o1oxEd8EWisvRvKSPxe4KZSJDIiFNNQzXkwogMN62QxcrnuIwbA8C6BsELfr8tQ
         gojg==
X-Gm-Message-State: AOAM5300hsRqSFiGbNrOroV0NRg3n++NwOtx5YPw2z3wNFQMU9epnGhZ
        TOvAIgxn3b01PohiL/QbkNGG8NMNemjNY617W3/plizU
X-Google-Smtp-Source: ABdhPJwNZARBUrqJO8qBdPU9Np5yiEnoQTMqLmz0WFTeQ2OxhtOy8fmTVEih8FH494g87IqFp9LdcigS/5KhzlIbge8=
X-Received: by 2002:a17:902:a713:b0:14d:8f49:84cd with SMTP id
 w19-20020a170902a71300b0014d8f4984cdmr20452909plq.145.1645482683610; Mon, 21
 Feb 2022 14:31:23 -0800 (PST)
MIME-Version: 1.0
References: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
 <YhMzKeX3FvJPvtmR@hungrycats.org>
In-Reply-To: <YhMzKeX3FvJPvtmR@hungrycats.org>
From:   ov2k <ov2k.github@gmail.com>
Date:   Mon, 21 Feb 2022 17:31:13 -0500
Message-ID: <CADwZqEts39gdoLKCN2t18UByo_WnLmoRPCbja61wVwSt3wvuhQ@mail.gmail.com>
Subject: Re: FIDEDUPERANGE and compression
To:     linux-btrfs@vger.kernel.org
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

It looks like btrfs coalesces adjacent uncompressed extents.  I'm not
sure whether this is done by FIDEDUPERANGE or FS_IOC_FIEMAP.  I think
the problem is that adjacent decompressed ranges (defined by #3 and
#4) within the same compressed block are not coalesced in a similar
manner.  Is there a particular reason why this isn't done, or is this
simply a case of nobody having done it?

On Mon, Feb 21, 2022 at 1:37 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Fri, Feb 18, 2022 at 10:14:20PM -0500, ov 2k wrote:
> > FIDEDUPERANGE does not seem to behave as expected with compressible
> > data on a btrfs volume with compression enabled, at least with small
> > adjacent FIDEDUPERANGE requests.  I've attached a basic test case.  It
> > writes two short identical files and calls FIDEDUPERANGE three times,
> > on the thirds of the file, in order.  filefrag -v reports that the
> > destination file has three extents that each reference the first third
> > of the source file.
> >
> > To be clear, the data in the destination file remains correct.
> > However, the second and third FIDEDUPERANGE calls do not seem to cause
> > the destination file to reference the expected source extents.  I'm
> > not actually certain whether this is a bug in FIDEDUPERANGE or
> > FS_IOC_FIEMAP or something deeper within btrfs itself.
>
> FIEMAP's output cannot correctly represent btrfs compressed data.
> In some cases you may be able to identify logical blocks as belonging
> to the same underlying compressed extent, but not with enough precision
> to infer data content of the blocks.
>
> The physical location of a compressed byte is a two-dimensional
> quantity--one to identify the physical compressed extent, one to identify
> the byte's offset within the decompressed data.  The length is similarly
> two-dimensional, one for the physical size and one for the logical size.
> Since compressed bytes are a different size unit than uncompressed bytes,
> we can't add a compressed offset or length to a physical position and
> get a number that isn't garbage, so we can't fill in distinct values
> for physical location of compressed data blocks that make numerical sense.
>
> Try 'btrfs-search-metadata file' (from the python-btrfs package) for
> an accurate description of what's going on with the extent references.
> It uses TREE_SEARCH_V2 and the underlying btrfs file extent reference
> structure, which has the fields that FIEMAP is missing.
>
> Underneath, the compressed extent is an immutable contiguous region of
> storage, identified by the bytenr (virtual address) of the first byte
> of the storage.  Each reference to the extent in the file refers to a
> contiguous range of the extent's logical blocks (after decompression).
> The fields are, in no particular order:
>
>         1. the logical offset within the file (seek offset) where
>         the referenced data appears in the file
>
>         2. the extent bytenr (extent identifier for reference counting
>         and backref search, first physical byte of the extent)
>
>         3. the logical length of the referenced data (the portion
>         of the compressed data referenced at this offset in the file)
>
>         4. the logical offset within the extent where the referenced
>         data begins (after decompressing the extent, where to start
>         reading the data in memory)
>
>         5. the physical (compressed) length of the complete extent data
>         (how many bytes are used in physical storage)
>
>         6. the logical (decompressed) length of the complete extent data
>         (how much RAM is required to decompress the extent)
>
> Only the first three of these fields are available via FIEMAP.  FIEMAP
> provides only one length field, so it can't handle compressed extents
> which have two distinct lengths.  FIEMAP provides only one integer for
> physical position, so it can't handle references to blocks that are
> not the first block in a compressed extent.
>
> TREE_SEARCH_V2 provides all six fields, so you can get accurate logical or
> physical extent boundary information as needed.
>
> In simple write() cases, the offset fields are zero, so FIEMAP appears to
> work at first:
>
>         1. seek offset is some number, FIEMAP returns that number
>
>         2. extent bytenr is the FIEMAP physical start of extent
>
>         3. logical length of the referenced data (#3) is the same as
>         the logical decompressed length (#6).  FIEMAP gives #3.
>         This value will change if the extent is partially overwritten
>         in the file.
>
>         4. logical offset within the extent is 0, since the extent
>         was created for exactly this file data reference
>
>         5. physical length of the compressed extent isn't reported in
>         FIEMAP.  Tools like 'filefrag -v' which try to compute extent
>         boundary adjacency won't work--they will use the length in #3
>         when they should use field #2 + #5 to compute physical extent
>         end boundaries.
>
>         6. logical length of the compressed extent is the same as #3.
>         This value never changes until the extent is destroyed.
>
> In the test case, FIEMAP reports the same number at #2 for all extents
> since the same physical extent is referenced, but the referenced data
> location is actually a function of fields #2 and #4.  The second and
> third extents have non-zero offsets for #4, and the length at #3 becomes
> different from the length at #6, making any computed values based on
> these fields nonsense.

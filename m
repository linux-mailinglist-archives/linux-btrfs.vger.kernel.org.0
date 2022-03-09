Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB274D3ACA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 21:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiCIUFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 15:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiCIUFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 15:05:50 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146024088
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 12:04:50 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o8so2867285pgf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IjiHtFjAn+NpNl4gqTwvUtZxMtZBYf4KHQi45FfKL5k=;
        b=H0vg9/4Ixmq7HK8uUx7LjnPlg58a7glqYw22HIf7NqaKYHeqhmM7iA2xFbr4w8u4/j
         zJq9Q3bXSxsuWBRJ0Q++LmgaNJNU6VJ8FaUeizQ0QcSphcWUc6Y8LCd8Ilh6DCW5ENuc
         aLARWNIrNE4J+gBkpuhpa7zJeb4THOwDsEs44a4/67aNMFrRbw7L2/RCtao6Txn3X4mb
         1wZMKeXBHoOOLbtFeoJdi20q6PJ7MuRir17T+EQAQM+iZly+Ow14yWB8atqVDsYZmVtT
         qwuUrPghSXM5gF+/5hpZSBryfS1cs39GJLLgtPGCzf4qdYot5ZQA/PHcZeeFO7WXzPh8
         aPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IjiHtFjAn+NpNl4gqTwvUtZxMtZBYf4KHQi45FfKL5k=;
        b=bVr5zioH56kF3GtAtnl4V85gwxKeASELsn0g1wi1SOlPSLWr8fQ3oYohcTa07Mz+bv
         xfUBwVn3WRXZS4VkkYaEeICC8CNhDpgzaO7l76xDnM0UezoNeBXlwQuf2XoOnFbo49ed
         WoCRxnyCw5djV5fKChF0K8QRQh4VznGjYLReBopAkWTEHPm0/bplLIsMJ75Ote3RPd4z
         DgEO+SGODfVOYDS3I/Ca3s+9ugC9mwLEWPlIh/+5veGsw0pjOkcLvOyXPAMcHerf9aMw
         P/Qdr5QC0ytLpbFn/DVnDPOTtcutDuWckGZY7ZxIYOHiq7YLoLPf3XIFMvBwlUjZJnxA
         9UMQ==
X-Gm-Message-State: AOAM5313wwjsiT0NsxoEx0zIwVXXnONJNSb1eK0xXyG1ZGiU7CIfzRDP
        mZsdrcyxRU6yscLuufXs/zNS92ti+0XiyAWZ1AdTFcuL9gc=
X-Google-Smtp-Source: ABdhPJwZclGqmxdAqgaAPEfAPpNvIbfYuuNnxaNLCrHKfutS+ZYJ2kIauf3l/OR6QH+aRhRA+SYQSaUEG2nJUDoPJAA=
X-Received: by 2002:a65:6e09:0:b0:380:4723:b4e9 with SMTP id
 bd9-20020a656e09000000b003804723b4e9mr1183975pgb.346.1646856290066; Wed, 09
 Mar 2022 12:04:50 -0800 (PST)
MIME-Version: 1.0
References: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
 <YhMzKeX3FvJPvtmR@hungrycats.org> <CADwZqEts39gdoLKCN2t18UByo_WnLmoRPCbja61wVwSt3wvuhQ@mail.gmail.com>
 <YiQ8HgWVNAnBFjVj@hungrycats.org>
In-Reply-To: <YiQ8HgWVNAnBFjVj@hungrycats.org>
From:   ov2k <ov2k.github@gmail.com>
Date:   Wed, 9 Mar 2022 15:04:40 -0500
Message-ID: <CADwZqEs8PHvmGAg4=+qwiQgrY1gFksoNkLZi3rne7uTFzZhoeA@mail.gmail.com>
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

On Sat, Mar 5, 2022 at 11:44 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Mon, Feb 21, 2022 at 05:31:13PM -0500, ov2k wrote:
> > It looks like btrfs coalesces adjacent uncompressed extents.  I'm not
> > sure whether this is done by FIDEDUPERANGE or FS_IOC_FIEMAP.  I think
> > the problem is that adjacent decompressed ranges (defined by #3 and
> > #4) within the same compressed block are not coalesced in a similar
> > manner.  Is there a particular reason why this isn't done, or is this
> > simply a case of nobody having done it?
>
> It hasn't been done because FIEMAP can't produce results for compressed
> extents that aren't nonsense.  The interface can't cope with compressed
> data.
>

I think there's a misunderstanding here.  The issue isn't making FS_IOC_FIEMAP
represent compressed data sensibly.  The goal is for btrfs_fiemap() to handle
adjacent subranges of a compressed extent in much the same way as it handles
adjacent uncompressed extents.  The result should be no more or less
nonsensical than it already is.

> Adjacent compressed extents occur when all of the following are true:
>
>         first extent #3 (decompressed start offset) + #4 (decompressed
>         logical length) == #6 (end of decompressed extent)
>
>         second extent #3 (decompressed start offset) = 0 (beginning
>         of decompressed extent)
>
>         first extent #2 (physical start offset) + #5 (physical compressed
>         length) == second extent #2 (physical start offset)
>
> FIEMAP doesn't have access to #5, so it can't evaluate that condition
> (and neither can anything that uses FIEMAP).
>

This is incorrect.  btrfs_fiemap() has access to #5.  I believe that's the
num_bytes member of struct btrfs_file_extent_item.  Extent merging is handled
by emit_fiemap_extent().  However, it looks like a lot of the information
needed to merge adjacent subranges of a compressed extent is discarded before
emit_fiemap_extent() is called.

> Suppose you have two adjacent extents, 128K and 96K that are compressed
> to 64K and 48K respectively.  They start at physical block 10000 at
> offset 0 in the file.  Then:
>
>         Extent 1 starts at physical 10000 and ends at 10063.
>         Extent 1 starts at logical offset 0 and ends at 127.
>
>         Extent 2 starts at physical 10064 and ends at 10111.
>         Extent 2 starts at logical offset 128 and ends at 223.
>
> FIEMAP reports:
>
>         extent 1 physical 10000 offset 0 length 128
>         extent 2 physical 10064 offset 128 length 48
>
> How would you be able to determine from this information that these
> extents are physically adjacent and contiguous?
>
> Lets add extent 3 and 4:
>
>         Extent 3 starts at physical 10112 and ends at 10127.
>         Extent 3 starts at logical offset 224 and ends at 239.
>
>         Extent 4 starts at physical 10128 and ends at 10127.
>         Extent 4 starts at logical offset 240 and ends at 255.
>
> FIEMAP reports:
>
>         extent 1 physical 10000 offset 0 length 128
>         extent 2 physical 10064 offset 128 length 48
>         extent 3 physical 10112 offset 224 length 16
>         extent 4 physical 10128 offset 240 length 16
>
> How would you be able to determine extents 1 and 4 are _not_ physically
> adjacent?
>

I'm talking about emitting a single struct fiemap_extent that corresponds to
two adjacent subranges of the same compressed btrfs extent.  The two btrfs
extents would simply have to satisfy:

        extent 1 #2 (bytenr) == extent2 #2 (bytenr)

        extent 1 #1 (seek offset) + extent 1 #3 (decompressed subrange length)
        == extent 2 #1 (seek offset)

        extent 1 #4 (decompressed subrange offset) + extent 1 #3 (decompressed
        subrange length) == extent 2 #4 (decompressed subrange offset)

The resulting struct fiemap_extent would have:

        fe_logical: extent 1 #1 (seek offset)

        fe_physical: extent 1 #2 (bytenr)

        fe_length: extent 1 #3 (decompressed subrange length) + extent 2 #3
        (decompressed subrange length)

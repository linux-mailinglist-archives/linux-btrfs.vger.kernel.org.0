Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D4520265
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiEIQbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiEIQa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 12:30:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C62216071
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 09:27:03 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r27so15917874iot.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTJS7m5AZeaOxYv6BZgCn9EBlizN/0Vt6KXSUZzbpyc=;
        b=fzIo2hfW21wWcy6tWUJ01+bnei/lEbjJpKasC8SRE1eYL3HTSxHZGV6j1SlxPMjXvy
         8pzXNWULgJMquxAprBL3leMdKpcD8aC9W36S9jF+EGU1Xv+b0AsnT61Ki//byc6zw4ge
         vja5V1RQy9SG/92/3aMc5iDd+T8H9rwMj/yBtEnZ4JXUk+EFYusczHz1OF/wOSO4T3fV
         vh8He11iZ8UYBfMBe4Bkh2BGkyVj2HXZ6vmKTlBhgH6fmAplb8JcIUwG7tryUUTYTxov
         1Ek4CZ5upaVeQWkXogjPrJus0ihQo4idT0fCOZkKqhtfo3RBl/Pf8W8ZZKU8YlTpcAL3
         YUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTJS7m5AZeaOxYv6BZgCn9EBlizN/0Vt6KXSUZzbpyc=;
        b=ia1DcNgXsDmZn/JVb9kLkxfxximwUfpob6Bm1xGvFZfoRikzJe2hoc7ENoOfk5nl/X
         Eg3tSU66NgJYZypqz5LhtJZXVOyVKUVFjxYEO2GEd8BxZ1GpLe8UuENAdSEsgKIP6oh0
         Ln0zRCdILsIoK+9JiqBR38Mh86vMvPdmqb0UDy8ffXy0jLSoxG21Tf8PGx2pO1cvu9KY
         WEupUCFiw4ynG9wUXmod0NYGRjFSOymZxNQSHWiemT2ex8QYenKOM8FHCel5KGH5vQZE
         WfdojHOFkqKnaYeOp2zQKpUWCQifwjVZboXpuXf6drBcaoFBg/zUwE8bCC1x77KyzM4K
         /mUQ==
X-Gm-Message-State: AOAM530G/QOkIgYggrMAFpgcOQcKvbgglrN2/zw2zaO3i01YVi0id2PT
        ypeeo3CUE0URFYgNF9/3cziW1iq2JbDad7KX8qpunD/D
X-Google-Smtp-Source: ABdhPJxjhKDSASarIAEypx7H18pTcoitCw2xYOP8qYHt4vklM+LfDxOb2WdGqKDT4ZEljNIBBs7jqmBlRvncXreKOCg=
X-Received: by 2002:a05:6638:15c9:b0:32d:b26d:a01e with SMTP id
 i9-20020a05663815c900b0032db26da01emr1671170jat.11.1652113622523; Mon, 09 May
 2022 09:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd7XocnyH8d_U8A0Mjy9+fk=DOTyiHzTR9FX+QSFevMtHGs=Q@mail.gmail.com>
In-Reply-To: <CAFd7XocnyH8d_U8A0Mjy9+fk=DOTyiHzTR9FX+QSFevMtHGs=Q@mail.gmail.com>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Mon, 9 May 2022 11:26:52 -0500
Message-ID: <CA+H1V9xQc0mxHkDXZTYMXEQtfJg7--CSs2k-RPQe92=+b09tBA@mail.gmail.com>
Subject: Re: How important is a full balance?
To:     Alexander Zapatka <alexzapatka@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's good enough. As long as the metadata and data are more or less
evenly distributed you aren't going to gain anything from letting the
balance finish.

Matthew Warren

On Mon, May 9, 2022 at 4:45 AM Alexander Zapatka <alexzapatka@gmail.com> wrote:
>
> How important is completing a full balance after adding a device?  I
> had a 16tb single array.  I then added a 4tb harddrive and started a
> full balance.  It's been running for several days and I still have 81%
> to go.  Despite that, if I look at the usage statistics the drive has
> balanced out the free space among the 5 physical drives.  dmesg still
> shows chunks being moved... is it worth completing the balance even if
> it takes several weeks?  or is it "good enough" because the files are
> distributed?

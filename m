Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD84D8F1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiCNVzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiCNVzf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 17:55:35 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F13A5ED
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 14:54:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w2so10864303oie.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=8J2KqqzaNNqQjhFwCeLS/exVEq+mmxX5Pknvq9APbUM=;
        b=fFKyYIRYIDUN3+JR/ozZfwJKOUuDLKI8mVu4XAEzYATdbRhEmcudyybQ2cEVPKZHzN
         A17ES99Wdpjm3x6oLMs8WV0hmiiA5UK7Jrwmj1ZudGUml6MWpJBer5YJGuHQWY2VTb5x
         Evd6kr3ox0ZIzdhIO3QA02uM2G6Hw5kiwYCeYzlvjYak1m/+ljGMj9rEzVJXUcYGYqhG
         TwoGxWcqGaK8+OLzJo9lRs7TVr6LWxYsbc3jnz5X2AcfYTI7gR9RcL/F5A/4COOpKL4x
         NkRXB4fo02yHs7ItwApd4/tDE87d6QjKq+Lu70xurtOYpGDyRcwS/jD2cTNCrMTPCZlr
         0rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=8J2KqqzaNNqQjhFwCeLS/exVEq+mmxX5Pknvq9APbUM=;
        b=rKUWpCP+EjYjI2fg+7nICu1IQ5eBfli4ZUb0koaVSaOn8jX8Y1UhCWkoPq4mwpCpVc
         NTjIpV8DEwIFheiu9CxhhIL+L8ptpLnAa6eSsfV1ub2bvomaFjn6JbRH2Ogwm+/RAm2s
         aoQ/v4OK+GlkW/S0ElwN0rxjhqIS0IIDBqn770hihsD2X8NkDd7n+il6pMiC9tI0TDRW
         xewEFax6QRRw0QytAtZGfNbhSw8Yp8yWhwVo4h5jeX2u8+7GsBXdFinT692w7ATo7M/n
         bhgF29I88YOYG3dIWvZvhRuXm55PHKR/1DJcyoflHiep+ct/azfVTY+yK36L5WoAzzsS
         v8QQ==
X-Gm-Message-State: AOAM5312U48WA/xvfPoRpv3KIs+Ne+ZieMirmKSoCCU7seQ6xuOro6aN
        YlETEmp/xp4thKmKOeA9HhS5B80S+UxrOU03vVSW120wFak=
X-Google-Smtp-Source: ABdhPJz7GlSx8o4rzYT5QncdrSGOVKYvuZyrgmgniXGlKeyWaWiSPeXD3LWxxBExz3iQTFh46RvjustF7B5ovYsZHC4=
X-Received: by 2002:a05:6808:2117:b0:2da:5906:22c3 with SMTP id
 r23-20020a056808211700b002da590622c3mr585245oiw.80.1647294864223; Mon, 14 Mar
 2022 14:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net> <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net> <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
In-Reply-To: <87ee34cnaq.fsf@vps.thesusis.net>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Mon, 14 Mar 2022 22:53:48 +0100
Message-ID: <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Cc:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000390b0905da34b9f7"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000390b0905da34b9f7
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 14, 2022 at 9:05 PM Phillip Susi <phill@thesusis.net> wrote:
> Jan Ziak <0xe2.0x9a.0x9b@gmail.com> writes:
>
> > The actual disk usage of a file in a copy-on-write filesystem can be
> > much larger than sb.st_size obtained via fstat(fd, &sb) if, for
> > example, a program performs many (millions) single-byte file changes
> > using write(fd, buf, 1) to distinct/random offsets in the file.
>
> How?  I mean if you write to part of the file a new block is written
> somewhere else but the original one is then freed, so the overall size
> should not change.  Just because all of the blocks of the file are not
> contiguous does not mean that the file has more of them, and making them
> contiguous does not reduce the number of them.
>

It is true that it is possible to design a copy-on-write filesystem,
albeit it may have additional costs, that will never waste a single
extent even in the case of high-fragmentation files. But, btrfs isn't
such a filesystem.

The manpage of /usr/bin/compsize contains the following diagram (use a
fixed font when viewing):

                +-------+-------+---------------+
       extent A | used  | waste | used          |
                +-------+-------+---------------+
       extent B         | used  |
                        +-------+

However, what the manpage doesn't mention is that, in the case of
btrfs, the above diagram applies not only to compressed extents but to
other types of extents as well.

You can examine this yourself if you compile compsize-1.5 using "make
debug" on your machine and use the Bash script that is attached to
this email.

The Bash script creates one 10 MiB file. This file has 1 extent of
size 10 MiB (assuming the btrfs filesystem has enough non-fragmented
free space to create a continuous extent of size 10 MiB). Then the
script writes random 4K blocks at random 4K offsets in the file.
Examination of compsize's debug output shows that the whole 10 MiB
extent is still stored on the storage device, despite the fact that
many of the 4K pages comprising the 10 MiB extent have been
overwritten and the file has been synced to the storage device:

....
regular: ram_bytes=10485760 compression=0 disk_num_bytes=10485760
....

In this test case, "Disk Usage" is 60% higher than the file's size:

$ compsize data
Processed 1 file, 612 regular extents (1221 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       16M          16M          10M

-Jan

--000000000000390b0905da34b9f7
Content-Type: application/x-shellscript; name="btrfs-waste.sh"
Content-Disposition: attachment; filename="btrfs-waste.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l0r8si300>
X-Attachment-Id: f_l0r8si300

IyEvYmluL2Jhc2gKc2V0IC1lClsgLWUgZGF0YSBdICYmIHsgZWNobyAiZXJyb3I6IGZpbGUgZXhp
c3RzOiBkYXRhIjsgZXhpdCAxOyB9CgpkZCBpZj0vZGV2L3VyYW5kb20gb2Y9ZGF0YSBicz0xTSBj
b3VudD0xMCBzdGF0dXM9bm9uZQpzeW5jIC0tZmlsZS1zeXN0ZW0gLgp4ZnNfaW8gLWMgImZpZW1h
cCAtdiAwZyAxMDBnIiBkYXRhIHwmIHRlZSBleHRlbnRzMQpzdWRvIGNvbXBzaXplIGRhdGEKCmZv
cigoaT0wO2k8MjU2MDtpKyspKTsgZG8KCWRkIGlmPS9kZXYvdXJhbmRvbSBvZj1kYXRhIGJzPTRL
IGNvdW50PTEgc2Vlaz0kW1JBTkRPTSUyNTYwXSBjb252PW5vdHJ1bmMgc3RhdHVzPW5vbmUKZG9u
ZQpzeW5jIC0tZmlsZS1zeXN0ZW0gLgp4ZnNfaW8gLWMgImZpZW1hcCAtdiAwZyAxMDBnIiBkYXRh
IHwmIHRlZSBleHRlbnRzMi1maWVtYXAKc3VkbyBjb21wc2l6ZS0xLjUvY29tcHNpemUgZGF0YSAy
PiBleHRlbnRzMi1jb21wc2l6ZQoKYnRyZnMgZmlsZXN5c3RlbSBkZWZyYWdtZW50IGRhdGEKc3lu
YyAtLWZpbGUtc3lzdGVtIC4KY29tcHNpemUgZGF0YQoKcm0gLWYgZGF0YQo=
--000000000000390b0905da34b9f7--

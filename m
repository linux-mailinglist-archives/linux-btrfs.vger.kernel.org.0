Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65059635CF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 13:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiKWMdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 07:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiKWMda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 07:33:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8715F84D
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 04:33:28 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i131so20679705ybc.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/S7VraB00zpPswsGctYJEUpzjNJGf6rpgAbktHVYfk=;
        b=B9Sjxs0wg8XUocyEEuxN2H7mK7587dPZt6/ELzsNI6UvEwG3Fn4ZHH/kn0b3YT5omD
         RaBybnNRlzCUyV2mDFC2IDolX0AlUUpsg1SZeyt6STb+ckNzCst0C5l6IW4v8p0X6y9r
         O6FJcO4t3jgbfGXqfgp2XtI7Q4Cmv8FoBGncNdj/6i9ZLLdBxUzPBweJMbUFM4J8Nhms
         zoCZzG+LfCCfEVmCZBSJQIo8y8VTLc2D0fU8Fp+GGfdG8NaFi6vFaMmUyrm8r2mymjC4
         hr/dQEI2hgP/oA6je+jrfbJS/Vtsrod5Baf1/KtyJ8BRK91JHGrcVB+XCHoWjGfpjpHB
         +r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/S7VraB00zpPswsGctYJEUpzjNJGf6rpgAbktHVYfk=;
        b=j44+ldH252da4rJtIh5Nqkj2WLWkkg4qEZIOOGldPs9RVbQH2kGp4nfBu5yK9uo3pi
         9Wd1sKHUKzq7fmcsu/DPgOEIbPfSZ2wAWMUp1pGyv45LyrLQuITLt+GH7GK1VolW7O3U
         LLlVSPs7hpNQU36BfadBuPFZKbR/w7qlJYWre9Y/qhplvNrpM0OpRgok2+c+o1/8ohD6
         hLvsmSboNXfYhFI7KQWnJdL4C8Sbh+MLC26M0IXqYYKG5g4wW3eNQ06RabVHFnKJWEqj
         qmvTIUNSAc6tbMSoJF4mP+hBU5bCGjB1TdIxL9WSX7Mf4dKj+MEW2gUZ7WN5NPN5fUSl
         wcCA==
X-Gm-Message-State: ANoB5pliF6pTc1qERahtqo5GhErElWprzljCpZUrQsZCqBDhLTk358hw
        vvXOQQBz0ENClNZQ0nm4I8JjJgMvGK5A2gyz9uyt33lXCNqHjw==
X-Google-Smtp-Source: AA0mqf5I4aCgtwwixWWSSvnSnoOsca/JU3a1OHt187HjnYtZ8T4f8rX+CoqkAgxdOzjzy3nbn+CeSymtk6HjPq8dylU=
X-Received: by 2002:a25:918a:0:b0:6ca:ecb9:970a with SMTP id
 w10-20020a25918a000000b006caecb9970amr7828442ybl.209.1669206807972; Wed, 23
 Nov 2022 04:33:27 -0800 (PST)
MIME-Version: 1.0
From:   Joakim <ahoj79@gmail.com>
Date:   Wed, 23 Nov 2022 13:33:17 +0100
Message-ID: <CAFka4xNPJby02JcK+immNU+AL6w-=iH7tNB4ZjULoYxnwG7U+Q@mail.gmail.com>
Subject: Speed up mount time?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a couple of machines (A and B) set up where each machine has a
~430 TB BTRFS subvolume, same data on both. Mounting these volumes
with the following flags: noatime,compress=lzo,space_cache=v2

Initially mount times were quite long, about 10 minutes. But after i
did run a defrag with -c option on machine B the mount time increased
to over 30 minutes. This volume has a little over 100 TB stored.

How come the mount time increased by this?

And is there any way to decrease the mount times? 10 minutes is long
but acceptable, while 30 minutes is way too long.

Advice would be highly appreciated. :)



Linux sm07b 5.4.17-2136.311.6.1.el8uek.x86_64 #2 SMP Thu Sep 22
19:29:28 PDT 2022 x86_64 x86_64 x86_64 GNU/Linux
btrfs-progs v5.15.1
Label: 'Storage'  uuid: 6ecd172e-3ebd-478c-9515-68162a41590d
        Total devices 1 FS bytes used 105.04TiB
        devid    1 size 436.57TiB used 107.87TiB path /dev/sdb

Data, single: total=107.34TiB, used=104.82TiB
System, DUP: total=40.00MiB, used=11.23MiB
Metadata, DUP: total=269.00GiB, used=221.57GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

[   51.764445] BTRFS info (device sdb): flagging fs with big metadata feature
[   51.764450] BTRFS info (device sdb): use lzo compression, level 0
[   51.764454] BTRFS info (device sdb): using free space tree
[   51.764455] BTRFS info (device sdb): has skinny extents

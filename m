Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3637476707E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjG1P0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbjG1P0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:26:22 -0400
X-Greylist: delayed 5223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 08:26:20 PDT
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3635E73
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:26:20 -0700 (PDT)
Received: from cc-smtpin3.netcologne.de (cc-smtpin3.netcologne.de [89.1.8.203])
        by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 82615125FB
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 17:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=netcologne.de;
        s=nc1116a; t=1690557978;
        bh=U6eMhIR+8FfYVg/WOmhNct/aAYowTMDEBxR8n/agon4=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:From;
        b=TFJYub+u4ytxOfYQgSEAa5z0BIAMCJjwj705AxFiA45tW9kXy6KfK52O/GwqaJzqL
         hh16bdBhzo4iFfk5T9bzlbQniU2L9ZSDPop91D4VeQR7vKnQ9iQJmyHQzijTLwhvKJ
         6C29aLDgXTGo0E/1/6n1RzGk2RVxnr3jyEssyqQjXH3KDhbEMMngu7XJFqXwidTPK2
         OdA4jyDJa43lFjueT7lpZPl11icvwQoGJVpSbuwf/hwHDvBBUZQ4FbneMFKPzjk9lY
         2EtBk4lrJRtANJzfihBP9Dcs4hFwHBarEsP4r3tb6ET8W5GTpxIwmXe3bH7KkmqOZL
         QgrIky5VhVcNQ==
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by cc-smtpin3.netcologne.de (Postfix) with ESMTPSA id 6745511E22
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 17:26:18 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-26809f86bd5so1301272a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:26:18 -0700 (PDT)
X-Gm-Message-State: ABy/qLa4X5OaLFTFg7l/ysRdYebLVjXS+q/KgYVGId2iMkFi0D4grOnd
        GWLeUs6BN3us4W6w9RmR1z4eF52su6AdfxG6CS4=
X-Google-Smtp-Source: APBJJlGEVZQEcXHn0LZ3aP1Mk/jKiqqlPATZY9At8K10a0pOaAmtrktopdQPFiOwtk4BhTRaJ6Nyt0/DOytjOxtZJbM=
X-Received: by 2002:a17:90a:6c04:b0:268:7dde:d90d with SMTP id
 x4-20020a17090a6c0400b002687dded90dmr1588507pjj.11.1690557976779; Fri, 28 Jul
 2023 08:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAA3ktqkR_hk++GpHM1oLUVto139oUOMLH92GPepQMA4M7-wdYQ@mail.gmail.com>
 <ec55663e-7655-a201-fc2c-6d64193e9fc7@gmail.com>
In-Reply-To: <ec55663e-7655-a201-fc2c-6d64193e9fc7@gmail.com>
From:   Stefan Malte Schumacher <s.schumacher@netcologne.de>
Date:   Fri, 28 Jul 2023 17:26:05 +0200
X-Gmail-Original-Message-ID: <CAA3ktqmUXi3phYodmV7q8HQ4XvDvWo8q59z0UbR5TkQWcf5a=w@mail.gmail.com>
Message-ID: <CAA3ktqmUXi3phYodmV7q8HQ4XvDvWo8q59z0UbR5TkQWcf5a=w@mail.gmail.com>
Subject: Re: Drives failures in irregular RAID1-Pool
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: 6745511E22
X-Rspamd-Action: no action
X-Spamd-Bar: ----
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the quick reply. Is there any way for me to validate if the
filesystem has redundant copies of all my files on different drives?
I read that it was suggested to do a full rebalance when adding a
drive to a RAID5 array. Should I do the same when adding a new disk to
my array?

Yours sincerely
Stefan

Am Fr., 28. Juli 2023 um 17:22 Uhr schrieb Andrei Borzenkov
<arvidjaar@gmail.com>:
>
> On 28.07.2023 16:59, Stefan Malte Schumacher wrote:
> > Hello,
> >
> > I recently read something about raidz and truenas, which led to me
> > realizing that despite using it for years as my main file storage I
> > couldn't answer the same question regarding btrfs. Here it comes:
> >
> > I have a pool of harddisks of different sizes using RAID1 for Data and
> > Metadata. Can the largest drive fail without causing any data loss? I
> > always assumed that the data would be distributed in a way that would
> > prevent data loss regardless of the drive size, but now I realize I
> > have never experienced this before and should prepare for this
> > scenario.
> >
>
> RAID1 should store each data copy on a different drive, which means all
> data on a failed disk must have another copy on some other disk.
>
> > Total devices 6 FS bytes used 27.72TiB
> > devid    7 size 9.10TiB used 6.89TiB path /dev/sdb
> > devid    8 size 16.37TiB used 14.15TiB path /dev/sdf
> > devid    9 size 9.10TiB used 6.90TiB path /dev/sda
> > devid   10 size 12.73TiB used 10.53TiB path /dev/sdd
> > devid   11 size 12.73TiB used 10.54TiB path /dev/sde
> > devid   12 size 9.10TiB used 6.90TiB path /dev/sdc
> >
> > Yours sincerely
> > Stefan Schumacher
>

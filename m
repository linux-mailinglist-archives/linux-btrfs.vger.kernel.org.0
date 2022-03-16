Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49F74DB7DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiCPSUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiCPSUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 14:20:09 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0129732ED1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:18:53 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso3632246oop.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rn6EjoyIwJbn9LJMTbSeddzrqPjKqRSTQkLhJCblMDE=;
        b=HRehzdNE1n7ep/Mvr2NmrJe4GRDIHz0kV2DGSxUAj8R8K3To+hpX8NQSwA48o1GhDs
         AjRjPSm29Dvgv5klWbUXS/tZAddDqSEKFenu+652PTwg2HRMTEmJem4Hu/V+z50LnuDK
         xeYiiIitaR+mc1KneMz67mQtPIQTnseXMVLJVDi7b/E9Et6XICBV6Dblls88aKLK6L+Z
         eKw2Pklcuid9LAmBTwW3nfqzfgeUHcsI9bXCsyjJS1hrZeboWvAqYQq+KEAmWWi7zpqt
         lSPx++Ao0R6+VcSNsR+CXXe42EvBah3c68MCFyylMHIMEbS67XggorH9rWntccjJB38m
         BqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rn6EjoyIwJbn9LJMTbSeddzrqPjKqRSTQkLhJCblMDE=;
        b=FxD42Wu2qsB4XkebHXnK2XeF6X8HKcgehyV4kg9/dCMrM1HnGknPgyFQC1Kk06nOuN
         kCQlvk4ibGRJjVl0me9RH4LdqDv8GubEEH4n4e0+CXOMgTHZZcPHrdCJsFUd8ZRV5vPe
         aq8PhA+/BrsMg23nQ6VWxGPax+0HhPUs6qZ4aF2H+olT+xbKYMnHRdISKwjFUEvJ5L3a
         5mBa62qEv5v0rk9BjJ60CBCK6D4vKDtOjPixEmyR/Acf6mH1hQkj+oaJ6MXNlvi/127o
         audue3+EpEB/G2QPrU/cwBceiq6MjTR33bcirsI6vFoa9MwQvYmiDA/gIGWFZ4yRwhbF
         g2Jg==
X-Gm-Message-State: AOAM53395RRr/znQbR3Nh0NBrpZl1zWzC/pDUhwmxIXOwIiCEWzhHbmE
        BDmrVajjaY43oG3766QOqE2DQQAAwiSKGHo8+xpvUcjW3A+wKQ==
X-Google-Smtp-Source: ABdhPJwcBvWUGwUnVWI505n2nwPv0+UbkFHiO9EA4YGPV8EGICqMESDehVTFWljo9SbdwZY/D5+ibqF7VjUVBKvtg5Y=
X-Received: by 2002:a05:6870:1613:b0:da:b3f:2b3c with SMTP id
 b19-20020a056870161300b000da0b3f2b3cmr4041033oae.219.1647454732275; Wed, 16
 Mar 2022 11:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <CAMthOuNR099Un3TvZMXVBaoBFChN9BWs7dxTzkgoQh90eYQRDg@mail.gmail.com>
In-Reply-To: <CAMthOuNR099Un3TvZMXVBaoBFChN9BWs7dxTzkgoQh90eYQRDg@mail.gmail.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 16 Mar 2022 19:18:16 +0100
Message-ID: <CAODFU0q-XLpu0mT2ULQd1p6L+HhOde=7JARuLdEAbj5wQ+ahMA@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 1:48 PM Kai Krakow <hurikhan77+btrfs@gmail.com> wro=
te:
> Am So., 6. M=C3=A4rz 2022 um 18:57 Uhr schrieb Jan Ziak <0xe2.0x9a.0x9b@g=
mail.com>:
> > Please try to avoid discussing no-CoW (chattr +C) in your response,
> > because it is beside the point. Thanks.
>
> Yeah, that's one solution. But you could also try disabling
> double-write by turning on WAL-mode in sqlite:

As far as I can tell, the app is using journal_mode=3Dwal for all
database connections using code such as:

c =3D await aiosqlite.connect(db_path)
await c.execute("pragma journal_mode=3Dwal")

There are sqlite-wal files in all database directories. Compression is
disabled. According to Bash history, I executed "btrfs filesystem
defragment -r" in the 41 GB sqlite directory about 2 days ago. The
current number of extents (after 2 days) is:

$ compsize file.sqlite
Processed 1 file, 1438640 regular extents (2593549 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       50G          50G          41G
none       100%       50G          50G          41G

-Jan

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F36DA5FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 00:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjDFWvu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 6 Apr 2023 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbjDFWvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 18:51:48 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708733596
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 15:51:47 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id qb20so4835400ejc.6
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821505; x=1683413505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/Yq+RogF4NLB0ytnE2c8qbIFYDpm8Av/BOMlLi7ICo=;
        b=HR1easvx/ITivfkovjsBFQo2jx/OXtZejaC9OLA9OIGecl+dDAEoPTh+SPu7ycK7LN
         5ONRaP/a/FUlNqKqpmjKVJn3vWZ9i0iJyXEDcXLjwdsQm4B9LyRHQQFvqejv4Zmpn71H
         6is+lXDCd1us2oEPphFIwjzuXqCZL6+XurLdNlDMZ/N0MbFtxT7noW7kVHybHUTLHXhn
         3wscL2pQFE7fRpepFSbsuknlualFCROCXmNWozpkk52suwh4xD9JF0pUzUmyAmzrH/H+
         esF966OCmIYJ9J/eP4pREgRM1eMRAjTrxxd9847/XcgRnm3p19CFfG4kzUZB/6SHLrYZ
         /R5A==
X-Gm-Message-State: AAQBX9fzdiJvzUJva7PlDeFaDg+dqpaFH31QwPgk3xNmfEE/+bp2BCUr
        agRRktdfvk7YGOgRPsSQ6JLat31gOxwKLcUW
X-Google-Smtp-Source: AKy350Z/+DKodeAPPN3CINvvHw9kLP+iO6W7/i8wc1eu4MNALQ7KTF3I7JJfS7AiMyjietzQefzhLQ==
X-Received: by 2002:a17:906:8477:b0:925:5549:f81c with SMTP id hx23-20020a170906847700b009255549f81cmr465318ejc.6.1680821505424;
        Thu, 06 Apr 2023 15:51:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ck24-20020a170906c45800b0093348be32cfsm1341714ejb.90.2023.04.06.15.51.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:51:44 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id qb20so4835256ejc.6
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:51:43 -0700 (PDT)
X-Received: by 2002:a17:907:7b81:b0:949:d4ef:f6ff with SMTP id
 ne1-20020a1709077b8100b00949d4eff6ffmr70090ejc.0.1680821503642; Thu, 06 Apr
 2023 15:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230322221714.2702819-1-neal@gompa.dev> <20230322221714.2702819-2-neal@gompa.dev>
 <ce66a6b0-01e2-990a-326a-9730083a436e@oracle.com>
In-Reply-To: <ce66a6b0-01e2-990a-326a-9730083a436e@oracle.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Thu, 6 Apr 2023 18:51:07 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9tccy8Xs=MzrfVRPiy667uv+BXoJVAPZLPvFELT_Vy6g@mail.gmail.com>
Message-ID: <CAEg-Je9tccy8Xs=MzrfVRPiy667uv+BXoJVAPZLPvFELT_Vy6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs-progs: mkfs: Enforce 4k sectorsize by default
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 1, 2023 at 1:31 AM Anand Jain <anand.jain@oracle.com> wrote:
>
>
> [ fixed table format ]
>
> Comparing btrfs sectorsize=64K with sectorsize=4K on an aarch64
> virtual host with PAGESIZE=64k shows that switching to sectorsize
> (ss) =4K by default for buffered IO has a low impact, while the
> direct IO performance is improved by roughly 21% to 152% for
> various fio block sizes as shown below.
>
>
> aarch64 PAGESIZE=64K
> ====================
>
> Buffered IO:
> ===========
>
> FIO bs  ss=64k ss=4k   diff
> K       MB/s   MB/s    %
> 4        752    755
> 8        783    832    +6
> 64      1066   1173    +10
> 128     1120   1098    +2
> 256     1112   1079    -3
>
>
> Dierct IO:
> =========
>
> FIO bs ss=64k  ss=4k  diff
> K      MB/s    MB/s   %
> 4       54      106   +96
> 8      107      270   +152
> 64     737      894   +21
> 128    862     1130   +31
> 256    846     1103   +30
>
>
> FIO config file:
>
> [global]
> directory=/mnt/scratch
> allrandrepeat=1
> readwrite=readwrite
> ioengine=io_uring
> iodepth=256
> end_fsync=1
> fallocate=none
> group_reporting
> gtod_reduce=1
> numjobs=8
> size=10G
> stonewall
>
> [fio-direct-4k]
> direct=1 <-- changed as appropriate
> bs=4k    <---changed as appropriate
>

Well, it's nice to see that there are performance advantages to using
4k block sizes everywhere. :)

Can we get this committed to btrfs-progs then?



--
真実はいつも一つ！/ Always, there's only one truth!

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55B16E7E21
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjDSPWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjDSPW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 11:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C583F2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681917587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tk4ILYUitykXDNv2nAhy0f5ydU+4a31pQqGhvmwhdPk=;
        b=MQyh0fUsEl95V78I8bk8Y1T6hmtsoiX3CxFKDjwvqrIlQ6To4e75tvKksorrlD/sDbgfDk
        nzucP2+xwPFzmt2xbz8yHdSMmMc8iWdpwPsaJ/v8xoPjLskQ2OVgDrhAfDniM8wNd1yG4/
        vHly6wGppWfgBBDmmORzbJ7nJ2hT5EE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-K62JROPnOqmHlEZKXmVWoA-1; Wed, 19 Apr 2023 11:19:45 -0400
X-MC-Unique: K62JROPnOqmHlEZKXmVWoA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2476a718feeso2035710a91.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 08:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917584; x=1684509584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tk4ILYUitykXDNv2nAhy0f5ydU+4a31pQqGhvmwhdPk=;
        b=Dvw13K/AwZRJUVkuk2SH2mOHRAPJ07IkwtDIE6IK0oa0KIJX7N3HmqM8rBKa3XEJvt
         aZmY2cPmezKybdk1ogOafj6xGNll73FNdzuUxaMfpnhTn0KRPsDsMrNiXdeXTQhs/Bbu
         lXJKese5vioFDJS2OpmL6D10AADuUJHEJFIQTPuwU1O/bW5ZdsKH6/EcRGnVaiCAm8ak
         yDHCIGJ9EVkkm/miCh0pyduvsphQtD2MvYW8q+HAL3l4UWkvhrJpGqgXiMRJAqpG0Fj8
         vYwVxDoqUh+Wy2iSTZ2o/blHuw1N9hoA29Dp1r8cDCFTinwp/RgEKtloXGj1NN40spqG
         G+3Q==
X-Gm-Message-State: AAQBX9dpzQIZGtQfHJFzejwDUwpM205xmGXhEaT6dD3bpgL3+k6mcLiI
        lo6FltFlm0DfFsYNoDLI17xkhiR3ggIZ/n9Z6Q9iKljH51zaZVIP74FxhEZRysTaO5GE/dlNNO0
        y0VrIqvw9pIzpLRvRVaqEG0fUfsnsz6UNnm4E5mg=
X-Received: by 2002:a17:90a:2ca4:b0:247:fec:3cf with SMTP id n33-20020a17090a2ca400b002470fec03cfmr1032469pjd.9.1681917584665;
        Wed, 19 Apr 2023 08:19:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZilzTP35l+fCVfSRmyAr7TA2z2HByJ2c77EoLXxjUVlBIE5WaJ/vbFqG27YJf1gGuB7p5La9B7yskBhiQ6yjg=
X-Received: by 2002:a17:90a:2ca4:b0:247:fec:3cf with SMTP id
 n33-20020a17090a2ca400b002470fec03cfmr1032449pjd.9.1681917584368; Wed, 19 Apr
 2023 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230419140929.5924-1-jth@kernel.org> <20230419140929.5924-12-jth@kernel.org>
In-Reply-To: <20230419140929.5924-12-jth@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 19 Apr 2023 17:19:31 +0200
Message-ID: <CAHc6FU6U1yZguZGeCc7BUqd1Qm4+SSRK8xbNZWBUSXTk_jjvVQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] gfs: use __bio_add_page for adding single page
 to bio
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 19, 2023 at 4:10=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> The GFS superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.

It's GFS2, not GFS, but otherwise this is obviously fine, thanks.

> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
>
> This brings us a step closer to marking bio_add_page() as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> ---
>  fs/gfs2/ops_fstype.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 6de901c3b89b..e0cd0d43b12f 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sect=
or_t sector, int silent)
>
>         bio =3D bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS=
);
>         bio->bi_iter.bi_sector =3D sector * (sb->s_blocksize >> 9);
> -       bio_add_page(bio, page, PAGE_SIZE, 0);
> +       __bio_add_page(bio, page, PAGE_SIZE, 0);
>
>         bio->bi_end_io =3D end_bio_io_page;
>         bio->bi_private =3D page;
> --
> 2.39.2
>


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48411725AD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjFGJl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbjFGJl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 05:41:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C801734
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 02:41:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so1122147a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686130883; x=1688722883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hFPeu/3BJQ1XAEBfX/WbvMEVzeUhOBPi58IZ/Esj6w=;
        b=DQ2W7u0kTQ72LzKcRWTgSG5Ic2en/sUZGdoBco91l0Mccvv0oAQBf/skoCqaEe9seE
         +dzp3Di1fk566WbDYFELqWJPFl5MunPBPZMeITsSShGZc7BDokFlIiDQLZFB4ZrSewGv
         3oX0GYhrvTDmISog+YzCJR1YtaZTCauUpfCjvwOk/JH+2E22rzqjqm0VAxXGE6uAZmC+
         EGD5OJ0fSz21kp9IqsqErfAtnLdYe5oeRENAmZus9bszHTyvCXJZvWktYhQnQZuZ89iJ
         k32HqmMpJwKqRO7v+RyJDkZmScyggr+L8hspyToZJsfDu3VkwGwgCJBAnl1PESLHhwEf
         au/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130883; x=1688722883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hFPeu/3BJQ1XAEBfX/WbvMEVzeUhOBPi58IZ/Esj6w=;
        b=eP75VmzF8NqR+eBVpQNd0XtotYYgDmdvEmiPQKfDFqdmj5m9jdUEvIMHCSuyw8k+yt
         3fhgU6IAAVsFE2QqBfP4s/0hHS5oFicF2gAFcS0oFM0YAYQlRWjZD+avZ2FN+yGSYNmN
         WQP3VBlcEnDXUA8KgIajyKIG1XjLA0t294LytJMzBrnRarZPZNS9a5zi38/LvO4ENny7
         f2QiwFtqvj1XqU4EhfKNkQy/S6iBz0/0kDYTR7ebBZ89j1uvUbfBdCmsrV0eqk6B/Ll3
         JcwnyFZ1Osovo5wJWgkE0VRhauw8uZmqXvwvWwlQeqXhKA8dm+sYeSMQ2ipWLUzD6TR7
         y93Q==
X-Gm-Message-State: AC+VfDzYMse+hPkmybuX77bQr4PyqoeOQiRcIDIfz+8cjIHBIgpVsW0U
        Su5ai+Ph8YycYGW0p/FxSgRA7Os2GO4LobstFA9Ykg==
X-Google-Smtp-Source: ACHHUZ78LLb5/9Eve9DZQqNC/TRa3vxkXV4pVMAtKfHjnQnscHPEcmWv/7uCCN4Q8kcsT8KuG+XDWcwCZO/ggZjCnJk=
X-Received: by 2002:a17:907:2d8c:b0:94e:e97b:c65 with SMTP id
 gt12-20020a1709072d8c00b0094ee97b0c65mr5404803ejc.60.1686130883637; Wed, 07
 Jun 2023 02:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-11-hch@lst.de>
In-Reply-To: <20230606073950.225178-11-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 7 Jun 2023 11:41:12 +0200
Message-ID: <CAMGffEkqXCkxpA+qqDVfx0echCPvNpWgK3hZWbb11F6cv2EQ-A@mail.gmail.com>
Subject: Re: [PATCH 10/31] block: remove the unused mode argument to ->release
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 6, 2023 at 9:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> The mode argument to the ->release block_device_operation is never used,
> so remove it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/drivers/ubd_kern.c          |  4 ++--
>  arch/xtensa/platforms/iss/simdisk.c |  2 +-
>  block/bdev.c                        | 14 +++++++-------
>  drivers/block/amiflop.c             |  2 +-
>  drivers/block/aoe/aoeblk.c          |  2 +-
>  drivers/block/ataflop.c             |  4 ++--
>  drivers/block/drbd/drbd_main.c      |  4 ++--
>  drivers/block/floppy.c              |  2 +-
>  drivers/block/loop.c                |  2 +-
>  drivers/block/nbd.c                 |  2 +-
>  drivers/block/pktcdvd.c             |  4 ++--
>  drivers/block/rbd.c                 |  2 +-
>  drivers/block/rnbd/rnbd-clt.c       |  2 +-
Acked-by: Jack Wang <jinpu.wang@ionos.com> # for rnbd

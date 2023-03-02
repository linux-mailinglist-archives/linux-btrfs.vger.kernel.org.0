Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C476A8999
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCBTjl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 14:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCBTje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 14:39:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45318B17
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 11:39:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a25so1699580edb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 11:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bYrczkeA0tAYWqVGdZ/Q+IMtaxX8jb/xxEyquc6+Xs=;
        b=pwHfDRe4OH27qSb9MtCV0Rj+bcGKYJrwWD4sIWzrwcWRnuIcZ8bVNVDOsJ/dX9awIL
         CCyPhejdKNB15NGma2M+BpjBUd0hNkp63gBPgZ+Z2qdNthfIPygJ0IuBucP3DpwuUJ1w
         cVRZORZM5NRPIJGqsL+C55wERzEkgNRAn0iZQGde+vi5Fnpxh7GoHvWYnyAgxT8AXXEX
         5ZCuL5a6aKT5NqqgPXjwz8bY7JdqtY+KqEBQqBkJjBM11eXYfzLo6irdIfuLNg50oy9d
         8scGrsaOMgYwY7LcEhhqXrwRM1gVm135+Cp4tJJJvGI3Xwc76M212vzfP/A26a/ssgY/
         lmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bYrczkeA0tAYWqVGdZ/Q+IMtaxX8jb/xxEyquc6+Xs=;
        b=I1h/33sUJCePGXU+VUxmSn6D51LmIdXtPAF5y1eT+JPc3NJgAlLux/Xgurok9lehJc
         mF/m00nvh1Sr/jvxwfoamAzd5rC3MurdHsrVcUHGCAVImBkC/m01DWONDEQhtnqNC1ny
         vx5yBuvpUgEqDAnBjHkgOTi63RlbogaTA0GxxA1P0lx7nW6lOzc7xq1eNex+NKqE2DHc
         tDAKH7WD6zc8fiP7xumjfTY2dIiqZtNshnsIDf6c6IsidvcGie9Z5nVd/F4hX+l4BKaN
         lgyMdlXFFKD206uSFxHZ91U25bOXrdh0aN3w1F8MUH7l1MPbigz7rWs6nGR4WsgZ/BQ7
         LIzQ==
X-Gm-Message-State: AO0yUKXW2YwWbtB/t49RPIOwlR3I7yDrMUeZNYX6xFiMKcEmb7chAl9F
        TzoWvrrbTjtwKjXRUy/Y8sFYpBB7J1PkF+TySvc=
X-Google-Smtp-Source: AK7set+TnLtUbJcy1RqacN/pJPbpuMzNR5+kNImve8IHzbj85bGVsAtccw09U7MCTZQN8N6jQR2epfL/TwAopm1eTls=
X-Received: by 2002:a50:c351:0:b0:4c2:ed2:1196 with SMTP id
 q17-20020a50c351000000b004c20ed21196mr1158519edb.5.1677785950683; Thu, 02 Mar
 2023 11:39:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 2 Mar 2023 14:38:34 -0500
Message-ID: <CAEg-Je_cswYA_6GNhxUMhsrZjt0fADZjt_zRGvUpRbLNANhzgw@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] btrfs: introduce RAID stripe tree
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 2, 2023 at 4:56=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Updates of the raid-stripe-tree are done at delayed-ref time to safe on
> bandwidth while for reading we do the stripe-tree lookup on bio mapping t=
ime,
> i.e. when the logical to physical translation happens for regular btrfs R=
AID
> as well.
>
> The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes an=
d
> it's contents are the respective physical device id and position.
>
> For an example 1M write (split into 126K segments due to zone-append)
> rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fs=
ync /mnt/test/test
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)
>
> The tree will look as follows:
>
> rapido2:/home/johannes/src/fstests# btrfs inspect-internal dump-tree -t r=
aid_stripe /dev/nullb0
> btrfs-progs v5.16.1
> raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> leaf 805847040 items 9 free space 15770 generation 9 owner RAID_STRIPE_TR=
EE
> leaf 805847040 flags 0x1(WRITTEN) backref revision 1
> checksum stored 1b22e1380000000000000000000000000000000000000000000000000=
0000000
> checksum calced 1b22e1380000000000000000000000000000000000000000000000000=
0000000
> fs uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
> chunk uuid 6f2d8aaa-d348-4bf2-9b5e-141a37ba4c77
>         item 0 key (939524096 RAID_STRIPE_KEY 126976) itemoff 16251 items=
ize 32
>                         stripe 0 devid 1 offset 939524096
>                         stripe 1 devid 2 offset 536870912
>         item 1 key (939651072 RAID_STRIPE_KEY 126976) itemoff 16219 items=
ize 32
>                         stripe 0 devid 1 offset 939651072
>                         stripe 1 devid 2 offset 536997888
>         item 2 key (939778048 RAID_STRIPE_KEY 126976) itemoff 16187 items=
ize 32
>                         stripe 0 devid 1 offset 939778048
>                         stripe 1 devid 2 offset 537124864
>         item 3 key (939905024 RAID_STRIPE_KEY 126976) itemoff 16155 items=
ize 32
>                         stripe 0 devid 1 offset 939905024
>                         stripe 1 devid 2 offset 537251840
>         item 4 key (940032000 RAID_STRIPE_KEY 126976) itemoff 16123 items=
ize 32
>                         stripe 0 devid 1 offset 940032000
>                         stripe 1 devid 2 offset 537378816
>         item 5 key (940158976 RAID_STRIPE_KEY 126976) itemoff 16091 items=
ize 32
>                         stripe 0 devid 1 offset 940158976
>                         stripe 1 devid 2 offset 537505792
>         item 6 key (940285952 RAID_STRIPE_KEY 126976) itemoff 16059 items=
ize 32
>                         stripe 0 devid 1 offset 940285952
>                         stripe 1 devid 2 offset 537632768
>         item 7 key (940412928 RAID_STRIPE_KEY 126976) itemoff 16027 items=
ize 32
>                         stripe 0 devid 1 offset 940412928
>                         stripe 1 devid 2 offset 537759744
>         item 8 key (940539904 RAID_STRIPE_KEY 32768) itemoff 15995 itemsi=
ze 32
>                         stripe 0 devid 1 offset 940539904
>                         stripe 1 devid 2 offset 537886720
> total bytes 26843545600
> bytes used 1245184
> uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
>
> A design document can be found here:
> https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit=
?usp=3Dsharing&ouid=3D103609947580185458266&rtpof=3Dtrue&sd=3Dtrue
>
> The user-space part of this series can be found here:
> https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thu=
mshirn@wdc.com
>

Apologies if this is a stupid question, but after reading through the
patch series and the design document, it sounds like the crux of this
change is switching how RAID works to be COW like everything else.
Does that also mean RAID 56 modes benefit from this in that manner?



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

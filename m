Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B946C6F026D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbjD0ITo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbjD0ITn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 04:19:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52213A9A
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 01:19:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-555d2810415so117868397b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682583580; x=1685175580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNtyGTyO3iJcRZccvb0hpkuNx8r0nTVJyO3M/slhY3I=;
        b=TdyCRm1sPjzi1LN09hdK1fXlTBsh5nbpl2OA4DpES6TrrG7Pwa+0cYyvkWgkmmizjD
         vGajf/C8A2A9CwuFLZNZLwVseceZAhYGWO7ZZCtgcbZaWpNipCSX+/x09avA7Kx6Ck7/
         YSmek3S/ZtUIch/kW34uYgiRHXOogzSGWDgKz48yOtoOhkLRvG9kNtJqHGkcyFtQWiEE
         SO29uhxj8+SeNvO2t1Ws51N+HY/PRTLANXA8yTLQPB4VDYk7jbIOVEaNP5LgAhyYUffO
         mB2LPiWw7I62W4+gB08TkA88B1QiP5rg7FQbapPBPVozKzTi5y4mE+ztYgypKzATLdG+
         PiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682583580; x=1685175580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNtyGTyO3iJcRZccvb0hpkuNx8r0nTVJyO3M/slhY3I=;
        b=CkFD4iOoPHgJIjT4yVMvVsMtvuUfn2uPHYBlVb2SJ9QqJGM9Fy3gyzR5geTo15SCtk
         uU0F3Lv7gsFYLXgqh0GQyZkW7LZNLJf8tKmznaUMA3ACly3jFz+A1Fpdt8udzx4KtRXE
         ioaH4++8gJ7D/sdc5xMPqJZicLnfXduxC8wBRfb8gOMXyjc8u5zrI44h6aGBvPHozwfc
         R8574u6vagZcXmcNKuvCjy+uao+Wa0xAoNrLxU0Rdby03jhes0PptrSaR51kphy3WSIi
         Qo8kLfL4CDqxn17Zb/WzCiO1m/Oj8um/fR3oum3iLCgRfjDVGeD9OIXsZn0S4yuCZuLr
         gJFA==
X-Gm-Message-State: AC+VfDyG2gbLI05fRr/TWKu9g5UiXGHe7f/GjjNa1PA0teM5uLbZ9PdL
        bSdEbEbzNIaMleo7CJJuPW1kzqo1HUlXVXGam2qUVNLws0Y=
X-Google-Smtp-Source: ACHHUZ7IOQm6T0Z23Ee0FijMIWb4qSJ/erEZifxL5W/L6w1OkHmsKC6WJSswVytRmwx3FEmn/tvU7fU9aT/OHsOaxUc=
X-Received: by 2002:a81:87c4:0:b0:556:e3eb:de38 with SMTP id
 x187-20020a8187c4000000b00556e3ebde38mr764588ywf.0.1682583579782; Thu, 27 Apr
 2023 01:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
 <89a6ede0-a043-ed11-016f-37f866f17e1c@suse.com>
In-Reply-To: <89a6ede0-a043-ed11-016f-37f866f17e1c@suse.com>
From:   Igor Raits <igor.raits@gmail.com>
Date:   Thu, 27 Apr 2023 10:19:28 +0200
Message-ID: <CAH2U3KrN4Dhm7QTxfCXA=P1B59kDduYcDH8wK7HRrwdAqb_x9Q@mail.gmail.com>
Subject: Re: Failed to recover log tree
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
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

Hello Qu,

On Thu, Apr 27, 2023 at 10:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/4/27 15:06, Igor Raits wrote:
> > Hello,
> >
> > We are using btrfs on some of our VMs and after some bug somewhere,
> > kernel has crashed and the VM had to be rebooted. After that, 1 out of
> > 4 drives was not able to mount.
> >
> > I've tried a few commands but that did not help to recover it (I did
> > not run btrfs check --repair yet).
> > The kernel is 6.1.18 and btrfs-progs 6.0.2 compiled with the
> > experimental flag (as we used that to use block-group-tree).
> >
> > Could you suggest some steps for recovery other than btrfs check
> > --repair to try out? Thanks in advance!
> >
> > # mount -t btrfs -o recovery,ro /dev/vdf /mnt/ebs/minio2
> >   kernel:BTRFS critical (device vdf): corrupt leaf: root=3D5
> > block=3D3562706763776 slot=3D17 ino=3D407482430, invalid nlink: has 2 e=
xpect
> > no more than 1 for dir
>
> This looks interesting, meaning a log replay leads to an extra reference
> on a directory, which is invalid.
>
> On the other hand, your btrfs check shows everything is fine, thus the
> directory in the subvolume tree is completely fine.
>
> >   kernel:BTRFS critical (device vdf): corrupt leaf: root=3D5
> > block=3D3562706763776 slot=3D17 ino=3D407482430, invalid nlink: has 2 e=
xpect
> > no more than 1 for dir
> >   kernel:BTRFS error (device vdf): block=3D3562706763776 write time tre=
e
> > block corruption detected
> >   kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
> > errno=3D-5 IO failure (Error while writing out transaction)
> >   kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
> > errno=3D-5 IO failure (Error while writing out transaction)
> >   kernel:BTRFS: error (device vdf: state EA) in
> > cleanup_transaction:1958: errno=3D-5 IO failure
> >   kernel:BTRFS: error (device vdf: state EA) in
> > cleanup_transaction:1958: errno=3D-5 IO failure
> > mount: /mnt/ebs/minio2: can't read superblock on /dev/vdf.
> >   kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
> > errno=3D-5 IO failure (Failed to recover log tree)
>
> This means there is something wrong in the log replay code.
> Maybe the log tree has something weird.
>
> Mind to dump the log tree?
>
> # btrfs ins dump-tree -b 3766932537344 /dev/vdf

leaf 3766932537344 items 1 free space 15819 generation 3595443 owner TREE_L=
OG
leaf 3766932537344 flags 0x1(WRITTEN) backref revision 1
checksum stored c1241ec5
checksum calced c1241ec5
fs uuid 261534ef-b111-4056-8124-6dd207030548
chunk uuid 976c9d1e-ca7a-4611-befc-5a08375564bc
    item 0 key (TREE_LOG ROOT_ITEM 5) itemoff 15844 itemsize 439
        generation 3595443 root_dirid 0 bytenr 3766932439040
byte_limit 0 bytes_used 3686400
        last_snapshot 0 flags 0x0(none) refs 0
        drop_progress key (0 UNKNOWN.0 0) drop_level 0
        level 1 generation_v2 3595443
        uuid 00000000-0000-0000-0000-000000000000
        parent_uuid 00000000-0000-0000-0000-000000000000
        received_uuid 00000000-0000-0000-0000-000000000000
        ctransid 0 otransid 0 stransid 0 rtransid 0
        ctime 0.0 (1970-01-01 01:00:00)
        otime 0.0 (1970-01-01 01:00:00)
        stime 0.0 (1970-01-01 01:00:00)
        rtime 0.0 (1970-01-01 01:00:00)

>
> >   kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
> > errno=3D-5 IO failure (Failed to recover log tree)
> >   kernel:BTRFS error (device vdf: state EA): open_ctree failed
>
> Although the workaround should be pretty simple, "btrfs rescue zero-log
> /dev/vdf" should fix it.
>
> But please consider not to zero the log until we have collected enough in=
fo.
>
> We may still need extra info even after the above dump-tree output.

No worries, I'll let it in the state and follow your guidance.

>
> Thanks,
> Qu
> >
> > # btrfs rescue super-recover -v /dev/vdf
> > All Devices:
> >      Device: id =3D 1, name =3D /dev/vdf
> >
> > Before Recovering:
> >      [All good supers]:
> >          device name =3D /dev/vdf
> >          superblock bytenr =3D 65536
> >
> >          device name =3D /dev/vdf
> >          superblock bytenr =3D 67108864
> >
> >          device name =3D /dev/vdf
> >          superblock bytenr =3D 274877906944
> >
> >      [All bad supers]:
> >
> > All supers are valid, no need to recover
> >
> > # btrfs-find-root /dev/vdf
> > Superblock thinks the generation is 3595442
> > Superblock thinks the level is 0
> > Found tree root at 3424157040640 gen 3595442 level 0
> > Well block 3424059916288(gen: 3595435 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3424054345728(gen: 3595434 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423941132288(gen: 3595431 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423913361408(gen: 3595430 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423724224512(gen: 3595429 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423618924544(gen: 3595428 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423522717696(gen: 3595419 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423509741568(gen: 3595418 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423381946368(gen: 3595417 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423254937600(gen: 3595411 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3423190253568(gen: 3595410 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257715638272(gen: 3595407 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257566904320(gen: 3595404 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257494061056(gen: 3595402 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257426460672(gen: 3595401 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257354846208(gen: 3595400 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257189138432(gen: 3595398 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257066291200(gen: 3595397 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3257054314496(gen: 3595395 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3256925880320(gen: 3595390 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3256790237184(gen: 3595384 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3256747343872(gen: 3595379 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3256734842880(gen: 3595378 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3256726290432(gen: 3595377 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070848090112(gen: 3595376 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070762254336(gen: 3595369 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070533402624(gen: 3595366 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070520950784(gen: 3595365 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070319542272(gen: 3595364 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070275878912(gen: 3595355 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070224957440(gen: 3595354 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070133649408(gen: 3595348 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3070109827072(gen: 3595347 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2889425747968(gen: 3595340 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2889301147648(gen: 3595339 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2889314811904(gen: 3595337 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2889158066176(gen: 3595332 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2889076523008(gen: 3595330 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2889007906816(gen: 3595329 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2888883896320(gen: 3595328 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2888770060288(gen: 3595326 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2888474230784(gen: 3595325 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2888414789632(gen: 3595324 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2654316625920(gen: 3595323 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2654292000768(gen: 3595322 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2654178476032(gen: 3595321 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2654046437376(gen: 3595317 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2653815832576(gen: 3595312 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2653688217600(gen: 3595311 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2653640425472(gen: 3595310 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503985594368(gen: 3595309 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503770832896(gen: 3595305 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503679131648(gen: 3595304 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503542685696(gen: 3595300 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503440711680(gen: 3595297 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503322124288(gen: 3595294 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503168000000(gen: 3595289 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503054426112(gen: 3595288 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503041384448(gen: 3595287 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2503445053440(gen: 3595285 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2412690669568(gen: 3595284 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2412570755072(gen: 3595281 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2221267697664(gen: 3595278 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2221141753856(gen: 3595275 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2221038993408(gen: 3595270 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220922290176(gen: 3595269 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220743933952(gen: 3595266 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220618924032(gen: 3595264 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220595019776(gen: 3595263 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220507889664(gen: 3595262 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220364578816(gen: 3595258 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220268486656(gen: 3595257 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220199788544(gen: 3595256 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220125945856(gen: 3595253 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220104859648(gen: 3595252 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219941019648(gen: 3595246 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219772805120(gen: 3595245 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219676188672(gen: 3595243 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219385782272(gen: 3595242 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219322032128(gen: 3595239 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219298471936(gen: 3595238 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219189157888(gen: 3595234 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2219168301056(gen: 3595233 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1725089398784(gen: 3595229 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1724993929216(gen: 3595224 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1724703211520(gen: 3595223 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1724590768128(gen: 3595214 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1124192288768(gen: 3595206 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1124086104064(gen: 3595204 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1123955785728(gen: 3595198 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1123796860928(gen: 3595188 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1123702702080(gen: 3595181 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1123696197632(gen: 3595180 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1123421716480(gen: 3595178 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 1123298459648(gen: 3595171 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 409090146304(gen: 3595168 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 408798691328(gen: 3595166 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 408693866496(gen: 3595163 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 408471683072(gen: 3595160 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 768655360(gen: 3595159 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 508542976(gen: 3595157 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 426082304(gen: 3595153 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 275447808(gen: 3595143 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 158154752(gen: 3595138 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 3069995843584(gen: 3594572 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> > Well block 2220640256000(gen: 3594469 level: 0) seems good, but
> > generation/level doesn't match, want gen: 3595442 level: 0
> >
> > # btrfs inspect-internal dump-super /dev/vdf
> > superblock: bytenr=3D65536, device=3D/dev/vdf
> > ---------------------------------------------------------
> > csum_type        0 (crc32c)
> > csum_size        4
> > csum            0x50cf7576 [match]
> > bytenr            65536
> > flags            0x1
> >              ( WRITTEN )
> > magic            _BHRfS_M [match]
> > fsid            261534ef-b111-4056-8124-6dd207030548
> > metadata_uuid        261534ef-b111-4056-8124-6dd207030548
> > label            minio2
> > generation        3595442
> > root            3424157040640
> > sys_array_size        129
> > chunk_root_generation    3581791
> > root_level        0
> > chunk_root        25460736
> > chunk_root_level    1
> > log_root        3766932537344
> > log_root_transid (deprecated)    0
> > log_root_level        0
> > total_bytes        5498631880704
> > bytes_used        4346997747712
> > sectorsize        4096
> > nodesize        16384
> > leafsize (deprecated)    16384
> > stripesize        4096
> > root_dir        6
> > num_devices        1
> > compat_flags        0x0
> > compat_ro_flags        0xb
> >              ( FREE_SPACE_TREE |
> >                FREE_SPACE_TREE_VALID |
> >                BLOCK_GROUP_TREE )
> > incompat_flags        0x371
> >              ( MIXED_BACKREF |
> >                COMPRESS_ZSTD |
> >                BIG_METADATA |
> >                EXTENDED_IREF |
> >                SKINNY_METADATA |
> >                NO_HOLES )
> > cache_generation    0
> > uuid_tree_generation    3595442
> > dev_item.uuid        1d32f1a0-6988-4ed4-b3cd-24d243baf975
> > dev_item.fsid        261534ef-b111-4056-8124-6dd207030548 [match]
> > dev_item.type        0
> > dev_item.total_bytes    5498631880704
> > dev_item.bytes_used    4820052213760
> > dev_item.io_align    4096
> > dev_item.io_width    4096
> > dev_item.sector_size    4096
> > dev_item.devid        1
> > dev_item.dev_group    0
> > dev_item.seek_speed    0
> > dev_item.bandwidth    0
> > dev_item.generation    0



--=20
=E2=80=94 Igor Raits.

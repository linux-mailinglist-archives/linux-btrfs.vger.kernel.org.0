Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19B44D9069
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 00:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiCNXfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiCNXfm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 19:35:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13BE273F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 16:34:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b67so14218775qkc.6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9UOZ8IDOSEexx3bnPsrtV4wQxnXiwyCaT+x3ZAezRVw=;
        b=GPU2g4gxnOFsuc1HXfWb7spYvchWH6vnL/QmLy+qtGJgzZsTCPsR3m6qfMj573T7Vz
         x8xxmHSQmY3qGvTse+WUM7x9FBC3P6EsQX3Bz/RDZlLE6737gPBaTRFSzsJu2YTtVlVd
         yG17jdkp2SMG3sAR1WjEZvYxztihst7S1uGIQ1Sgvhl56scSM+l+GQu0mfj2TwLs2IhD
         UthwOZupBbi+BHB7S1qoZR1WtFTxon9SduNMcuUEljCNaf+FwBe6vzBS71dZK/tNMW4o
         IIKzotlOABvXuT1gFqswNaVM7niyr67/NUa4DG3pilCvi7om1odmFhlqYUn8CCItO80d
         IYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9UOZ8IDOSEexx3bnPsrtV4wQxnXiwyCaT+x3ZAezRVw=;
        b=xB1xIPNiAVEw9fiGnQacTrx1nXjRIyW649x7uzRPVjIe+A/Xk3YZwGQ90RqMXDkIHk
         NudQqaryE/cZqgaJrVlqKTQAAY0lk4GOnSdartvRV3842OOdMVkQIkPCsjVQt7GfdUTS
         qpogzcrmEiJE5fIy5DkMHkhls9oXqQFqpzBwph9hI5RYo3CSdrDDMj+qF0LHYQBmIB5+
         6khYQ7134gN340ZSd/o6stqtVao5jE6YA8CDqwIma3gsV8/5uO5KP/E/Mk4WPUatzY4a
         Y6I2P6UqfdfuqJcwi5AkR/fBKsUd4xCKcCMZs88twyd0erW/ntDkWZHPLX9g9PNkU/Zj
         /bog==
X-Gm-Message-State: AOAM531zqjH0ClGUjuSQGa3opG8XDYGy/ZBd0lPS8EMzosAxgkvrug0s
        GQNdbu7IiRzGgogW6h/2m7/VEy77CM/whbdI+VzHKyxooAg=
X-Google-Smtp-Source: ABdhPJxDhh7dL5bqNsVkPqZJ7D1Ac1kNMMlRjpQAX1JMugbJvoOQfZuhLW+CT6wAyY8YFd+fTgYkg6JO3TGy6or2KAo=
X-Received: by 2002:a37:af81:0:b0:502:7ea:34e7 with SMTP id
 y123-20020a37af81000000b0050207ea34e7mr16402538qke.737.1647300867218; Mon, 14
 Mar 2022 16:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646875648.git.osandov@fb.com> <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
In-Reply-To: <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 14 Mar 2022 23:33:51 +0000
Message-ID: <CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] btrfs: allocate inode outside of btrfs_new_inode()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
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

On Thu, Mar 10, 2022 at 4:56 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Instead of calling new_inode() and inode_init_owner() inside of
> btrfs_new_inode(), do it in the callers. This allows us to pass in just
> the inode instead of the mnt_userns and mode and removes the need for
> memalloc_nofs_{save,restores}() since we do it before starting a
> transaction. This also paves the way for some more cleanups in later
> patches.
>
> This also removes the comments about Smack checking i_op, which are no
> longer true since commit 5d6c31910bc0 ("xattr: Add
> __vfs_{get,set,remove}xattr helpers"). Now it checks inode->i_opflags &
> IOP_XATTR, which is set based on sb->s_xattr.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

There's some leak here Omar.

misc-next is triggering tons of these on dmesg:

[ 1476.957056] run fstests btrfs/232 at 2022-03-14 23:30:17
[ 1477.657768] BTRFS: device fsid 9674450f-5f48-4518-97d1-c69714c76a89
devid 1 transid 5 /dev/sdc scanned by mkfs.btrfs (96574)
[ 1477.701683] BTRFS info (device sdc): flagging fs with big metadata featu=
re
[ 1477.701689] BTRFS info (device sdc): disk space caching is enabled
[ 1477.701691] BTRFS info (device sdc): has skinny extents
[ 1477.708205] BTRFS info (device sdc): checking UUID tree
[ 1486.226044] BTRFS warning (device sdc): qgroup rescan is already in prog=
ress
[ 1486.232228] BTRFS info (device sdc): qgroup scan completed
(inconsistency flag cleared)
[ 1520.615331] BTRFS warning (device sdc): page private not zero on
page 38846464
[ 1520.615350] BTRFS warning (device sdc): page private not zero on
page 38850560
[ 1520.615365] BTRFS warning (device sdc): page private not zero on
page 38854656
[ 1520.615380] BTRFS warning (device sdc): page private not zero on
page 38858752
[ 1520.615394] BTRFS warning (device sdc): page private not zero on
page 44597248
[ 1520.615409] BTRFS warning (device sdc): page private not zero on
page 44601344
[ 1520.615423] BTRFS warning (device sdc): page private not zero on
page 44605440
[ 1520.615482] BTRFS warning (device sdc): page private not zero on
page 44609536
[ 1520.615496] BTRFS warning (device sdc): page private not zero on
page 47349760
[ 1520.615511] BTRFS warning (device sdc): page private not zero on
page 47353856
[ 1520.615525] BTRFS warning (device sdc): page private not zero on
page 47357952
[ 1520.615539] BTRFS warning (device sdc): page private not zero on
page 47362048
[ 1520.615554] BTRFS warning (device sdc): page private not zero on
page 56229888
[ 1520.615568] BTRFS warning (device sdc): page private not zero on
page 56233984
[ 1520.615582] BTRFS warning (device sdc): page private not zero on
page 56238080
[ 1520.615596] BTRFS warning (device sdc): page private not zero on
page 56242176
[ 1520.615611] BTRFS warning (device sdc): page private not zero on
page 59228160
[ 1520.615625] BTRFS warning (device sdc): page private not zero on
page 59232256
[ 1520.615640] BTRFS warning (device sdc): page private not zero on
page 59236352
[ 1520.615654] BTRFS warning (device sdc): page private not zero on
page 59240448
[ 1520.615668] BTRFS warning (device sdc): page private not zero on
page 60702720
[ 1520.615682] BTRFS warning (device sdc): page private not zero on
page 60706816
[ 1520.615722] BTRFS warning (device sdc): page private not zero on
page 60710912
[ 1520.615736] BTRFS warning (device sdc): page private not zero on
page 60715008
[ 1520.615751] BTRFS warning (device sdc): page private not zero on
page 60719104
[ 1520.615765] BTRFS warning (device sdc): page private not zero on
page 60723200
[ 1520.615779] BTRFS warning (device sdc): page private not zero on
page 60727296
[ 1520.615793] BTRFS warning (device sdc): page private not zero on
page 60731392
[ 1520.615808] BTRFS warning (device sdc): page private not zero on
page 62930944
[ 1520.615822] BTRFS warning (device sdc): page private not zero on
page 62935040
[ 1520.615836] BTRFS warning (device sdc): page private not zero on
page 62939136
[ 1520.615851] BTRFS warning (device sdc): page private not zero on
page 62943232
[ 1520.615865] BTRFS warning (device sdc): page private not zero on
page 69533696
[ 1520.615879] BTRFS warning (device sdc): page private not zero on
page 69537792
[ 1520.615893] BTRFS warning (device sdc): page private not zero on
page 69541888
[ 1520.615908] BTRFS warning (device sdc): page private not zero on
page 69545984
[ 1520.615922] BTRFS warning (device sdc): page private not zero on
page 73629696
[ 1520.615959] BTRFS warning (device sdc): page private not zero on
page 73633792
[ 1520.615973] BTRFS warning (device sdc): page private not zero on
page 73637888
[ 1520.615987] BTRFS warning (device sdc): page private not zero on
page 73641984
[ 1520.616002] BTRFS warning (device sdc): page private not zero on
page 83623936
[ 1520.616016] BTRFS warning (device sdc): page private not zero on
page 83628032
[ 1520.616030] BTRFS warning (device sdc): page private not zero on
page 83632128
[ 1520.616045] BTRFS warning (device sdc): page private not zero on
page 83636224
[ 1520.616059] BTRFS warning (device sdc): page private not zero on
page 86884352
[ 1520.616073] BTRFS warning (device sdc): page private not zero on
page 86888448
[ 1520.616088] BTRFS warning (device sdc): page private not zero on
page 86892544
[ 1520.616102] BTRFS warning (device sdc): page private not zero on
page 86896640
[ 1520.616116] BTRFS warning (device sdc): page private not zero on
page 92979200
[ 1520.616130] BTRFS warning (device sdc): page private not zero on
page 92983296
[ 1520.616145] BTRFS warning (device sdc): page private not zero on
page 92987392
[ 1520.616159] BTRFS warning (device sdc): page private not zero on
page 92991488
[ 1520.616212] BTRFS warning (device sdc): page private not zero on
page 97697792
[ 1520.616227] BTRFS warning (device sdc): page private not zero on
page 97701888
[ 1520.616241] BTRFS warning (device sdc): page private not zero on
page 97705984
[ 1520.616255] BTRFS warning (device sdc): page private not zero on
page 97710080
[ 1520.616270] BTRFS warning (device sdc): page private not zero on
page 100270080
[ 1520.616284] BTRFS warning (device sdc): page private not zero on
page 100274176
[ 1520.616298] BTRFS warning (device sdc): page private not zero on
page 100278272
[ 1520.616313] BTRFS warning (device sdc): page private not zero on
page 100282368
[ 1520.616327] BTRFS warning (device sdc): page private not zero on
page 104431616
[ 1520.616341] BTRFS warning (device sdc): page private not zero on
page 104435712
[ 1520.616356] BTRFS warning (device sdc): page private not zero on
page 104439808
[ 1520.616403] BTRFS warning (device sdc): page private not zero on
page 104443904
[ 1520.616418] BTRFS warning (device sdc): page private not zero on
page 110411776
[ 1520.616432] BTRFS warning (device sdc): page private not zero on
page 110415872
[ 1520.616446] BTRFS warning (device sdc): page private not zero on
page 110419968
[ 1520.616461] BTRFS warning (device sdc): page private not zero on
page 110424064
[ 1520.616475] BTRFS warning (device sdc): page private not zero on
page 110854144
[ 1520.616489] BTRFS warning (device sdc): page private not zero on
page 110858240
[ 1520.616503] BTRFS warning (device sdc): page private not zero on
page 110862336
[ 1520.616518] BTRFS warning (device sdc): page private not zero on
page 110866432
[ 1520.616532] BTRFS warning (device sdc): page private not zero on
page 113491968
[ 1520.616546] BTRFS warning (device sdc): page private not zero on
page 113496064
[ 1520.616560] BTRFS warning (device sdc): page private not zero on
page 113500160
[ 1520.616575] BTRFS warning (device sdc): page private not zero on
page 113504256
[ 1520.616589] BTRFS warning (device sdc): page private not zero on
page 118177792
[ 1520.616603] BTRFS warning (device sdc): page private not zero on
page 118181888
[ 1520.616639] BTRFS warning (device sdc): page private not zero on
page 118185984
[ 1520.616654] BTRFS warning (device sdc): page private not zero on
page 118190080
[ 1520.616668] BTRFS warning (device sdc): page private not zero on
page 118210560
[ 1520.616682] BTRFS warning (device sdc): page private not zero on
page 118214656
[ 1520.616696] BTRFS warning (device sdc): page private not zero on
page 118218752
[ 1520.616711] BTRFS warning (device sdc): page private not zero on
page 118222848
[ 1520.616725] BTRFS warning (device sdc): page private not zero on
page 121749504
[ 1520.616739] BTRFS warning (device sdc): page private not zero on
page 121753600
[ 1520.616754] BTRFS warning (device sdc): page private not zero on
page 121757696
[ 1520.616768] BTRFS warning (device sdc): page private not zero on
page 121761792
[ 1520.616782] BTRFS warning (device sdc): page private not zero on
page 128712704
[ 1520.616797] BTRFS warning (device sdc): page private not zero on
page 128716800
[ 1520.616811] BTRFS warning (device sdc): page private not zero on
page 128720896
[ 1520.616825] BTRFS warning (device sdc): page private not zero on
page 128724992
[ 1520.616840] BTRFS warning (device sdc): page private not zero on
page 135806976
[ 1520.616879] BTRFS warning (device sdc): page private not zero on
page 135811072
[ 1520.616894] BTRFS warning (device sdc): page private not zero on
page 135815168
[ 1520.616908] BTRFS warning (device sdc): page private not zero on
page 135819264
[ 1520.616922] BTRFS warning (device sdc): page private not zero on
page 138182656
[ 1520.616936] BTRFS warning (device sdc): page private not zero on
page 138186752
[ 1520.616951] BTRFS warning (device sdc): page private not zero on
page 138190848
[ 1520.616965] BTRFS warning (device sdc): page private not zero on
page 138194944
[ 1520.631273] BTRFS error (device sdc): leaked root 259 refcount 1
[ 1520.632324] BTRFS error (device sdc): leaked root 260 refcount 1
[ 1520.633439] BTRFS error (device sdc): leaked root 258 refcount 1
[ 1520.634585] BTRFS error (device sdc): leaked root 261 refcount 1
[ 1520.635817] BTRFS error (device sdc): leaked root 262 refcount 1
[ 1520.636954] BTRFS error (device sdc): leaked root 263 refcount 1
[ 1520.638021] BTRFS error (device sdc): leaked root 264 refcount 1
[ 1520.639023] BTRFS error (device sdc): leaked root 265 refcount 1
[ 1520.640117] BTRFS error (device sdc): leaked root 267 refcount 1
[ 1520.641238] BTRFS error (device sdc): leaked root 268 refcount 1
[ 1520.642317] BTRFS error (device sdc): leaked root 269 refcount 1
[ 1520.643405] BTRFS error (device sdc): leaked root 271 refcount 1
[ 1520.644567] BTRFS error (device sdc): leaked root 272 refcount 1
[ 1520.645708] BTRFS error (device sdc): leaked root 273 refcount 1
[ 1520.646843] BTRFS error (device sdc): leaked root 274 refcount 1
[ 1520.647923] BTRFS error (device sdc): leaked root 276 refcount 1
[ 1520.649052] BTRFS error (device sdc): leaked root 277 refcount 1
[ 1520.650195] BTRFS error (device sdc): leaked root 280 refcount 1
[ 1520.651361] BTRFS error (device sdc): leaked root 281 refcount 1
[ 1520.652496] BTRFS error (device sdc): leaked root 284 refcount 1
[ 1520.653645] BTRFS error (device sdc): leaked root 285 refcount 1
[ 1520.654804] BTRFS error (device sdc): leaked root 286 refcount 1
[ 1520.655826] BTRFS error (device sdc): leaked root 288 refcount 1
[ 1520.656913] BTRFS error (device sdc): leaked root 289 refcount 1
[ 1520.658003] BTRFS error (device sdc): leaked root 291 refcount 1
[ 1520.659218] BTRFS error (device sdc): leaked root 292 refcount 1
[ 1520.660322] BTRFS error (device sdc): leaked root 296 refcount 1
[ 1520.661473] BTRFS error (device sdc): leaked root 297 refcount 1
[ 1520.662641] BTRFS error (device sdc): leaked root 298 refcount 1
[ 1520.663850] BTRFS error (device sdc): leaked root 302 refcount 1
[ 1520.664974] BTRFS error (device sdc): leaked root 303 refcount 1
[ 1520.666122] BTRFS error (device sdc): leaked root 304 refcount 1
[ 1520.667245] BTRFS error (device sdc): leaked root 305 refcount 1
[ 1520.668027] BTRFS error (device sdc): leaked root 306 refcount 1
[ 1520.668799] BTRFS error (device sdc): leaked root 307 refcount 1
[ 1520.669571] BTRFS error (device sdc): leaked root 310 refcount 1
[ 1520.670353] BTRFS error (device sdc): leaked root 311 refcount 1
[ 1520.671175] BTRFS error (device sdc): leaked root 316 refcount 1
[ 1520.672003] BTRFS error (device sdc): leaked root 319 refcount 1
[ 1520.672945] BTRFS error (device sdc): leaked root 321 refcount 1
[ 1520.673892] BTRFS error (device sdc): leaked root 320 refcount 1
[ 1520.674726] BTRFS error (device sdc): leaked root 324 refcount 1
[ 1520.675626] BTRFS error (device sdc): leaked root 325 refcount 1
[ 1520.676484] BTRFS error (device sdc): leaked root 326 refcount 1
[ 1520.677252] BTRFS error (device sdc): leaked root 327 refcount 1
[ 1520.678168] BTRFS error (device sdc): leaked root 329 refcount 1
[ 1520.679144] BTRFS error (device sdc): leaked root 330 refcount 1
[ 1520.680253] BTRFS error (device sdc): leaked root 332 refcount 1
[ 1520.681365] BTRFS error (device sdc): leaked root 337 refcount 1
[ 1520.682482] BTRFS error (device sdc): leaked root 336 refcount 1
[ 1520.683614] BTRFS error (device sdc): leaked root 333 refcount 1
[ 1520.684725] BTRFS error (device sdc): leaked root 339 refcount 1
[ 1520.685831] BTRFS error (device sdc): leaked root 334 refcount 1
[ 1520.686935] BTRFS error (device sdc): leaked root 335 refcount 1
[ 1520.688060] BTRFS error (device sdc): leaked root 338 refcount 1
[ 1520.689162] BTRFS error (device sdc): leaked root 342 refcount 1
[ 1520.690266] BTRFS error (device sdc): leaked root 344 refcount 1
[ 1520.691402] BTRFS error (device sdc): leaked root 345 refcount 1
[ 1520.692511] BTRFS error (device sdc): leaked root 346 refcount 1
[ 1520.693613] BTRFS error (device sdc): leaked root 350 refcount 1
[ 1520.694735] BTRFS error (device sdc): leaked root 351 refcount 1
[ 1520.695727] BTRFS error (device sdc): leaked root 352 refcount 1
[ 1520.696645] BTRFS error (device sdc): leaked root 353 refcount 1
[ 1520.697540] BTRFS error (device sdc): leaked root 354 refcount 1
[ 1520.698471] BTRFS error (device sdc): leaked root 357 refcount 1
[ 1520.699382] BTRFS error (device sdc): leaked root 359 refcount 1
[ 1520.700353] BTRFS error (device sdc): leaked root 361 refcount 1
[ 1520.701256] BTRFS error (device sdc): leaked root 362 refcount 1
[ 1520.702216] BTRFS error (device sdc): leaked root 367 refcount 1
[ 1520.703215] BTRFS error (device sdc): leaked root 365 refcount 1
[ 1520.704263] BTRFS error (device sdc): leaked root 366 refcount 1
[ 1520.705337] BTRFS error (device sdc): leaked root 372 refcount 1
[ 1520.706426] BTRFS error (device sdc): leaked root 375 refcount 1
[ 1520.707552] BTRFS error (device sdc): leaked root 376 refcount 1
[ 1520.708677] BTRFS error (device sdc): leaked root 378 refcount 1
[ 1520.709812] BTRFS error (device sdc): leaked root 382 refcount 1
[ 1520.710918] BTRFS error (device sdc): leaked root 383 refcount 1
[ 1520.712052] BTRFS error (device sdc): leaked root 384 refcount 1
[ 1520.713288] BTRFS error (device sdc): leaked root 388 refcount 1
[ 1520.714400] BTRFS error (device sdc): leaked root 391 refcount 1
[ 1520.715526] BTRFS error (device sdc): leaked root 394 refcount 1
[ 1520.716631] BTRFS error (device sdc): leaked root 398 refcount 1
[ 1520.717743] BTRFS error (device sdc): leaked root 404 refcount 1
[ 1520.718856] BTRFS error (device sdc): leaked root 405 refcount 1
[ 1520.719690] BTRFS error (device sdc): leaked root 407 refcount 1
[ 1520.720441] BTRFS error (device sdc): leaked root 406 refcount 1
[ 1520.721192] BTRFS error (device sdc): leaked root 408 refcount 1
[ 1520.721977] BTRFS error (device sdc): leaked root 410 refcount 1
[ 1520.722738] BTRFS error (device sdc): leaked root 412 refcount 1
[ 1520.723538] BTRFS error (device sdc): leaked root 411 refcount 1
[ 1520.724311] BTRFS error (device sdc): leaked root 417 refcount 1
[ 1520.725048] BTRFS error (device sdc): leaked root 418 refcount 1
[ 1520.725833] BTRFS error (device sdc): leaked root 420 refcount 1
[ 1520.726608] BTRFS error (device sdc): leaked root 423 refcount 1
[ 1520.727401] BTRFS error (device sdc): leaked root 424 refcount 1
[ 1520.728171] BTRFS error (device sdc): leaked root 425 refcount 1
[ 1520.728923] BTRFS error (device sdc): leaked root 426 refcount 1
[ 1520.729777] BTRFS error (device sdc): leaked root 428 refcount 1
[ 1520.730625] BTRFS error (device sdc): leaked root 430 refcount 1
[ 1520.731687] BTRFS error (device sdc): leaked root 429 refcount 1
[ 1520.733214] BTRFS: buffer leak start 650739712 len 16384 refs 1
bflags 529 owner 483
[ 1520.734174] BTRFS: buffer leak start 648740864 len 16384 refs 1
bflags 529 owner 468
[ 1520.735134] BTRFS: buffer leak start 647577600 len 16384 refs 1
bflags 529 owner 649
[ 1520.736077] BTRFS: buffer leak start 647512064 len 16384 refs 1
bflags 529 owner 651
[ 1520.737023] BTRFS: buffer leak start 645873664 len 16384 refs 1
bflags 529 owner 449
[ 1520.737975] BTRFS: buffer leak start 645562368 len 16384 refs 1
bflags 529 owner 376
[ 1520.738923] BTRFS: buffer leak start 645218304 len 16384 refs 1
bflags 529 owner 633
[ 1520.739879] BTRFS: buffer leak start 645185536 len 16384 refs 1
bflags 529 owner 365
[ 1520.740819] BTRFS: buffer leak start 644382720 len 16384 refs 1
bflags 529 owner 640
[ 1520.741769] BTRFS: buffer leak start 639467520 len 16384 refs 1
bflags 529 owner 439
[ 1520.742706] BTRFS: buffer leak start 638517248 len 16384 refs 1
bflags 529 owner 647
[ 1520.743649] BTRFS: buffer leak start 621477888 len 16384 refs 1
bflags 529 owner 391
[ 1520.744584] BTRFS: buffer leak start 621428736 len 16384 refs 1
bflags 529 owner 484
[ 1520.745518] BTRFS: buffer leak start 621412352 len 16384 refs 1
bflags 529 owner 418
[ 1520.746460] BTRFS: buffer leak start 621395968 len 16384 refs 1
bflags 529 owner 375
[ 1520.747403] BTRFS: buffer leak start 615235584 len 16384 refs 1
bflags 529 owner 645
[ 1520.748345] BTRFS: buffer leak start 607076352 len 16384 refs 1
bflags 529 owner 444
[ 1520.749296] BTRFS: buffer leak start 607027200 len 16384 refs 1
bflags 529 owner 643
[ 1520.750320] BTRFS: buffer leak start 602423296 len 16384 refs 1
bflags 529 owner 534
[ 1520.751285] BTRFS: buffer leak start 602177536 len 16384 refs 1
bflags 529 owner 333
[ 1520.752228] BTRFS: buffer leak start 601587712 len 16384 refs 1
bflags 529 owner 420
[ 1520.753203] BTRFS: buffer leak start 600834048 len 16384 refs 1
bflags 529 owner 359
[ 1520.754145] BTRFS: buffer leak start 597262336 len 16384 refs 1
bflags 529 owner 561
[ 1520.755106] BTRFS: buffer leak start 597082112 len 16384 refs 1
bflags 529 owner 570
[ 1520.756041] BTRFS: buffer leak start 595820544 len 16384 refs 1
bflags 529 owner 477
[ 1520.756980] BTRFS: buffer leak start 594903040 len 16384 refs 1
bflags 529 owner 629
[ 1520.757988] BTRFS: buffer leak start 593575936 len 16384 refs 1
bflags 529 owner 311
[ 1520.758962] BTRFS: buffer leak start 592822272 len 16384 refs 1
bflags 529 owner 426
[ 1520.759928] BTRFS: buffer leak start 591052800 len 16384 refs 1
bflags 529 owner 620
[ 1520.760883] BTRFS: buffer leak start 585383936 len 16384 refs 1
bflags 529 owner 627
[ 1520.761862] BTRFS: buffer leak start 581173248 len 16384 refs 1
bflags 529 owner 599
[ 1520.762809] BTRFS: buffer leak start 579321856 len 16384 refs 1
bflags 529 owner 601
[ 1520.763780] BTRFS: buffer leak start 577994752 len 16384 refs 1
bflags 529 owner 320
[ 1520.764722] BTRFS: buffer leak start 573882368 len 16384 refs 1
bflags 529 owner 430
[ 1520.765661] BTRFS: buffer leak start 571965440 len 16384 refs 1
bflags 529 owner 542
[ 1520.766656] BTRFS: buffer leak start 567951360 len 16384 refs 1
bflags 529 owner 406
[ 1520.767631] BTRFS: buffer leak start 564953088 len 16384 refs 1
bflags 529 owner 624
[ 1520.768581] BTRFS: buffer leak start 562823168 len 16384 refs 1
bflags 529 owner 310
[ 1520.769579] BTRFS: buffer leak start 556138496 len 16384 refs 1
bflags 529 owner 579
[ 1520.770755] BTRFS: buffer leak start 554008576 len 16384 refs 1
bflags 529 owner 615
[ 1520.771905] BTRFS: buffer leak start 550092800 len 16384 refs 1
bflags 529 owner 612
[ 1520.773016] BTRFS: buffer leak start 545488896 len 16384 refs 1
bflags 529 owner 326
[ 1520.774173] BTRFS: buffer leak start 545374208 len 16384 refs 1
bflags 529 owner 297
[ 1520.775263] BTRFS: buffer leak start 542048256 len 16384 refs 1
bflags 529 owner 273
[ 1520.776238] BTRFS: buffer leak start 541999104 len 16384 refs 1
bflags 529 owner 606
[ 1520.777211] BTRFS: buffer leak start 541261824 len 16384 refs 1
bflags 529 owner 513
[ 1520.778177] BTRFS: buffer leak start 539721728 len 16384 refs 1
bflags 529 owner 424
[ 1520.779159] BTRFS: buffer leak start 538460160 len 16384 refs 1
bflags 529 owner 544
[ 1520.780134] BTRFS: buffer leak start 535248896 len 16384 refs 1
bflags 529 owner 566
[ 1520.781096] BTRFS: buffer leak start 534986752 len 16384 refs 1
bflags 529 owner 277
[ 1520.782076] BTRFS: buffer leak start 530939904 len 16384 refs 1
bflags 529 owner 582
[ 1520.783037] BTRFS: buffer leak start 530448384 len 16384 refs 1
bflags 529 owner 354
[ 1520.784050] BTRFS: buffer leak start 529285120 len 16384 refs 1
bflags 529 owner 584
[ 1520.785025] BTRFS: buffer leak start 529022976 len 16384 refs 1
bflags 529 owner 285
[ 1520.786034] BTRFS: buffer leak start 527679488 len 16384 refs 1
bflags 529 owner 578
[ 1520.787026] BTRFS: buffer leak start 526352384 len 16384 refs 1
bflags 529 owner 274
[ 1520.788001] BTRFS: buffer leak start 521420800 len 16384 refs 1
bflags 529 owner 536
[ 1520.788947] BTRFS: buffer leak start 520273920 len 16384 refs 1
bflags 529 owner 352
[ 1520.789906] BTRFS: buffer leak start 516194304 len 16384 refs 1
bflags 529 owner 549
[ 1520.790845] BTRFS: buffer leak start 515571712 len 16384 refs 1
bflags 529 owner 452
[ 1520.791803] BTRFS: buffer leak start 515473408 len 16384 refs 1
bflags 529 owner 357
[ 1520.792753] BTRFS: buffer leak start 514818048 len 16384 refs 1
bflags 529 owner 417
[ 1520.793708] BTRFS: buffer leak start 512835584 len 16384 refs 1
bflags 529 owner 590
[ 1520.794700] BTRFS: buffer leak start 512540672 len 16384 refs 1
bflags 529 owner 411
[ 1520.795670] BTRFS: buffer leak start 512491520 len 16384 refs 1
bflags 529 owner 350
[ 1520.796610] BTRFS: buffer leak start 508936192 len 16384 refs 1
bflags 529 owner 472
[ 1520.797571] BTRFS: buffer leak start 502546432 len 16384 refs 1
bflags 529 owner 591
[ 1520.798531] BTRFS: buffer leak start 501366784 len 16384 refs 1
bflags 529 owner 585
[ 1520.799494] BTRFS: buffer leak start 501235712 len 16384 refs 1
bflags 529 owner 580
[ 1520.800440] BTRFS: buffer leak start 500203520 len 16384 refs 1
bflags 529 owner 558
[ 1520.801386] BTRFS: buffer leak start 495648768 len 16384 refs 1
bflags 529 owner 583
[ 1520.802346] BTRFS: buffer leak start 493813760 len 16384 refs 1
bflags 529 owner 525
[ 1520.803310] BTRFS: buffer leak start 490881024 len 16384 refs 1
bflags 529 owner 492
[ 1520.804247] BTRFS: buffer leak start 486146048 len 16384 refs 1
bflags 529 owner 581
[ 1520.805196] BTRFS: buffer leak start 474529792 len 16384 refs 1
bflags 529 owner 263
[ 1520.806172] BTRFS: buffer leak start 474185728 len 16384 refs 1
bflags 529 owner 576
[ 1520.807146] BTRFS: buffer leak start 466354176 len 16384 refs 1
bflags 529 owner 575
[ 1520.808094] BTRFS: buffer leak start 454000640 len 16384 refs 1
bflags 529 owner 478
[ 1520.809049] BTRFS: buffer leak start 451657728 len 16384 refs 1
bflags 529 owner 384
[ 1520.810027] BTRFS: buffer leak start 451575808 len 16384 refs 1
bflags 529 owner 259
[ 1520.810975] BTRFS: buffer leak start 448479232 len 16384 refs 1
bflags 529 owner 286
[ 1520.811942] BTRFS: buffer leak start 446103552 len 16384 refs 1
bflags 529 owner 521
[ 1520.812890] BTRFS: buffer leak start 444252160 len 16384 refs 1
bflags 529 owner 344
[ 1520.813867] BTRFS: buffer leak start 437616640 len 16384 refs 1
bflags 529 owner 304
[ 1520.814942] BTRFS: buffer leak start 428965888 len 16384 refs 1
bflags 529 owner 366
[ 1520.815918] BTRFS: buffer leak start 428195840 len 16384 refs 1
bflags 529 owner 268
[ 1520.816872] BTRFS: buffer leak start 426901504 len 16384 refs 1
bflags 529 owner 556
[ 1520.817842] BTRFS: buffer leak start 424935424 len 16384 refs 1
bflags 529 owner 554
[ 1520.818791] BTRFS: buffer leak start 424476672 len 16384 refs 1
bflags 529 owner 288
[ 1520.819766] BTRFS: buffer leak start 422592512 len 16384 refs 1
bflags 529 owner 553
[ 1520.820817] BTRFS: buffer leak start 418512896 len 16384 refs 1
bflags 529 owner 448
[ 1520.821793] BTRFS: buffer leak start 415072256 len 16384 refs 1
bflags 529 owner 429
[ 1520.822742] BTRFS: buffer leak start 408682496 len 16384 refs 1
bflags 529 owner 531
[ 1520.823712] BTRFS: buffer leak start 401932288 len 16384 refs 1
bflags 529 owner 532
[ 1520.824666] BTRFS: buffer leak start 400900096 len 16384 refs 1
bflags 529 owner 539
[ 1520.825684] BTRFS: buffer leak start 400359424 len 16384 refs 1
bflags 529 owner 470
[ 1520.826825] BTRFS: buffer leak start 397787136 len 16384 refs 1
bflags 529 owner 537
[ 1520.827780] BTRFS: buffer leak start 388071424 len 16384 refs 1
bflags 529 owner 456
[ 1520.828719] BTRFS: buffer leak start 384303104 len 16384 refs 1
bflags 529 owner 522
[ 1520.829659] BTRFS: buffer leak start 383123456 len 16384 refs 1
bflags 529 owner 339
[ 1520.830613] BTRFS: buffer leak start 377585664 len 16384 refs 1
bflags 529 owner 498
[ 1520.831569] BTRFS: buffer leak start 375209984 len 16384 refs 1
bflags 529 owner 305
[ 1520.832590] BTRFS: buffer leak start 375013376 len 16384 refs 1
bflags 529 owner 264
[ 1520.833551] BTRFS: buffer leak start 374145024 len 16384 refs 1
bflags 529 owner 362
[ 1520.834520] BTRFS: buffer leak start 373260288 len 16384 refs 1
bflags 529 owner 327
[ 1520.835503] BTRFS: buffer leak start 371933184 len 16384 refs 1
bflags 529 owner 502
[ 1520.836468] BTRFS: buffer leak start 355844096 len 16384 refs 1
bflags 529 owner 455
[ 1520.837449] BTRFS: buffer leak start 340525056 len 16384 refs 1
bflags 529 owner 262
[ 1520.838413] BTRFS: buffer leak start 340262912 len 16384 refs 1
bflags 529 owner 388
[ 1520.839375] BTRFS: buffer leak start 340246528 len 16384 refs 1
bflags 529 owner 479
[ 1520.840320] BTRFS: buffer leak start 340230144 len 16384 refs 1
bflags 529 owner 481
[ 1520.841314] BTRFS: buffer leak start 340197376 len 16384 refs 1
bflags 529 owner 281
[ 1520.842269] BTRFS: buffer leak start 339099648 len 16384 refs 1
bflags 529 owner 437
[ 1520.843220] BTRFS: buffer leak start 339017728 len 16384 refs 1
bflags 529 owner 284
[ 1520.844197] BTRFS: buffer leak start 338919424 len 16384 refs 1
bflags 529 owner 258
[ 1520.845156] BTRFS: buffer leak start 338886656 len 16384 refs 1
bflags 529 owner 291
[ 1520.846254] BTRFS: buffer leak start 338706432 len 16384 refs 1
bflags 529 owner 428
[ 1520.847260] BTRFS: buffer leak start 338673664 len 16384 refs 1
bflags 529 owner 272
[ 1520.848240] BTRFS: buffer leak start 337723392 len 16384 refs 1
bflags 529 owner 353
[ 1520.849225] BTRFS: buffer leak start 337625088 len 16384 refs 1
bflags 529 owner 461
[ 1520.850214] BTRFS: buffer leak start 337575936 len 16384 refs 1
bflags 529 owner 511
[ 1520.851207] BTRFS: buffer leak start 337035264 len 16384 refs 1
bflags 529 owner 463
[ 1520.852188] BTRFS: buffer leak start 336756736 len 16384 refs 1
bflags 529 owner 475
[ 1520.853168] BTRFS: buffer leak start 336674816 len 16384 refs 1
bflags 529 owner 510
[ 1520.854146] BTRFS: buffer leak start 335380480 len 16384 refs 1
bflags 529 owner 508
[ 1520.855145] BTRFS: buffer leak start 334331904 len 16384 refs 1
bflags 529 owner 407
[ 1520.856128] BTRFS: buffer leak start 333135872 len 16384 refs 1
bflags 529 owner 280
[ 1520.857148] BTRFS: buffer leak start 331104256 len 16384 refs 1
bflags 529 owner 405
[ 1520.858109] BTRFS: buffer leak start 330924032 len 16384 refs 1
bflags 529 owner 260
[ 1520.859056] BTRFS: buffer leak start 330203136 len 16384 refs 1
bflags 529 owner 425
[ 1520.860012] BTRFS: buffer leak start 329728000 len 16384 refs 1
bflags 529 owner 324
[ 1520.860961] BTRFS: buffer leak start 329285632 len 16384 refs 1
bflags 529 owner 464
[ 1520.861919] BTRFS: buffer leak start 326139904 len 16384 refs 1
bflags 529 owner 398
[ 1520.862876] BTRFS: buffer leak start 325173248 len 16384 refs 1
bflags 529 owner 501
[ 1520.863846] BTRFS: buffer leak start 324059136 len 16384 refs 1
bflags 529 owner 500
[ 1520.864798] BTRFS: buffer leak start 323551232 len 16384 refs 1
bflags 529 owner 367
[ 1520.865766] BTRFS: buffer leak start 310476800 len 16384 refs 1
bflags 529 owner 451
[ 1520.866731] BTRFS: buffer leak start 298860544 len 16384 refs 1
bflags 529 owner 486
[ 1520.867719] BTRFS: buffer leak start 297156608 len 16384 refs 1
bflags 529 owner 378
[ 1520.868674] BTRFS: buffer leak start 270565376 len 16384 refs 1
bflags 529 owner 462
[ 1520.869615] BTRFS: buffer leak start 270483456 len 16384 refs 1
bflags 529 owner 336
[ 1520.870581] BTRFS: buffer leak start 269303808 len 16384 refs 1
bflags 529 owner 473
[ 1520.871659] BTRFS: buffer leak start 266649600 len 16384 refs 1
bflags 529 owner 433
[ 1520.872626] BTRFS: buffer leak start 257409024 len 16384 refs 1
bflags 529 owner 467
[ 1520.873609] BTRFS: buffer leak start 249872384 len 16384 refs 1
bflags 529 owner 412
[ 1520.874597] BTRFS: buffer leak start 241156096 len 16384 refs 1
bflags 529 owner 458
[ 1520.875578] BTRFS: buffer leak start 240517120 len 16384 refs 1
bflags 529 owner 383
[ 1520.876540] BTRFS: buffer leak start 232964096 len 16384 refs 1
bflags 529 owner 329
[ 1520.877509] BTRFS: buffer leak start 229867520 len 16384 refs 1
bflags 529 owner 382
[ 1520.878485] BTRFS: buffer leak start 203472896 len 16384 refs 1
bflags 529 owner 289
[ 1520.879606] BTRFS: buffer leak start 197148672 len 16384 refs 1
bflags 529 owner 435
[ 1520.880861] BTRFS: buffer leak start 190791680 len 16384 refs 1
bflags 529 owner 408
[ 1520.882433] BTRFS: buffer leak start 187875328 len 16384 refs 1
bflags 529 owner 325
[ 1520.883878] BTRFS: buffer leak start 186761216 len 16384 refs 1
bflags 529 owner 316
[ 1520.885201] BTRFS: buffer leak start 181272576 len 16384 refs 1
bflags 529 owner 423
[ 1520.886550] BTRFS: buffer leak start 176816128 len 16384 refs 1
bflags 529 owner 394
[ 1520.887882] BTRFS: buffer leak start 164495360 len 16384 refs 1
bflags 529 owner 410
[ 1520.889217] BTRFS: buffer leak start 158760960 len 16384 refs 1
bflags 529 owner 338
[ 1520.890555] BTRFS: buffer leak start 156450816 len 16384 refs 1
bflags 529 owner 404
[ 1520.891885] BTRFS: buffer leak start 146800640 len 16384 refs 1
bflags 529 owner 346
[ 1520.893217] BTRFS: buffer leak start 138182656 len 16384 refs 1
bflags 529 owner 319
[ 1520.894561] BTRFS: buffer leak start 135806976 len 16384 refs 1
bflags 529 owner 296
[ 1520.895871] BTRFS: buffer leak start 128712704 len 16384 refs 1
bflags 529 owner 276
[ 1520.896835] BTRFS: buffer leak start 121749504 len 16384 refs 1
bflags 529 owner 337
[ 1520.898165] BTRFS: buffer leak start 118210560 len 16384 refs 1
bflags 529 owner 372
[ 1520.899487] BTRFS: buffer leak start 118177792 len 16384 refs 1
bflags 529 owner 361
[ 1520.900801] BTRFS: buffer leak start 113491968 len 16384 refs 1
bflags 529 owner 303
[ 1520.902223] BTRFS: buffer leak start 110854144 len 16384 refs 1
bflags 529 owner 342
[ 1520.903566] BTRFS: buffer leak start 110411776 len 16384 refs 1
bflags 529 owner 335
[ 1520.904808] BTRFS: buffer leak start 104431616 len 16384 refs 1
bflags 529 owner 351
[ 1520.906074] BTRFS: buffer leak start 100270080 len 16384 refs 1
bflags 529 owner 334
[ 1520.907392] BTRFS: buffer leak start 97697792 len 16384 refs 1
bflags 529 owner 330
[ 1520.908697] BTRFS: buffer leak start 92979200 len 16384 refs 1
bflags 529 owner 345
[ 1520.910017] BTRFS: buffer leak start 86884352 len 16384 refs 1
bflags 529 owner 332
[ 1520.911326] BTRFS: buffer leak start 83623936 len 16384 refs 1
bflags 529 owner 261
[ 1520.912506] BTRFS: buffer leak start 73629696 len 16384 refs 1
bflags 529 owner 321
[ 1520.913456] BTRFS: buffer leak start 69533696 len 16384 refs 1
bflags 529 owner 307
[ 1520.914413] BTRFS: buffer leak start 62930944 len 16384 refs 1
bflags 529 owner 306
[ 1520.915383] BTRFS: buffer leak start 60719104 len 16384 refs 1
bflags 529 owner 302
[ 1520.916327] BTRFS: buffer leak start 60702720 len 16384 refs 1
bflags 529 owner 292
[ 1520.917269] BTRFS: buffer leak start 59228160 len 16384 refs 1
bflags 529 owner 298
[ 1520.918223] BTRFS: buffer leak start 56229888 len 16384 refs 1
bflags 529 owner 271
[ 1520.919251] BTRFS: buffer leak start 47349760 len 16384 refs 1
bflags 529 owner 265
[ 1520.920554] BTRFS: buffer leak start 44597248 len 16384 refs 1
bflags 529 owner 269
[ 1520.921860] BTRFS: buffer leak start 38846464 len 16384 refs 1
bflags 529 owner 267

A git bisection reliably points to this patch.
I haven't checked the patch in detail to see where the leak is.

Thanks.



> ---
>  fs/btrfs/ctree.h |   5 +-
>  fs/btrfs/inode.c | 284 +++++++++++++++++++++++++----------------------
>  fs/btrfs/ioctl.c |  22 ++--
>  3 files changed, 167 insertions(+), 144 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db17bd05a21..f39730420e8a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3254,10 +3254,11 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_in=
fo *fs_info, long nr,
>  int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 =
end,
>                               unsigned int extra_bits,
>                               struct extent_state **cached_state);
> +struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
> +                                    struct inode *dir);
>  int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
> -                            struct btrfs_root *new_root,
>                              struct btrfs_root *parent_root,
> -                            struct user_namespace *mnt_userns);
> +                            struct inode *inode);
>   void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state=
 *state,
>                                unsigned *bits);
>  void btrfs_clear_delalloc_extent(struct inode *inode,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c47bdada2440..ff780256c936 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6090,15 +6090,12 @@ static void btrfs_inherit_iflags(struct inode *in=
ode, struct inode *dir)
>         btrfs_sync_inode_flags_to_i_flags(inode);
>  }
>
> -static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> -                                    struct btrfs_root *root,
> -                                    struct user_namespace *mnt_userns,
> -                                    struct inode *dir,
> -                                    const char *name, int name_len,
> -                                    umode_t mode, u64 *index)
> +static int btrfs_new_inode(struct btrfs_trans_handle *trans,
> +                          struct btrfs_root *root, struct inode *inode,
> +                          struct inode *dir, const char *name, int name_=
len,
> +                          u64 *index)
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> -       struct inode *inode;
>         struct btrfs_inode_item *inode_item;
>         struct btrfs_key *location;
>         struct btrfs_path *path;
> @@ -6108,20 +6105,11 @@ static struct inode *btrfs_new_inode(struct btrfs=
_trans_handle *trans,
>         u32 sizes[2];
>         struct btrfs_item_batch batch;
>         unsigned long ptr;
> -       unsigned int nofs_flag;
>         int ret;
>
>         path =3D btrfs_alloc_path();
>         if (!path)
> -               return ERR_PTR(-ENOMEM);
> -
> -       nofs_flag =3D memalloc_nofs_save();
> -       inode =3D new_inode(fs_info->sb);
> -       memalloc_nofs_restore(nofs_flag);
> -       if (!inode) {
> -               btrfs_free_path(path);
> -               return ERR_PTR(-ENOMEM);
> -       }
> +               return -ENOMEM;
>
>         /*
>          * O_TMPFILE, set link count to 0, so that after this point,
> @@ -6133,8 +6121,7 @@ static struct inode *btrfs_new_inode(struct btrfs_t=
rans_handle *trans,
>         ret =3D btrfs_get_free_objectid(root, &objectid);
>         if (ret) {
>                 btrfs_free_path(path);
> -               iput(inode);
> -               return ERR_PTR(ret);
> +               return ret;
>         }
>         inode->i_ino =3D objectid;
>
> @@ -6144,8 +6131,7 @@ static struct inode *btrfs_new_inode(struct btrfs_t=
rans_handle *trans,
>                 ret =3D btrfs_set_inode_index(BTRFS_I(dir), index);
>                 if (ret) {
>                         btrfs_free_path(path);
> -                       iput(inode);
> -                       return ERR_PTR(ret);
> +                       return ret;
>                 }
>         } else if (dir) {
>                 *index =3D 0;
> @@ -6163,7 +6149,7 @@ static struct inode *btrfs_new_inode(struct btrfs_t=
rans_handle *trans,
>
>         btrfs_inherit_iflags(inode, dir);
>
> -       if (S_ISREG(mode)) {
> +       if (S_ISREG(inode->i_mode)) {
>                 if (btrfs_test_opt(fs_info, NODATASUM))
>                         BTRFS_I(inode)->flags |=3D BTRFS_INODE_NODATASUM;
>                 if (btrfs_test_opt(fs_info, NODATACOW))
> @@ -6208,10 +6194,8 @@ static struct inode *btrfs_new_inode(struct btrfs_=
trans_handle *trans,
>         location->type =3D BTRFS_INODE_ITEM_KEY;
>
>         ret =3D btrfs_insert_inode_locked(inode);
> -       if (ret < 0) {
> -               iput(inode);
> +       if (ret < 0)
>                 goto fail;
> -       }
>
>         batch.keys =3D &key[0];
>         batch.data_sizes =3D &sizes[0];
> @@ -6221,8 +6205,6 @@ static struct inode *btrfs_new_inode(struct btrfs_t=
rans_handle *trans,
>         if (ret !=3D 0)
>                 goto fail_unlock;
>
> -       inode_init_owner(mnt_userns, inode, dir, mode);
> -
>         inode->i_mtime =3D current_time(inode);
>         inode->i_atime =3D inode->i_mtime;
>         inode->i_ctime =3D inode->i_mtime;
> @@ -6259,15 +6241,20 @@ static struct inode *btrfs_new_inode(struct btrfs=
_trans_handle *trans,
>                           "error inheriting props for ino %llu (root %llu=
): %d",
>                         btrfs_ino(BTRFS_I(inode)), root->root_key.objecti=
d, ret);
>
> -       return inode;
> +       return 0;
>
>  fail_unlock:
> +       /*
> +        * discard_new_inode() calls iput(), but the caller owns the refe=
rence
> +        * to the inode.
> +        */
> +       ihold(inode);
>         discard_new_inode(inode);
>  fail:
>         if (dir && name)
>                 BTRFS_I(dir)->index_cnt--;
>         btrfs_free_path(path);
> -       return ERR_PTR(ret);
> +       return ret;
>  }
>
>  /*
> @@ -6365,37 +6352,36 @@ static int btrfs_mknod(struct user_namespace *mnt=
_userns, struct inode *dir,
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(dir->i_sb);
>         struct btrfs_trans_handle *trans;
>         struct btrfs_root *root =3D BTRFS_I(dir)->root;
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         int err;
>         u64 index =3D 0;
>
> +       inode =3D new_inode(dir->i_sb);
> +       if (!inode)
> +               return -ENOMEM;
> +       inode_init_owner(mnt_userns, inode, dir, mode);
> +       inode->i_op =3D &btrfs_special_inode_operations;
> +       init_special_inode(inode, inode->i_mode, rdev);
> +
>         /*
>          * 2 for inode item and ref
>          * 2 for dir items
>          * 1 for xattr if selinux is on
>          */
>         trans =3D btrfs_start_transaction(root, 5);
> -       if (IS_ERR(trans))
> +       if (IS_ERR(trans)) {
> +               iput(inode);
>                 return PTR_ERR(trans);
> +       }
>
> -       inode =3D btrfs_new_inode(trans, root, mnt_userns, dir,
> -                       dentry->d_name.name, dentry->d_name.len,
> -                       mode, &index);
> -       if (IS_ERR(inode)) {
> -               err =3D PTR_ERR(inode);
> +       err =3D btrfs_new_inode(trans, root, inode, dir, dentry->d_name.n=
ame,
> +                             dentry->d_name.len, &index);
> +       if (err) {
> +               iput(inode);
>                 inode =3D NULL;
>                 goto out_unlock;
>         }
>
> -       /*
> -       * If the active LSM wants to access the inode during
> -       * d_instantiate it needs these. Smack checks to see
> -       * if the filesystem supports xattrs by looking at the
> -       * ops vector.
> -       */
> -       inode->i_op =3D &btrfs_special_inode_operations;
> -       init_special_inode(inode, inode->i_mode, rdev);
> -
>         err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_n=
ame);
>         if (err)
>                 goto out_unlock;
> @@ -6424,36 +6410,36 @@ static int btrfs_create(struct user_namespace *mn=
t_userns, struct inode *dir,
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(dir->i_sb);
>         struct btrfs_trans_handle *trans;
>         struct btrfs_root *root =3D BTRFS_I(dir)->root;
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         int err;
>         u64 index =3D 0;
>
> +       inode =3D new_inode(dir->i_sb);
> +       if (!inode)
> +               return -ENOMEM;
> +       inode_init_owner(mnt_userns, inode, dir, mode);
> +       inode->i_fop =3D &btrfs_file_operations;
> +       inode->i_op =3D &btrfs_file_inode_operations;
> +       inode->i_mapping->a_ops =3D &btrfs_aops;
> +
>         /*
>          * 2 for inode item and ref
>          * 2 for dir items
>          * 1 for xattr if selinux is on
>          */
>         trans =3D btrfs_start_transaction(root, 5);
> -       if (IS_ERR(trans))
> +       if (IS_ERR(trans)) {
> +               iput(inode);
>                 return PTR_ERR(trans);
> +       }
>
> -       inode =3D btrfs_new_inode(trans, root, mnt_userns, dir,
> -                       dentry->d_name.name, dentry->d_name.len,
> -                       mode, &index);
> -       if (IS_ERR(inode)) {
> -               err =3D PTR_ERR(inode);
> +       err =3D btrfs_new_inode(trans, root, inode, dir, dentry->d_name.n=
ame,
> +                             dentry->d_name.len, &index);
> +       if (err) {
> +               iput(inode);
>                 inode =3D NULL;
>                 goto out_unlock;
>         }
> -       /*
> -       * If the active LSM wants to access the inode during
> -       * d_instantiate it needs these. Smack checks to see
> -       * if the filesystem supports xattrs by looking at the
> -       * ops vector.
> -       */
> -       inode->i_fop =3D &btrfs_file_operations;
> -       inode->i_op =3D &btrfs_file_inode_operations;
> -       inode->i_mapping->a_ops =3D &btrfs_aops;
>
>         err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_n=
ame);
>         if (err)
> @@ -6562,34 +6548,38 @@ static int btrfs_mkdir(struct user_namespace *mnt=
_userns, struct inode *dir,
>                        struct dentry *dentry, umode_t mode)
>  {
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(dir->i_sb);
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         struct btrfs_trans_handle *trans;
>         struct btrfs_root *root =3D BTRFS_I(dir)->root;
> -       int err =3D 0;
> +       int err;
>         u64 index =3D 0;
>
> +       inode =3D new_inode(dir->i_sb);
> +       if (!inode)
> +               return -ENOMEM;
> +       inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
> +       inode->i_op =3D &btrfs_dir_inode_operations;
> +       inode->i_fop =3D &btrfs_dir_file_operations;
> +
>         /*
>          * 2 items for inode and ref
>          * 2 items for dir items
>          * 1 for xattr if selinux is on
>          */
>         trans =3D btrfs_start_transaction(root, 5);
> -       if (IS_ERR(trans))
> +       if (IS_ERR(trans)) {
> +               iput(inode);
>                 return PTR_ERR(trans);
> +       }
>
> -       inode =3D btrfs_new_inode(trans, root, mnt_userns, dir,
> -                       dentry->d_name.name, dentry->d_name.len,
> -                       S_IFDIR | mode, &index);
> -       if (IS_ERR(inode)) {
> -               err =3D PTR_ERR(inode);
> +       err =3D btrfs_new_inode(trans, root, inode, dir, dentry->d_name.n=
ame,
> +                             dentry->d_name.len, &index);
> +       if (err) {
> +               iput(inode);
>                 inode =3D NULL;
>                 goto out_fail;
>         }
>
> -       /* these must be set before we unlock the inode */
> -       inode->i_op =3D &btrfs_dir_inode_operations;
> -       inode->i_fop =3D &btrfs_dir_file_operations;
> -
>         err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_n=
ame);
>         if (err)
>                 goto out_fail;
> @@ -8747,25 +8737,39 @@ static int btrfs_truncate(struct inode *inode, bo=
ol skip_writeback)
>         return ret;
>  }
>
> +struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
> +                                    struct inode *dir)
> +{
> +       struct inode *inode;
> +
> +       inode =3D new_inode(dir->i_sb);
> +       if (inode) {
> +               /*
> +                * Subvolumes don't inherit the sgid bit or the parent's =
gid if
> +                * the parent's sgid bit is set. This is probably a bug.
> +                */
> +               inode_init_owner(mnt_userns, inode, NULL,
> +                                S_IFDIR | (~current_umask() & S_IRWXUGO)=
);
> +               inode->i_op =3D &btrfs_dir_inode_operations;
> +               inode->i_fop =3D &btrfs_dir_file_operations;
> +       }
> +       return inode;
> +}
> +
>  /*
>   * create a new subvolume directory/inode (helper for the ioctl).
>   */
>  int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
> -                            struct btrfs_root *new_root,
>                              struct btrfs_root *parent_root,
> -                            struct user_namespace *mnt_userns)
> +                            struct inode *inode)
>  {
> -       struct inode *inode;
> +       struct btrfs_root *new_root =3D BTRFS_I(inode)->root;
>         int err;
>         u64 index =3D 0;
>
> -       inode =3D btrfs_new_inode(trans, new_root, mnt_userns, NULL, ".."=
, 2,
> -                               S_IFDIR | (~current_umask() & S_IRWXUGO),
> -                               &index);
> -       if (IS_ERR(inode))
> -               return PTR_ERR(inode);
> -       inode->i_op =3D &btrfs_dir_inode_operations;
> -       inode->i_fop =3D &btrfs_dir_file_operations;
> +       err =3D btrfs_new_inode(trans, new_root, inode, NULL, "..", 2, &i=
ndex);
> +       if (err)
> +               return err;
>
>         unlock_new_inode(inode);
>
> @@ -8776,8 +8780,6 @@ int btrfs_create_subvol_root(struct btrfs_trans_han=
dle *trans,
>                           new_root->root_key.objectid, err);
>
>         err =3D btrfs_update_inode(trans, new_root, BTRFS_I(inode));
> -
> -       iput(inode);
>         return err;
>  }
>
> @@ -9254,31 +9256,36 @@ static int btrfs_rename_exchange(struct inode *ol=
d_dir,
>         return ret;
>  }
>
> +static struct inode *new_whiteout_inode(struct user_namespace *mnt_usern=
s,
> +                                       struct inode *dir)
> +{
> +       struct inode *inode;
> +
> +       inode =3D new_inode(dir->i_sb);
> +       if (inode) {
> +               inode_init_owner(mnt_userns, inode, dir,
> +                                S_IFCHR | WHITEOUT_MODE);
> +               inode->i_op =3D &btrfs_special_inode_operations;
> +               init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
> +       }
> +       return inode;
> +}
> +
>  static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
>                                      struct btrfs_root *root,
> -                                    struct user_namespace *mnt_userns,
> -                                    struct inode *dir,
> +                                    struct inode *inode, struct inode *d=
ir,
>                                      struct dentry *dentry)
>  {
>         int ret;
> -       struct inode *inode;
>         u64 index;
>
> -       inode =3D btrfs_new_inode(trans, root, mnt_userns, dir,
> -                               dentry->d_name.name,
> -                               dentry->d_name.len,
> -                               S_IFCHR | WHITEOUT_MODE,
> -                               &index);
> -
> -       if (IS_ERR(inode)) {
> -               ret =3D PTR_ERR(inode);
> +       ret =3D btrfs_new_inode(trans, root, inode, dir, dentry->d_name.n=
ame,
> +                             dentry->d_name.len, &index);
> +       if (ret) {
> +               iput(inode);
>                 return ret;
>         }
>
> -       inode->i_op =3D &btrfs_special_inode_operations;
> -       init_special_inode(inode, inode->i_mode,
> -               WHITEOUT_DEV);
> -
>         ret =3D btrfs_init_inode_security(trans, inode, dir,
>                                 &dentry->d_name);
>         if (ret)
> @@ -9305,6 +9312,7 @@ static int btrfs_rename(struct user_namespace *mnt_=
userns,
>                         unsigned int flags)
>  {
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(old_dir->i_sb);
> +       struct inode *whiteout_inode;
>         struct btrfs_trans_handle *trans;
>         unsigned int trans_num_items;
>         struct btrfs_root *root =3D BTRFS_I(old_dir)->root;
> @@ -9359,6 +9367,12 @@ static int btrfs_rename(struct user_namespace *mnt=
_userns,
>         if (new_inode && S_ISREG(old_inode->i_mode) && new_inode->i_size)
>                 filemap_flush(old_inode->i_mapping);
>
> +       if (flags & RENAME_WHITEOUT) {
> +               whiteout_inode =3D new_whiteout_inode(mnt_userns, old_dir=
);
> +               if (!whiteout_inode)
> +                       return -ENOMEM;
> +       }
> +
>         if (old_ino =3D=3D BTRFS_FIRST_FREE_OBJECTID) {
>                 /* close the racy window with snapshot create/destroy ioc=
tl */
>                 down_read(&fs_info->subvol_sem);
> @@ -9495,9 +9509,9 @@ static int btrfs_rename(struct user_namespace *mnt_=
userns,
>                                    rename_ctx.index, new_dentry->d_parent=
);
>
>         if (flags & RENAME_WHITEOUT) {
> -               ret =3D btrfs_whiteout_for_rename(trans, root, mnt_userns=
,
> +               ret =3D btrfs_whiteout_for_rename(trans, root, whiteout_i=
node,
>                                                 old_dir, old_dentry);
> -
> +               whiteout_inode =3D NULL;
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
>                         goto out_fail;
> @@ -9509,7 +9523,8 @@ static int btrfs_rename(struct user_namespace *mnt_=
userns,
>  out_notrans:
>         if (old_ino =3D=3D BTRFS_FIRST_FREE_OBJECTID)
>                 up_read(&fs_info->subvol_sem);
> -
> +       if (flags & RENAME_WHITEOUT)
> +               iput(whiteout_inode);
>         return ret;
>  }
>
> @@ -9728,7 +9743,7 @@ static int btrfs_symlink(struct user_namespace *mnt=
_userns, struct inode *dir,
>         struct btrfs_root *root =3D BTRFS_I(dir)->root;
>         struct btrfs_path *path;
>         struct btrfs_key key;
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         int err;
>         u64 index =3D 0;
>         int name_len;
> @@ -9741,6 +9756,14 @@ static int btrfs_symlink(struct user_namespace *mn=
t_userns, struct inode *dir,
>         if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
>                 return -ENAMETOOLONG;
>
> +       inode =3D new_inode(dir->i_sb);
> +       if (!inode)
> +               return -ENOMEM;
> +       inode_init_owner(mnt_userns, inode, dir, S_IFLNK | S_IRWXUGO);
> +       inode->i_op =3D &btrfs_symlink_inode_operations;
> +       inode_nohighmem(inode);
> +       inode->i_mapping->a_ops =3D &btrfs_aops;
> +
>         /*
>          * 2 items for inode item and ref
>          * 2 items for dir items
> @@ -9749,28 +9772,19 @@ static int btrfs_symlink(struct user_namespace *m=
nt_userns, struct inode *dir,
>          * 1 item for xattr if selinux is on
>          */
>         trans =3D btrfs_start_transaction(root, 7);
> -       if (IS_ERR(trans))
> +       if (IS_ERR(trans)) {
> +               iput(inode);
>                 return PTR_ERR(trans);
> +       }
>
> -       inode =3D btrfs_new_inode(trans, root, mnt_userns, dir,
> -                               dentry->d_name.name, dentry->d_name.len,
> -                               S_IFLNK | S_IRWXUGO, &index);
> -       if (IS_ERR(inode)) {
> -               err =3D PTR_ERR(inode);
> +       err =3D btrfs_new_inode(trans, root, inode, dir, dentry->d_name.n=
ame,
> +                             dentry->d_name.len, &index);
> +       if (err) {
> +               iput(inode);
>                 inode =3D NULL;
>                 goto out_unlock;
>         }
>
> -       /*
> -       * If the active LSM wants to access the inode during
> -       * d_instantiate it needs these. Smack checks to see
> -       * if the filesystem supports xattrs by looking at the
> -       * ops vector.
> -       */
> -       inode->i_fop =3D &btrfs_file_operations;
> -       inode->i_op =3D &btrfs_file_inode_operations;
> -       inode->i_mapping->a_ops =3D &btrfs_aops;
> -
>         err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_n=
ame);
>         if (err)
>                 goto out_unlock;
> @@ -9806,8 +9820,6 @@ static int btrfs_symlink(struct user_namespace *mnt=
_userns, struct inode *dir,
>         btrfs_mark_buffer_dirty(leaf);
>         btrfs_free_path(path);
>
> -       inode->i_op =3D &btrfs_symlink_inode_operations;
> -       inode_nohighmem(inode);
>         inode_set_bytes(inode, name_len);
>         btrfs_i_size_write(BTRFS_I(inode), name_len);
>         err =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
> @@ -10087,30 +10099,34 @@ static int btrfs_tmpfile(struct user_namespace =
*mnt_userns, struct inode *dir,
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(dir->i_sb);
>         struct btrfs_trans_handle *trans;
>         struct btrfs_root *root =3D BTRFS_I(dir)->root;
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         u64 index;
> -       int ret =3D 0;
> +       int ret;
> +
> +       inode =3D new_inode(dir->i_sb);
> +       if (!inode)
> +               return -ENOMEM;
> +       inode_init_owner(mnt_userns, inode, dir, mode);
> +       inode->i_fop =3D &btrfs_file_operations;
> +       inode->i_op =3D &btrfs_file_inode_operations;
> +       inode->i_mapping->a_ops =3D &btrfs_aops;
>
>         /*
>          * 5 units required for adding orphan entry
>          */
>         trans =3D btrfs_start_transaction(root, 5);
> -       if (IS_ERR(trans))
> +       if (IS_ERR(trans)) {
> +               iput(inode);
>                 return PTR_ERR(trans);
> +       }
>
> -       inode =3D btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
> -                       mode, &index);
> -       if (IS_ERR(inode)) {
> -               ret =3D PTR_ERR(inode);
> +       ret =3D btrfs_new_inode(trans, root, inode, dir, NULL, 0, &index)=
;
> +       if (ret) {
> +               iput(inode);
>                 inode =3D NULL;
>                 goto out;
>         }
>
> -       inode->i_fop =3D &btrfs_file_operations;
> -       inode->i_op =3D &btrfs_file_inode_operations;
> -
> -       inode->i_mapping->a_ops =3D &btrfs_aops;
> -
>         ret =3D btrfs_init_inode_security(trans, inode, dir, NULL);
>         if (ret)
>                 goto out;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 891352fd6d0f..60c907b14547 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -587,6 +587,12 @@ static noinline int create_subvol(struct user_namesp=
ace *mnt_userns,
>         if (ret < 0)
>                 goto out_root_item;
>
> +       inode =3D btrfs_new_subvol_inode(mnt_userns, dir);
> +       if (!inode) {
> +               ret =3D -ENOMEM;
> +               goto out_anon_dev;
> +       }
> +
>         btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
>         /*
>          * The same as the snapshot creation, please see the comment
> @@ -594,13 +600,13 @@ static noinline int create_subvol(struct user_names=
pace *mnt_userns,
>          */
>         ret =3D btrfs_subvolume_reserve_metadata(root, &block_rsv, 8, fal=
se);
>         if (ret)
> -               goto out_anon_dev;
> +               goto out_inode;
>
>         trans =3D btrfs_start_transaction(root, 0);
>         if (IS_ERR(trans)) {
>                 ret =3D PTR_ERR(trans);
>                 btrfs_subvolume_release_metadata(root, &block_rsv);
> -               goto out_anon_dev;
> +               goto out_inode;
>         }
>         trans->block_rsv =3D &block_rsv;
>         trans->bytes_reserved =3D block_rsv.size;
> @@ -683,16 +689,16 @@ static noinline int create_subvol(struct user_names=
pace *mnt_userns,
>         }
>         /* anon_dev is owned by new_root now. */
>         anon_dev =3D 0;
> +       BTRFS_I(inode)->root =3D new_root;
> +       /* ... and new_root is owned by inode now. */
>
>         ret =3D btrfs_record_root_in_trans(trans, new_root);
>         if (ret) {
> -               btrfs_put_root(new_root);
>                 btrfs_abort_transaction(trans, ret);
>                 goto out;
>         }
>
> -       ret =3D btrfs_create_subvol_root(trans, new_root, root, mnt_usern=
s);
> -       btrfs_put_root(new_root);
> +       ret =3D btrfs_create_subvol_root(trans, root, inode);
>         if (ret) {
>                 /* We potentially lose an unused inode item here */
>                 btrfs_abort_transaction(trans, ret);
> @@ -745,11 +751,11 @@ static noinline int create_subvol(struct user_names=
pace *mnt_userns,
>                 ret =3D btrfs_commit_transaction(trans);
>
>         if (!ret) {
> -               inode =3D btrfs_lookup_dentry(dir, dentry);
> -               if (IS_ERR(inode))
> -                       return PTR_ERR(inode);
>                 d_instantiate(dentry, inode);
> +               inode =3D NULL;
>         }
> +out_inode:
> +       iput(inode);
>  out_anon_dev:
>         if (anon_dev)
>                 free_anon_bdev(anon_dev);
> --
> 2.35.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

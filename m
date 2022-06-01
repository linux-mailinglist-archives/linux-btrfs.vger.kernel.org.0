Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4040353AC6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356559AbiFASA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356558AbiFASA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 14:00:56 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AE9CC9C
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 11:00:55 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 2so2534830iou.5
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z++FcfyL89hUQBg3NNn/kBGnI46WtPi/uokIeaDsASU=;
        b=jx6IgOkj5fs2hJCUG+VkWN18aoR9kGKJCRxRMIt0JFeRZE3Mlftg5zqmeOWjXNHuDa
         yzHjUXxZnFBiHi94cWOkQ/va2ID8XUH+Zwy23h9NhZ7ePxJNIOXVQSI079JqlP6U+4lM
         RfC6qQrEvIb1jTbEQ6AX+P5kBBds3A/L7B04bbw19E7U9CWHkOMEkKKPBTSFIYpdiEQN
         EDzylUJxW+cN/Irtq0QeqfQNvbyFS4NknQtfOmD6o1RTS8KA+AgpmGIIo4I+Z3zKhXm3
         lcCzQBToO0MDyROsjt/GAcIQyBJfiKJPZVNRfteYPwZedTYG5bkXefJCCAM9A+wZHILN
         SaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z++FcfyL89hUQBg3NNn/kBGnI46WtPi/uokIeaDsASU=;
        b=hseLZbtdRF4LFasqIn8jViTyJPs13yHQ1DWLDJxmqlU9D5OUvj/3MA70PWb1THS2Eq
         Dqxba13neTZYEVx4A93tlALJXlwNZOs74BpAi++z7wTDl2gDJas5mvuZMMzsmZYxtrbs
         E1ey1omDINZgRRRq8mSIN+amfHsI/6FEwLH14AlXiiwz1Tg2Jnlhqtq4Ouk2JfgRzUOI
         BYQP1e9jdl2sKqJSqte92Y4GQIMUn6plR1ZnEqk97ZhLeBXCnxJSDhocpZ/j3lrtDnFg
         MAQJVSb5wXpO4CDas3PiPgCOH/QDqjH53+I4FTk35D6rXGswUEMYyg4Y35ki6c+TX797
         Vxpg==
X-Gm-Message-State: AOAM533OdlsW6DjTOWfGxsrcwZiuj1o7kQPW6U4SHNKzq2psyIydi9+i
        GiKuaHDZAjdPkk2poL3kzRI6iuxBjIqog9K+yw1AY8Q/AFQ=
X-Google-Smtp-Source: ABdhPJx2XYELwbT0byD4eg8/E+alYX0qZ7qAaN+rfNRNfiTsdAJaMR0FsoDPSxCDShGT1JGymODTag462C0zeNdqek0=
X-Received: by 2002:a6b:c9d6:0:b0:668:ee98:a835 with SMTP id
 z205-20020a6bc9d6000000b00668ee98a835mr664211iof.10.1654106454471; Wed, 01
 Jun 2022 11:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220531011224.GA1745079@merlins.org> <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org> <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org> <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org> <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org> <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org>
In-Reply-To: <20220601163924.GE1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 14:00:43 -0400
Message-ID: <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 1, 2022 at 12:39 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 09:56:14AM -0400, Josef Bacik wrote:
> > Sigh, try again please.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> scanning, best has 0 found 1 bad
> ret is 0 offset 20971520 len 8388608
> ret is -2 offset 20971520 len 8388608
> checking block 22495232 generation 1572124 fs info generation 2582703
> trying bytenr 22495232 got 1 blocks 0 bad
> checking block 22462464 generation 1479229 fs info generation 2582703
> trying bytenr 22462464 got 1 blocks 0 bad
> checking block 22528000 generation 1572115 fs info generation 2582703
> trying bytenr 22528000 got 1 blocks 0 bad
> checking block 22446080 generation 1571791 fs info generation 2582703
> trying bytenr 22446080 got 1 blocks 0 bad
> checking block 22544384 generation 1556078 fs info generation 2582703
> trying bytenr 22544384 got 1 blocks 0 bad
> checking block 22511616 generation 1555799 fs info generation 2582703
> trying bytenr 22511616 got 1 blocks 0 bad
> checking block 22577152 generation 1586277 fs info generation 2582703
> trying bytenr 22577152 got 1 blocks 0 bad
> checking block 22478848 generation 1561557 fs info generation 2582703
> trying bytenr 22478848 got 1 blocks 0 bad
> checking block 22593536 generation 1590219 fs info generation 2582703
> trying bytenr 22593536 got 1 blocks 0 bad
> checking block 22609920 generation 1551635 fs info generation 2582703
> trying bytenr 22609920 got 1 blocks 0 bad
> checking block 22560768 generation 1590217 fs info generation 2582703
> trying bytenr 22560768 got 1 blocks 0 bad
> ret is 0 offset 20971520 len 8388608
> ret is -2 offset 20971520 len 8388608
> setting chunk root to 22593536

Ok perfect, now try btrfs rescue recover-chunks <device>, thanks,

Josef

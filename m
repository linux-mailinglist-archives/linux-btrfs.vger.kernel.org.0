Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF3517A92
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 01:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiEBXUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiEBXUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 19:20:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A72286E6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 16:16:26 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e194so17466607iof.11
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9Tfp/rdpEx0RlpBkBRnDiY2uZjzynE5Ei1JjckN0vI=;
        b=sJVI66wEf+oX9XDcGao5NfIlOhXjikn3INI9JYvwoLIDppiwQaM2/7cWs2AQT13Ele
         S0Ve+X78GCNn25zsAPfVUpmsyHFxFrHJNCAN1yKLgVpo692R0ejCgX9PFR78HOjRrCk1
         IumYnddZh6H8Q/iUs61zmuK63bQVOGD+ta/5m41I17GWPxwsEV/Am21F40RdDHcoAFgR
         n8qvG7qgejFdIGP7P72hFjx9fKM5rVyDyv39u3Rbqmy8wGIQ8tAfwnfChizIG8YvaH/u
         TkLsPjP0OPV3iRNyjEplLl4zuRUQPxXZa//M6hZjwqrY2ASOppm/KwI5kdvUhI59tJRx
         /ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9Tfp/rdpEx0RlpBkBRnDiY2uZjzynE5Ei1JjckN0vI=;
        b=l1ZMbgNuU1xA29TzIQvQ0uS/1D1LYv7Xxk+ZskYjAIpD31g/i6lnDYqdutK44/XSE1
         2gdh6DUCFk8Kj5j9+MW72smzT0XopKataT/DFxAClvX0Vyx70TvUHhYwbvSDHIGNjsm4
         e8okQloUKr2UpexUfyfpbUia1qbdNbzNkuAqTw9jbxhbAiIws7XEJvkhx2uB+6hy7uvz
         gxzlrCaN/YCzK/3QNwQqF0Jgc3yBzAf7sIO2ckEDShaUSoCa9i3GcWk9EF8vSUxYeFXg
         834P+gAT6c5NRpOtObdGkNBYLl+WwxSTdMPMMaXzdATOeiablKkQ2sP+x38LnaCB3PGQ
         ekqA==
X-Gm-Message-State: AOAM531ELyVEVwK5gQF7SJ19VOL8bUKHiovYRQzQecBZAHi04HrlpsgB
        9Jnt3MUdmE+svZllPjx7uCUYYZB2OMtX61JR4RfHkd4JL0xZuQ==
X-Google-Smtp-Source: ABdhPJxoHZEatg4vMkQNue8rXkNehLgmfNyCM0/U8tKyI6a3e1+gf+dmlXy8SbNykFTxuTkyUdnrQzlHaLSsVi1kEsA=
X-Received: by 2002:a05:6602:2c4b:b0:65a:7a65:8037 with SMTP id
 x11-20020a0566022c4b00b0065a7a658037mr1765379iov.134.1651533385738; Mon, 02
 May 2022 16:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220501045456.GL12542@merlins.org> <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org> <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org> <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org> <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org> <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org>
In-Reply-To: <20220502214916.GB29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 2 May 2022 16:16:14 -0700
Message-ID: <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
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

On Mon, May 2, 2022 at 2:49 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 02, 2022 at 05:03:40PM -0400, Josef Bacik wrote:
> > Ok I've fixed it to yell about what file has this weird extent so you
> > can delete it and we can carry on.  Thanks,
>
> That worked.  How do I delete this one?
>
> doing roots
> Recording extents for root 4
> processed 1032192 of 1064960 possible bytes
> Recording extents for root 5
> processed 10960896 of 10977280 possible bytes
> Recording extents for root 7
> processed 16384 of 16545742848 possible bytes
> Recording extents for root 9
> processed 16384 of 16384 possible bytes
> Recording extents for root 11221
> processed 16384 of 255983616 possible bytes
> Recording extents for root 11222
> processed 49479680 of 49479680 possible bytes
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819130,108,0 on root 11223

btrfs-corrupt-block -d "1819130,108,0" -r 11223 <device>

Thanks,

Josef

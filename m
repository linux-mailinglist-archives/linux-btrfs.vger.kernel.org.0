Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F6512779
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiD0XZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiD0XZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 19:25:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5705118B
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:22:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so4827388iov.10
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PSWnW6RdAv3DwRP7Jm9wPIfziTzYzdl+WmrFEgc/yk=;
        b=JpZ7pVpHPk5RbozIr7aOvb88QJJvbigo/Vn8oiEPqe0k6DDJZMLOQzfkFNZntxA4T4
         lkXYP+VOv9ab7ksODEwKowQ6SGwIBIT0+uLM9MBsFDUQNWMmtNS1ogC0paseYt+KO/vy
         J2oVquxYDhWz53axg2E0ldT2/cBUzbAz62Uj5xPb5qBXvSn5PHcvAzx8/2T7j2zgLl1o
         ECi8wEMpmfX2n9qxTNgdlA+BKs3tRbxAgV47sKcyzpiwkvu98wjHK5T1gEVH7lynnl3+
         ULHVuMfL2tqwkVohOIIC6UlmiGfGoEbCp8zL7682/ZduggCrNahEJxTwvqmesFnXAHbB
         E5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PSWnW6RdAv3DwRP7Jm9wPIfziTzYzdl+WmrFEgc/yk=;
        b=t6CVCqED0x6tmnHAOrO8nFHhHdBklsBH2v/cfIyuIK5nDKUoLdFoNie5S+NaVnWI73
         i6akwbiLbn8gnCqilBWWKRUfNHalDyUtri/KUjpYeuG+y2SRVbTqfLKNUYu87j9ez8nN
         M3zFlAdKZkqDH2GRQgnA+2YDiBAKjEdV2qK49neaWq/0iFn6zRV8P9chdYp8ucnhNe9q
         oQH1ijabtM2nRYQFSzehQHycsj2JkZBvagoO7fkFb/oLpmc46j1j5z6dNcvjTDZHZgo4
         6MWFefXUsJGMTqYZSYlIOx+ZOwU718DO9X2MigN86Dtmo0nTYnRPj08IbZxVYzPzKHei
         2i3w==
X-Gm-Message-State: AOAM531ryb078XtTTuQmGrI2tgxHk5cdsGVQxN78eOSOs7zF553IHbLx
        e9ANERJNJ/eNZZ4/lz8SPe+y4WpkcqLI7Ts1Yloobsv+Wg4=
X-Google-Smtp-Source: ABdhPJzlO0lK67C4Mh1RCBB+Y+XH7nt7s8YpAPLLKwJhucddEPbtANdL6oF25eCtSTpvG2TJbZrpnT8fF1790ayL5DQ=
X-Received: by 2002:a05:6602:14ce:b0:657:2bbc:ade8 with SMTP id
 b14-20020a05660214ce00b006572bbcade8mr12677374iow.83.1651101722671; Wed, 27
 Apr 2022 16:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220427035451.GM29107@merlins.org> <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org> <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org> <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org> <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org> <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org> <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
In-Reply-To: <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 19:21:51 -0400
Message-ID: <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 7:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Apr 27, 2022 at 6:59 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 05:27:44PM -0400, Josef Bacik wrote:
> > > Sigh, added another print_leaf.  Thanks,
> >
> > doing an insert that overlaps our bytenr 7750833627136 262144
> > processed 1146880 of 0 possible bytes
> > processed 1163264 of 0 possible bytes
> > processed 1179648 of 0 possible bytes
> > processed 1196032 of 0 possible bytes
> > processed 1212416 of 0 possible bytes
> > processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> > inode ref info failed???
> > leaf 15645023322112 items 123 free space 55 generation 1546750 owner ROOT_TREE
>
> Ooooh that explains it, it's the free space cache, that's perfect!
> I'll get something wired up and let you know when it's ready.  Thanks,
>

Ok, lets hope for better results this time.  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171A653F1CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 23:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiFFVkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 17:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiFFVj6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 17:39:58 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015E6B486
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 14:39:57 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s1so12915819ilj.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jun 2022 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP4oz2drND7wo1YxRW2WtA5RDhRZ4UhRBZk39uA1YD0=;
        b=EuiUQf/iCHv1VVnDtB1Qzju7ZLCypFZskV0NkfWpfLAlj3pqy2Sd5CzB82bTODBk/7
         HxdxBH6K8NuAmZcQioIZu5oX0smqTtDwGtZUmiFkfEWg9/LbAAUQUvkEMuGGOFsZvYbP
         5ZJ/yPqBVT0husQ0x6TKo5kW/GVE6fv1pVozkSLTN/Le2V6aVc/jaW14zadpY4hazs8g
         PpsNaqpA1W2mOot1Cl45so27iEqbF02huGlfpqZiWISOgW2zLR+2lk8YrgupXwAthzU4
         lOjC44USwqTCWk/WnI8yLRYL1SLjNzpPEpshwDdukOobXUCNsBK4qGLRDwAmB3LiiRjW
         IJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP4oz2drND7wo1YxRW2WtA5RDhRZ4UhRBZk39uA1YD0=;
        b=lsQ7zQtiz2b0FSwvgxtVP6sm0d9TOhm2GrThh5gwfHzqCRUiHMHDd6DRnm8zbw8dq6
         2pzP93dKa3SpAB+2rki1pI63ypJrK4x6vsWdduM3gYI9Km5XJiWhDU+L6rcZSwQMGdC+
         FsoFluWt5fp1rvUMBpbjoShOIPDy+JxZsQ78GZ15LWeGdrPWI/em9TlyZ2XScqC931xJ
         CJtKZJ+iVzaLjDr7TcTWJ9NuJunEWkYykgChq9E24wL83I+1QAHyWODvqHuBkgDEKkaF
         0/aLfBLEluuxzgY3Rn+yjebg8ggDKzrM+gIks1UFtfkE71j44cFa0htC+Z+qXZrAMdzX
         vpRQ==
X-Gm-Message-State: AOAM532hLCsQh6Cu9K2dBHe3n9sh3WngQquRZlAbSVTrmt2IEA/lLXHS
        W0vAqoJTS8hrVeVHxxG/WHTSpbMV05AK/yWIsJpm9NPg6Ls=
X-Google-Smtp-Source: ABdhPJyh7GVuBniG2x6E/ZOUhI6olcHjD0rLIOAH8zzLCTsB1ozKkKZlWWmF3rEfqcNdDMsnS6HvrJuHYkuDwx6NLIM=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr15081274ilo.127.1654551596267; Mon, 06
 Jun 2022 14:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220605212637.GO1745079@merlins.org> <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org> <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org> <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org> <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
 <20220606210855.GL22722@merlins.org> <CAEzrpqe1_vbZ=+3C5=YPDJOCJGLAX9e4cmO_a+F1P3sdg9ubwQ@mail.gmail.com>
 <20220606212301.GM22722@merlins.org>
In-Reply-To: <20220606212301.GM22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 6 Jun 2022 17:39:45 -0400
Message-ID: <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
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

On Mon, Jun 6, 2022 at 5:23 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Jun 06, 2022 at 05:19:40PM -0400, Josef Bacik wrote:
> > Nope different spot, I added some more printf's to narrow down which
> > path is messing up the key order.  Thanks,
>
> processed 49152 of 49463296 possible bytes, 0%
> searching 164623 for bad extents
> processed 311296 of 63193088 possible bytes, 0%
> searching 164624 for bad extents
>
> Found an extent we don't have a block group for in the file
> Flying/Flying Wild Alaska/Flying Wild Alaska - 02x04  Era Alaska Rises Again - 624x352 - 1012kbps - xvid.avi
> push node left from right mid nritems 48 right nritems 0
> setting parent slot 0 to [256 1 0]
> corrupt node: root=164624 root bytenr 15645019684864 commit bytenr 15645019602944 block=15645019717632 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)

Hmm, this sounds like we're not adjusting nritems, but the code
definitely is, so I'm sort of nervous about what's going to be
uncovered here.  Added some more information,

Josef

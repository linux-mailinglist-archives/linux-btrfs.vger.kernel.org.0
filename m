Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35591517BF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 04:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiECClq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiECClp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 22:41:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6FC3633E
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 19:38:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f2so17552420ioh.7
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 19:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2t4igtA4QXtik1IweGxsx8qHXLEtLIz6Dos2puQo9Q=;
        b=TLdvehhCGDFuY+DT+Ojn/jYPp4EGj2iWg7M+ldIKR3vBXW0ahnTUlslp2zukfpnetJ
         XHMPeH0Uw6NZHu7Bei2tNKphY7EgBdo6bYKlZNUgM38PJZUXN57e1jIdZlA24pt7b+Yc
         1sRKk79PxkAZayF1ca2PEZpEN7k+TUQx+js9yt+FcVlQKDboLKamSmNSMkfz5IAUQSOn
         3zfCsuvSnqPUhcA7Tkew7yF1AKU9FnlTQfWSfgq+fqiONVztv6HmZFdeqlCJS/hy4xzo
         zpmSPum4FODWbj+3h/uBxdjL8JD57H4Il1+8ncsE9A/Hiqrs+Lvoqjmdwp00XTGyo3O1
         4utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2t4igtA4QXtik1IweGxsx8qHXLEtLIz6Dos2puQo9Q=;
        b=VQnAc/z6tfgdHwGoOd25VuFDZ8IWHAfs7z0SMkWlvRgXi9I8PT1xUfOheVoMi9KtJZ
         nRjj0W1FcpxYCVavsy4rqYJMoudlURXa0kRRCEOLL6FpmLg3ZIpUIZQGRu5gun4DabzL
         FN7E7e/sd5jvoM8o+2OpXCR44fVOq653WkCN+yXmsVnguGlFK8w72ZtPb2E9Bi2si2fX
         +nIgzwWO+qIryJXnZR4RdzrzvgcLP1mSOlXc6+qnHWPFjRDc0tWqYfYBhr3lzY2ER0Nd
         0Vbobty9ySQhSTQgIKdsG591SmErkPXFaLYMP/r7Z9mySvN68J908L6h+JynegJyVMps
         luNQ==
X-Gm-Message-State: AOAM5329bMPGwgCZ5O/2WmXm/r2vdj969QjbrVOkNyxY/VlI4puziFFc
        NQlqUfeEHdnVaxqRiP8LQXCPYIVvEe5x0OiuiB9N5IyiX1o=
X-Google-Smtp-Source: ABdhPJwDmKlckHeSk8uWNQNEkWpIpyqVkRFmv/dzHwzV14yhWNEkKivoiMZWaEoi/Y5xslh2M2ZkEt95m9eZ7Ap7SgA=
X-Received: by 2002:a05:6602:2c4b:b0:65a:7a65:8037 with SMTP id
 x11-20020a0566022c4b00b0065a7a658037mr2032473iov.134.1651545494257; Mon, 02
 May 2022 19:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220502012528.GA29107@merlins.org> <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org> <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
 <20220502200848.GR12542@merlins.org> <CAEzrpqf2VMEzZxO3k74imXCgXKhG=Nm+=ph=qkNhfJ_G8KFb4g@mail.gmail.com>
 <20220502214916.GB29107@merlins.org> <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org> <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org>
In-Reply-To: <20220503012602.GT12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 2 May 2022 22:38:03 -0400
Message-ID: <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
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

On Mon, May 2, 2022 at 9:26 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 02, 2022 at 09:06:50PM -0400, Josef Bacik wrote:
> > It's a different inode number, 1819131 instead of 1819130.  This is
> > going to be the frustrating delete shit until it works thing again.
>
> Indeed, I missed that.
>
> Now I'm stuck here:
> Recording extents for root 11223
> processed 1619902464 of 1635549184 possible bytesWe're tyring to add a data extent that we don't have a block group for, delete 1819133,108,0 on root 11223
> inode ref info failed???
> elem_cnt 1 elem_missed 0 ret 0
> Xilinx_Unified_2020.1_0602_1208/payload/rdi_0410_2020.1_0602_1208.xz
>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1819133,108,0" -r 11223 /dev/mapper/dshelf1
> FS_INFO IS 0x55ca68c6d600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55ca68c6d600
> parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
> parent transid verify failed on 13576823635968 wanted 1619791 found 1619802
> couldn't find root 11223
>
> Mmmh, that's not great looking....
>

Ugh IDK why that happens every once and a while.  I pushed a fix for
btrfs-corrupt-block, it should work now.  Thanks,

Josef

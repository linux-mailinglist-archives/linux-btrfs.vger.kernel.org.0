Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB91512845
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiD1Ar0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 20:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiD1ArZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 20:47:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA092612E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 17:44:13 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c125so4971972iof.9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7vbULkvD/UUqKpsn1c9LcEjdfNpbOw7mt3DFOn2qj8=;
        b=kzILw7CNroM73AOhqxci5HThfDa1UqZST88ZiQLurEHfbV+0YHpX1l7OJ7HyRjO5gp
         OaQRF3RDwiarqNfjUeVfTJV2hslau/mfzYvoYST5WVQQcu0AIamrcg71hpAuBdq+kY8i
         nxOyFatw2MEoBQmlf3CsfUm9qPN63/W4ml48WhhNio3Jwnz9anKdKD9FDhO2q0h5V2qJ
         yprbwxpFFsHd+qugXt73HqUd1VG67OK4gqGVye9mQBJyzn93xQnxCoFTsHSxfDdYHXEQ
         puezy7A6+Z990QaarWNRI3QppQXhO5waWH6QEbefcshmRGGVS2fNDY8lvLIVEXdgwu4k
         wbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7vbULkvD/UUqKpsn1c9LcEjdfNpbOw7mt3DFOn2qj8=;
        b=oXuVLfGybRvxzYiYN7CkAJxsOOTfCSlJ9nqTr/2fz4fRJ0uOsl+mkEHMYaDkWJjXjf
         rfEsDH13UCOT3xQx7Myk9NHU/zbJl2Q3aIy7/uPrgl/Q0PRRdjgASAM+HlN8JDbWwAy6
         k1hyKk3qzhOWD97FrHm0/kQeNCaDsCUsG0wjFOqtXBj0lGHdYPEHgxCd1EQIX3z4gbeH
         2ye+AIcOtPmn4zdgmis0XbzLBIJl4B5j1eWqm1qyC4l3zpfN7sn28TVGpfczDGJ+HnMJ
         km7pKYY1F5gJNAIlQ3vOdXsj1Y6HoQT/0rNm2DoAaobafX/d0JB+BWaDFo2xBtvD2vNh
         WUlg==
X-Gm-Message-State: AOAM530DdyF1O4tIDqh0eAWA0Qhsq7aJuN6iqtoeb6MvXutTKQXvsSyA
        dGyKiITEC1f25ceXSTpYRAhdFTAPtTmI7M+mDdMobjtuclw=
X-Google-Smtp-Source: ABdhPJx12opV2fs7jmskuRI3Emw/MjsHm28yPrORXLInGi0vWmf9BbZ3nbknHiAgkDsceQgKZ3B6nLQMnpLy+bfGROQ=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr13231019ioq.160.1651106652391; Wed, 27
 Apr 2022 17:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org> <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org> <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org> <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org> <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com> <20220428001822.GZ12542@merlins.org>
In-Reply-To: <20220428001822.GZ12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 20:44:01 -0400
Message-ID: <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 8:18 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 07:21:51PM -0400, Josef Bacik wrote:
> > On Wed, Apr 27, 2022 at 7:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 6:59 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Wed, Apr 27, 2022 at 05:27:44PM -0400, Josef Bacik wrote:
> > > > > Sigh, added another print_leaf.  Thanks,
> > > >
> > > > doing an insert that overlaps our bytenr 7750833627136 262144
> > > > processed 1146880 of 0 possible bytes
> > > > processed 1163264 of 0 possible bytes
> > > > processed 1179648 of 0 possible bytes
> > > > processed 1196032 of 0 possible bytes
> > > > processed 1212416 of 0 possible bytes
> > > > processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> > > > inode ref info failed???
> > > > leaf 15645023322112 items 123 free space 55 generation 1546750 owner ROOT_TREE
> > >
> > > Ooooh that explains it, it's the free space cache, that's perfect!
> > > I'll get something wired up and let you know when it's ready.  Thanks,
> > >
> >
> > Ok, lets hope for better results this time.  Thanks,
>

Ok it should work now.  Thanks,

Josef

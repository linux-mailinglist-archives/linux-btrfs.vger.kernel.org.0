Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656F4F4785
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiDEVM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449699AbiDEUK1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 16:10:27 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA921F2103
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:56:42 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 14so345938ily.11
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psWrC6/QABgP2AGlmqWCQysqkI2aJ4VvHtRaiAOq5Bk=;
        b=tcriGclU3pMiBocFXpu9zz5jIMPSxmdeVzgKUygWTX35rh2V5S43CShJK5Xx9WQYTh
         TLp36Bte+ifdLuy4S4wp+dfpIa1DWQgr42FLx3MgwM3vlc44+nIyxLJ5GpkaZQRQEyiC
         czv2DDDMMoEWpaT1g2aPkQxC2bG27xXht0bAoVsfbPhWR19zkzykgqGqUCXJpXVqkufj
         kSGLeO/k4ECr+EeuJFjldAMauFu/Nppe3jdl//RZsKexp50sLbRB4KdC5OVMcNmTuu1O
         5PylC8FA61dZ1Q7VcP47wo4u/yrv8ASJyKIYChNW6jxhIU0+PYy716ger76dFz8rCoIT
         xU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psWrC6/QABgP2AGlmqWCQysqkI2aJ4VvHtRaiAOq5Bk=;
        b=fkhzqTaji+w08Byr6sexT+LLokHQ/QWo1czC1H7cMZOVcjxVP+Q60p7V0/vHGtxssC
         byAu7I7COLmyCaMkxi+t8pepOgOkiaM0Y9YxTjcukdBHJcITFLeOnzWbs1SONZU58Hrg
         M8RIhHDJws+zbqT/tnvZm0wfc4aJ208ZjVbNEAcr7Bpn3Ew0ekVBU76GwBma0u6ziWFw
         06q8cUzEATQ4bco4SdzwKQI8dPu+W6DEmL0LD87KKVUfXYEUbb0cIZSo+LSrxGMy3xTx
         CXiv+TiREmRDPdJX2ZL9SV2iqNAbo9SoNFBiBabPnfncpJjIuwBfOoc1AjKMPJYJDzNt
         xP0A==
X-Gm-Message-State: AOAM5317COVNdb1eHOmq94Hk2boiasiF4FD52frb0PAzwiNx0FJ/mu20
        43YiCdAn3nqW4hzMtb92PvRCIYiw9ZNc0FbUMrvOln8bUDI=
X-Google-Smtp-Source: ABdhPJzDly47HQK7xnpyacpRMvVnqhYkxvlkvoyN+IMZVe4FkCflLGxzasovNA+w4cGLVHx4UTVrJZzomXnIS2p2dXs=
X-Received: by 2002:a05:6e02:170a:b0:2c9:f038:7f2e with SMTP id
 u10-20020a056e02170a00b002c9f0387f2emr2587500ill.127.1649188602205; Tue, 05
 Apr 2022 12:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org> <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org> <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org> <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org> <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
In-Reply-To: <20220405195157.GA3307770@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 15:56:31 -0400
Message-ID: <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 3:51 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 02:36:29PM -0400, Josef Bacik wrote:
> > > Couldn't read chunk tree
> > > WTF???
> > > ERROR: open ctree failed
> >
> > That's new, the chunk tree wasn't failing before right?  Anyway I
> > pushed a change, it should work now, thanks,
>
> It failed for one commands we did before:
>  ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> btrfs-progs v5.16.2
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Couldn't read chunk tree
>

Ok I think this is from you redirecting into your device, can you do

btrfs inspect-internal dump-super -s 0
btrfs inspect-internal dump-super -s 1

and see if they're different?  We may have to put your old super back.  Thanks,

Josef

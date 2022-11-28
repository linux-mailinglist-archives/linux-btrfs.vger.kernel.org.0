Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BD63AD55
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 17:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiK1QJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 11:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiK1QJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 11:09:52 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954D22282
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:09:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i12so7690735qvs.2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBw6BHgPgj9vEMI/LtgRLqEDNYDZruCoN4tJmSgLZdc=;
        b=OZw7XBpel1Ads1o0Rxmw6opTYOrGA+eAluDoQjVIyDl4pkVa+N249xXe2CPHF63bfY
         YEjhVwQkiQCsEAqlwRza+HGqBlkZ5/XwOcX75cZPmlxqUlntvsZ+3NipNTPC8cCAXCVG
         EbBaT6BbxyxC20FMLNJ6XlPybyYr1pBmvaM9g9XNsLPAOArq+16Aoli0LwWpdVm687LX
         1Dfznlw4rhkriXJnabJgVW20UU7F2TjnYzmAMQD06myJRlQKGk/TEouOwz2tPBntPWhK
         PdmutHOMmouZq2g3jbv6g9JfhfqhQyaDdvxrUoGV2/+N8ANrc64hrOnFcg5sqVw00kpt
         WIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBw6BHgPgj9vEMI/LtgRLqEDNYDZruCoN4tJmSgLZdc=;
        b=ZDuqgIu1xF+7QjFDNpMLUyqqsyPYJGdYJobjtUpYMferbt93a7pCpn10Qa8lXPcaJ9
         sncXYfPsXvTKQqILl3evLLkFVi2nap6+6Ls6f6Kg5s/iaJFFjio/sl9SugR/FKVFLuMA
         roVp4epE0NHk/4JIXTNPOd/rbQjxPzr3ujAPAaHS3/SvXiYftv8/PcxcXhuOxEIHJbtC
         EPVYSm7m8GGtNhbsIeElw7DrgVVhtBv9ozJtGq6D32Z/uNl5cgp6sq8nP043rlcWQKxh
         6W0I/EyB3cGUR3lMEjbqBS02PG+YQaojy1AzjWlJJTyMYXax8hynHJf7wVeqh1tlt3Ug
         WZQw==
X-Gm-Message-State: ANoB5pniJj1d2lHUOqJQCEhAlOYuxd6wqGffLaKaW+/jh8MCydq50gCq
        Zhp2tpYNVCCXpWjTsfzL1oYPeYb/PBUfDQ==
X-Google-Smtp-Source: AA0mqf5SkkQfigIjFFt84L2TYcWsMIG5kL2/K0w8K+d4elppImN4fvm6UwmbTOqbC/bqNBdcJebx2Q==
X-Received: by 2002:a05:6214:2f10:b0:4c7:75e:5258 with SMTP id od16-20020a0562142f1000b004c7075e5258mr2160322qvb.50.1669651791026;
        Mon, 28 Nov 2022 08:09:51 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006bbf85cad0fsm8715635qko.20.2022.11.28.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:09:50 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:09:49 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 04/29] btrfs-progs: use -std=gnu11
Message-ID: <Y4TdTYBp7kuHPcB1@localhost.localdomain>
References: <cover.1669242804.git.josef@toxicpanda.com>
 <d14df29fe513f2ee0cd0290407da381824af239e.1669242804.git.josef@toxicpanda.com>
 <e88cbf8f-7f98-9642-d9b8-44ec1d4f9e2c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88cbf8f-7f98-9642-d9b8-44ec1d4f9e2c@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 01:49:36PM +0530, Anand Jain wrote:
> On 11/24/22 04:07, Josef Bacik wrote:
> > The kernel switched to this recently, switch btrfs-progs to this as well
> > to avoid issues with syncing the kernel code.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 475754e2..aae7d66a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -401,7 +401,7 @@ ifdef C
> >   			grep -v __SIZE_TYPE__ > $(check_defs))
> >   	check = $(CHECKER)
> >   	check_echo = echo
> 
> 
> > -	CSTD = -std=gnu89
> > +	CSTD = -std=gnu11
> 
> We have one btrfs-progs source code compiling for kernels 4.x, 5.x and 6.x;
> I am not yet sure if this will remain compatible, any idea?
> 

It'll remain compatible, it just means that we can use the newer fancier things
in the btrfs-progs codebase that we may pull down from the kernel.  Thanks,

Josef

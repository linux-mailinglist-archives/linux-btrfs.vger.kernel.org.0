Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418978B1CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjH1N3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjH1N3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 09:29:32 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA0A7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 06:29:29 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579de633419so37726157b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1693229369; x=1693834169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51R6Aj1L+VFNN3PzwjRGnYs3w7otquZjgIw9jgIYfi8=;
        b=vCxnqEmMfJeqFqZp+Srr8UYDPRncAa3IzvebimadxXcyo36fvNkqJiARKhSO1bROgm
         90tj4ev8bEglCOmzdY+Z6rVwfE1vkxpyCbgjKRI3aylxoCqnJzAUu4m2QeV9j2reGXFt
         FSDjhG/IbYUd/5cHuZwU5i6EmN8kU2YmWawXt7mGJBnyW9c2xI9UyMFyQpmClVjxV+ly
         OMwlIcTKUpGLwfC/Fe0y/fuY5KyyS31lp5iJQ3MpzBLaNOJqm0D8H0vgDqtFYltqsBxI
         UdJHJ2YJgaBAGeyoRFdffL1r4IxOznXzh/XMHlxITZq1L2TSYqd+kX72/2Nok3AxTH4S
         j4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229369; x=1693834169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51R6Aj1L+VFNN3PzwjRGnYs3w7otquZjgIw9jgIYfi8=;
        b=TT7vPy9vEOhUv85MQ5mjdRA3/zs0GO+Lw3V+PaGLX9bYa3MN/FwVphjKHYlDLbKMe3
         M9SvutkQQ6hdFlalQNbWr7xzYokEZgAucigNWJ+dYcb2l7TP4CFX37vqc10JvaLRlsiI
         NapkgHKqu2paftJGgLmF9ywxEpDEs5/t3eoB2BD1dm1a9ks50VYLHfPiWQCzv6RaAMDy
         SS8PDxIIVhJBgcMIyjMAjc3ATZ4lR1bzDAm/5/L2m8JIe4q/Ifz5GarPzevuXuDrHKIY
         vW6LPRsjhs3anfFfEH6HWyRFxSMzk4gYzwiklI+eDUcNrxQT1yjtnLFtI6W41vlTxQzK
         56VQ==
X-Gm-Message-State: AOJu0Yx+4t4M4pDNBRFsvLnMBUBWPwtrr1JeogALGrys9k5OfhwW1hyj
        eo2vQT/C2DM0X4JStYIkXh56Hw==
X-Google-Smtp-Source: AGHT+IF1iYs5B7zie8m+xk570ZO/ODFuih0+7OlUGdtxxB+9zyf5FAHNDhqVFXeedLy6BnaUnEBE3g==
X-Received: by 2002:a81:4e54:0:b0:58c:6ddc:7717 with SMTP id c81-20020a814e54000000b0058c6ddc7717mr26953320ywb.37.1693229369106;
        Mon, 28 Aug 2023 06:29:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g63-20020a0ddd42000000b00589a5bbeb43sm2118733ywe.117.2023.08.28.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:29:28 -0700 (PDT)
Date:   Mon, 28 Aug 2023 09:29:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     kernel test robot <lkp@intel.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 11/11] btrfs: remove extraneous includes from ctree.h
Message-ID: <20230828132928.GD875235@perftesting>
References: <ed1caf5b26573e62547cb3b96031af66c0f082ca.1692798556.git.josef@toxicpanda.com>
 <202308252218.ReiikzVx-lkp@intel.com>
 <bc67655d-70f7-4c41-899c-9da863c61691@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc67655d-70f7-4c41-899c-9da863c61691@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 28, 2023 at 11:08:46AM +0000, Johannes Thumshirn wrote:
> On 25.08.23 16:23, kernel test robot wrote:
> > Hi Josef,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on kdave/for-next]
> > [also build test ERROR on next-20230825]
> > [cannot apply to linus/master v6.5-rc7]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/btrfs-move-btrfs_crc32c_final-into-free-space-cache-c/20230823-215354
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> > patch link:    https://lore.kernel.org/r/ed1caf5b26573e62547cb3b96031af66c0f082ca.1692798556.git.josef%40toxicpanda.com
> > patch subject: [PATCH 11/11] btrfs: remove extraneous includes from ctree.h
> > config: arc-randconfig-001-20230824 (https://download.01.org/0day-ci/archive/20230825/202308252218.ReiikzVx-lkp@intel.com/config)
> > compiler: arc-elf-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230825/202308252218.ReiikzVx-lkp@intel.com/reproduce)
> 
> 
> Looks like #include <linux/security.h> is missing in super.c
> 

Yup I fixed it in v2 I sent on Friday.  Thanks,

Josef

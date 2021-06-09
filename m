Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFB3A1968
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhFIP1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 11:27:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47006 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhFIP1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 11:27:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 300A91FD5F;
        Wed,  9 Jun 2021 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623252314;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnwpRx7yBJ1OiUH+QEEKkqma20IwsS7l8C1CBgxMwZE=;
        b=x9blfVsfHU2ikNtiGmwORxv051ighw3RV83vLk8ry8KxoVXs65eMhqqkYyciHcC0seOXvd
        BranzjpuMgzxDm5zgng/Ig0skdoIeenjgkYxnk0c+AufmSTHCRkt1dZ+kpyxTV15DI6saK
        6OP+0uWaJzUIEakwd5kEMegTIq0ZZww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623252314;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnwpRx7yBJ1OiUH+QEEKkqma20IwsS7l8C1CBgxMwZE=;
        b=u9SGg7nzulHYh4r8kwbpIOc6cZWOUDYfiiCA/vX4hvdeGK3YPPEOFWC+yM13ThOluPu/zT
        bOfFWIe7daFyA9Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 126EBA3B84;
        Wed,  9 Jun 2021 15:25:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA216DA908; Wed,  9 Jun 2021 17:22:29 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:22:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: include/linux/compiler_types.h:326:38: error: call to
 '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON
 failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
Message-ID: <20210609152229.GB27283@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202106092159.05DloM1z-lkp@intel.com>
 <6cc4b52b-48cd-45e2-67b5-289c4962fedb@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cc4b52b-48cd-45e2-67b5-289c4962fedb@csgroup.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 04:01:20PM +0200, Christophe Leroy wrote:
> Le 09/06/2021 à 15:55, kernel test robot a écrit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   368094df48e680fa51cedb68537408cfa64b788e
> > commit: 4eeef098b43242ed145c83fba9989d586d707589 powerpc/44x: Remove STDBINUTILS kconfig option
> > date:   4 months ago
> > config: powerpc-randconfig-r012-20210609 (attached as .config)
> > compiler: powerpc-linux-gcc (GCC) 9.3.0
> 
> That's a BTRFS issue, and not directly linked to the above mentioned commit. Before that commit the 
> problem was already present.
> 
> Problem is that with 256k PAGE_SIZE, following BUILD_BUG() pops up:
> 
> BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0)

A 256K page is a problem for btrfs, until now I was not even aware
there's an architecture supporting that so. That the build fails is
probably best thing. Maximum metadata nodesize supported is 64K and
having that on a 256K page would need deeper changes, no top of the
currently developed subpage changes (that do 4K blocks on 64K pages).

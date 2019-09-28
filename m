Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB7C11C8
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2019 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfI1SgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Sep 2019 14:36:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36101 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfI1SgH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Sep 2019 14:36:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so4587863qkc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Sep 2019 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=z1AYMuz47VCLxQnvsZUkQ2ACl2t+4oXAMpZjQs1mh/8=;
        b=FDo0y9LtefVNslxlj1xzNdg0nmAHhkNSbzHK+1VYqk8jXXBhs9v0yepNXkg2iWQNPX
         aP5gRjjaQ8ZMGG3K4SrHQRjBYSir4iqhEpxZ9R6dBiqcw1eOak31+18O2GM1uzYSuV/H
         dsZyfDGqry5HpMkBIwvS1OHCQc0eM4DsZOu1Fw7EdXLWUSchHB78CtDwGU1FEYHEQUF3
         D3MUtM5skfM+uNPGo+kIm6twxi5NrT9WnmwuCTEn3CbVTMMbWmL8DAQNciTnmOYQy6AX
         O7tPm0QJscM+Q8U7SpygsiwtFSmwAgeuvzxf5y94y+YDG7eyqJh50dTkYabdkoj3wiIA
         u+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=z1AYMuz47VCLxQnvsZUkQ2ACl2t+4oXAMpZjQs1mh/8=;
        b=eduuBps23Ib3mwKw0FdOynECayBPHieVqh0Fyd85n93OpLvdHn86CLPzGqcWPWHUYg
         cvXDq/526MUA5Q4OdfL6jPsSCJ8ufWw4pUURFTsPdslsg/BUBBZHnc7i40j21UCQeDH3
         9JlpWFN2pk/FOLM1/OR2SOgyZVCGi8wUS3bc6MVedrTvMkI4Z1+XMZwLHU9+M7gLPGNv
         nZ+f8sm0O10dYuBNMqcsrr/M5urolAiML2qg/h968LIGSCvEc+3SGsOPb7ilWkf5vtpo
         WW6v4sr2IEDgjtRBbnvj7kRHvR2mu6zp06IR9xPkBqRoxi/vBiQ6ER3Et7I03N2Yx7Fo
         o/SA==
X-Gm-Message-State: APjAAAUDm4XAhl5+N0wZEg/JLfvJSwpXxmUeTWKxl54ODboutn+bq/WG
        MslkpWWuVhWuLhd3/psIuPOW0dWPsR0=
X-Google-Smtp-Source: APXvYqzOR3/2T1RWqlyTnCW1/A69FN2k0O7VT0TppBdKAkWnPnUzl6ad0I/ejjbf9u0cwqlAuS8SNA==
X-Received: by 2002:a05:620a:54f:: with SMTP id o15mr10469432qko.324.1569695766329;
        Sat, 28 Sep 2019 11:36:06 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:c428:5029:cbb2:41f? ([2604:6000:1014:c7c6:c428:5029:cbb2:41f])
        by smtp.gmail.com with ESMTPSA id z38sm5555659qtj.83.2019.09.28.11.36.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 11:36:05 -0700 (PDT)
Message-ID: <d19eb085373417fb13f5ec3c634224ecefa9dca2.camel@gmail.com>
Subject: Re: while (1) in btrfs_relocate_block_group didn't end
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 28 Sep 2019 14:36:04 -0400
In-Reply-To: <6476e5f02a4bdf26c8f342db11f6dc1675c94394.camel@gmail.com>
References: <ef805fda2976d3b89b80204f8d119a9342176bae.camel@gmail.com>
         <6476e5f02a4bdf26c8f342db11f6dc1675c94394.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2019-09-16 at 17:20 -0400, Cebtenzzre wrote:
> On Sat, 2019-09-14 at 17:36 -0400, Cebtenzzre wrote:
> > Hi,
> > 
> > I started a balance of one block group, and I saw this in dmesg:
> > 
> > BTRFS info (device sdi1): balance: start -dvrange=2236714319872..2236714319873
> > BTRFS info (device sdi1): relocating block group 2236714319872 flags data|raid0
> > BTRFS info (device sdi1): found 1 extents
> > BTRFS info (device sdi1): found 1 extents
> > BTRFS info (device sdi1): found 1 extents
> > BTRFS info (device sdi1): found 1 extents
> > BTRFS info (device sdi1): found 1 extents
> > 
> > [...]
> > 
> > I am using Arch Linux with kernel version 5.2.14-arch2, and I specified
> > "slub_debug=P,kmalloc-2k" in the kernel cmdline to detect and protect
> > against a use-after-free that I found when I had KASAN enabled. Would
> > that kernel parameter result in a silent retry if it hit the use-after-
> > free?
> 
> Please disregard the quoted message. This behavior does appear to be a
> result of using the slub_debug option instead of KASAN. It is not
> directly caused by BTRFS.

Actually, I just reproduced this behavior without slub_debug in the
cmdline, on Linux 5.3.0 with "[PATCH] btrfs: relocation: Fix KASAN
report about use-after-free due to dead reloc tree cleanup race" (
https://patchwork.kernel.org/patch/11153729/) applied.

So, this issue is still relevant and possible to trigger, though under
different conditions (different volume, kernel version, and cmdline).
-- 
Cebtenzzre <cebtenzzre@gmail.com>


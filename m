Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCFCB23E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfIMQON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 12:14:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40784 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbfIMQOM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 12:14:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so18366128pfb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bob543yc4RAEtrwQvBCY/KawWpcBEGA5iqhVmu7uiBw=;
        b=01Xhx/MIIGxJ7Rt8yQSDiduPE/zfRGgpUDAlOVZ1YDa5vBB+IrqEhJM1pAJH/afAs1
         ykDMJVpn5TSYTQ7cX6xwHvtKcDXnWveBouiELo5WX0ebkcqvtqGrRlH8KVVbn7lSWpff
         M9YIa4PtOlpxKKyE0VYOqtqeDWvDba4Xl3NcTn/maNbAtd+FtNDpoVDmTI/DNMdH/Jaa
         TSa6oLxUbmGq0yrMx9hxiuU6fymiEpkugBhlQvNZCcCor/YupVVujjw15z6c8zOzqmZy
         FnH+psGXR3t1xpy+B2+FTPhqHMg727njM/+MLxEvVJI0u9kiAhZty5nxuQMgrtWC5rDR
         NujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bob543yc4RAEtrwQvBCY/KawWpcBEGA5iqhVmu7uiBw=;
        b=VywzhDJXSlrPcp3XVKH07DfVW1Jbw/mwA6c58mwpgwp3Dru3CDg/pNGXbjYAv6htkn
         1mP/fZsGNmHaRkisCDhHp9UnvSY77UdRRgcIgIgV/eJFg+k7EkNYvuFadBByrpoG9Pl4
         QKQj1ZoyFODO5VGQvHc2ccU4C0FxXdJ8iHTyTyRM8Rd6S9QtLnQS0vNS2UST7hjuS17h
         YUuQsG2QMyhwEz833Y4RK+S1IjC4s/P78Zdd3pb00yezpHQ2uSJjlSC27Rmp4tcmiXBj
         ovM7CTqi68dHdAcNiXwdn5jaPLljGV5LHqyUL+FmS/FZO1ojQ6QgM9cufzHDXkx1n+zm
         QY9Q==
X-Gm-Message-State: APjAAAXI/RntFJtiZ8rE+IDlEcrNyeHKXvZK3qUIFvC2+z+w+dZH7wPy
        2lL0z9X4CnGXLlhLF8aMiTrlFo4MjRjZnQ==
X-Google-Smtp-Source: APXvYqxtIdylWkANKXMTN0RW1brzqXHIq0nQjd2E81Bol5ZZs2JBu40Ij4AnsRozEJY/PHFP0aYbeg==
X-Received: by 2002:a63:6193:: with SMTP id v141mr44942693pgb.263.1568391250625;
        Fri, 13 Sep 2019 09:14:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:200::1d1c])
        by smtp.gmail.com with ESMTPSA id r18sm26966041pfc.3.2019.09.13.09.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 09:14:10 -0700 (PDT)
Date:   Fri, 13 Sep 2019 09:14:08 -0700
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix balance convert to single on 32-bit host CPUs
Message-ID: <20190913161408.fs3i4apgrcmajmev@macbook-pro-91.dhcp.thefacebook.com>
References: <20190912235507.3DE794232AF@james.kirk.hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912235507.3DE794232AF@james.kirk.hungrycats.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 07:55:01PM -0400, Zygo Blaxell wrote:
> Currently, the command:
> 
> 	btrfs balance start -dconvert=single,soft .
> 
> on a Raspberry Pi produces the following kernel message:
> 
> 	BTRFS error (device mmcblk0p2): balance: invalid convert data profile single
> 
> This fails because we use is_power_of_2(unsigned long) to validate
> the new data profile, the constant for 'single' profile uses bit 48,
> and there are only 32 bits in a long on ARM.
> 
> Fix by open-coding the check using u64 variables.
> 
> Tested by completing the original balance command on several Raspberry
> Pis.
> 
> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

Honestly I'd rather we fixed is_power_of_2 to work on 32bit, that way any other
users don't get bitten by the same problem.  Thanks,

Josef

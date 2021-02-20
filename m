Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7132055D
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 13:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBTMiw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 07:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTMiv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 07:38:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BCC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 04:38:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t11so7111505pgu.8
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UTECVMPDyeNgkuakugfNIKWps8Hp11kV96FHNC1vj+4=;
        b=XPe+fHVRajRq3DV4fnezhn/FeZEzdmduhAUL9hPMzU22oAs4LeRIKr/DrxLS7skRAS
         r5TKWVeX2zAELyvyCbkOdvU7TCW7nYt+du2fGPSzAKw/t5tVTHpfqS4DqjpBFH5jRYCv
         OCR+ATBxioMBd/F+yQbc+vNyUgLohP0bZZLaniZizoUgyZfRSDIzyD3PK6rX+kWq4mcH
         5hLh89sms9aF/4Avsy5XJw5W++XnoscCimaOCVtcEKFOJWPJUBbLdKFFs7g9h3LoHdp+
         kEe8ufNDgjzS5wID2syhUMMr3bRnUla8hbX1P3WoFPuVpW/D4otCKDnjbsNm4FoMCKmY
         yhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTECVMPDyeNgkuakugfNIKWps8Hp11kV96FHNC1vj+4=;
        b=BLSD//eqCtxNmUXaNFRo508bTrx/f9+2PLSF9nFjlzhfiUK+Qv9qu0eneh/sL/0OxP
         ooaErtFStAWCs8IBe+PQuJ2wFA9SuUkqjvvYGQWtdQyG5tLIroVfKGmeyNezrX3X2hu5
         qzJi/t5/wduJTfj3Qq6lBoBAbEtVp1rg4f39XtOqi38OIJtcO5gN7fg9zfuKtt0BT2cH
         K64OF9+LjlSK+6YXfidkCN0sx1spHN868hR/Me5028DGZKWfnKPVKzyyXBzBc0LKFV5a
         rGmQicPHFMPbdEohisJ0NnANgfGDaxYtKWJroyH4SvPLtM7xLVgolUKNvtOfkb/kW2jl
         U2Mg==
X-Gm-Message-State: AOAM533/xWkDj2VFANM4dkxBxSyYLrf2OSqJWKrPoZQ2VRa7h+8UI/PE
        VF+yZNQJUp2vk3HTB7KpuhDRtDacO7Lbnw==
X-Google-Smtp-Source: ABdhPJzX4PbWZhLhCx7+NqfwtmWGmyaJINpOIoMtUsS3HLO5dmbueVzwl0cOtVQL0DqiTy8j10l+sQ==
X-Received: by 2002:a63:4343:: with SMTP id q64mr12218690pga.109.1613824691057;
        Sat, 20 Feb 2021 04:38:11 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id lx1sm11161230pjb.8.2021.02.20.04.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:38:10 -0800 (PST)
Date:   Sat, 20 Feb 2021 12:38:03 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: filesystem-resize: make output more
 readable
Message-ID: <20210220123803.GA11258@realwakka>
References: <20210219171818.10170-1-realwakka@gmail.com>
 <20210219181149.GI1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219181149.GI1993@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 07:11:49PM +0100, David Sterba wrote:
> On Fri, Feb 19, 2021 at 05:18:18PM +0000, Sidong Yang wrote:
> > This patch make output of filesystem-resize command more readable and
> > give detail information for users. This patch provides more information
> > about filesystem like below.
> > 
> > Before:
> > Resize '/mnt' of '1:-1G'
> > 
> > After:
> > Resize device id 1 (/dev/vdb) from 4.00GiB to 3.00GiB
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 
> Code-wise it looks good, but I tried a simple test and it does not work:

Thanks, It should be fixed to make devid having default value 1 that
also kernel code does it. and initialize sizestr with amount_dup because
if there is no devid, sizestr will be NULL and command failed.

I'll write patch v4.

Thanks,
Sidong

> 
> # truncate -s 4g image
> # mkfs.btrfs image
> # mount -o loop image mnt
> # btrfs fi resize -1G mnt
> ERROR: cannot find devid: 0
> 
> while running the same command with the installed system 'btrfs' resizes
> the fs: "Resize '.' of '-1G'".

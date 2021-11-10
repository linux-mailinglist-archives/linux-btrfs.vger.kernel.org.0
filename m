Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094D344C449
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhKJPYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 10:24:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52002 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKJPYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 10:24:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D12521B17;
        Wed, 10 Nov 2021 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636557695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoSLQSfrXIaBEcSpyuMJHOOQzW+UxbR3slrY36oD2dc=;
        b=pfOZj8d6deSXsb/KNmXugmW8aG81+lJtggQbP8vBbtjfpipHTGZDcbBiJBSmcllc13bwDX
        GherLnkdD+25A9V1dcMAFqkWBJomK1pmECHyJdjrg0GmVdXkeGVGhNBvSKjJF73+Wcm+44
        XlEplHCLgxBKGR2luOExepj7a4/QCcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636557695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoSLQSfrXIaBEcSpyuMJHOOQzW+UxbR3slrY36oD2dc=;
        b=FXLYgBygvZKL35Iva+Btdw/Z2+xpieQTOOZfgBBSV/7DPmtf15Jy/tg+tv4Metz0BXFRz4
        sJKDUXZ1Ht+PFpAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66B99A3B81;
        Wed, 10 Nov 2021 15:21:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3466DDA799; Wed, 10 Nov 2021 16:20:55 +0100 (CET)
Date:   Wed, 10 Nov 2021 16:20:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     cgel.zte@gmail.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] btrfs: remove unneeded variable
Message-ID: <20211110152054.GU28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, cgel.zte@gmail.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211110115619.150678-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110115619.150678-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 11:56:19AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./fs/btrfs/disk-io.c: 4641: 5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Please teach the robot to ignore warning from this function. Thanks.

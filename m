Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D903F2B17
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHTLV0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:21:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42594 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbhHTLVZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:21:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A51522176;
        Fri, 20 Aug 2021 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629458447;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iobDxqCz9QJhm9xFYnLATpFNb4ETxaYDD9/UCGxRHoA=;
        b=jbisJHVqj3Q3PysEudVemRhkomdAzJHIP8OYB+MzEYE/LFwIC5cfmcYfErkPa7cusA7oqZ
        +LqwkPxrkYnpDPXfFQJuORsMB1iItoP/15kcTAd0gGcYP0Mx0zw9N8Hiq5UKyPNTwRaaH7
        /vGZGfnwMdfSSETTu8oUiyneaVDp3DU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629458447;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iobDxqCz9QJhm9xFYnLATpFNb4ETxaYDD9/UCGxRHoA=;
        b=ttMBH9zh/aN+BOThIn56papmuBnRtJy/WzgWRH2pgDcAI24agwD6ZJ9PsWRrlydj14KDNz
        qRwpnyFWm+c1nrBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23439A3B8C;
        Fri, 20 Aug 2021 11:20:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70FC2DA730; Fri, 20 Aug 2021 13:17:49 +0200 (CEST)
Date:   Fri, 20 Aug 2021 13:17:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs: reflink: Initialize return value in
 btrfs_extent_same()
Message-ID: <20210820111749.GO5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210820004100.35823-1-realwakka@gmail.com>
 <6902f367-03d3-f732-5864-7c8b19a0f9e1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6902f367-03d3-f732-5864-7c8b19a0f9e1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 09:08:26AM +0300, Nikolay Borisov wrote:
> 
> 
> On 20.08.21 г. 3:41, Sidong Yang wrote:
> > btrfs_extent_same() cannot be called with zero length. This patch add
> > code that initialize ret as -EINVAL to make it safe.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> One minor nit: In this case the variable could have been initialized
> during definition to save 1 extra line of code.

Yeah the function is short enough to have the declaration initialization
in sight, I've changed that.

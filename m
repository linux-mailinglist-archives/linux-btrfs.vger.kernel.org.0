Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1F466A74
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 20:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbhLBTcY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 14:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhLBTcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 14:32:20 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13583C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 11:28:57 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id de30so1119460qkb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 11:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8wYykdXj/cfjl4gsN4e4acXKgx208HbfOe+YWmVVcE=;
        b=wUHNQlB3hybaLo+zKyx9XOGc3O1pn97fyJ7nLXxN3dBUqQs492HfhZAAD/5eGeBYfq
         zySCEVG7dEHaoMwISzMFo0//KEXHONejwslIK3qVwWlGGaRGhzaWBtMlABK2Ds9cOWPQ
         5SVRbcMXH9VNyiZF1sWrBaBxH2EsWvhaqRwIlt0KGhejPUW04dQ9ScNME6WZAI3xkjD6
         gEtvQ3sKLp25SM+agTasiDVuxRmFFTZ7t58uY86BzW4pyCtIeFH+zPSxGUxlQbFfplJl
         h5df1de8PiJf2wI4vDMm+fgSf240Xx1Zkoj1vVX+1iUg3CEsTvR/DW/wNKU1HRwiHblG
         S+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8wYykdXj/cfjl4gsN4e4acXKgx208HbfOe+YWmVVcE=;
        b=2rDmVkIuHz4WuSAh518uqh8Cak1hzMo4eCAY/qDU/K0qclccN5OfFVGJBhjEg77ZQI
         6TRBVS/WU4An34QKLMdozPo/+3lwnRuzv0z4n9R3aJvU0Es/FEw0ejS12c1BTZvhnxqa
         EKJiJcqqcpFAOuzdS29NPl/pK81DI6dSC0FFmgUB0s3usp62eTfxLPyb5bov92xsqoha
         iezgdehumXqCnyl+XWxudOe9K2X5U6ZRB+XmRO9ze0CdaGxCmKVCxy03ytfqTSVcz2G9
         c+ITuu6+X4dCCq+B25zxZToCspXWVw9tNDvCbaYXnydz8QnEZRedwJqU2zmD+ItxIpAo
         QY+A==
X-Gm-Message-State: AOAM532Rbh543VsxOE7DJmiypgKt3jAjD2aD5lATDeuOy36RwPhOrJa6
        We7dvpAisWA3Vi6OwHprX0bZasZj45hHRw==
X-Google-Smtp-Source: ABdhPJyMaB2etrtQYfHsYyvBHcEkb9NkE1PJyXdbuCTwjZ+xlUvRxPbbxPQcxdNSWnJtdwcYNPmXrg==
X-Received: by 2002:a37:a811:: with SMTP id r17mr13949304qke.305.1638473335985;
        Thu, 02 Dec 2021 11:28:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t11sm495924qkp.56.2021.12.02.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:28:55 -0800 (PST)
Date:   Thu, 2 Dec 2021 14:28:49 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix a failure when looking for data
 backrefs after relocation
Message-ID: <YakecWBMcRKlPdGa@localhost.localdomain>
References: <829076d580be74f270e740f8dded6fda45390311.1638440202.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829076d580be74f270e740f8dded6fda45390311.1638440202.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 10:21:43AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a send, when trying to find roots from which to clone data extents,
> if the leaf of our file extent item was obtained before relocation for a
> data block group finished, we can end up trying to lookup for backrefs
> for an extent location (file extent item's disk_bytenr) that is not in
> use anymore. That is, the extent was reallocated and the transaction used
> for the relocation was committed. This makes the backref lookup not find
> anything and we fail at find_extent_clone() with -EIO and log an error
> message like the following:
> 
>   [ 7642.897365] BTRFS error (device sdc): did not find backref in send_root. inode=881, offset=2592768, disk_byte=1292025856 found extent=1292025856
> 
> This is because we are checking if relocation happened after we check if
> we found the backref for the file extent item we are processing. We should
> do it before, and in case relocation happened, do not attempt to clone and
> instead fallback to issuing write commands, which will read the correct
> data from the new extent location. The current check is being done too
> late, so fix this by moving it to right after we do the backref lookup and
> before checking if we found our own backref.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I'm not against this in principal, but won't we come all the way back out of
this loop and re-search higher up because things changed?  Can we just do a
-EAGAIN, come out and re-search down to this key so we can still do the clone
properly?  If we can't then this is reasonable, but I'd like to avoid blowing up
a send stream because relocation was running if at all possible.

Josef

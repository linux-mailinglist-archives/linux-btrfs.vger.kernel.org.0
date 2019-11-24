Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DEE108427
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2019 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKXQPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Nov 2019 11:15:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36494 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfKXQPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Nov 2019 11:15:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so5848734pgh.3;
        Sun, 24 Nov 2019 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HEMyPYslSRvsQaFXYqP66gozSXb19Xey/UqHovRaLu8=;
        b=fJrDcJgSc1WTy5HQBPeIr8aPegFFPyTOdu0KgMG+/z0VEyS5VnAXSznzKL4IZrdeLe
         +NHGARfSHN6X/MRnaU+fQkQtbYhy/KQBdMlAn4J7PjaxlUs1ycKqwQObCIwybHopFSGz
         57zwBDJk/kFgsLV+jd40aofmzabQ1A3PgdbHxwKTcKM7uIcMkGSYzGEx6xrTgnk9kxPE
         G12q5tbtHSXZrmE2W6GucY0b3Wqsp10dvpYuZIyOJqzU1NdAbAQgtFcmG4S5AujCt30g
         /UQUoY1E41RNxNo6bw+BHgNRg/PyNeA4DLFdStC19k9I47v0NKGaaoS2XlMId6fWDvhS
         AB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HEMyPYslSRvsQaFXYqP66gozSXb19Xey/UqHovRaLu8=;
        b=a3SI6ayxqwqBlq6uE1cU/GEfwg4QOxQ16UPLeN+xoD8hc8chMQdOnsMdqr1b+uoWcH
         pUDjdueg1bw3EipgPlD0ZI2Y2pqNosiqcDTYe/um6kQ1ePrQBilgQgdR03QP291+81eD
         J2SiOueSiTNjAmfUKMqVkRicJgKKkUCWTpM2xROgvQFnzXicdKVbuCXvSfm9Sf/8wKXh
         qv2kTqYLqN2HP7gRf68a9rPMp1+bkZJd4oI3vRJv+AgSRkLBFSrJ6qTfB6K0hHQnDHaH
         cI1AJexvMWMcymooVRYloNUkuV2Cs5uOaDXuTG+UsbqihczKi8UWoElG5hRLb8wG5HmO
         mRQQ==
X-Gm-Message-State: APjAAAXF2ONWO99f6jXju/558tHWFdx5Lok//igOqNzYY6uZVqXP53QS
        ZM/yQ0AurpQ7rxxv7RsSLWY=
X-Google-Smtp-Source: APXvYqyHW3/DCFWX39ZnKWIMeT1OYEkL2J5DkWbPLvQvvYpz8ESIPyJLa6835vFjAM2LeiQwcYBhrA==
X-Received: by 2002:aa7:86c2:: with SMTP id h2mr29512432pfo.248.1574612144782;
        Sun, 24 Nov 2019 08:15:44 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id j186sm4941960pfg.161.2019.11.24.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 08:15:44 -0800 (PST)
Date:   Mon, 25 Nov 2019 00:15:38 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: common: Keep $seqres.dmesg in $RESULT_DIR
Message-ID: <20191124161538.GG8664@desktop>
References: <20191113065938.34720-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113065938.34720-1-wqu@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 13, 2019 at 02:59:38PM +0800, Qu Wenruo wrote:
> Currently fstests will remove $seqres.dmesg if nothing wrong happened.
> It saves some space, but sometimes it may not provide good enough
> history for developers to check.
> E.g. some unexpected dmesg from fs, but not serious enough to be caught
> by current filter.
> 
> So instead of deleting the ordinary $seqres.dmesg, just keep them, so
> we can archive them for later review.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This looks fine to me, but it causes more disk space consumption and may
eat all rootfs space quickly and unexpectedly.

I suggest we add an option to control the behavior, and default behavior
is to delete the dmesg file.

Thanks,
Eryu

> ---
>  common/rc | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index b988e912..59a339a6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3625,10 +3625,8 @@ _check_dmesg()
>  	if [ $? -eq 0 ]; then
>  		_dump_err "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
>  		return 1
> -	else
> -		rm -f $seqres.dmesg
> -		return 0
>  	fi
> +	return 0
>  }
>  
>  # capture the kmemleak report
> -- 
> 2.23.0
> 

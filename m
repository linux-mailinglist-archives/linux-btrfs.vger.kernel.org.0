Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB027194E5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 02:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0BYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 21:24:36 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.184]:35027 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727509AbgC0BYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 21:24:36 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 1A5EC5F22
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 20:01:01 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id HdMrjQ0WzAGTXHdMrjohqZ; Thu, 26 Mar 2020 20:01:01 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iDG6vdS8QE/qDWvJxcp6xRUl31tG610gSlOvsWob6FQ=; b=RyrWe6RFNsLeoEuXN7MZ0af0f
        ww51wmQfDCo703zzDx1D9mzNqvHPTIYBTtvOE7QiGj9N7nyodv1NZf6i2FxdWbY+XMYxtIiElBo4/
        HePxPmUgeHd6MwWmFuecnrJkfvP8f2QKcSd0thUu0VMY38FyMHX232JRk0Aolh9AgkuSuL+adhmRN
        NPctFYGZMxo5EZ/ETSCn7MyDAqVMvNqByaJ/tVBAd8L0x+Nlue+mxAy5Ddboby3yewNRLyh8PGq4d
        od5BJy3KfbXb7Y+11Kh2t14dN1Ezq2X9NZEjDkBOyBfSC4SL5lkPG7ZRDCZiwYLLLg1hkid7D2UAp
        yFBY8Coyw==;
Received: from 189.26.190.54.dynamic.adsl.gvt.net.br ([189.26.190.54]:46160 helo=hephaestus)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jHdMq-002ZVY-9C; Thu, 26 Mar 2020 22:01:00 -0300
Date:   Thu, 26 Mar 2020 22:04:09 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: typo in an error message: "boudnary"
Message-ID: <20200327010409.GA317@hephaestus>
References: <20200327005505.126534-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327005505.126534-1-kilobyte@angband.pl>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.190.54
X-Source-L: No
X-Exim-ID: 1jHdMq-002ZVY-9C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.190.54.dynamic.adsl.gvt.net.br (hephaestus) [189.26.190.54]:46160
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 1
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 27, 2020 at 01:55:05AM +0100, Adam Borowski wrote:
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 4115049a..484b0729 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -8640,7 +8640,7 @@ static int check_dev_extents(struct btrfs_fs_info *fs_info)
>  		}
>  		if (physical_offset + physical_len > dev->total_bytes) {
>  			error(
> -"dev extent devid %llu physical offset %llu len %llu is beyond device boudnary %llu",
> +"dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
>  			      devid, physical_offset, physical_len,
>  			      dev->total_bytes);
>  			ret = -EUCLEAN;

LGTM,

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

> -- 
> 2.26.0
> 

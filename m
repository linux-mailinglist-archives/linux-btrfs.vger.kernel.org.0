Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882A8449748
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhKHPAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbhKHPAa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:00:30 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A892C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 06:57:46 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id bq14so15700106qkb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DhfVz/7YMfkyNQFAj7BO55jKCqxkWX4N63tPO7f9L3I=;
        b=jPnHLtKzg2LoE2+xqufDooPDQWA57NUbf/eRMJrTefSD1v7vzCRpLjT6CB/2Nb+fwz
         sjuGrr1ce4HQX1/5l8nAV6/e/n68xD7E0b5Ga5IMqq4QxxdXeNXf3KRH8QOuK2IC+hYp
         2r8rbuXUoCXnLkKNX8kZaIZ9W9ir25CbXpb5qsU/+EVZKFLBm38XjCfQMQLCtdI5vC7o
         Rl+LOGu1Vz0CiJdUiyf18XpvIbarQwZvtOLRlG90PsbVXLrCTlWgRqfF3yF8XY1+LZDV
         3bNRRZgO8uV6rYxguH3UO+g9LwSpm52pJxwn7cOez1RRDzL9VS/pfH70LG6HA7JTBUPz
         fn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DhfVz/7YMfkyNQFAj7BO55jKCqxkWX4N63tPO7f9L3I=;
        b=kRRmSPXFr/rZ+PzVXfjukoovuCLx5zpJ6SSICrv7q8VCZK49SwOxdRDZo1+ziXUIOR
         Uuyn5fC+4MtaxXD80gTgh5MzkaoCX+Sk7zQLetvQ/yuuWe7iUV3K2Zj4DFSDzC/P1c7i
         0aXEhJ6aMfs4sia8rkGbih0oCZxUTDu2P+K1Fy7oDIBsjMJ5gjfebkZUQYOU3ziolkKd
         utT5GCTTEbDnwGZAOXoyXoY1NDWTvu52vcVVOfS8Sqx6V7g4vCdhF5sxXPDWKpnG1K7b
         FuvPLeVXv0Un0f2wSUF8MW68K72Qk+jzo/uFBPz/4HBpIMY3A3ayDFzCzfAf1c2rLZn7
         fLpg==
X-Gm-Message-State: AOAM532VUFrIgjt+h+4nmDa19nBWAanWMq6sGgzp/MzWjYjeXrwD0Xyg
        pIyYb/8cLGsAh4mQdVVuZxeJbOZvQ96mCA==
X-Google-Smtp-Source: ABdhPJy3TwnEhU5ik2IYuUvExF7rgs5aem6r38Ksit8fmsmyxr/CAcTsCd4zZNMKbyAJKQlhej6rpg==
X-Received: by 2002:a37:44d7:: with SMTP id r206mr92282qka.421.1636383465376;
        Mon, 08 Nov 2021 06:57:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s16sm10402965qko.82.2021.11.08.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:57:45 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:57:43 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: make device add compatible with paused
 balance in btrfs_exclop_start_try_lock
Message-ID: <YYk655fYg/L+jSk3@localhost.localdomain>
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108142820.1003187-3-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 04:28:19PM +0200, Nikolay Borisov wrote:
> This is needed to enable device add to work in cases when a file system
> has been mounted with 'skip_balance' mount option.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

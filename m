Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5263A421C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFKMlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 08:41:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53212 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFKMlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 08:41:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 705B11FD3F;
        Fri, 11 Jun 2021 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623415193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/uUnemKV/YPUrxmI8PIvoG4lndIOcqM4o6jEug+6oA=;
        b=N+dMCvpxKOnuv0to7ysNxkpq9iEmX0aw7/zk9/7hbfk3Ud3+k6tqpccF8CobI65+Ukro30
        fJlQ3qw33b+aqgar/yAMMcjLYsQVByakhvrG/TlapHs/4HMEi37MUM2UbcSswN1karDctH
        99rhgpsBoEDdDrSAXFX4IHFGOO88v1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623415193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/uUnemKV/YPUrxmI8PIvoG4lndIOcqM4o6jEug+6oA=;
        b=yi2Q//J4GyD0Hm9mfUSjWX6IfJc0aFkjK0xYGcJMm2OHJHqjvphkq4XzHAQ74unc0k23Ig
        OuAnYby8zyMgEtCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5FCECA3BC2;
        Fri, 11 Jun 2021 12:39:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 522F8DA77B; Fri, 11 Jun 2021 14:37:08 +0200 (CEST)
Date:   Fri, 11 Jun 2021 14:37:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next v2] btrfs: send: use list_move_tail instead of
 list_del/list_add_tail in send.c
Message-ID: <20210611123708.GE28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Baokun Li <libaokun1@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20210611065115.1165906-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611065115.1165906-1-libaokun1@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 11, 2021 at 02:51:15PM +0800, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail() in send.c.
> And open-code name_cache_used() as there is only one user.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
>         open-code name_cache_used()

Added to misc-next, thanks.

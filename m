Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3450B45
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfFXM7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 08:59:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32877 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfFXM7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 08:59:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id w40so3753621qtk.0;
        Mon, 24 Jun 2019 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DWkkM2LQJnLqQ9mL4Q4VZowB5B9WSyjJGV//+UzbHVo=;
        b=Knj0PVJoYsFETKY1bXIB2yw4ELWyZnJDq8qsKe2o3LylTS5nGiDabO5fV0MYRSeWdU
         uDIt56Ah18UyDNojfSwhTt10HXZDnyRKUhq0S7f+ESg+9A9yvuF/n+nZMPVYLM/tLKXl
         lZXbUvL9OxJYSu3v9ELsNKoCpJAV/IEmltlgmJUbwxynyvNFooMhbfOMPduOWjuJCd6u
         FgJCKd/GhAHKvvupNMe7lSDzf5RJhi1onV4SIAsx8IEYl4kWlDsvTWXQWOEu1Cqe/glh
         qufSY3chBoB2UevXen2GOooNGibx8WYdsyDLHi4/f6qYc4TXSLQVv3wsG4nT4yyn8F8y
         QfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DWkkM2LQJnLqQ9mL4Q4VZowB5B9WSyjJGV//+UzbHVo=;
        b=BK9CQIWAdXStaLhUhTt8ugupxLmm5nt6mHndY52EqjBseeRlMLQZBExAtIEl3vAEJ4
         /h9p28Pe3H+hfmbJ/HUMK9sWmJ90oK95vEqN2MDDquMi5Nx7uZXIDjhqOjMF+GIjNCtG
         a4D735snyXWA+T1W3x4zRlJRcNss1r0ug1HsyX0BahilPKOPxNAH7q7W1ASRfT5Cq+5x
         czF16Sz+Muxi4bHFeKOzjejbYGBq9yrNWsxRvOnqTrfkuYV5cE4GJabRbVtgvwFVWNPG
         yyomA5qdmXUtE1aX9skffSHlE8ZLHAHFNuXioEVqtd/lPIAOLu1AbALFiUZNFAW4eypr
         Dr1w==
X-Gm-Message-State: APjAAAUEKCtPxVFHPlSW2xDFqVMK2IRDOTFKVjo0O+gob3z4P5u6eoER
        Iiu/r7tU9nXte+iuzhGhWkc=
X-Google-Smtp-Source: APXvYqxyqmUAN0XevsGL58UvEms4bJfE5JAIV8JURnSB2+6VQZEG0ejliEbPbHaYIW9tsKLKmkbstw==
X-Received: by 2002:a0c:b0e4:: with SMTP id p33mr48061763qvc.208.1561381140837;
        Mon, 24 Jun 2019 05:59:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8b21])
        by smtp.gmail.com with ESMTPSA id z63sm5273756qkb.136.2019.06.24.05.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:58:58 -0700 (PDT)
Date:   Mon, 24 Jun 2019 05:58:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190624125856.GO657710@devbig004.ftw2.facebook.com>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-3-tj@kernel.org>
 <20190620152145.GL30243@quack2.suse.cz>
 <20190620170250.GL657710@devbig004.ftw2.facebook.com>
 <20190624082129.GA32376@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624082129.GA32376@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, Jan.

On Mon, Jun 24, 2019 at 10:21:30AM +0200, Jan Kara wrote:
> OK, now I understand. Just one more question: So effectively, you are using
> wbc->no_wbc_acct to pass information from btrfs code to btrfs code telling
> it whether IO should or should not be accounted with wbc_account_io().

Yes.

> Wouldn't it make more sense to just pass this information internally
> within btrfs? Granted, if this mechanism gets more widespread use by other
> filesystems, then probably using wbc flag makes more sense. But I'm not
> sure if this isn't a premature generalization...

The btrfs async issuers end up using generic writeback path and uses
the generic wbc owner mechanisms so that ios are attached to the right
cgroup too.  So, I kinda prefer to provide a generic mechanism from
wbc side.  That said, the names are a bit misleading and I think it'd
be better to rename them to something more explicit, e.g. sth along
the line of wbc_update_cgroup_owner() and wbc->no_cgroup_owner.  What
do you think?

Thanks.

-- 
tejun

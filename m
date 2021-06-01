Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1693978BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhFARKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 13:10:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhFARKF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 13:10:05 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BDBF721957;
        Tue,  1 Jun 2021 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622567302;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cFmHpdN9MUUTyq4CZFEiWk1/ny33j3vulJrzpjp9OJY=;
        b=ACXExCra+mTXQm6IK7JxIK/SKWA88+kXq7KdDq72botJonBuEio7+LVVX6CPqf9U1Oa8u5
        Uz/keR/SXL8Iyj3XaNE+fsdmul4GDjkFiW10LpchE+W3ZPDAc2+jdNiQDZIHPfzj0Ils0G
        2mghlDz+uwcYWqXp2XiuD94ZSR4fj8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622567302;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cFmHpdN9MUUTyq4CZFEiWk1/ny33j3vulJrzpjp9OJY=;
        b=wRiEdBXijdF4XIAqxf31pwSiW8LF3LmqI9K+AP2HjJDMbtgoNhsdsciytq6iIMPsWoepBy
        6Spz7H8JtRJuZeBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B3461A3B84;
        Tue,  1 Jun 2021 17:08:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C0B2DDA734; Tue,  1 Jun 2021 19:05:42 +0200 (CEST)
Date:   Tue, 1 Jun 2021 19:05:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: Promote debugging asserts to full-flegded checks
 in validate_super
Message-ID: <20210601170542.GI31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org,
        syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
References: <20210531092601.107452-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531092601.107452-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 12:26:01PM +0300, Nikolay Borisov wrote:
> Syzbot managed to trigger this assert while performing its fuzzing.
> Turns out it's better to have those asserts turned into full-fledged
> checks so that in case buggy btrfs images are mounted the users gets
> an error and mounting is stopped. Alternatively with CONFIG_BTRFS_ASSERT
> disabled such image would have been erroneously allowed to be mounted.
> 
> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E39445819
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhKDRQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 13:16:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42128 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhKDRQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 13:16:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2251F218ED;
        Thu,  4 Nov 2021 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636046048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTI16dGQ0lG7FNA/kW98v3Pzn1J1rUVWMVXaoacx5Rs=;
        b=QV4ZOH7LwLfHpXoOG/qlWXSJqE1OmlOhunSoeJDzsw+pOBv9phu500mhrdvc68kiteB5Cb
        e6GLpHFDl8iIIIkCpD3b1lwdXCY8+grQZ/+I5/54xFBQQJlb6MsSz2M9p1RkinDDcf+nNx
        HZKX6B2yU2OjZ44m9DJlcRWGOcVcvOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636046048;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTI16dGQ0lG7FNA/kW98v3Pzn1J1rUVWMVXaoacx5Rs=;
        b=fC0Xezpg0FSRD3detpYLvVNk/JrHZJLDyhqzImmLu81z/ISLhZxy9O2KHrAbgUAFeYGLte
        qOczkR+ajbj13XDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16F5F2C154;
        Thu,  4 Nov 2021 17:14:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7FA9DA781; Thu,  4 Nov 2021 18:13:31 +0100 (CET)
Date:   Thu, 4 Nov 2021 18:13:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove spurious unlock/lock of unused_bgs_lock
Message-ID: <20211104171331.GB28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211014070311.1595609-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014070311.1595609-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 10:03:11AM +0300, Nikolay Borisov wrote:
> Since both unused block groups and reclaim bgs lists are protected by
> unused_bgs_lock then free them in the same critical section without
> doing an extra unlock/lock pair.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next. The cond_resched in the loops still makes sense but
is for another patch.

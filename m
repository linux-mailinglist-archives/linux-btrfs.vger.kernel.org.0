Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE53F4A0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhHWLtr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:49:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34804 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhHWLti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:49:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34C4221F54;
        Mon, 23 Aug 2021 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629719335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Av+KU/0Oe3IVMkKQNObVeRwwUe1eoP12ErEzaHumtxw=;
        b=XJFT0ZqA/xEjdA6DNl+rDVTP2zlO/X3aqf9wSkS7ToWyk0EfIcLPMW4vi1jljPw6ExC27c
        RvJYGAFbUSpMUadz1HXF5GR7fZrbm4hdWoWoD9RTu2WCSfUj5Vtsh+jt4Um6O166SCqoFQ
        5puPwCJaFQpaG+/g8ceO0i3+urwpNcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629719335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Av+KU/0Oe3IVMkKQNObVeRwwUe1eoP12ErEzaHumtxw=;
        b=sx7dHaXJ2fPXgS7nWr0XA2k/wL+N8AAAdtqcC+QSp5AonXW1b+3Ga2kflajM1nMdz6L5d9
        7sFE6Auzir8bfJCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 29A9EA3BC0;
        Mon, 23 Aug 2021 11:48:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1769DA725; Mon, 23 Aug 2021 13:45:55 +0200 (CEST)
Date:   Mon, 23 Aug 2021 13:45:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH v3 0/4] btrf_show_devname related fixes
Message-ID: <20210823114555.GX5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 07:28:38PM +0800, Anand Jain wrote:
> These fixes are inspired by the bug report and its discussions in the
> mailing list subject
>  btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
> 
> v3:
>  Fix rcu_lock in the patch 3/4

Please next time send a separate patch with another revision, the
threading is a total mess, look

https://lore.kernel.org/linux-btrfs/7171ca39-8f57-4646-face-70d3d23fbf02@oracle.com/T/#t

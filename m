Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF87B449CDD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 21:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhKHUJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 15:09:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43064 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhKHUJ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 15:09:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6790921B0B;
        Mon,  8 Nov 2021 20:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636402002;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Xx006MWHd2uLefGTTXOqBzasP8D7Rf4t9gtBDX29i4=;
        b=i40IpDbum9Gp/VMQuyMePGjoflJNyEm8HzqzB94TbomnI/t6N0cXpc0LXoASsc8YF532B7
        CHJGU1msG0i7pwGWD7HTZ0/WsM7OAtNapmmNG0SkyQfNtm1alGQtrHKEseAJ9fxdJ0qt38
        Xpmsd4gb2iXclVX1tXHP9XyVuCaEzSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636402002;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Xx006MWHd2uLefGTTXOqBzasP8D7Rf4t9gtBDX29i4=;
        b=p7sqvMao94ysUVATeX+98tqlLUtDK8fXFKyY7L6JzK3+rdxoeohOWqyqiWW5nGoE7MiWpP
        7QbRYeRjCgbb6CAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 61667A3B87;
        Mon,  8 Nov 2021 20:06:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2CF1DA799; Mon,  8 Nov 2021 21:06:03 +0100 (CET)
Date:   Mon, 8 Nov 2021 21:06:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 1/3] btrfs: declare seeding_dev in init_new_device as
 bool
Message-ID: <20211108200603.GP28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <cover.1632179897.git.anand.jain@oracle.com>
 <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
 <6fea27d3-1eb7-4725-b894-1a742d6e5c3d@oracle.com>
 <58acdca4-a716-7144-e75c-0810bac754b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58acdca4-a716-7144-e75c-0810bac754b4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 12:39:54PM +0800, Anand Jain wrote:
> 
>   2nd try. Ping?
> 
>   (Pls note, patch 2/3  dropped based on Nik's comments.  patch 3/3 
> separated from this set, as it went thru revisions and not related)

Patch 1 added to misc-next, thanks.

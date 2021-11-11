Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B444D8DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhKKPIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 10:08:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhKKPI3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 10:08:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D72CA21B28;
        Thu, 11 Nov 2021 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636643139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCsCOvgbZ6+yZw0Fm6M5W91m+irwNnifQFZTCIJy4Lo=;
        b=TK/fE8d8IpZt3n1wR5yag4ia/hX11qGy6gdG55j4hDliZP0qo50G2eqjyskEY/Gi/+axC5
        U89VI+TabACodNS9DlWpDEJ7HsGc+lpKz56u6GPgehfDN2FPRvJVFXc8SkgUhs1pE1V04j
        Pbi2VPWlDxoLY5hnpbHRADdNO5UWl1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636643139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCsCOvgbZ6+yZw0Fm6M5W91m+irwNnifQFZTCIJy4Lo=;
        b=ZWVhyTWXUiLyS6Xar2LbSrV2zQS483On9BDinWT2M1u4WbcvvD2AIa4PAsvGroAJaw+dyi
        +z70qUtRcvOis4Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D0458A3B8B;
        Thu, 11 Nov 2021 15:05:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28033DA799; Thu, 11 Nov 2021 16:05:39 +0100 (CET)
Date:   Thu, 11 Nov 2021 16:05:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x Balance vs device add fixes
Message-ID: <20211111150538.GF28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108142820.1003187-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 04:28:17PM +0200, Nikolay Borisov wrote:
> Here's v2 of the patchset allowinig to add a device if we have paused balanced.

I haven't figred out any problematic state. As the paused balance is
a note about the request filters and progress, restarting balance with a
new device will apply accordingly. The result will be of course
affected, eg. chunk layout or allocation order, but other than that I
think it's fine.

One remaining thing is to teach progs that there's a new state and how
it's compatible. This needs to mimic the logic in kernel. As it's a
simple change it can go to any release before the kernel changes get
released.

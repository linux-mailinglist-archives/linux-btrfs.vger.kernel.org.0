Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB5443FCB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJ2Mzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 08:55:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49260 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhJ2Mzc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 08:55:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 27FDE1FD65;
        Fri, 29 Oct 2021 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635511983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BL0X6M+QIrpizYGDbr7+BVnUeMlbZqi1Bv6eM3mA81I=;
        b=i5EcHRWNv7V/p3d4KCKwJ5he1ac2bAayIQ7px8wUKoEagr1Y8I0mXXpEGuQ/MFx+/M05iA
        CR0K5vC31/0up8mMdploZjhXDyp6Ot1EYfQrVMGoDg/UDyg4/TaykHG9QlK7tFcfIqR1y+
        Kx17jlNn7WDZg3zxjH42jdOnJIXO3HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635511983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BL0X6M+QIrpizYGDbr7+BVnUeMlbZqi1Bv6eM3mA81I=;
        b=l7weRgiVyWNv6hhQwVzS1JI6hfGwPql3cMcjt5QWRMrXvaERvYTDBZ8EthaKl1Ax9CcABy
        NDJZt6qVQayLiVDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1FA41A3B85;
        Fri, 29 Oct 2021 12:53:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0FB5EDA7A9; Fri, 29 Oct 2021 14:52:29 +0200 (CEST)
Date:   Fri, 29 Oct 2021 14:52:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     grub-devel@gnu.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
Message-ID: <20211029125229.GY20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        grub-devel@gnu.org, linux-btrfs@vger.kernel.org
References: <20211016014049.201556-1-wqu@suse.com>
 <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 03:36:10PM +0800, Qu Wenruo wrote:
> Gentle ping?
> 
> Without this patch, the new mkfs.btrfs NO_HOLES feature would break any 
> kernel/initramfs with hole in it.

Just to clarify, it's not a new feature, it's been out for a long time
(since 3.14).  The new thing is that it's going to be enabled by default
so the potential impact would be higher.

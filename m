Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFECB44C453
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhKJP1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 10:27:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56590 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhKJP1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 10:27:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A9F641FD33;
        Wed, 10 Nov 2021 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636557883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIyMyy5jZam3Ff+EFoHxe8b+fewZDGtIeXor0Brysq4=;
        b=fFdV3BkJfAdXZZgbkAAaL/vbVQAyg96mIyPBfh5kdo3Sn4YWA/MZZSXWYHQi2zRH8064eb
        sOESz4kIyp1rujqGtE4n71RgFLAbaXqRZLGCnyJd35tsaWI9v7042I2XTGCVo+rFDybcQY
        L7NliVrBHH+dxeUt1VAWAIERw3tK8yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636557883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIyMyy5jZam3Ff+EFoHxe8b+fewZDGtIeXor0Brysq4=;
        b=cbNlb+x7kbw61NO0gJ1X9Gt8aQQX2TkAqkrx6WHMBOCKMG/bD0Hid3B61TV7jyN9KyPY11
        6YmTES04KiGfbMCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 24526A3B81;
        Wed, 10 Nov 2021 15:24:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA905DA799; Wed, 10 Nov 2021 16:24:03 +0100 (CET)
Date:   Wed, 10 Nov 2021 16:24:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_IOC_BALANCE ioctl
Message-ID: <20211110152403.GV28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211110114104.1140727-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110114104.1140727-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 01:41:04PM +0200, Nikolay Borisov wrote:
> The v2 balance ioctl has been introduced more than 9 years ago. Users of
> the old v1 ioctl should have long been migrated to it. It's time we
> deprecate it and eventually remove it.

Agreed. I maybe put this patch to the 5.16 queue, there's not much
reason to delay it and it's not a functional change.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440D244D601
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 12:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhKKLoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 06:44:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhKKLo3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 06:44:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C85321B35;
        Thu, 11 Nov 2021 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636630899;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cx/y3EzzAMc48cJquyFRWZduJjFjXrXxaEZM1nDjuc=;
        b=Ry5HumbVhs2Mjzk6+PLxH1fdoUfVzq9HQvao7vLoej/ylRlSmiJKiMMqrfK5TCgK8FXbPl
        ffPlAT7GBxH3w8r0vKVvtnzpLSQgCMfHqq1ftBN1QPGSMk5liA8YfnH9aSf83hykdX68d1
        S+YiCYwW5FQRrJUy/so/gyxd2nyCTlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636630899;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cx/y3EzzAMc48cJquyFRWZduJjFjXrXxaEZM1nDjuc=;
        b=IXdk0zf7qj0F7nrnhEaLbU6SsXuRGc4uEBduvRb5kdOWr4PhmfHK2kaA3vHAEEB81tNXkn
        D/5v1D+j8fmyP3Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2584DA3B94;
        Thu, 11 Nov 2021 11:41:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99EFBDA799; Thu, 11 Nov 2021 12:41:38 +0100 (CET)
Date:   Thu, 11 Nov 2021 12:41:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused parameter fs_devices from
 btrfs_init_workqueues
Message-ID: <20211111114138.GA28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20211110064217.98007-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110064217.98007-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 02:42:17PM +0800, Su Yue wrote:
> Since commit ba8a9d079543 ("Btrfs: delete the entire async bio submission
> framework") removed submit workqueues, the parameter fs_devices is not used
> anymore.
> 
> So remove the parameter, no functional changes.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to misc-next, thanks.

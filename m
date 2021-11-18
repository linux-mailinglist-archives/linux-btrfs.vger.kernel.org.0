Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74139455DA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhKROOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 09:14:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41784 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhKROOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 09:14:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F358E21891;
        Thu, 18 Nov 2021 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637244694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65QucN6r0OlIYtl+/hrVM2DwIyO7fLFMdsrYKR11s3g=;
        b=SU7BW7SbMHv8KtbKxCLZva0Tjc01TuE4ctpsAIp+nBLjD2QarNM/MEO6hhiM1319cgHsXE
        wuIRL1Zth86AyTchPHRGNSC/zDQk8bPObvpgUJas48pbmq/JIDaNTxwYObmoAeS9qCErD5
        Qm87rL2tKl8Jsulow1AWbeDSNWrclUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637244694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65QucN6r0OlIYtl+/hrVM2DwIyO7fLFMdsrYKR11s3g=;
        b=rDrrnCqvwYwfkXObi2Ss9ACn3v7sdgBRPGWid7h0jD1uOBYgnuVwuQ9JFZzDz41rQ8ax3b
        RJVvxLIYcWVk5EBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E9EECA3B88;
        Thu, 18 Nov 2021 14:11:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 81025DA735; Thu, 18 Nov 2021 15:11:29 +0100 (CET)
Date:   Thu, 18 Nov 2021 15:11:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 11/17] btrfs: send: remove unused
 send_ctx::{total,cmd}_send_size
Message-ID: <20211118141129.GB28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <27b1a93caae1666ea29ea76f3eb6a7aa2878e65e.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27b1a93caae1666ea29ea76f3eb6a7aa2878e65e.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:21PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We collect these statistics but have never used them for anything.

There was a protocol extension to put the progress information to the
stream, so that should be also part of the v2 update.

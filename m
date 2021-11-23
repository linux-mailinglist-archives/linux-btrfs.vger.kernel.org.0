Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687CA45A65B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKWPRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 10:17:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41212 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbhKWPRH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 10:17:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1397321940;
        Tue, 23 Nov 2021 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637680437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXCOqfkFyBq2dq9RvUyd3Ay3AuTDWCffLSzpgupEri0=;
        b=RxzItaXUSBDpO9RCUAnnaLnsH/kzB1aNNCWcxiWHQ3osNxWa+XmcOExFX1yzgw2uzh6dg1
        9My94x47+LVmA1VNqZA+hBkU94DlaCSLAtbWan4P8g003j+avmqjz9VQ+USAm+WpwRHaGl
        ZJkpgiyZqEMv5ZmG9DwZJfXvGIsM5OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637680437;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXCOqfkFyBq2dq9RvUyd3Ay3AuTDWCffLSzpgupEri0=;
        b=6g7M0odzBr1Y+qoGPF4kowq2ORYtGzOX0/JOhuWYEgo0o1wAi6qZsEcwHwGQqS+M1AQMrC
        zgEHUOp68kYLfIAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E3691A3B85;
        Tue, 23 Nov 2021 15:13:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2AA0DA735; Tue, 23 Nov 2021 16:13:49 +0100 (CET)
Date:   Tue, 23 Nov 2021 16:13:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fail if fstrim_range->start == U64_MAX
Message-ID: <20211123151349.GQ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 05:04:19PM -0500, Josef Bacik wrote:
> We've always been failing generic/260 because it's testing things we
> actually don't care about and thus won't fail for.  However we probably
> should fail for fstrim_range->start == U64_MAX since we clearly can't
> trim anything past that.  This in combination with an update to
> generic/260 will allow us to pass this test properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.

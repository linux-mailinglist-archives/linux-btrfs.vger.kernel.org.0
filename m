Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC01F4027AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbhIGLUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:20:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbhIGLTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:19:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC0B21FF66;
        Tue,  7 Sep 2021 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631013528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYgc/YN5fhPIegT1smXoRY8H9Dk3xCg9+25XuSoJXtM=;
        b=w8QILQx8vvj5mpHQoYc+Xc0Vdg/LER14qwFOnnsqkaZ/Std/HjPRMDslvafAAVOsi/p9gE
        LxoKLiuz02cgtWWOy50Egd1CvA3A2B3bXLWlvo7EPo7jvr+7qqkQOZxhnrnGl5NFFmwBnE
        HmKA5jXavwaJs02LWhrvaW9yrf5oEyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631013528;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYgc/YN5fhPIegT1smXoRY8H9Dk3xCg9+25XuSoJXtM=;
        b=g12vCyUxPgY0qgTU6+6uRGKtQZ2n/UQUntmqZPgY2aNybRA/hOECCYkwthMGRi6Fq+FT1T
        5Edb2fIfBliZlaAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BE52AA3B96;
        Tue,  7 Sep 2021 11:18:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2033DA7F3; Tue,  7 Sep 2021 13:18:44 +0200 (CEST)
Date:   Tue, 7 Sep 2021 13:18:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: fix double counting of split ordered extent
Message-ID: <20210907111843.GJ3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210906150428.2399128-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906150428.2399128-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 07, 2021 at 12:04:28AM +0900, Naohiro Aota wrote:
> btrfs_add_ordered_extent_*() add num_bytes to fs_info->ordered_bytes.
> Then, splitting an ordered extent will call btrfs_add_ordered_extent_*()
> again for split extents, leading to double counting of the region of
> a split extent. These leaked bytes are finally reported at unmount time
> as follow.
> 
> BTRFS info (device dm-1): at unmount dio bytes count 364544
> 
> This commit fixes the double counting by subtracting split extent's size
> from fs_info->ordered_bytes.
> 
> Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sent")
> Cc: stable@vger.kernel.org # 5.12+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

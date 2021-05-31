Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A307639682D
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEaSyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 14:54:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhEaSxw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 14:53:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622487131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P2+XpL6bA1dWzOKKx24TJXR/xOmW/lymET7Xy13OfQ=;
        b=q67FgBAOsH6xBBroRAlWYofi3/3OvoqWy3sRCaPFY/r68B1NI87KELJJa90TKR9d9Ad9CU
        FNWBTaFlu3ozF4jNwLKPpA7bXqmHFSKFGPQ6NoruQx9Mk4d2Pf77xkLgMa/emuYEQQ4HI4
        WQmzl8LsWOuhKbvMK2asgNEl/JCShRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622487131;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2P2+XpL6bA1dWzOKKx24TJXR/xOmW/lymET7Xy13OfQ=;
        b=aoDbSOtSbJYwqxaykVmQa4MtQU4D7NOW+2BqD1W0a2/nQSWSSl/gcPq9060F3WJG4eviRK
        P+Wq1FDmZLHfzACw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC023B723;
        Mon, 31 May 2021 18:52:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 17722DA70B; Mon, 31 May 2021 20:49:32 +0200 (CEST)
Date:   Mon, 31 May 2021 20:49:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH] btrfs: Fix return value of btrfs_mark_extent_written()
 in case of error
Message-ID: <20210531184931.GE31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <76ddeec8b7de89c338b8cb94ee2c4015a0be6e2f.1622386360.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ddeec8b7de89c338b8cb94ee2c4015a0be6e2f.1622386360.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 30, 2021 at 08:24:05PM +0530, Ritesh Harjani wrote:
> We always return 0 even in case of an error in btrfs_mark_extent_written().
> Fix it to return proper error value in case of a failure.

Oh right, this looks like it got forgotten, the whole function does the
right thing regarding errors and the callers also handle it.

> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> Tested fstests with "-g quick" group. No new failure seen.

That won't be probably enough to trigger the error paths but the patch
otherwise looks correct to me. Added to misc-next, thanks.

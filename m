Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23B453736
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhKPQXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 11:23:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhKPQW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 11:22:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BAE591FD2A;
        Tue, 16 Nov 2021 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637079601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcaAS2s6f7BU4zubwQrjWhqJHtEnG7thACiNBEHHyeA=;
        b=ojMk/qzVylQMB004sj0nxFEtuozT8L5IW1wkWzkNdQ+7rhs1I1bJVLEHKLrwgPXGI0wtk1
        r1s1Zm6oh61kakcFAXzeIBqW248P8yNTdlyCUkvkNiQ3eyfxk0SrzhdmSW6pvcF+n1i0sL
        rd57f4swVWnTOVv0IbIeyZksGad+X08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637079601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcaAS2s6f7BU4zubwQrjWhqJHtEnG7thACiNBEHHyeA=;
        b=qEFyKxZLyM7NQsBwN9yHeOst3yEAo+pQU662HGCByOmrcoon9arg5m3UqE2j5xlP3T1jAw
        n97ufiEyCDUQ7zBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B295EA3B81;
        Tue, 16 Nov 2021 16:20:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5BBEADA799; Tue, 16 Nov 2021 17:19:58 +0100 (CET)
Date:   Tue, 16 Nov 2021 17:19:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix error pointer dereference in
 btrfs_ioctl_rm_dev_v2()
Message-ID: <20211116161958.GS28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20211116115025.GC11936@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116115025.GC11936@kili>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 16, 2021 at 02:50:25PM +0300, Dan Carpenter wrote:
> If memdup_user() fails the error handing will crash when it tries
> to kfree() an error pointer.  Just return directly because there is
> no cleanup required.
> 
> Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Added to misc-next, thanks.

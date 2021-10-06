Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA64424689
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhJFTNu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 15:13:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFTNu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 15:13:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 08B7822575;
        Wed,  6 Oct 2021 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633547517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHVU5WP110KisfZPpW9C0kGrH2/xG0qpfLIIsJSydSg=;
        b=aLmuOU6/ZjcZt/h3LM7kqWo2czUZHDOkl5ccrMYt0PH1eZzZ9sd1f68Ey9/w9c+9yHFUBK
        a1MdKLWv519N+PBegJgXhM3PBF/+adK6bsrjNp2S8fdjuzLaS+34CRaJOMEzJ2aW5eVjBs
        zKy3J2plrt8E8VeO1bxPaE9ltpDs8io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633547517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHVU5WP110KisfZPpW9C0kGrH2/xG0qpfLIIsJSydSg=;
        b=3QljKFK0mJ4xvaT2T0h9xxeZgtpB8VinvNXXSOdeckSsKaa1b9CsM9eNPSBazJ1HdxJeZb
        cMBkBDoE5XltozAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E8D3CA3B81;
        Wed,  6 Oct 2021 19:11:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 908E8DA7F3; Wed,  6 Oct 2021 21:11:36 +0200 (CEST)
Date:   Wed, 6 Oct 2021 21:11:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 3/5] btrfs: add a BTRFS_FS_ERROR helper
Message-ID: <20211006191136.GV9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1633465964.git.josef@toxicpanda.com>
 <6a296199cacaf7ec138e8e25d6cbf79644434bbf.1633465964.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a296199cacaf7ec138e8e25d6cbf79644434bbf.1633465964.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 04:35:25PM -0400, Josef Bacik wrote:
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
> -	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
> +	if (BTRFS_FS_ERROR(fs_info))

This is not a 1:1: change as it drops the TRANS_ABORTED check. This was
added in af7227338135 ("Btrfs: clean up resources during umount after
trans is aborted") and is not specific under what circumstances it
actually is needed and not covered by the fs error.

I think the fs error should be enough and if we are a able to catch the
assertion where it's not covering the resource leak, it needs to be
fixed there. The special case without a proper explanation is strange
and I don't mind removing it.

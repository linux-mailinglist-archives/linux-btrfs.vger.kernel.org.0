Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3ED4614ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346264AbhK2MZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 07:25:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244158AbhK2MXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 07:23:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 479A4212CB;
        Mon, 29 Nov 2021 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638188390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgPU6mcFlgYJ+O0zHg4E3RsYyCxRhd0CaMigQ7SA0us=;
        b=d5g9OnGuHBxhV769r1jMBenJiuzMB75c0IR11E6fp3rH6vX/RAeBCoZ4o/j0nVBbOEJsHv
        z5H+1hSaT3L9t94e36YkUSSAkqOall35t215sLhERISTuAlBHSPeWETlQRNR8yzGAcRIjK
        kmQx/S/TqqfxWAFZNttd7BabSDhiP5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638188390;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgPU6mcFlgYJ+O0zHg4E3RsYyCxRhd0CaMigQ7SA0us=;
        b=Q+GCVAOWXi5DK5spp7IIzh4VLd3Zv1oNnsCtWvuFZGcJRuR88oYWSTq3EC/CV7mVtlzn6B
        fLEaA1Bt/hRxL6Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 10B25A3B87;
        Mon, 29 Nov 2021 12:19:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4E67DA735; Mon, 29 Nov 2021 13:19:39 +0100 (CET)
Date:   Mon, 29 Nov 2021 13:19:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Message-ID: <20211129121939.GD28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211129024930.1574325-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129024930.1574325-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 11:49:30AM +0900, Naohiro Aota wrote:
> For zoned btrfs, we re-dirty a freeing tree node to ensure btrfs write
> the region and not to leave a write hole on a zoned device. Current
> code failed to re-dirty a node when the tree-log tree's depth >=
> 2. This leads to a transaction abort with -EAGAIN.
> 
> Fix the issue by properly re-dirty a node on walking up the tree.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/415

Can you please add more information from the issue that's relevant to
the problem? Eg. the stacktraces, reproducer etc.

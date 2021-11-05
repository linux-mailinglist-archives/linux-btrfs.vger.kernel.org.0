Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4944462FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 12:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhKELxy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 07:53:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58646 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhKELxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 07:53:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E8AAB212BC;
        Fri,  5 Nov 2021 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636113073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLnNnciQBxIm9dixRppFJ+O0DJZUtntS5N+qiTHFsOk=;
        b=QGKUrVmHdbFSvfebjLm7+PDrDmzpoOQtFZFoS59vEbTVIX4uuhIpHnl5pykPRAhrGHapY/
        z2FSUQLoQDc/O9bz9g7pOpXvLyq0BtraoJDF0t4ZGzaPNMNKX9yrgQVd9OwYS3fmFwafiW
        ZCkrR/IZGyWX77Xk1bfLrA/nReXpZvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636113073;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLnNnciQBxIm9dixRppFJ+O0DJZUtntS5N+qiTHFsOk=;
        b=XmnFOHLvbF63Qn7w8zeOmTQNgGsCVcSCapG2I/0BL4ozfL6aDd9X3CWUMC32fGXnA8mV68
        F5z6PhRZ/4GLdcAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E19802C144;
        Fri,  5 Nov 2021 11:51:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF83CDA735; Fri,  5 Nov 2021 12:50:36 +0100 (CET)
Date:   Fri, 5 Nov 2021 12:50:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs-progs: balance: print warn mesg in old command
Message-ID: <20211105115036.GH28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211031131011.42401-1-realwakka@gmail.com>
 <20211105160541.ED15.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105160541.ED15.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 04:05:41PM +0800, Wang Yugui wrote:
> Hi,
> 
> This patch broken tests/cli-tests/002-balance-full-no-filters.
> 
> becasue this
> 	printf("WARNING:\n\n");
>         printf("\tFull balance without filters requested. This operation is very\n");
> is put after fork() in this patch when '--backgroud';

Right, I ran all the other tests than test-cli. I'll remove the patch
from 5.15 queue.

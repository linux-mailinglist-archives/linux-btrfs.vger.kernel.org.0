Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809EC4983BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiAXPpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 10:45:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiAXPpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 10:45:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C66DD218ED;
        Mon, 24 Jan 2022 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643039104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W63PHqmSZpJFIwNzYmTn0bme7WdT8iSMgPfYJ8Hda70=;
        b=y38OI8t6nNvHogS2/iS/hbU2W6x44CjOrYUpnC8X+qNKetE2sADw/x0Up8LohI5UtkOhcM
        8rVsfD7F0gOdrRvBHSPAXFTnzA+ADzgX0NyKkNNXr3xwzDWPZeesNhlbsemL/qS7bTfpVQ
        BXz2oTO2tLpj/rVwL6VwyPVyuKx1IbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643039104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W63PHqmSZpJFIwNzYmTn0bme7WdT8iSMgPfYJ8Hda70=;
        b=qfOPJXsBZSM8hFHiWA8KE9drrQ+TbVmYZnQMwcqXAt+01Di996tuTS6qw9cJb9Kc/541Oy
        0JHIMG1uW2q0rdDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BC5E0A3B83;
        Mon, 24 Jan 2022 15:45:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D54ACDA7A3; Mon, 24 Jan 2022 16:44:24 +0100 (CET)
Date:   Mon, 24 Jan 2022 16:44:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Simple two patches for tree checker
Message-ID: <20220124154424.GX14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20220121093335.1840306-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121093335.1840306-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 21, 2022 at 05:33:33PM +0800, Su Yue wrote:
> Two commits for enhancing tree checker to reject the img from
> https://bugzilla.kernel.org/show_bug.cgi?id=215299.
> 
> Su Yue (2):
>   btrfs: tree-checker: check item_size for inode_item
>   btrfs: tree-checker: check item_size for dev_item

Nice, added to misc-next, thanks. I'll update and close the bug.

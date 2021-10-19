Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD7433BC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhJSQNP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 12:13:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhJSQNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 12:13:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2B01321973;
        Tue, 19 Oct 2021 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634659861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O90+KZM2iZPmlCb3hqFrRmXG85owEXZ1q4LQnplLhuc=;
        b=SnPITRKA+fo4Ku8gUykE75KwqcAVJPw3AjWwPkcimJZlEraRitOs/SSfULrwTV6gHlwDVW
        vd6YjrmPcDtxTnGGAAT6LCVvv3zx6LYubo4Pj6HjL3wI8yutrTMeBh8wxsh0k9RLyVQ/VG
        dHGQXiO2cN3euYv6rQff5YcaVwdzgvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634659861;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O90+KZM2iZPmlCb3hqFrRmXG85owEXZ1q4LQnplLhuc=;
        b=MpOXZ7WxmTckMtaUGy+Q3wDzMIHAqWnTyMaeeM9UDVqs+OSQxgdIMWl1L7L5EWq8gzmKCe
        gdu06obILzGcXEBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2457CA3B85;
        Tue, 19 Oct 2021 16:11:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 790D1DA7A3; Tue, 19 Oct 2021 18:10:33 +0200 (CEST)
Date:   Tue, 19 Oct 2021 18:10:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: move btrfs_super_block to
 uapi/linux/btrfs_tree.h
Message-ID: <20211019161033.GV30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211019112925.71920-1-wqu@suse.com>
 <20211019112925.71920-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019112925.71920-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 07:29:25PM +0800, Qu Wenruo wrote:
> Due to the fact that btrfs_tree.h contains all the info for
> BTRFS_IOC_TREE_SEARCH, it's almost the perfect location of btrfs on-disk
> schema.
> 
> So let's move struct btrfs_super_block to uapi/linux/btrfs_tree.h,
> further reducing the size of ctree.h.

The definitions of tree items are in the public header due to the search
tree ioctl, but why do you want to make superblock public? Ie. what user
space tool is going to use it?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE73B0271
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFVLMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 07:12:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48082 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhFVLMI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 07:12:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 33C4F21988;
        Tue, 22 Jun 2021 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624360192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ma8aDK2A9VngUKG1CUPkRhnKiKf45k5KtH2dnv7lN+s=;
        b=nKIZMmhwylMSwpA7X6JzV8ZpWiCwc7PxTs75MCmiJAvm2RUrDcpCcbnUIzqvpUVfsqI11U
        IxZ+E/ZlnmSpFMzqAmM3vVQSKuskYgnpuu4y03yF/hJSAvBkqkwW+60/cPFSP3AMt/iU2s
        sHnDjRKYEL6k56La15xeLhQSHWN0Ksc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624360192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ma8aDK2A9VngUKG1CUPkRhnKiKf45k5KtH2dnv7lN+s=;
        b=9ImtZ5J2jqlFAXtTBxG+jwwvsK/J59ijmwG0ooERRaoHwb4CVnekCQTWusSSg4MJn6FwHb
        ckUuvRQKgpkPFfCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2D98CA3B92;
        Tue, 22 Jun 2021 11:09:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 942A4DA7F9; Tue, 22 Jun 2021 13:07:01 +0200 (CEST)
Date:   Tue, 22 Jun 2021 13:07:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: send: fix crash when memory allocations
 trigger reclaim
Message-ID: <20210622110701.GD28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1624269734.git.fdmanana@suse.com>
 <33fc2ecb82f1e020c2e4ae7bd51a261a4134e090.1624269734.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fc2ecb82f1e020c2e4ae7bd51a261a4134e090.1624269734.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 21, 2021 at 11:10:39AM +0100, fdmanana@kernel.org wrote:
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -122,8 +122,6 @@ struct btrfs_transaction {
>  
>  #define TRANS_EXTWRITERS	(__TRANS_START | __TRANS_ATTACH)
>  
> -#define BTRFS_SEND_TRANS_STUB	((void *)1)

Good riddance.

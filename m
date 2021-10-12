Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21842A2CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhJLLGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 07:06:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhJLLF7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 07:05:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 129BE22098;
        Tue, 12 Oct 2021 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634036637;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0neIauyPDBIU/AGUXLKvWG+1CUu4uVU1utj5vqzRJU=;
        b=DCqieuMkHzPaez5ZcxavZ0Fpkz3fOXrpRk22z+JiqEgTWkEgI602p/c6xnbVwWUBXQ8CpN
        Z8WRCzDAk2SgL+A3dcG455uXJrfdqCdl/ArXxJb+4uVSrj6AuvK2HRD7bej5iYvo8P2k2S
        B9QrHCbpAdessmxnVUUfZeeVhTXyGng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634036637;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0neIauyPDBIU/AGUXLKvWG+1CUu4uVU1utj5vqzRJU=;
        b=Ag35vQ9y5GLLJlZM9pFnohrLINdMO1DBFIoTM9yOBV+Z4L8+HSDAQhhMcnqvyaH3th0+6l
        1Zir/4vJHIaQYDAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0C353A3B81;
        Tue, 12 Oct 2021 11:03:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65DDBDA781; Tue, 12 Oct 2021 13:03:33 +0200 (CEST)
Date:   Tue, 12 Oct 2021 13:03:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Make real_root used only in ref-verify
Message-ID: <20211012110332.GY9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012082137.1476078-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012082137.1476078-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 11:21:32AM +0300, Nikolay Borisov wrote:
> Updated version incorporating David's feedback:
> 
> * Used the short form of the ternary operator in the last patch
> * Made all patches subject lines begin with lower case
> * Expanded the condition in the 4th patch when setting skip_qgroup
> 
> Nikolay Borisov (5):
>   btrfs: rename root fields in delayed refs structs
>   btrfs: rely on owning_root field in btrfs_add_delayed_tree_ref to
>     detect CHUNK_ROOT
>   btrfs: add additional parameters to
>     btrfs_init_tree_ref/btrfs_init_data_ref
>   btrfs: pull up qgroup checks from delayed-ref core to init time
>   btrfs: make real_root optional

Added to misc-next, thanks.

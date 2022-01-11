Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9349848B2CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiAKREI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 12:04:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbiAKREF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 12:04:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5849E2170C;
        Tue, 11 Jan 2022 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641920643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=voAhGyz9uxAvcOT44KXLmaswAMSoxRbPV67gKWAhgak=;
        b=tFBF+/HgVGFEAJ6B443nGSMcGci4IwzxyVsg1kDuc3fmfrmGx3Om9cWD6wa7Vqw1dujEPD
        YwGMPxoLyWrndmbeOIEbqBdqn+wEXQSw9krtkF4JLuXsDVQ0O/U+tD9LSniRNorMZ0dD6V
        9stg12S4UgsJz9jyhWOmUixig/DVzhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641920643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=voAhGyz9uxAvcOT44KXLmaswAMSoxRbPV67gKWAhgak=;
        b=/ZqilvcQ47RKBPBwQZfJgc4ZCC5BaECHCVB1TUm9L7HCuDAzwAyIdYdwiyoj1rG3LdvjTF
        rs1SpMdPYaztLlDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5166DA3B84;
        Tue, 11 Jan 2022 17:04:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45C56DA7A9; Tue, 11 Jan 2022 18:03:30 +0100 (CET)
Date:   Tue, 11 Jan 2022 18:03:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: Remove redundant fs uuid validation from
 make_btrf
Message-ID: <20220111170330.GU14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220110090155.1813901-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110090155.1813901-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 11:01:55AM +0200, Nikolay Borisov wrote:
> cfg->fs_uuid is either 0 or set to the value of the -U parameter
> passed to mkfs.btrfs. However the value of the latter is already being
> validated in the main mkfs function. Just remove the duplicated checks
> in make_btrfs as they effectively can never be executed.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> v2:
>  * Properly "copy" the cfg->fs_uuid into the superblock's fsid field. This fixes
>  a failure in 002-uuid-rewrite.

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509474350DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTREX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 13:04:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51348 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTREW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 13:04:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7AD3321960;
        Wed, 20 Oct 2021 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634749327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40U8pbwnESEh9QWZ9/69EDu7l3wpr94YISf3gKeel28=;
        b=b98FfOl9doEE3zvuOmhIpgfuaZq62G460BxaCQL+rufQ9w2B2DzlIO4Hrt22F0UJxDTxKc
        /SsEPGrkxQdrMh3aL8rI55CDEyDGvSy7S6m8LxCXAwIwVivQAaON/4uDlIY31SB0wc4jNM
        cOoc/y8VEDj1mM/URYL6WpyC8GzTt84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634749327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40U8pbwnESEh9QWZ9/69EDu7l3wpr94YISf3gKeel28=;
        b=H5JPfPJ2DIPff2PA4kWZhi4R9eOaUe6pGtYBtv1rbv2i+x2YXrzmm+D6EmSCffvm/bh5Zq
        q7n6eyQ0mQr/3aCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 741D3A3B8A;
        Wed, 20 Oct 2021 17:02:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58C83DA7A3; Wed, 20 Oct 2021 19:01:39 +0200 (CEST)
Date:   Wed, 20 Oct 2021 19:01:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs-progs: use btrfs_pwrite in place of pwrite
Message-ID: <20211020170139.GA30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211020065701.375186-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020065701.375186-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 03:57:01PM +0900, Naohiro Aota wrote:
> We need to use btrfs_pwrite instead of pwrite to ensure the writing to
> O_DIRECT file works.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to devel, though it does not fix the problem with creating zoned
on a file image.

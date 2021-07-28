Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20E3D8C85
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhG1LKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 07:10:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38550 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbhG1LKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 07:10:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C90922227A;
        Wed, 28 Jul 2021 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627470646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjhMAkXymGppxfXLi/CbrGSCGFIf/dycTdHBF+exDXI=;
        b=jojYiBdd135QUk/CAWiD9jucao6xylfxpPvRtI7LgQDfZdTRBBtNKIuEbEsfFB9SdDSfvY
        7Ar6Q9T142e8qRvQ9DHUDhbX6MlkPzUT3DLySGI0PDv0sWqPwc2xIA5m5kyK3kZDCBrPTx
        i7e7MSuKy/wN9J124sj6jri6F2ro+WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627470646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjhMAkXymGppxfXLi/CbrGSCGFIf/dycTdHBF+exDXI=;
        b=nA49/w3xa99WvhGjrOju7ySTS5iwLycqq3ktH0OPXkt1gkoxfQxYtZNJVSWFb0UrFZDCKS
        jEIP+duShLiwS5AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C18EEA3B85;
        Wed, 28 Jul 2021 11:10:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F202FDA8A7; Wed, 28 Jul 2021 13:08:01 +0200 (CEST)
Date:   Wed, 28 Jul 2021 13:08:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/7] btrfs: Allocate walk_control on stack
Message-ID: <20210728110801.GZ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210727211731.23394-1-rgoldwyn@suse.de>
 <381dc8c84c07b4eecc8b5de6686d79ad5c60ae58.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381dc8c84c07b4eecc8b5de6686d79ad5c60ae58.1627418762.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 04:17:25PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate walk_control, allocate
> walk_control on stack.
> 
> No need to memset() a struct to zero if it is initialized to zero.
> 
> sizeof(walk_control) = 200

This is IMHO too much for on-stack variable, the function can be called
from nested contexts. Removing snapshots is a restartable operation so
this is not a critical operation where we'd consider reducing the
potential errors.

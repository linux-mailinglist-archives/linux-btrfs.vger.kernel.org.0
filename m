Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557F422C33
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhJEPUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 11:20:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEPUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 11:20:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 851032243D;
        Tue,  5 Oct 2021 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633447101;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Lr8rqL2gxQby5EUFsjQTFtLNta9MoqvvYFlWYrxUKo=;
        b=nasasJXpq28Jl81Ssi5JVaDzRyqZctgIuhQsOV5cxuB9choTOObi391ezpT045c/CIVsoj
        L20L/17T/y3lq/WGSCVxMMKujL3mHydpJZutUHU7IujtJ1qdo6hnpSYuZUqqJ5USqjdDfR
        dZJUMVBA4O+jHyjnIHUO0DnX7KIt6fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633447101;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Lr8rqL2gxQby5EUFsjQTFtLNta9MoqvvYFlWYrxUKo=;
        b=QXJo0GKpl8ImUJw1eigSsq2FK8gDPcvnMMv4RAq0RawklDAQLIKqjp/52FPpJFEmOC+fsX
        TCm1X0RQa3mntHDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E831A3B88;
        Tue,  5 Oct 2021 15:18:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9412DA7F3; Tue,  5 Oct 2021 17:18:01 +0200 (CEST)
Date:   Tue, 5 Oct 2021 17:18:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ignore path devices in multipath setups
Message-ID: <20211005151801.GE9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210930120634.632946-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930120634.632946-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 03:06:31PM +0300, Nikolay Borisov wrote:
> This patch set improves the scanning behavior of btrfs-progs such that devices
> which represent paths to a multipath device will be ignored when scanning. There
> was an internal report that this causes problems with libstorage-ng. The behavior of
> showing path devices diverges from the kernel, where on mounted filesystem only
> the actual multipath device will be shown.
> 
> Changes in V2:
> 
> * Split build system related changes to the first patch of the series.
> 
> * Eliminated function names starting with __
> 
> * Instead of defining an 'if' always implement sane behavior of is_path_device
> based on the state of the systems
> 
> * Eliminated special constant and started using PATH_MAX.
> 
> 
> Nikolay Borisov (3):
>   btrfs-progs: Add optional dependency on libudev
>   btrfs-progs: Ignore devices representing paths in multipath
>   btrfs-progs: Add fallback code for path device ignore for static build

Added to devel, thanks. I slightly changed how the libudev dependency is
done, required by default with possible --diable-libudev. Though it's
introducing a dependency in a minor release, it's required to have the
multipath support and that I belive is case for most distros anyway.

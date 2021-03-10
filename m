Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD9333FFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 15:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhCJOKL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 09:10:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:42406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhCJOKJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 09:10:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C10AFAE84;
        Wed, 10 Mar 2021 14:10:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0D365DA7D7; Wed, 10 Mar 2021 15:08:09 +0100 (CET)
Date:   Wed, 10 Mar 2021 15:08:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Heiko Becker <heirecka@exherbo.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: build: Use PKG_CONFIG instead of pkg-config
Message-ID: <20210310140809.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Heiko Becker <heirecka@exherbo.org>,
        linux-btrfs@vger.kernel.org
References: <20210309212440.2136364-1-heirecka@exherbo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309212440.2136364-1-heirecka@exherbo.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 09, 2021 at 10:24:40PM +0100, Heiko Becker wrote:
> Hard-coding the pkg-config executable might result in build errors
> on system and cross environments that have prefixed toolchains. The
> PKG_CONFIG variable already holds the proper one and is already used
> in a few other places.
> 
> Signed-off-by: Heiko Becker <heirecka@exherbo.org>

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14F21D96CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgESM5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 08:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgESM5I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 08:57:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32D4EB018;
        Tue, 19 May 2020 12:57:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F202DA7AD; Tue, 19 May 2020 14:56:13 +0200 (CEST)
Date:   Tue, 19 May 2020 14:56:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] Btrfs: fix corrupt log due to concurrent fsync of
 inodes with shared extents
Message-ID: <20200519125612.GB18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200518111450.30771-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518111450.30771-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 12:14:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>

> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, 1-4 added to misc-next.

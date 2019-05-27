Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558DB2B7A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfE0OhQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 10:37:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfE0OhQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 10:37:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DE6BAEFD
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 14:37:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D108FDA85C; Mon, 27 May 2019 16:38:09 +0200 (CEST)
Date:   Mon, 27 May 2019 16:38:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Enable crc32 optimization probe for convert
 and mkfs
Message-ID: <20190527143809.GL15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190527044627.31588-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527044627.31588-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 27, 2019 at 12:46:27PM +0800, Qu Wenruo wrote:
> Although moderm hardware is fast enough and crc32 calculation is not a
> hotspot, doing such optimization won't hurt anyway.
> 
If there is a bug report, please reference it in the commit. I use the
following format for github issues

Issue: #1234

as this will add an notification to the issue when the patch is pushed
to some branch.

Patch added to devel, thanks.

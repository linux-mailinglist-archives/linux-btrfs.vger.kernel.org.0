Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38116AF96
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBXSqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 13:46:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:48052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgBXSqM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 13:46:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1AA03AD4F;
        Mon, 24 Feb 2020 18:46:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5813EDA727; Mon, 24 Feb 2020 19:45:52 +0100 (CET)
Date:   Mon, 24 Feb 2020 19:45:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/3] Add full support for cloning inline extents
Message-ID: <20200224184551.GC2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
References: <20200224171219.3655117-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224171219.3655117-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 05:12:19PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset adds support for currently unsupported cases of reflink
> operations that cover a file range that has inline extents, more details
> on why/how in patch 4/4.

Great to have the remaining cases handled, thanks. Patches look good to
me I'll add them to for-next and move to misc-next soon.

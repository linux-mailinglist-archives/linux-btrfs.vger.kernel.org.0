Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7541F46B4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbgFIS6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 14:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbgFIS6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 14:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CBECAAE8;
        Tue,  9 Jun 2020 18:58:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9A7DDA790; Tue,  9 Jun 2020 20:58:33 +0200 (CEST)
Date:   Tue, 9 Jun 2020 20:58:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: fix data block group relocation failure due
 to concurrent scrub
Message-ID: <20200609185833.GE27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200608123255.26354-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608123255.26354-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 08, 2020 at 01:32:55PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
[...]

1 and 2 added to misc-next, thanks.

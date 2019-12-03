Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAC110487
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 19:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLCSvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 13:51:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLCSvU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 13:51:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F51EB28A6;
        Tue,  3 Dec 2019 18:51:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92580DA7D9; Tue,  3 Dec 2019 19:51:14 +0100 (CET)
Date:   Tue, 3 Dec 2019 19:51:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Btrfs: fix missing data checksums after replaying
 a log tree
Message-ID: <20191203185114.GV2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191129151359.31905-1-fdmanana@kernel.org>
 <20191202110058.20409-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202110058.20409-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 11:00:58AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
[...]

Added to misc-next, thanks.

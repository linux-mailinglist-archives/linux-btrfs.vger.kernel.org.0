Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9F1BA648
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgD0OZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 10:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgD0OZH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 10:25:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0AD17AE63;
        Mon, 27 Apr 2020 14:25:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 033DDDA781; Mon, 27 Apr 2020 16:24:21 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:24:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] Btrfs: fix partial loss of prealloc extent past
 i_size after fsync
Message-ID: <20200427142421.GA18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200421102520.14686-1-fdmanana@kernel.org>
 <20200423153053.25956-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423153053.25956-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 23, 2020 at 04:30:53PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Updated in misc-next, thanks.

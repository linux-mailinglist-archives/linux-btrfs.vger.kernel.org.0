Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9479DD2F24
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJJRCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 13:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfJJRCl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 13:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 097E8B02E;
        Thu, 10 Oct 2019 17:02:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1FED3DA7E3; Thu, 10 Oct 2019 19:02:54 +0200 (CEST)
Date:   Thu, 10 Oct 2019 19:02:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: unbreak btrfs-sb-mod compilation
Message-ID: <20191010170253.GA2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191010140949.6590-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010140949.6590-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 04:09:49PM +0200, Johannes Thumshirn wrote:
> Fix compiler warnings and errors in btrfs-sb-mod due to incorrect
> conversion with the checksum updates.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---

Applied, thnanks.

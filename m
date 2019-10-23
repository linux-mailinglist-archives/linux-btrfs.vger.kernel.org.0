Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C558E19B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391233AbfJWMOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 08:14:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:51672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388674AbfJWMOl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 08:14:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3A9EB306;
        Wed, 23 Oct 2019 12:14:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54B1EDA734; Wed, 23 Oct 2019 14:14:53 +0200 (CEST)
Date:   Wed, 23 Oct 2019 14:14:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     damenly.su@gmail.com
Cc:     linux-btrfs@vger.kernel.org, Damenly_Su@gmx.com
Subject: Re: [PATCH] btrfs-progs: mkfs-tests/005: check global prereq for
 dmsetup
Message-ID: <20191023121453.GA3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org, Damenly_Su@gmx.com
References: <20191023092634.20310-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023092634.20310-1-Damenly_Su@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 05:26:34PM +0800, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> This test uses tool dmsetup so add the global prereq.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/192
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>

Applied, thanks.

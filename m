Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2281966
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 14:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfHEMgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 08:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfHEMgR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 08:36:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5DB6AC8C;
        Mon,  5 Aug 2019 12:36:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B24F0DABC7; Mon,  5 Aug 2019 14:36:47 +0200 (CEST)
Date:   Mon, 5 Aug 2019 14:36:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][btrfs-next] btrfs: fix spelling mistake "aliged" ->
 "aligned"
Message-ID: <20190805123647.GZ28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Colin King <colin.king@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190805104732.26738-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805104732.26738-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 11:47:32AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an extent_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, I've folded the fix to the patch ("btrfs: tree-checker: Add
EXTENT_ITEM and METADATA_ITEM check").

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA23E3020
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408094AbfJXLRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 07:17:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408056AbfJXLRi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 07:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC902B4BB;
        Thu, 24 Oct 2019 11:17:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D99FDDA733; Thu, 24 Oct 2019 13:17:48 +0200 (CEST)
Date:   Thu, 24 Oct 2019 13:17:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Remove btrfs_bio::flags member
Message-ID: <20191024111748.GG3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191024013829.17931-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024013829.17931-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 24, 2019 at 09:38:29AM +0800, Qu Wenruo wrote:
> This member is not used by any one, just remove it.
> 
> And since it's between two pointers, such removal should save us a
> pointer size of the structure.
> 
> The last user of btrfs_bio::flags is removed in commit 326e1dbb5736
> ("block: remove management of bi_remaining when restoring original
> bi_end_io").

Oh, that's an old patch, 2015. I'll add a stable tag though it's not a
fix but the size reduction of a frequently used structure is a good
thing. Thanks.

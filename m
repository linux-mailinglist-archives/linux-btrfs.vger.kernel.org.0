Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122CE2DB28D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgLOR1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 12:27:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:35262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbgLOR1J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 12:27:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DAF0B727;
        Tue, 15 Dec 2020 17:26:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B3A0DA7C3; Tue, 15 Dec 2020 18:24:45 +0100 (CET)
Date:   Tue, 15 Dec 2020 18:24:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2] btrfs: free-space-cache: Fix error return code in
 __load_free_space_cache
Message-ID: <20201215172445.GZ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zhihao Cheng <chengzhihao1@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20201207135612.4132398-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207135612.4132398-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 09:56:12PM +0800, Zhihao Cheng wrote:
> Fix to return the error code(instead always 0) when memory allocating
> failed in __load_free_space_cache().
> 
> This lacks the analysis of consequences, so there's only one caller and

By "This lacks the analysis of consequences" I was referring to
changelog in your patch and I did not expect you copy&paste it verbatim
to the next patch :)

Anyway, updated patch added to misc-next, thanks.

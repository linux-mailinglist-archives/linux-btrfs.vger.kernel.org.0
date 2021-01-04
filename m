Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CC2E9796
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbhADOsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 09:48:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADOs3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 09:48:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E91FACBA;
        Mon,  4 Jan 2021 14:47:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 00399DA882; Mon,  4 Jan 2021 15:45:59 +0100 (CET)
Date:   Mon, 4 Jan 2021 15:45:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] btrfs: use DEFINE_MUTEX() for mutex lock
Message-ID: <20210104144559.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zheng Yongjun <zhengyongjun3@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201224132217.30741-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132217.30741-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 24, 2020 at 09:22:17PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().

And is there some reason why it should be done that way?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F51CF4F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgELMyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 08:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgELMyc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 08:54:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 631AEADFF;
        Tue, 12 May 2020 12:54:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E671DA70B; Tue, 12 May 2020 14:53:39 +0200 (CEST)
Date:   Tue, 12 May 2020 14:53:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] btrfs: Remove duplicated include in block-group.c
Message-ID: <20200512125339.GB18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1589255703-7193-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589255703-7193-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 12, 2020 at 11:55:03AM +0800, Tiezhu Yang wrote:
> disk-io.h is included more than once in block-group.c, remove it.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Applied, thanks.

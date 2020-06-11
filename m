Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50431F6BE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgFKQKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 12:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFKQKd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 12:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10490ACBD;
        Thu, 11 Jun 2020 16:10:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 028C1DA82A; Thu, 11 Jun 2020 18:10:22 +0200 (CEST)
Date:   Thu, 11 Jun 2020 18:10:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH v2] btrfs: Remove unnecessary failure messages during
 memory allocation
Message-ID: <20200611161022.GR27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yi Wang <wang.yi59@zte.com.cn>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
References: <1591836036-26253-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591836036-26253-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 11, 2020 at 08:40:36AM +0800, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> As there is a dump_stack() done on memory allocation
> failures, these messages might as well be deleted instead.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
> Changes in v2: Remove these error messages instead of changing them.

Thanks. I found two more messages to remove and also removed { } when
there was only one statement left.

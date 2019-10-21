Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721B6DED48
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfJUNRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:17:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbfJUNRA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:17:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF1BBB18B;
        Mon, 21 Oct 2019 13:16:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0C99DA8C5; Mon, 21 Oct 2019 15:17:11 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:17:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: Make init_tree_roots static
Message-ID: <20191021131711.GI3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191018120604.29508-1-yuehaibing@huawei.com>
 <bab47b8e-d35f-a769-a703-4dcfe1a17980@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bab47b8e-d35f-a769-a703-4dcfe1a17980@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 03:09:58PM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.10.19 г. 15:06 ч., YueHaibing wrote:
> > Fix sparse warning:
> > 
> > fs/btrfs/disk-io.c:2534:12: warning:
> >  symbol 'init_tree_roots' was not declared. Should it be static?
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Huhz, I thought I had added static... Anyway this could be folded in the
> original patch. Thanks for the report.

Folded.

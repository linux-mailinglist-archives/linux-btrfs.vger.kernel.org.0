Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA01B1A3762
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgDIPp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 11:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgDIPp5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 11:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8423AC37;
        Thu,  9 Apr 2020 15:45:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 521F4DA70B; Thu,  9 Apr 2020 17:45:19 +0200 (CEST)
Date:   Thu, 9 Apr 2020 17:45:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs-progs: tests: Don't use run_check_stdout
 without filtering
Message-ID: <20200409154519.GC5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200406061106.596190-1-wqu@suse.com>
 <20200406061106.596190-2-wqu@suse.com>
 <20200406165637.GQ5920@twin.jikos.cz>
 <1ac7c293-41f4-8249-5d61-62df6a3c35a2@gmx.com>
 <20200409154135.GB5920@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409154135.GB5920@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 09, 2020 at 05:41:35PM +0200, David Sterba wrote:
> On Tue, Apr 07, 2020 at 06:44:37AM +0800, Qu Wenruo wrote:
> > On 2020/4/7 上午12:56, David Sterba wrote:
> > What about adding filtering for the mentioned callers?
> 
> I'm not sure what exactly do you mean, can you send an example?

Never mind, it's in the v3 patches.

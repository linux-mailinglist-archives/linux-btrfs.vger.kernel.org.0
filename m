Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71EC1A3758
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 17:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgDIPmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 11:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgDIPmM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 11:42:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE3D8AE5A;
        Thu,  9 Apr 2020 15:42:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39CA2DA70B; Thu,  9 Apr 2020 17:41:35 +0200 (CEST)
Date:   Thu, 9 Apr 2020 17:41:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs-progs: tests: Don't use run_check_stdout
 without filtering
Message-ID: <20200409154135.GB5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200406061106.596190-1-wqu@suse.com>
 <20200406061106.596190-2-wqu@suse.com>
 <20200406165637.GQ5920@twin.jikos.cz>
 <1ac7c293-41f4-8249-5d61-62df6a3c35a2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ac7c293-41f4-8249-5d61-62df6a3c35a2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 06:44:37AM +0800, Qu Wenruo wrote:
> On 2020/4/7 上午12:56, David Sterba wrote:
> > On Mon, Apr 06, 2020 at 02:11:05PM +0800, Qu Wenruo wrote:
> >> Since run_check_stdout() can insert INSTRUMENT, which could easily
> >> pollute the stdout, any caller of run_check_stdout() should filter its
> >> output before using it.
> >>
> >> There are some callers which just grab the output without filtering it,
> >> most of them are simple inspect-dump commands.
> >>
> >> To avoid false alert with INSTRUMENT set, just don't utilize
> >> run_check_stdout() for those call sites.
> >> Since those call sites are pretty simple, shouldn't cause too many holes
> >> in the coverage.
> > 
> > I don't like this, it removes a lot of the coverage. The instrument
> > tools should provide a way to avoid stdout/stderr pollution, eg.
> > valgrind has --log-fd or --log-file. We can add a shortcut that will
> > provide some defaults so we can conveniently use 'INSTRUMENT=valgrind'.
> > 
> Then that's too INSTURMENT dependent.

Yes, but how many do we use besides valgrind. I have tried gdb with some
init script or batch mode to catch crashes, but I can't think of other
tools.

> What about adding filtering for the mentioned callers?

I'm not sure what exactly do you mean, can you send an example?

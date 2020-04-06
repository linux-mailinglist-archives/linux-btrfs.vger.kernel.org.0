Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0419FB86
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDFR3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 13:29:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDFR3S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 13:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB24FB1E1D;
        Mon,  6 Apr 2020 17:29:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DF02DA726; Mon,  6 Apr 2020 18:56:38 +0200 (CEST)
Date:   Mon, 6 Apr 2020 18:56:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs-progs: tests: Don't use run_check_stdout
 without filtering
Message-ID: <20200406165637.GQ5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200406061106.596190-1-wqu@suse.com>
 <20200406061106.596190-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406061106.596190-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 06, 2020 at 02:11:05PM +0800, Qu Wenruo wrote:
> Since run_check_stdout() can insert INSTRUMENT, which could easily
> pollute the stdout, any caller of run_check_stdout() should filter its
> output before using it.
> 
> There are some callers which just grab the output without filtering it,
> most of them are simple inspect-dump commands.
> 
> To avoid false alert with INSTRUMENT set, just don't utilize
> run_check_stdout() for those call sites.
> Since those call sites are pretty simple, shouldn't cause too many holes
> in the coverage.

I don't like this, it removes a lot of the coverage. The instrument
tools should provide a way to avoid stdout/stderr pollution, eg.
valgrind has --log-fd or --log-file. We can add a shortcut that will
provide some defaults so we can conveniently use 'INSTRUMENT=valgrind'.

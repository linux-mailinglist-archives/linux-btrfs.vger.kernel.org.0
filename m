Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB08DB4BA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfIQKME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 06:12:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbfIQKME (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 06:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBCD8AD88;
        Tue, 17 Sep 2019 10:12:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E3E3DA889; Tue, 17 Sep 2019 12:12:23 +0200 (CEST)
Date:   Tue, 17 Sep 2019 12:12:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix Wmaybe-uninitialized warning
Message-ID: <20190917101223.GQ2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Austin Kim <austindh.kim@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190903033019.GA149622@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903033019.GA149622@LGEARND20B15>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 12:30:19PM +0900, Austin Kim wrote:
> gcc throws warning message as below:

What version of gcc reports that? 9.2.1 does not.

> ‘clone_src_i_size’ may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>  #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) == 0)
>                        ^
> fs/btrfs/send.c:5088:6: note: ‘clone_src_i_size’ was declared here
>  u64 clone_src_i_size;
>    ^
> The clone_src_i_size is only used as call-by-reference
> in a call to get_inode_info().

The reference is passed to a static function, so the compiler has enough
information to determine if it's unused. By inspection I don't see a
problem with the uninitalized variable: if __get_inode_info succeeds,
there's a valid value, in error case it's not used at all.

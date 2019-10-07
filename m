Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B677ECE657
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfJGPD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 11:03:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbfJGPD3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 11:03:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C14BACD8;
        Mon,  7 Oct 2019 15:03:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1B4BDA7FB; Mon,  7 Oct 2019 17:03:41 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:03:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix Wmaybe-uninitialized warning
Message-ID: <20191007150340.GA2751@twin.jikos.cz>
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
> 
> ‘clone_src_i_size’ may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>  #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) == 0)
>                        ^
> fs/btrfs/send.c:5088:6: note: ‘clone_src_i_size’ was declared here
>  u64 clone_src_i_size;
>    ^
> The clone_src_i_size is only used as call-by-reference
> in a call to get_inode_info().
> 
> Silence the warning by initializing clone_src_i_size to 0.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

A few more people have repoted this warning, so I'm gonig to apply the
patch to avoid further reports. Thanks.

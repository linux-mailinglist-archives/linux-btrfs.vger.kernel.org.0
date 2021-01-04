Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4E2E9985
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 17:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbhADQAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 11:00:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbhADQAo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 11:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7D0CACAF;
        Mon,  4 Jan 2021 16:00:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20BD4DA882; Mon,  4 Jan 2021 16:58:13 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:58:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix issues when mouting the poc image
Message-ID: <20210104155813.GH6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210103092804.756-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103092804.756-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 03, 2021 at 05:28:02PM +0800, Su Yue wrote:
> The two patches fix issues found by the image which is provided by
> Insu Yun at SSLab@Gatech.
> 
> patch 1 fixes a NULL pointer dereference in error handling path.
> patch 2 enhances tree checker to detect chunk item end overflow.
> 
> Su Yue (2):
>   btrfs: prevent NULL pointer dereference in extent_io_tree_panic()
>   btrfs: tree-checker: check if chunk item end oveflows

Thanks, added to misc-next. I've slightly updated the error message in
patch 2, to say that it's the 'logical start' of the chunk.

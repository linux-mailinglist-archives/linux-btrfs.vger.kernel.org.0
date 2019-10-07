Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67851CE81E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJGPok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 11:44:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfJGPoj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 11:44:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27AE5AC19;
        Mon,  7 Oct 2019 15:44:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22CC6DA7FB; Mon,  7 Oct 2019 17:44:53 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:44:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: remove unnecessary hash_init()
Message-ID: <20191007154452.GE2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chengguang Xu <cgxu519@mykernel.net>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20191005051736.29857-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005051736.29857-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 05, 2019 at 01:17:34PM +0800, Chengguang Xu wrote:
> hash_init() is not necessary in btrfs_props_init(),
> so remove it.

The part that explains why it's not necessary is missing in the
changelo. And looking what hash_init and plain DEFINE_HASHTABLE does I
don't think that removing hash_init is safe or making the code more
clear.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B0D2F14
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfJJQ6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfJJQ6A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:58:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC11CB024;
        Thu, 10 Oct 2019 16:57:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85238DA7E3; Thu, 10 Oct 2019 18:58:12 +0200 (CEST)
Date:   Thu, 10 Oct 2019 18:58:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: remove unnecessary hash_init()
Message-ID: <20191010165811.GZ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chengguang Xu <cgxu519@mykernel.net>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20191010075958.28346-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010075958.28346-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 03:59:56PM +0800, Chengguang Xu wrote:
> DEFINE_HASHTABLE itself has already included initialization code,
> we don't have to call hash_init() again, so remove it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

1-3 added to misc-next, with minor updates. Thanks.

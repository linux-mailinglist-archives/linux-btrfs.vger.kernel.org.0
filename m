Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D937233683D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 00:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCJX67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 18:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhCJX6i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 18:58:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65D6364FA9;
        Wed, 10 Mar 2021 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615420717;
        bh=luK33h5nP8fsBBPXEQ/QzxyI7Rp8lL7ssg1ESsYovco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PWPbXbmUPDuaxxwOXGMFkJwz3+KhBbEuY0dtfsHo8Sp6E/u4pIWNAYPV0/JlduYuD
         63m8KvxzeXoPX23tAUJI2hFEXYItkPBnssFlukQPvVU8R1ynC5STCBRMd8Wret/mzI
         CKTeuNgTh2jX1ACnNfv7LTQhGhnSnyFe3N6CuIUM=
Date:   Wed, 10 Mar 2021 15:58:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ira.weiny@intel.com
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Convert kmap/memset/kunmap to memzero_user()
Message-Id: <20210310155836.7d63604e28d746ef493c1882@linux-foundation.org>
In-Reply-To: <20210309212137.2610186-1-ira.weiny@intel.com>
References: <20210309212137.2610186-1-ira.weiny@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue,  9 Mar 2021 13:21:34 -0800 ira.weiny@intel.com wrote:

> Previously this was submitted to convert to zero_user()[1].  zero_user() is not
> the same as memzero_user() and in fact some zero_user() calls may be better off
> as memzero_user().  Regardless it was incorrect to convert btrfs to
> zero_user().
> 
> This series corrects this by lifting memzero_user(), converting it to
> kmap_local_page(), and then using it in btrfs.

This impacts btrfs more than MM.  I suggest the btrfs developers grab
it, with my

Acked-by: Andrew Morton <akpm@linux-foundation.org>


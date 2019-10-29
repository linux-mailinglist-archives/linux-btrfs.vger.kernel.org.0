Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3296E817E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 07:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJ2GxT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 02:53:19 -0400
Received: from rin.romanrm.net ([91.121.75.85]:60436 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfJ2GxT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 02:53:19 -0400
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 3622A2027D;
        Tue, 29 Oct 2019 06:53:17 +0000 (UTC)
Date:   Tue, 29 Oct 2019 11:53:17 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] btrfs: rescue: Introduce new rescue mount option,
 rescue=skipdatacsum, to skip data csum verification
Message-ID: <20191029115317.03b43d94@natsu>
In-Reply-To: <20191029062149.217995-1-wqu@suse.com>
References: <20191029062149.217995-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 29 Oct 2019 14:21:49 +0800
Qu Wenruo <wqu@suse.com> wrote:

> Here we introduce a new rescue= mount option to completely skip data
> csum check.
> Since data csum check is completely skipped, for profiles with extra
> mirrors/copies, it will return the first copy only, which is not
> optimized, but should be good enough for rescue usage.
> 
> This option only affects data csum verification, doesn't affect data
> csum calcuation, so new data write will still be protected by csum (if
> it doesn't get affected by csum tree corruption).

Maybe just make the "nodatasum" mount option skip verification of existing
checksums as well? Actually before seeing this patch I believed "nodatasum"
already does that.

Also for consistency note that datasum/nodatasum call it just "sum" in the
mount option name, not "csum".

-- 
With respect,
Roman

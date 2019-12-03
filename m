Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82410F9FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 09:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCIio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 03:38:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCIio (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 03:38:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 363DDAC48;
        Tue,  3 Dec 2019 08:38:43 +0000 (UTC)
Date:   Tue, 3 Dec 2019 09:38:41 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/9] btrfs: remove dead snapshot-aware defrag code
Message-ID: <20191203083841.GC21721@Johanness-MacBook-Pro.local>
References: <cover.1575336815.git.osandov@fb.com>
 <e8079362b1884b5f71ebe839f01ab8492c2d5d2e.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8079362b1884b5f71ebe839f01ab8492c2d5d2e.1575336815.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

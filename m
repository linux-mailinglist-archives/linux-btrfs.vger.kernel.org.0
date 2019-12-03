Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC08F10FB20
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfLCJv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 04:51:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJv4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 04:51:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68A99AC1A;
        Tue,  3 Dec 2019 09:51:55 +0000 (UTC)
Date:   Tue, 3 Dec 2019 10:51:53 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/9] btrfs: make btrfs_ordered_extent naming consistent
 with btrfs_file_extent_item
Message-ID: <20191203095153.GD21721@Johanness-MacBook-Pro.local>
References: <cover.1575336815.git.osandov@fb.com>
 <1a8119f808ba10f315b4b6a37ce27896f1b113a4.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8119f808ba10f315b4b6a37ce27896f1b113a4.1575336815.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65910F9F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 09:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCIhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 03:37:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:41566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbfLCIhA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 03:37:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFEBFAEBD;
        Tue,  3 Dec 2019 08:36:59 +0000 (UTC)
Date:   Tue, 3 Dec 2019 09:36:57 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 1/9] btrfs: get rid of trivial __btrfs_lookup_bio_sums()
 wrappers
Message-ID: <20191203083657.GB21721@Johanness-MacBook-Pro.local>
References: <cover.1575336815.git.osandov@fb.com>
 <af5aefd84186419ead73107895ddd6aba02ef8b6.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5aefd84186419ead73107895ddd6aba02ef8b6.1575336815.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

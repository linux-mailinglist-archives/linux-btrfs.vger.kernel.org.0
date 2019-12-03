Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53F10FE40
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 13:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCM7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 07:59:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:34226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCM7T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 07:59:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81238B201;
        Tue,  3 Dec 2019 12:59:18 +0000 (UTC)
Date:   Tue, 3 Dec 2019 13:59:16 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/9] btrfs: remove unnecessary pg_offset assignments in
 __extent_writepage()
Message-ID: <20191203125916.GF21721@Johanness-MacBook-Pro.local>
References: <cover.1575336815.git.osandov@fb.com>
 <07b6177024a181dfd87c1c2e56a04d07152549fe.1575336816.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b6177024a181dfd87c1c2e56a04d07152549fe.1575336816.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

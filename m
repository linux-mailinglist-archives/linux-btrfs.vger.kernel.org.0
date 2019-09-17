Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD79B4D8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfIQMKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 08:10:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbfIQMKj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 08:10:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE9A8B620;
        Tue, 17 Sep 2019 12:10:38 +0000 (UTC)
Date:   Tue, 17 Sep 2019 14:10:38 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/7] btrfs: don't prematurely free work in
 scrub_missing_raid56_worker()
Message-ID: <20190917121038.GE12128@x250>
References: <cover.1568658527.git.osandov@fb.com>
 <469b0ce8c1abc7d86cf59228d81e300695fa0217.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <469b0ce8c1abc7d86cf59228d81e300695fa0217.1568658527.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

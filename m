Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBBEDF90
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfKDMD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:03:27 -0500
Received: from submit.uniweb.no ([91.207.158.45]:57413 "EHLO submit.uniweb.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfKDMD1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:03:27 -0500
X-Greylist: delayed 1683 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 07:03:26 EST
Received: from [91.207.158.168] (helo=mail.uniweb.no)
        by submit.uniweb.no with esmtpa (Exim 4.90_1)
        (envelope-from <odin@digitalgarden.no>)
        id 1iRadj-00029r-Kr
        for linux-btrfs@vger.kernel.org; Mon, 04 Nov 2019 12:35:19 +0100
Date:   Mon, 4 Nov 2019 12:35:19 +0100
From:   Odin Hultgren van der Horst <odin@digitalgarden.no>
To:     linux-btrfs@vger.kernel.org
Subject: Extent to files
Message-ID: <20191104113519.htdigcg6lzbes6v7@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I did a ioctl(FICLONE) IOCTL-FICLONERANGE(2) at some point later I want to be
able to check if the new file still shares all its physical storage with just
knowing the name of the new file.

I found some people suggesting to compare the files extents.

But the implementation I looked at knew both files used in the comparison,
so I was wondering if there a way to get all files that references a extent
in user space?

In reality I want a count off clones/(identical files) to a given file
in user space.

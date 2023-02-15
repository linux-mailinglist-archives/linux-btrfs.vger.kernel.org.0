Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E45697764
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 08:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjBOHb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 02:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjBOHb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 02:31:28 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1F2914A
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 23:31:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50EAA67373; Wed, 15 Feb 2023 08:31:25 +0100 (CET)
Date:   Wed, 15 Feb 2023 08:31:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: BTRFS_IOC_ENCODED_READ testing
Message-ID: <20230215073125.GA31530@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Omar and other btrfs regulars,

what is the testing coverage of BTRFS_IOC_ENCODED_READ?  I can't find
anyhing in xfstests that seems to specifically exercise it, although
I guess btrfs receive testing on a file system with compression and
a new enough btrfsprogs will eventually hit it.  Are there any good
targeted tests somewhere else?

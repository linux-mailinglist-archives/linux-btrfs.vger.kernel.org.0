Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF52D476362
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhLOUfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:35:53 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:47092 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhLOUfx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:35:53 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 15:35:53 EST
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 4BB1740526
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 14:27:44 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 2F2C48036291
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 14:27:10 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 215FC803626B
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 14:27:10 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NsoXUQiZlSLp for <linux-btrfs@vger.kernel.org>;
        Wed, 15 Dec 2021 14:27:10 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.16.192.142])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id E0A318036292
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 14:27:09 -0600 (CST)
Message-ID: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
Subject: receive failing for incremental streams
From:   Eric Levy <contact@ericlevy.name>
To:     linux-btrfs@vger.kernel.org
Date:   Wed, 15 Dec 2021 15:27:08 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

I have been experiencing very confusing problems with incremental
streams.

For a subvolume, I have a simple incremental backup created from two
stages:

btrfs send old/@ > base.btrfs
btrfs send new/@ -p old/@ > update.btrfs

The two source subvolumes are snapshots captured at separate times from
the same actively mounted subvolume.

On the target, I attempt to restore:

btrfs receive ./ < base.btrfs
btrfs receive ./ < update.btfs

The expectation is that the prior command would create a restored
snapshot of the initial backup stage, and that the latter would apply
the updated stage.

The prior command succeeds, but the latter fails:

ERROR: creating snapshot ./@ -> @ failed: File exists

Since it is obvious I cannot usefully apply the second stage to a
target that does not exist, I am puzzled about why the process performs
this check, as well as what is expected to have success applying the
update.

How may I apply the update stage to the target generated from restoring
the initial stage?



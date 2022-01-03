Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C7483030
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 12:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiACLIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 06:08:49 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:59779 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiACLIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 06:08:49 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id A7062405D4
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:09:34 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 783728034785
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:08:48 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 6894780347A8
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:08:48 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gAQC1WnHY2x6 for <linux-btrfs@vger.kernel.org>;
        Mon,  3 Jan 2022 05:08:48 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id ECE398034785
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:08:47 -0600 (CST)
Message-ID: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
Subject: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Mon, 03 Jan 2022 06:08:46 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am operating a Btrfs file system on logical volumes provided through
an iSCSI target. The software managing the volumes shows that they are
configured for certain features, which include "hardware-assisted
zeroing" and "space reclamation". Presumably the meaning of these
features, at least the former, is that a file system, with support of
the kernel, may issue a SCSI command indicating that a region of a
block device would be cleared. For a file system, such an operation has
no direct value, because the contents of de-allocated space is
irrelevant, but for a logical volume, it creates an opportunity to free
space on the underlying file system on the back end.

I have searched the term "hardware-assisted zeroing", without finding
any useful resources on the application of the term.

Does it describe a feature supported by Btrfs or Linux? Is it possible
for a LUN manager to "know" that Btrfs has freed space on a volume, in
a region that had previously been allocated?



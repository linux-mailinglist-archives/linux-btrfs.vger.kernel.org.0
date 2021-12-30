Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1673248205B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Dec 2021 22:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbhL3VK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Dec 2021 16:10:27 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:58070 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbhL3VK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Dec 2021 16:10:26 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id F1B3040597
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 15:11:09 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 07BA58036FF2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 15:10:26 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id ED9DB80343FA
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 15:10:25 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lVDSrtixFvbE for <linux-btrfs@vger.kernel.org>;
        Thu, 30 Dec 2021 15:10:25 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 9FF378036FF2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Dec 2021 15:10:25 -0600 (CST)
Message-ID: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
Subject: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Thu, 30 Dec 2021 16:10:23 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

I had a simple Btrfs partition, with only one subvolume, about 250 Gb
in size. As it began to fill, I added a second volume, live. By the
time the size of the file system reached the limit for the first
volume, the file system reverted to read only.

From journalctl, the following message has recurred, with the same
numeric values:

BTRFS error (device sdc1): parent transid verify failed on 867434496
wanted 9212 found 8675

Presently, the file system mounts only as read only. It will not mount
in read-write, even with the usebackuproot option. 

It seems that balance and scrub are not available, either due to read-
only mode, or some other reason. Both abort as soon as they begin to
run.

What is the best next step for recovery?



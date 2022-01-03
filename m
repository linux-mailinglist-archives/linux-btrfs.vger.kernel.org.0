Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66433483071
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 12:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiACLYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 06:24:30 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:60028 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiACLY0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 06:24:26 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 186F4405CF
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:25:11 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id D80108036FF2
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:24:24 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id CA1008034785
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:24:24 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VMk-0MOUSWqT for <linux-btrfs@vger.kernel.org>;
        Mon,  3 Jan 2022 05:24:24 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 7C42C8036FF2
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 05:24:24 -0600 (CST)
Message-ID: <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
Subject: Re: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Mon, 03 Jan 2022 06:24:23 -0500
In-Reply-To: <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
         <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > an iSCSI target. The software managing the volumes shows that they
> > are
> > configured for certain features, which include "hardware-assisted
> > zeroing" and "space reclamation". Presumably the meaning of these
> > features, at least the former, is that a file system, with support
> > of
> > the kernel, may issue a SCSI command indicating that a region of a
> > block device would be cleared.
> 
> This looks pretty much like ATA TRIM or SCSI UNMAP command.
> 
> If they are the same, then btrfs supports it by either fstrim command
> (recommended) or discard mount option.

Thanks for the explanation. How does trimming work? Does the file
system maintain a register of blocks that have been cleared? Why is the
command not sent instantly, as soon as the space is freed by the file
system?


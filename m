Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8532482AB8
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiABKRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 05:17:33 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:51345 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiABKRd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jan 2022 05:17:33 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 44A03404F1
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 04:18:18 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id B33D68034BC0
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 04:17:32 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id A57148034BC2
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 04:17:32 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yiW6sBq6E_lH for <linux-btrfs@vger.kernel.org>;
        Sun,  2 Jan 2022 04:17:32 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 5D2DC8034BC0
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 04:17:32 -0600 (CST)
Message-ID: <e1519e64fe10513e1c469e2a3adf705121ba8b06.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sun, 02 Jan 2022 05:17:27 -0500
In-Reply-To: <YdE+zWLrQhAmAX6F@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
         <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
         <YdDAGLU7M5mx7rL8@hungrycats.org>
         <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
         <YdDurReZpZQeo+7/@hungrycats.org>
         <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
         <YdEbsxw7Nk0GKKzN@hungrycats.org>
         <b6f84999f9506ca2e72673d8e94e72a0f29cea11.camel@ericlevy.name>
         <YdE+zWLrQhAmAX6F@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 2022-01-02 at 00:57 -0500, Zygo Blaxell wrote:

> Device order (mapping of /dev/sd? device to underlying storage)
> usually
> isn't guaranteed, but once it's set it tends to be persistent;
> otherwise,
> disastrous problems would occur with every multi-device Linux
> subsystem:
> btrfs, mdadm, lvm, and dm-crypt would all significantly damage their
> data
> if the mapping from subdevice to physical storage changed
> unexpectedly
> while they were active.
> 
> In disconnect-reconnect cases, the old device is reconnected only if
> it
> can be reliably identified; otherwise, an entirely new device is
> created
> (as in the case where sdc became sdf after iSCSI logout and
> reconnect).

After poking around, I made an interesting discovery:

$ ls  -l /dev/disk/by-path
lrwxrwxrwx 1 root root  9 Jan  2 04:47 <iscsi-tgt-name>-lun-1 -> ../../sdd
lrwxrwxrwx 1 root root  9 Jan  2 04:47 <iscsi-tgt-name>-lun-2 -> ../../sdc

It seems somehow the devices are exposed to the system in a different
order from how they are scanned in the iSCSI session.

Although I hoped when I gave the rescan command to the iSCSI daemon, it
would simply add a device, actually it did much more.

Obviously, there should be better support for predictability and safety
in these procedures. It's rather unhelpful that even after rebooting,
the device order remains inverted in the two views.



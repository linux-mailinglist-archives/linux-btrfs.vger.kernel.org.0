Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE330476753
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 02:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhLPBNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 20:13:10 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:50211 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLPBNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 20:13:10 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 8BB9640594
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 19:13:43 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 54F118034FCC
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 19:13:09 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 41D098034FE7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 19:13:09 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y2Ri0tHPba3p for <linux-btrfs@vger.kernel.org>;
        Wed, 15 Dec 2021 19:13:09 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.16.192.142])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 07C7D8034FDD
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 19:13:08 -0600 (CST)
Message-ID: <70553d13e265a2c7bced888f1a3d3b3e65539ce1.camel@ericlevy.name>
Subject: Re: receive failing for incremental streams
From:   Eric Levy <contact@ericlevy.name>
To:     linux-btrfs@vger.kernel.org
Date:   Wed, 15 Dec 2021 20:13:08 -0500
In-Reply-To: <ea6260d5-c383-9079-8a53-2051972b11d3@cobb.uk.net>
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
         <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
         <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
         <ea6260d5-c383-9079-8a53-2051972b11d3@cobb.uk.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Later you snapshot /data again to create /data-2 on the source
> system.
> You btrfs-send /data-2 to the other system again and it creates a new
> read-only subvolume - you tell btrfs-receive what to call it and
> where
> to put it, let's say you call it /copy-data-2 - using the data in the
> stream and reusing some extents from the existing /copy-data-1.
> /copy-data-2 is now a (read-only) copy of /data-2 from the source
> system.
> 
> How you use that copy is up to you. If you are just taking backups
> you
> probably do nothing with it unless you have a problem (it will form
> part
> of the source for data for any future /copy-data-3). If you want to
> use
> it to initialize a read-write subvolume on the destination system you
> can take a read-write snapshot of /copy-data-2 to create a new
> subvolume
> (say /my-new-data) on the destination system.

Such is close to what I have always understood about receive, but the
confusion is that the second receive command makes no reference to the
subvolume created by the first command. How do I ultimately create a
restore target that combines the original full capture with the
incremental differences?

When I ask how I use it, I mean what commands do I enter into the
system.

Note in my case I archive the streams into regular (compressed) filesm
for later recovery.



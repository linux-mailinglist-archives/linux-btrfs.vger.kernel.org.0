Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6246B628D5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 00:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiKNXYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 18:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKNXYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 18:24:06 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAA023B
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 15:24:05 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id D015040554
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 17:27:56 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 22657803772E
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 17:24:04 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id EA5858036FD0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 17:24:03 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZW5o_OeuLzkS for <linux-btrfs@vger.kernel.org>;
        Mon, 14 Nov 2022 17:24:03 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 95E99803772E
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 17:24:03 -0600 (CST)
Date:   Mon, 14 Nov 2022 18:23:55 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: property designating root subvolumes
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The file system allows one subvolume per partition to be designated as 
the default, and no more than one would be sensible. Generally, for 
partitions organized with a base file hierarchy constituted of multiple 
subvolumes, the one representing the root mount would be designated as 
the default. Although this association is not required, it is a 
reasonable assumption, enough so that some tools depend on it for 
certain features. For example, the rEFInd bootloader scans a BTRFS file 
system for a Linux-based OS by attempting to identify a root file 
hierarchy on the default subvolume. However, in such usage, the 
constraint of one subvolume designated per partition is limiting. In 
principle, a bootloader might support multiple operating systems 
installed on the same partition, as long as each root partition may be 
separately indicated. To support such usage, it might be helpful if a 
property, separate from the designation of a default subvolume, was 
supported. As a property, it would be allowed to be assigned 
arbitrarily to any number of subvolumes.

Presently, rEFInd supports multiple operating systems on different 
subvolumes of the same partition only by static configuration. Such a 
constraint is particularly cumbersome because any operation for 
installing the bootloader utilizes configuration only on the active 
operating system.

In principle, the broader concept might be extended further, adding 
even more properties, for supporting yet further use cases. As one 
example, a subvolume might be selected as containing configuration 
information applicable to the bootloader, regardless of the active 
operating system. Such a feature would facilitate synchronization of 
bootloader settings for installation tools across all operating systems 
on a partition. Yet, even the single new property would support cleaner 
semantics for greater flexibility of usage.

Note that for such a feature to work properly, the file system would 
need to enforce that the property not be inherited by child volumes, 
that is, snapshots derived from a subvolume with the property enabled. 
Furthermore, some thought must be given to the case of the user 
enabling the property for a subvolume having an ancestor with the 
property already enabled. In such a case, it most likely is desired 
that the property would be disabled for the ancestor.



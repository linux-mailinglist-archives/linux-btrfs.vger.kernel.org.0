Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15751623F8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKJKNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 05:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKJKNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 05:13:01 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772CBD1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 02:13:01 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 1698B405B8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:16:50 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 3943C8037774
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:13:00 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 2A6CC803778A
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:13:00 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8YWXei0Dz55K for <linux-btrfs@vger.kernel.org>;
        Thu, 10 Nov 2022 04:13:00 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id CCB5A8037774
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:12:59 -0600 (CST)
Date:   Thu, 10 Nov 2022 05:12:52 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: option to mount read-only subvolume with read-write access
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <G1N4LR.84UPK81F80SK3@ericlevy.name>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At times it is helpful to modify a subvolume to which has been assigned 
a read-only property, without changing the property. One reason for 
keeping the property is that the same subvolume may be reachable 
through another mount point. Another is to ensure that the property 
persists even if some operation fails to complete.

Would you consider adding a mount option to cause the system to ignore 
a read-only property for the subvolume accessed through the mount 
point, without affecting access to the same subvolume through other 
mount points?




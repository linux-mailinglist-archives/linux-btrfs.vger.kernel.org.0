Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D962A135
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKOSUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKOSUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:20:32 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB3713DFF
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:20:32 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 5A59D4056D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:24:24 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 2D58080366A0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:20:31 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 1E62E80366A1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:20:31 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fEEv4hiSE1Ei for <linux-btrfs@vger.kernel.org>;
        Tue, 15 Nov 2022 12:20:31 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id B1C9E80366B7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:20:30 -0600 (CST)
Date:   Tue, 15 Nov 2022 13:20:24 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: separate mailing list for patches?
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <0YIELR.GA2T7GBWR97P2@ericlevy.name>
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

I have subscribed to the Btrfs development list occasionally, for 
seeking support and raising issues, though I am not involved in the 
development effort. Currently, there is no channel of communication 
more accessible to members of the public, yet, the list is often used 
for patches sent among the development team. For many of us, it may 
seem cumbersome to be flooded by so many messages carrying the patches.

Perhaps it would be useful to consider a separate mailing list for 
patches, or to open a web interface that is friendly to those seeking 
to interact with the group for more occasional support. Hopefully, it 
would not much affect those regularly involved to subscribe to two 
lists, using one for patches and the other for basic correspondence.




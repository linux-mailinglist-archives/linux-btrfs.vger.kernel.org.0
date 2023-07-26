Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E2763E44
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGZSTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGZSTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 14:19:11 -0400
X-Greylist: delayed 933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 11:19:10 PDT
Received: from barramail.cs.umass.edu (barramail.cs.umass.edu [128.119.240.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DF9B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 11:19:10 -0700 (PDT)
X-ASG-Debug-ID: 1690394615-24039d13451110540001-6jHSXT
Received: from mailsrv.cs.umass.edu (mailsrv.cs.umass.edu [128.119.240.136]) by barramail.cs.umass.edu with ESMTP id 3u85E76VTZAenY3Z (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO) for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 14:03:35 -0400 (EDT)
X-Barracuda-Envelope-From: fikurnia@cs.umass.edu
X-Barracuda-RBL-Trusted-Forwarder: 128.119.240.136
Received: from mailsrv.cs.umass.edu (localhost [127.0.0.1])
        by mailsrv.cs.umass.edu (Postfix) with ESMTP id 899434033B42
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 14:03:35 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Jul 2023 14:03:35 -0400
From:   Fadhil Kurnia <fikurnia@cs.umass.edu>
To:     linux-btrfs@vger.kernel.org
Subject: The complexity of btrfs incremental send vs rsync in batch mode
Organization: College of Information & Computer Sciences, UMass Amherst
X-ASG-Orig-Subj: The complexity of btrfs incremental send vs rsync in batch mode
Message-ID: <3e6376bf18be789f8f1cefa6970c9c1b@cs.umass.edu>
X-Sender: fikurnia@cs.umass.edu
User-Agent: Roundcube Webmail/1.1.12
X-Barracuda-Connect: mailsrv.cs.umass.edu[128.119.240.136]
X-Barracuda-Start-Time: 1690394615
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://barramail.cs.umass.edu:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cs.umass.edu
X-Barracuda-Scan-Msg-Size: 855
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.7 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.111906
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi btrfs developer,

I am using btrfs-send with the hope that it has logarithmic
complexity compared to linear complexity of rsync in batch mode.

In rsync, to compare what changes between two directory
(or files), it needs to do a linear scan in both the original
and the copy directory to get the differences between them.

In incremental btrfs-send, my expectation is that it can compare
two subvolumes in logarithmic complexity (not linear) since under
the hood the subvolumes are represented in B+Tree; both subvolumes
(snapshots) also share many blocks in the tree. The expected
complexity is logarithmic as in the comparison between
two merkle-tree.

Could anyone confirm my expectation that btrfs-send run in
logarithmic complexity is correct?

Thanks,
Fadhil I. Kurnia
CS PhD Candidate,
University of Massachusetts Amherst

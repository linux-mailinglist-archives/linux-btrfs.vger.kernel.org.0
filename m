Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210E8577E7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiGRJSh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 18 Jul 2022 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiGRJST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 05:18:19 -0400
Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4B7101D4
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 02:18:17 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id DMtJo495JCVxYDMtKoh6BU; Mon, 18 Jul 2022 10:18:16 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ENUVbnVC c=1 sm=1 tr=0 ts=62d52558
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7pan45PUXvOoycvVN40A:9 a=QEXdDO2ut3YA:10
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>,
        "'Nikolay Borisov'" <nborisov@suse.com>
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk> <38d342a0-9057-7fd7-6ed9-d9b07bc4c27c@gmx.com>
In-Reply-To: <38d342a0-9057-7fd7-6ed9-d9b07bc4c27c@gmx.com>
Subject: RE: Odd output from scrub status
Date:   Mon, 18 Jul 2022 10:18:13 +0100
Message-ID: <004901d89a87$500ea870$f02bf950$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQG0I+mo95iLQgivBE5YQgylXxMxEwGizODprb+vxyA=
X-CMAE-Envelope: MS4xfKpah8+NNFuBXh9G7nY8IiMGQztoEbIu4DAqgcue62SZKQwyv1V2Uhs82ju+S7KhtQ0pGYV+FHDWWGTVa2xlddSKpABwDRW+rVgc24dS/YejLe8gOlz/
 2wB3RXHF5Om6YkBAfmJyeQEqPNjAnd1+h494NWComHqebk1qCHAnTh9tjhP8LvpSenCbfAfTYMMZHxD8WLclqhEURHkCoii6kkc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Mind to share the following commands output?

Sure, no problem

root@charon:/home/amonra# btrfs fi df /shared
Data, single: total=8.37TiB, used=5.76TiB
System, DUP: total=32.00MiB, used=1.09MiB
Metadata, DUP: total=11.00GiB, used=5.56GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
root@charon:/home/amonra# btrfs fi usage /shared
Overall:
    Device size:		  25.46TiB
    Device allocated:		   8.39TiB
    Device unallocated:		  17.07TiB
    Device missing:		     0.00B
    Used:			   5.77TiB
    Free (estimated):		  19.68TiB	(min: 11.14TiB)
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,single: Size:8.37TiB, Used:5.76TiB (68.89%)
   /dev/sdb1	   8.37TiB

Metadata,DUP: Size:11.00GiB, Used:5.56GiB (50.53%)
   /dev/sdb1	  22.00GiB

System,DUP: Size:32.00MiB, Used:1.09MiB (3.42%)
   /dev/sdb1	  64.00MiB

Unallocated:
   /dev/sdb1	  17.07TiB
root@charon:/home/amonra# uname -a
Linux charon 5.4.0-122-generic #138-Ubuntu SMP Wed Jun 22 15:00:31 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
root@charon:/home/amonra#

David


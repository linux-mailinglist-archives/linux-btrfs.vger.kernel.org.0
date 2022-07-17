Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC45775F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiGQL2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 07:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiGQL2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 07:28:35 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B015809
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 04:28:32 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id D2RnoEwWMGjO8D2RoozMhQ; Sun, 17 Jul 2022 12:28:31 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62d3f25f
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=kj9zAlcOel0A:10 a=msZaM4owKHOemsm-nAIA:9 a=CjuIK1q_8ugA:10
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     <linux-btrfs@vger.kernel.org>
Subject: Odd output from scrub status
Date:   Sun, 17 Jul 2022 12:28:27 +0100
Message-ID: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdiZ0ELvp/wbsNrSQ3KR3a0up7jj+w==
Content-Language: en-gb
X-CMAE-Envelope: MS4xfMT8ICe6NsIu32F6KUQH/h/IkZCDNg/XKkzKoXb/p2QGSw18bAC9saaQYYKzCR57rIaTMa0F4uS76tQ+A0KgfbjzBmw6DRah9A/4wGUiBA1u0kudvy8f
 v0LZMniNMP37a/JZsVrM8WDd8vepsnQBM6uAfPB7J2R6X3YmUXIDcFA8h6XCv9gxc9sQt+9t1wuoHJJm1diCe7ocKki5ghzwNf8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

root@charon:~/bin# btrfs scrub status /dev/sdb1
UUID:             f9655777-8c81-4d5e-8f14-c1906b7b27a3
Scrub started:    Sun Jul 17 10:27:39 2022
Status:           running
Duration:         1:59:29
Time left:        6095267:46:37
ETA:              Tue Nov 20 23:13:45 2717
Total to scrub:   4.99TiB
Bytes scrubbed:   5.48TiB
Rate:             801.72MiB/s
Error summary:    no errors found
root@charon:~/bin#

Cheers, David



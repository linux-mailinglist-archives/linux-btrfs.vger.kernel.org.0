Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7E680134
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jan 2023 20:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjA2Tjq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 29 Jan 2023 14:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjA2Tjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Jan 2023 14:39:45 -0500
X-Greylist: delayed 1107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 11:39:42 PST
Received: from bufferz9.csloxinfo.com (bufferz.csloxinfo.com [203.146.237.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9F0EA5CF
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 11:39:42 -0800 (PST)
Received: from mailx4-7.csloxinfo.com (unknown [10.20.140.67])
        by bufferz9.csloxinfo.com (Postfix) with ESMTP id 70D0323D6668;
        Mon, 30 Jan 2023 02:21:13 +0700 (ICT)
IronPort-SDR: 63d6c729_WveNMsm4sJRvav4aEhbF4s/dUZBmuf5SFlSjbO63vd4tmjb
 NYaD6vRKItStTo/5OjXeDcs2+MqnA8tXGdxUCfQ==
X-IPAS-Result: =?us-ascii?q?A0D2/wANxtZj/zLBqstagRKBYIQcEhgBAY13gyuCa4Ujj?=
 =?us-ascii?q?lFdAXiDHguCD4RKgX0PAQEBAQEBAQEBCxIwBAEBgVQBgygFA4UpASVLAQYBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwIFAwIBAQYEgQoThXWGTn8jDX8XEzSCS4MiAgGnZm6BN?=
 =?us-ascii?q?BoCZYRdgQ2aAQGBVIlzgy+FaxYGgg2BS4I9Nz5rGgFNhwKCLptygTl1gSUOg?=
 =?us-ascii?q?UaBDwIJAhFGDx9ANwMzER03CQMLbQo/FCEIDkorGhsHGiRIKiQEFQMEBAMCB?=
 =?us-ascii?q?ggLAyICDSQEMRQEKRMNEhUmIkcJAgMiYgMDBBgNAy0JPwcVESQ8BxBGOAUCD?=
 =?us-ascii?q?x83BgMJAwIfT4EgDRcFAwsVKkcECDYFBlESAggPBQ0FCgYDI0MOQhgfATMOB?=
 =?us-ascii?q?QYwPBoLDhEDUB59MgQvgUoYVZ1ogyWBZ5R2jROhZAcDg3WXXIh0GjIYgQaCW?=
 =?us-ascii?q?4xihjAIFgOECo15Q5cMolIghDGCMFAOgVlwFYFZCSWBagMZhVqIbJYqQYEHC?=
 =?us-ascii?q?YwjAQE?=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BmIsDK6XzxhsGmU1tQPXwLLXdLJyesId70hD6qkcc3dom6Wj/q
 iTdZ8guCMc5gx6ZE0d
X-IronPort-Anti-Spam-Filtered: true
Spam_Positive: LL
X-IronPort-AV: E=Sophos;i="5.97,256,1669050000"; 
   d="scan'208";a="456936020"
Received: from unknown (HELO mailx2.bestidc.net) ([203.170.193.50])
  by mail-4.csloxinfo.com with ESMTP; 30 Jan 2023 02:21:13 +0700
Received: from mailx2.bestidc.net (localhost.localdomain [127.0.0.1])
        by mailx2.bestidc.net (Proxmox) with ESMTP id AA4FC491F3;
        Sun, 29 Jan 2023 16:37:14 +0700 (+07)
Received: from mail.thaipaiboon.com (mail.thaipaiboon.com [203.170.193.111])
        by mailx2.bestidc.net (Proxmox) with ESMTPS id 1FB64491F0;
        Sun, 29 Jan 2023 16:37:14 +0700 (+07)
Received: from mail.thaipaiboon.com (localhost [127.0.0.1])
        by mail.thaipaiboon.com (Postfix) with ESMTPS id D0DE7C00C303D;
        Sun, 29 Jan 2023 16:37:13 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by mail.thaipaiboon.com (Postfix) with ESMTP id A0816C00C364C;
        Sun, 29 Jan 2023 16:37:13 +0700 (+07)
Received: from mail.thaipaiboon.com ([127.0.0.1])
        by localhost (mail.thaipaiboon.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SGubmmakiW-A; Sun, 29 Jan 2023 16:37:13 +0700 (+07)
Received: from [192.168.10.100] (unknown [160.152.44.246])
        by mail.thaipaiboon.com (Postfix) with ESMTPSA id 528C6C00C3665;
        Sun, 29 Jan 2023 16:36:56 +0700 (+07)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Re: Request Partner
To:     Recipients <banpotl@thaipaiboon.com>
From:   "Mrs. Reem E. Al-Hashimi" <banpotl@thaipaiboon.com>
Date:   Sun, 29 Jan 2023 10:36:44 +0100
Reply-To: nationalbureau@kakao.com
Message-Id: <20230129093657.528C6C00C3665@mail.thaipaiboon.com>
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_MR_MRS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Sir/Ma,

My name is Mrs. Reem E. Al-Hashimi, The Emirates Minister of State  United Arab Emirates.I have a great business proposal to discuss with you, if you are interested in Foreign Investment/Partnership please reply with your line of interest.


PLEASE REPLY ME : rrrhashimi2022@kakao.com

Reem


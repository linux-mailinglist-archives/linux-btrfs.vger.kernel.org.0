Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3A542651
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiFHF2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 01:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiFHF1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 01:27:41 -0400
Received: from out20-206.mail.aliyun.com (out20-206.mail.aliyun.com [115.124.20.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C5E18CA81
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 19:44:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0614546|-1;BR=01201311R101S92rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0471917-0.00165341-0.951155;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.O.QbPwS_1654656257;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O.QbPwS_1654656257)
          by smtp.aliyun-inc.com;
          Wed, 08 Jun 2022 10:44:17 +0800
Date:   Wed, 08 Jun 2022 10:44:21 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Forza <forza@tnonline.net>
Subject: Re: What mechanisms protect against split brain?
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <c31c664.705b352f.1810f98f3ee@tnonline.net>
References: <c31c664.705b352f.1810f98f3ee@tnonline.net>
Message-Id: <20220608104421.3759.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I tried some test about this case.

After the missing RAID1 device is re-introduced,
1, mount/read seem to work.
   checksum based error detect help.
   current pid based i/o patch select policy may help too.
       preferred_mirror = first + (current->pid % num_stripes);

2, 'btrfs scrub' failed to finish.
    Any advice to return to clean state?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/08

> Hi,
> 
> Recently there have been some discussions, both here on the mailing list and on #btrfs IRC, about the consequences of mounting one RAID1 mirror as degraded and then later re-introduce the missing device. But also on having degraded mount option in fstab and kernel command line.
> 
> So I wonder if Btrfs has some protective mechanisms against data loss/corruption if a drive is missing for a bit but later re-introduced. There is also the case of split brain where each mirror might be independently updated and then recombined.
> 
> Is there an official recommendation to have with regards to degraded mounts from kernel command line? I understand the use case as it allows the system to boot even if a device goes missing or dead after a reboot.
> 
> Thanks,
> Forza



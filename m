Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A410580751
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiGYWZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGYWZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:25:48 -0400
Received: from out20-110.mail.aliyun.com (out20-110.mail.aliyun.com [115.124.20.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C66252AA
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:25:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06773967|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00378093-0.000296213-0.995923;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.OdYhrhQ_1658787937;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OdYhrhQ_1658787937)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 06:25:37 +0800
Date:   Tue, 26 Jul 2022 06:25:38 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
In-Reply-To: <20220725134149.GY13489@twin.jikos.cz>
References: <20220723074936.30FD.409509F4@e16-tech.com> <20220725134149.GY13489@twin.jikos.cz>
Message-Id: <20220726062537.D2E7.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > In this patch, the max chunk size is changed from 
> > BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?
> 
> The patch hasn't been merged, the change from 1G to 10G without proper
> evaluation won't happen. The sysfs knob is available for users who want
> to test it or know that the non-default value works in their
> environment.

this patch is in misc-next( 5.19.0-rc8 based, 5.19.0-rc7 based) now.

5.19.0-rc8 based:
f6fca3917b4d btrfs: store chunk size in space-info struct

The sysfs knob show that current default chunk size is 1G, not 10G as
older version.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/26



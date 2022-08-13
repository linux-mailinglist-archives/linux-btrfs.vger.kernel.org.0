Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE4591BD8
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 18:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiHMQDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiHMQC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 12:02:59 -0400
Received: from out20-133.mail.aliyun.com (out20-133.mail.aliyun.com [115.124.20.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B77BE16
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 09:02:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06259475|-1;BR=01201311R151S12rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0706021-0.000990026-0.928408;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OsgPPpF_1660406574;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OsgPPpF_1660406574)
          by smtp.aliyun-inc.com;
          Sun, 14 Aug 2022 00:02:54 +0800
Date:   Sun, 14 Aug 2022 00:03:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Bart Van Assche <bvanassche@acm.org>
Subject: Re: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <e129b7aa-9589-242e-b259-298b73382002@acm.org>
References: <20220813125331.3F71.409509F4@e16-tech.com> <e129b7aa-9589-242e-b259-298b73382002@acm.org>
Message-Id: <20220814000301.7CAD.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 8/12/22 21:53, Wang Yugui wrote:
> > both '__field(enum req_op,opf)' and '__field(blk_opf_t,opf)' failed to work.
> >
> > ./include/trace/events/btrfs.h:2327:1: warning: incorrect type in assignment (different base types)
> > ./include/trace/events/btrfs.h:2327:1:    expected unsigned int [usertype] opf
> > ./include/trace/events/btrfs.h:2327:1:    got restricted blk_opf_t enum req_op
> >
> > /ssd/git/os/linux-5.19/fs/btrfs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/btrfs.h):
> > ./include/trace/events/btrfs.h:2327:1: warning: cast to restricted blk_opf_t
> > ./include/trace/events/btrfs.h:2327:1: warning: cast to restricted blk_opf_t
> > ./include/trace/events/btrfs.h:2327:1: warning: restricted blk_opf_t degrades to integer
> > ./include/trace/events/btrfs.h:2327:1: warning: restricted blk_opf_t degrades to integer
> 
>  From https://en.wikipedia.org/wiki/Posting_style:
> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?

Thanks for the comment.


> Regarding the warnings reported above: please apply patch "[PATCH] tracing: Suppress sparse warnings triggered by is_signed_type()" before testing my patch.
> 
> Thanks,
> 
> Bart.

After applied patch "[PATCH] tracing: Suppress sparse warnings triggered
by is_signed_type()",  both '__field(enum req_op,opf)' and 
'__field(blk_opf_t,opf)' work well without sparse warning(make C=1).

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/13



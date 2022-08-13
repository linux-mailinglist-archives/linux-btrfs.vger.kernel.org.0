Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3E5918D9
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiHMExk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 13 Aug 2022 00:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMExj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 00:53:39 -0400
Received: from out20-159.mail.aliyun.com (out20-159.mail.aliyun.com [115.124.20.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944784F695
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 21:53:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0456781|-1;BR=01201311R171S74rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0023675-5.01308e-05-0.997582;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OsPLFi6_1660366405;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OsPLFi6_1660366405)
          by smtp.aliyun-inc.com;
          Sat, 13 Aug 2022 12:53:25 +0800
Date:   Sat, 13 Aug 2022 12:53:32 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Bart Van Assche <bvanassche@acm.org>
Subject: Re: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <bc8c1eb6-18e0-788c-3863-7f0b39501944@acm.org>
References: <20220813091324.38BB.409509F4@e16-tech.com> <bc8c1eb6-18e0-788c-3863-7f0b39501944@acm.org>
Message-Id: <20220813125331.3F71.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

both '__field(enum req_op,opf)' and '__field(blk_opf_t,opf)' failed to work.

./include/trace/events/btrfs.h:2327:1: warning: incorrect type in assignment (different base types)
./include/trace/events/btrfs.h:2327:1:    expected unsigned int [usertype] opf
./include/trace/events/btrfs.h:2327:1:    got restricted blk_opf_t enum req_op

/ssd/git/os/linux-5.19/fs/btrfs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/btrfs.h):
./include/trace/events/btrfs.h:2327:1: warning: cast to restricted blk_opf_t
./include/trace/events/btrfs.h:2327:1: warning: cast to restricted blk_opf_t
./include/trace/events/btrfs.h:2327:1: warning: restricted blk_opf_t degrades to integer
./include/trace/events/btrfs.h:2327:1: warning: restricted blk_opf_t degrades to integer


the flowing works, but  I'm not confident about it.

./include/linux/blk_types.h:243:typedef __u32 __bitwise blk_opf_t;

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 73df80d462dc..e1f95b061ff1 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2338,7 +2338,7 @@ DECLARE_EVENT_CLASS(btrfs_raid56_bio,
                __field(        u64,    devid           )
                __field(        u32,    offset          )
                __field(        u32,    len             )
-               __field(        u8,     opf             )
+               __field(        u32,    opf             )
                __field(        u8,     total_stripes   )
                __field(        u8,     real_stripes    )
                __field(        u8,     nr_data         )
@@ -2349,7 +2349,7 @@ DECLARE_EVENT_CLASS(btrfs_raid56_bio,
                __entry->full_stripe    = rbio->bioc->raid_map[0];
                __entry->physical       = bio->bi_iter.bi_sector << SECTOR_SHIFT;
                __entry->len            = bio->bi_iter.bi_size;
-               __entry->opf            = bio_op(bio);
+               __entry->opf            = (__force u32)bio_op(bio);
                __entry->devid          = trace_info->devid;
                __entry->offset         = trace_info->offset;
                __entry->stripe_nr      = trace_info->stripe_nr;

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/13

> On 8/12/22 18:13, Wang Yugui wrote:
> > This warning is still ON after applied this patch([PATCH] tracing: Suppress sparse warnings triggered by is_signed_type())
> 
> How about the patch below?
> 
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 73df80d462dc..925e74356547 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2338,7 +2338,7 @@ DECLARE_EVENT_CLASS(btrfs_raid56_bio,
>   		__field(	u64,	devid		)
>   		__field(	u32,	offset		)
>   		__field(	u32,	len		)
> -		__field(	u8,	opf		)
> +		__field(enum req_op,	opf		)
>   		__field(	u8,	total_stripes	)
>   		__field(	u8,	real_stripes	)
>   		__field(	u8,	nr_data		)
> 
> Thanks,
> 
> Bart.



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936E714BD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjE2OPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjE2OPg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 10:15:36 -0400
Received: from out28-58.mail.aliyun.com (out28-58.mail.aliyun.com [115.124.28.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD139C
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 07:15:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05396103|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.028183-0.000427146-0.97139;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.TFjg.wr_1685369729;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.TFjg.wr_1685369729)
          by smtp.aliyun-inc.com;
          Mon, 29 May 2023 22:15:30 +0800
Date:   Mon, 29 May 2023 22:15:32 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz
Subject: Re: please fold some fix into misc-next(btrfs: print assertion failure report and stack trace from the same line)
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230529134758.GF575@twin.jikos.cz>
References: <20230528060227.AF10.409509F4@e16-tech.com> <20230529134758.GF575@twin.jikos.cz>
Message-Id: <20230529221531.FEDF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Sun, May 28, 2023 at 06:02:28AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > please fold some fix into misc-next(btrfs: print assertion failure report and stack trace from the same line).
> > 
> > Because 'btrfs_assertfail' become macro(inline), we should drop it from objtools.
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index f937be1afe65..060032cfb046 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -170,7 +170,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
> >  		"__reiserfs_panic",
> >  		"__stack_chk_fail",
> >  		"__ubsan_handle_builtin_unreachable",
> > -		"btrfs_assertfail",
> 
> If this is not in objtool, does it produce any warning? I'm not sure if
> I want to do the change in the same patch and last time I checked
> objtool was fine with the listed function not existing.

yes, it produce no warning, but this funciton in here become a noisy.

we need to do this in the same patch, because in this patch, 
it become from necessary to noisy.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/29



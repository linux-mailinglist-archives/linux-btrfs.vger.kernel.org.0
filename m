Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14253357884
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 01:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhDGX2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 19:28:07 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:47523 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDGX2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 19:28:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1162082|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.36726-0.00326118-0.629478;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JwZxs4d_1617838075;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JwZxs4d_1617838075)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 08 Apr 2021 07:27:55 +0800
Date:   Thu, 08 Apr 2021 07:28:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Dennis Zhou <dennis@kernel.org>
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
In-Reply-To: <YG3IJnAjgikZ0PkC@google.com>
References: <20210407210905.F790.409509F4@e16-tech.com> <YG3IJnAjgikZ0PkC@google.com>
Message-Id: <20210408072800.6C1F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> > > > upper caller:
> > > >     nofs_flag = memalloc_nofs_save();
> > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > >     memalloc_nofs_restore(nofs_flag);
> 
> The issue is here. nofs is set which means percpu attempts an atomic
> allocation. If it cannot find anything already allocated it isn't happy.
> This was done before memalloc_nofs_{save/restore}() were pervasive.
> 
> Percpu should probably try to allocate some pages if possible even if
> nofs is set.

Thanks.

I will wait for the patch, and then test it.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/08



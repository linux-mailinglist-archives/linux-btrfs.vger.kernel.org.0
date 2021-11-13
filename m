Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C344F1F1
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 08:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhKMHHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Nov 2021 02:07:38 -0500
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:50434 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKMHHg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Nov 2021 02:07:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04849523|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0034905-0.000201677-0.996308;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Ls9rlrO_1636787082;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ls9rlrO_1636787082)
          by smtp.aliyun-inc.com(10.147.41.121);
          Sat, 13 Nov 2021 15:04:43 +0800
Date:   Sat, 13 Nov 2021 15:04:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: fix discard support check
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <19cde2a1-d17d-d8cf-2539-c1d79b32e376@gmx.com>
References: <20211113031408.17521-1-wangyugui@e16-tech.com> <19cde2a1-d17d-d8cf-2539-c1d79b32e376@gmx.com>
Message-Id: <20211113150444.C372.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2021/11/13 11:14, Wang Yugui wrote:
> > [BUG]
> > mkfs.btrfs(v5.15) output a message even if the disk is a HDD without
> > TRIM/DISCARD support.
> >    Performing full device TRIM /dev/sdc2 (326.03GiB) ...
> >
> > [CAUSE]
> > mkfs.btrfs check TRIM/DISCARD support through the content of
> > queue/discard_granularity, but compare it against a wrong value.
> >
> > When hdd without TRIM/DISCARD support, the content of
> > queue/discard_granularity is '0' '\n' '\0', rather than '0' '\0'.
> 
> Can we get rid of such bad comparison and just go strtoll() and compare
> the value?

strtoll() or strcmp() is a good choice for refact.  but now just a
direct fix.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/11/13


> 
> >
> > [FIX]
> > compare it against the right value.
> >
> > Fixes: c50c448518bb ("btrfs-progs: do sysfs detection of device discard capability")
> > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > ---
> >   common/device-utils.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/device-utils.c b/common/device-utils.c
> > index 74a25879..76d5c584 100644
> > --- a/common/device-utils.c
> > +++ b/common/device-utils.c
> > @@ -64,7 +64,7 @@ static int discard_supported(const char *device)
> >   		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
> >   		return 0;
> >   	} else {
> > -		if (buf[0] == '0' && buf[1] == 0) {
> > +		if (buf[0] == '0' && buf[1] == '\n') {
> >   			pr_verbose(3, "%s: discard_granularity %s\n", device, buf);
> >   			return 0;
> >   		}
> >



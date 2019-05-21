Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FF258AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 22:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfEUUMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 16:12:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33634 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfEUUMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 16:12:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id p18so60469qkk.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ahuj8dsoqzxV7jo0Q60VogkYnQLmP0dwnM5S0EqWAmI=;
        b=Es9kdpwSxoe/IZKRrHzA6BXpSxfy3uDawKBhMkbj9o99ByXj+pmX47M+ZqoOp+gEqP
         3ofmAeUCDPzHuKmiGMvMlcogxPlZhcoQ0zV8w07KAbc/lprM9tZni4heoKrAq9TPGkKW
         4SLCQ1LVMIMP0kT/qMrkn+L7m82aepTGN4rdDnSLvVu4vAhJOs9+cddaHltVIKjLhMyN
         YXHo3uOoBDyc10XGTO+xlT1mbV2WQPZ5O3iodbRo+wCwIvFn53Kh/BvXJaaJVu5X7B4o
         w4avqIKcEVTbnRuavSDNydfcS0xZBxhCFbZzbAoE9G4Mlw7e0vkoKTEVct0x+Rx9rAqG
         bwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ahuj8dsoqzxV7jo0Q60VogkYnQLmP0dwnM5S0EqWAmI=;
        b=ICjwSv1OzD6CJCZjAWm7KqH7egJYX4r/SfWJ1SyCZPR9F/xCxv6zwMM0ZOYGZPo2u7
         BoP5WqdTNoHd3FOdxQuESiNegq4nhcMCj8cuq8Z+X9as2oU4nedUxHEkxTSf4IibpRzi
         CddmOIJwt6D13hk2OpsEYkBBMI29vtWeubKh0Okjb91ZJJ3MEiIx8HFypEJYo+oNKqHB
         KKzruBHJowh6jkSQne25K8TYG2m3quvLW4RG5ndgiFvnGjdf/3kYdrKlUnzo6p+GgM75
         ri0YVy72BayxieW5OzO3yYNjVokg9jDC8Nmao10yODlx9XbESzdTjlGluR0BAJmO4MVb
         ItHA==
X-Gm-Message-State: APjAAAX3OJQWg8tOxOOfSFrWCihBR4bv09BKi+ZkEs3ohvEuZHsgRUv1
        Exl7Wb58zIgBHYRqsjp6P5A=
X-Google-Smtp-Source: APXvYqybSgi+6YnTjtT/7+YhMTfR4CUDr99plsbFteUA1L7IO8fAt+x/WCGmzAB03izLz3WDWaFuOg==
X-Received: by 2002:a37:9085:: with SMTP id s127mr43685881qkd.352.1558469549248;
        Tue, 21 May 2019 13:12:29 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t2sm10642458qkd.57.2019.05.21.13.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 13:12:28 -0700 (PDT)
Date:   Tue, 21 May 2019 16:12:27 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Andrea Gelmini <andrea.gelmini@linux.it>
Cc:     Michael =?iso-8859-1?B?TGHf?= <bevan@bi-co.net>,
        dm-devel@redhat.com, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: fstrim discarding too many or wrong blocks on Linux 5.1, leading
 to data loss
Message-ID: <20190521201226.GA23332@lobo>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net>
 <3142764D-5944-4004-BC57-C89C89AC9ED9@bi-co.net>
 <F170BB63-D9D7-4D08-9097-3C18815BE869@bi-co.net>
 <20190521190023.GA68070@glet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521190023.GA68070@glet>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21 2019 at  3:00pm -0400,
Andrea Gelmini <andrea.gelmini@linux.it> wrote:

> On Tue, May 21, 2019 at 06:46:20PM +0200, Michael Laß wrote:
> > > I finished bisecting. Here’s the responsible commit:
> > > 
> > > commit 61697a6abd24acba941359c6268a94f4afe4a53d
> > > Author: Mike Snitzer <snitzer@redhat.com>
> > > Date:   Fri Jan 18 14:19:26 2019 -0500
> > > 
> > >    dm: eliminate 'split_discard_bios' flag from DM target interface
> > > 
> > >    There is no need to have DM core split discards on behalf of a DM target
> > >    now that blk_queue_split() handles splitting discards based on the
> > >    queue_limits.  A DM target just needs to set max_discard_sectors,
> > >    discard_granularity, etc, in queue_limits.
> > > 
> > >    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > 
> > Reverting that commit solves the issue for me on Linux 5.1.3. Would
> that be an option until the root cause has been identified? I’d rather
> not let more people run into this issue.
> 
> Thanks a lot Michael, for your time/work.
> 
> This kind of bisecting are very boring and time consuming.
> 
> I CC: also the patch author.

Thanks for cc'ing me, this thread didn't catch my eye.

Sorry for your troubles.  Can you please try this patch?

Thanks,
Mike

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1fb1333fefec..997385c1ca54 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1469,7 +1469,7 @@ static unsigned get_num_write_zeroes_bios(struct dm_target *ti)
 static int __send_changing_extent_only(struct clone_info *ci, struct dm_target *ti,
 				       unsigned num_bios)
 {
-	unsigned len = ci->sector_count;
+	unsigned len;
 
 	/*
 	 * Even though the device advertised support for this type of
@@ -1480,6 +1480,8 @@ static int __send_changing_extent_only(struct clone_info *ci, struct dm_target *
 	if (!num_bios)
 		return -EOPNOTSUPP;
 
+	len = min((sector_t)ci->sector_count, max_io_len_target_boundary(ci->sector, ti));
+
 	__send_duplicate_bios(ci, ti, num_bios, &len);
 
 	ci->sector += len;

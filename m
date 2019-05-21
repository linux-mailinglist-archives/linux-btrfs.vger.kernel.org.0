Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC3257E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEUTA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 15:00:29 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40156 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfEUTA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 15:00:28 -0400
Received: by mail-wr1-f45.google.com with SMTP id f10so4410038wre.7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yA8lmoKu5fbp6TKJMD+R4FTojscpyNZ+klKiYX0Db54=;
        b=Su319boZWugKIkcpAlfpxfuJj0/yR07CC0RQqDiSanelRwDOCkzAUUasu3ZZj2+S0i
         GpLxpUMTONRAYxvZ9z6FOhFR0WGHAuKNNvNR3aw8D06UvxplzSfc5eOUMH+EcxxTcjiE
         gVIBpV2/Xt1TvD90TVNojoFPfATV1G0SAsI4UsEaXPhxUB5nFlGtsVSAqDTQhHhX6wc6
         0zYwwHfB09AsoysAFDcW742hYOin6T+R/KGJDdsZA7zp+57UoNumZ+Tnbu+IEG/oglEr
         YrFXRCsmqEKq2++F9Q6flb+YKPzHPNObgy5Kblk0ALG6OgFMmZNbXHxgRfvPKIu7wLwq
         UHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yA8lmoKu5fbp6TKJMD+R4FTojscpyNZ+klKiYX0Db54=;
        b=WkIXcASlKsWGuxI1PX1ZxlKO8E+WJEJNMpiA0RuMlye2cz6tO/x1zB7/+OsdnI+Vzf
         7wH8BIeXqEvhcVUdlRy7Wt9Lix5fsyMzk7W+LHvTa4LZyKHBk4A2Kc4FizhReLbwSL91
         MhxMMQDaWBv80qBVOnkQ4z2nF1fTgkXP38jnQSh+LNFE7ByIHPsX+NQkJg8+amZ47Zij
         KvB4cYlE7zSLr/xjMJO83qWTeTioqdzMYaJR05jLEDjxATV/RIKQ4CZLFcJVX/hxw/ml
         amQ/UAbHFsupE4qlUaGStoVdyPpRdvkMFYF7E/sJ3hT2LL7MxqaLPMUEtsGm9xsw3XGR
         qG9w==
X-Gm-Message-State: APjAAAVSAzhnjctvwD62x9kBfzEUP/n4cPx0U3zWxuAt05bi5SH+M2UC
        gjYdhDgL93GkU9z4nmDghoo=
X-Google-Smtp-Source: APXvYqxnl9qzDKl+opfSn1q4+1QbnktOTLdIPSMLM8o2SVSRwAheyBolnqCxs3wXkdWpQ1FnWUIUZw==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr12544322wrv.268.1558465226324;
        Tue, 21 May 2019 12:00:26 -0700 (PDT)
Received: from glet ([91.187.202.82])
        by smtp.gmail.com with ESMTPSA id h14sm21055273wrt.11.2019.05.21.12.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:00:25 -0700 (PDT)
Date:   Tue, 21 May 2019 21:00:23 +0200
From:   Andrea Gelmini <andrea.gelmini@linux.it>
To:     Michael =?iso-8859-1?B?TGHf?= <bevan@bi-co.net>
Cc:     dm-devel@redhat.com, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [dm-devel] fstrim discarding too many or wrong blocks on Linux
 5.1, leading to data loss
Message-ID: <20190521190023.GA68070@glet>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
 <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net>
 <3142764D-5944-4004-BC57-C89C89AC9ED9@bi-co.net>
 <F170BB63-D9D7-4D08-9097-3C18815BE869@bi-co.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F170BB63-D9D7-4D08-9097-3C18815BE869@bi-co.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 06:46:20PM +0200, Michael Laß wrote:
> > I finished bisecting. Here’s the responsible commit:
> > 
> > commit 61697a6abd24acba941359c6268a94f4afe4a53d
> > Author: Mike Snitzer <snitzer@redhat.com>
> > Date:   Fri Jan 18 14:19:26 2019 -0500
> > 
> >    dm: eliminate 'split_discard_bios' flag from DM target interface
> > 
> >    There is no need to have DM core split discards on behalf of a DM target
> >    now that blk_queue_split() handles splitting discards based on the
> >    queue_limits.  A DM target just needs to set max_discard_sectors,
> >    discard_granularity, etc, in queue_limits.
> > 
> >    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> 
> Reverting that commit solves the issue for me on Linux 5.1.3. Would that be an option until the root cause has been identified? I’d rather not let more people run into this issue.

Thanks a lot Michael, for your time/work.

This kind of bisecting are very boring and time consuming.

I CC: also the patch author.

Thanks again,
Andrea

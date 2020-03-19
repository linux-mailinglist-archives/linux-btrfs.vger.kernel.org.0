Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B318118B9E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCSPAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:00:36 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.52]:14529 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbgCSPAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:00:36 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id DD0E71E2685
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 10:00:34 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id EwewjHr6PVQh0EwewjWtWh; Thu, 19 Mar 2020 10:00:34 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5ZethQ5VJ2UTE5O57DfMDXC0wSJ7S0J1b8ytigJDsgI=; b=u0BYLkEGQYJVRTIwd1MV+X0lKN
        Abj+Ue9wf+VsCn5ULHLLvWpPw2fq1n+lp/yHzKaS6pC95ENnTAT5MBs9T7s1KF6Dzr3Fp8n95OQLZ
        H2TzdzKw3Jbo5etBia1z0FjWzXRul2ovVbjNcrOqPXUwhzD0PNEs/VhjipdbSCDISXm+Bbmeld4Co
        bhXe/y64qyKtL6WV4LjKWV/dhFaF+OVWZpq40VxgpC6hvwlfabAOiEXlz+TCllj24IYkiZTlr9xH0
        1GmQkrLzGceCZ7xuX2xKxhLHSFb4aVyat+3fsNWJfifn7ZaABf081WQdGEjcnam5M0vBzZsQW4Dv9
        aaklnf+g==;
Received: from [191.249.66.103] (port=59898 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEwew-0007bh-71; Thu, 19 Mar 2020 12:00:34 -0300
Message-ID: <1dce098edf73da46c5ae251554455d462d79ec01.camel@mpdesouza.com>
Subject: Re: [PATCHv2] progs: mkfs-tests: Skip test if truncate failed with
 EFBIG
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        wqu@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Thu, 19 Mar 2020 12:03:44 -0300
In-Reply-To: <20200306033922.GA32710@hephaestus>
References: <20200224180534.15279-1-marcos@mpdesouza.com>
         <20200302200716.GW2902@twin.jikos.cz> <20200302203006.GA22707@hephaestus>
         <20200302203649.GA2902@twin.jikos.cz> <20200306033922.GA32710@hephaestus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEwew-0007bh-71
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.172]) [191.249.66.103]:59898
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Humble ping :)

On Fri, 2020-03-06 at 00:39 -0300, Marcos Paulo de Souza wrote:
> On Mon, Mar 02, 2020 at 09:36:49PM +0100, David Sterba wrote:
> > On Mon, Mar 02, 2020 at 05:30:06PM -0300, Marcos Paulo de Souza
> wrote:
> >
> > > >From 52b96ac75c2f8876f1ed9424cef92a4557306009 Mon Sep 17
> 00:00:00 2001
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > Date: Sat, 15 Feb 2020 19:47:12 -0300
> > > Subject: [PATCH] progs: mkfs-tests: Skip test if truncate failed
> with EFBIG
> > > 
> > > The truncate command can fail in some platform like PPC32[1]
> because it
> > > can't create files up to 6E in size. Skip the test if this was
> the
> > > problem why truncate failed.
> > > 
> > > [1]: https://github.com/kdave/btrfs-progs/issues/192
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > >  tests/mkfs-tests/018-multidevice-overflow/test.sh | 12
> +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh
> b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> > > index 6c2f4dba..b8e2b18d 100755
> > > --- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
> > > +++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> > > @@ -14,7 +14,17 @@ prepare_test_dev
> > >  run_check_mkfs_test_dev
> > >  run_check_mount_test_dev
> > >  
> > > -run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
> > > +# truncate can fail with EFBIG if the OS cannot created a 6E
> file
> > > +stdout=$($SUDO_HELPER truncate -s 6E "$TEST_MNT/img1" 2>&1)
> > 
> > So this is reading and parsing stdout, but not using the standard
> > helpers that also log the commands. The stdout approach probably
> works
> > but I'd still like to avoid using plain $(...)
> 
> What do you think about the patches bellow? With these two patches
> applied you
> can drop this one. Thanks.


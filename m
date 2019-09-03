Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F56A680F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICMFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 08:05:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbfICMFo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 08:05:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4662FAF30;
        Tue,  3 Sep 2019 12:05:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9564ADA8CD; Tue,  3 Sep 2019 14:06:03 +0200 (CEST)
Date:   Tue, 3 Sep 2019 14:06:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
Message-ID: <20190903120603.GB2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <20190703132158.GV20977@twin.jikos.cz>
 <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com>
 <51c42306-b4ae-a243-ac96-fb3acb1a317c@oracle.com>
 <20190902162230.GY2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902162230.GY2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 02, 2019 at 06:22:30PM +0200, David Sterba wrote:
> On Mon, Sep 02, 2019 at 04:01:56PM +0800, Anand Jain wrote:
> > 
> > David,
> > 
> >   I don't see this patch is integrated. Can you please integrated this 
> > patch thanks.
> 
> I don't know why but the patch got lost somewhere, adding to devel
> again.

Not lost, but dropped, misc-tests/021 fails. So dropped again, please
fix it and test before posting again. Thanks.

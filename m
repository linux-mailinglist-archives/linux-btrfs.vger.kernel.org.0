Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336E03FF03F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345838AbhIBPck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 11:32:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbhIBPci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 11:32:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 942901FFB9;
        Thu,  2 Sep 2021 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630596689;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tF0Klwcq51RKixweTldK4xWB6QJRjB6Pgp3dOtxTuNs=;
        b=FwwmYn4rGdL7oAk+glZ469FkzwiuMhouu9awEJccf/wuYZlMQTKr0g1kdvfxKUdlhPlekw
        45kzOOEW3PhjQTWXk4yuEzGcB7SZSz/rhPhsLtbPMwWBrWfcpIAOvnS6tW3S85fzKdGKN+
        pkzQKR5qysRdwmo8mTKQG7bhP/5lV6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630596689;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tF0Klwcq51RKixweTldK4xWB6QJRjB6Pgp3dOtxTuNs=;
        b=Z5eZaY79x6FyZ0zmhOeO+sYH9mVfzbGvp+tWhQXxVCqM2z/LTKsIhSRH79spxpoxqCRKsG
        Rem0nzRm4V7sWyCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8C4C1A3BBC;
        Thu,  2 Sep 2021 15:31:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C674DA72B; Thu,  2 Sep 2021 17:31:28 +0200 (CEST)
Date:   Thu, 2 Sep 2021 17:31:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: use num_device to check for the last
 surviving seed device
Message-ID: <20210902153128.GY3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1630478246.git.anand.jain@oracle.com>
 <d9c89b1740a876b3851fcf358f22809aa7f1ad2a.1630478246.git.anand.jain@oracle.com>
 <ea5d6985-7c7d-3147-e0b6-fac17a2e298f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea5d6985-7c7d-3147-e0b6-fac17a2e298f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 01, 2021 at 12:22:30PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 9:43, Anand Jain wrote:
> > For both sprout and seed fsids,
> >  btrfs_fs_devices::num_devices provides device count including missing
> >  btrfs_fs_devices::open_devices provides device count excluding missing
> > 
> > We create a dummy struct btrfs_device for the missing device, so
> > num_devices != open_devices when there is a missing device.
> > 
> > In btrfs_rm_devices() we wrongly check for %cur_devices->open_devices
> > before freeing the seed fs_devices. Instead we should check for
> > %cur_devices->num_devices.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Is there a sequence of step that reproduce the problem?

Yeah that would be great, I don't have much idea what actually happens
here and what is the bug.

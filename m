Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238A810C7BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfK1LIw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 06:08:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfK1LIw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 06:08:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C77E9B33D;
        Thu, 28 Nov 2019 11:08:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 677D9DAC01; Thu, 28 Nov 2019 12:08:48 +0100 (CET)
Date:   Thu, 28 Nov 2019 12:08:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs-progs: qgroup: Check for ENOTCONN error on
 create/assign/limit
Message-ID: <20191128110848.GD2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191127034851.13482-1-marcos.souza.org@gmail.com>
 <0d82cb5f-9d01-0e3a-26bb-33019d8a9e65@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d82cb5f-9d01-0e3a-26bb-33019d8a9e65@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 27, 2019 at 12:30:38PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/11/27 上午11:48, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Current btrfs code returns ENOTCONN when the user tries to create a
> > qgroup on a subvolume without quota enabled. In order to present a
> > meaningful message to the user, we now handle ENOTCONN showing
> > the message "quota not enabled".
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Don't forget the original -EINVAL.
> 
> So it needs to cover both -EINVAL (for older kernel) and -ENOTCONN (for
> newer kernel).

I think for now only ENOTCONN should be interpreted as 'quotas not
enabled' as we can be sure it's just that. But EINVAL means 'invalid
parameter' and this can be interpreted in that context as if the qgroup
ids are wrong etc.

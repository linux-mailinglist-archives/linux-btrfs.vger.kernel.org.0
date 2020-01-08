Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34D713433D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAHNCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 08:02:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:54254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAHNC3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 08:02:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 646C6ACE1;
        Wed,  8 Jan 2020 13:02:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0BEF9DA791; Wed,  8 Jan 2020 14:02:17 +0100 (CET)
Date:   Wed, 8 Jan 2020 14:02:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: memleaks in btrfs-devel/misc-next
Message-ID: <20200108130217.GD3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jth@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <b3cfdb33-11d6-b237-c00f-60e1e51f1848@kernel.org>
 <20200108003104.GA41934@dennisz-mbp.dhcp.thefacebook.com>
 <a1834955-9d1e-2f7b-13e9-7be02bd368fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1834955-9d1e-2f7b-13e9-7be02bd368fe@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 08, 2020 at 08:28:12AM +0100, Johannes Thumshirn wrote:
> Am 08.01.20 um 01:31 schrieb Dennis Zhou:
> [...]
> > I believe it's because I forgot to put a reference in the relocation
> > path. The below seems to fix it in my tests, but would you mind
> > verifying?
> 
> 
> Thanks for the quick turn around.
> Tested-by: Johannes Thumshirn <jth@kernel.org>
> 
> @David can you fold this into
> 63c3d72cf65e ("btrfs: add the beginning of async discard, discard
> workqueue")

Folded and pushed, thanks for catching it.

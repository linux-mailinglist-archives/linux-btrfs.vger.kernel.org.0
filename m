Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53FC162B20
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 17:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgBRQy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 11:54:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:33576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQy4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 11:54:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50116AF41;
        Tue, 18 Feb 2020 16:54:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B02EDDA7BA; Tue, 18 Feb 2020 17:54:38 +0100 (CET)
Date:   Tue, 18 Feb 2020 17:54:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, ethanwu <ethanwu@synology.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
Message-ID: <20200218165438.GT2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        ethanwu <ethanwu@synology.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
 <5901b2be7358137e691b319cbad43111@synology.com>
 <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
 <20200211182159.GD2902@twin.jikos.cz>
 <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
 <8eeca7c0-8283-8cd6-2354-9eb9373c9bd3@gmx.com>
 <20200212145740.GK2902@twin.jikos.cz>
 <0aa5bb89-d8ed-973b-9cd2-8e787fabe301@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa5bb89-d8ed-973b-9cd2-8e787fabe301@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 13, 2020 at 08:59:56AM +0800, Qu Wenruo wrote:
> BTW, from your initial report, the csum looks pretty long.
> 
> Are you testing with those new csum algos? And could that be the reason
> why it's much easier to reproduce?

I have various configurations of test setups, some VMs use SHA256 and it
could be the factor that makes the bug reproducible.

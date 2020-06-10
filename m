Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F451F505F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgFJIeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 04:34:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:54916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFJIeH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 04:34:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9EAEDABE3;
        Wed, 10 Jun 2020 08:34:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ACA95DA872; Wed, 10 Jun 2020 10:33:59 +0200 (CEST)
Date:   Wed, 10 Jun 2020 10:33:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add little-endian optimized key helpers
Message-ID: <20200610083359.GG27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200609194926.9343-1-dsterba@suse.com>
 <SN4PR0401MB35987DAB480E00C23708C7019B830@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987DAB480E00C23708C7019B830@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 10, 2020 at 07:51:55AM +0000, Johannes Thumshirn wrote:
> One question, why endianity instead of endianess?
> I think the latter is more common (in fact I had to google 
> to see if the former even exists)

It exists but you're right that endianness (double n) is more common,
I'll fix it. Thanks.

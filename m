Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5B81739E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgB1Oc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 09:32:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:51178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB1Oc5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 09:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6398DAE71;
        Fri, 28 Feb 2020 14:32:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C823BDA7FF; Fri, 28 Feb 2020 15:32:35 +0100 (CET)
Date:   Fri, 28 Feb 2020 15:32:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 00/21] btrfs: refactor and generalize
 chunk/dev_extent/extent allocation
Message-ID: <20200228143235.GM2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
 <20200225143404.GF2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225143404.GF2902@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 03:34:04PM +0100, David Sterba wrote:
> Hi,
> 
> On Tue, Feb 25, 2020 at 12:56:05PM +0900, Naohiro Aota wrote:
> > This series refactors chunk allocation, device_extent allocation and
> > extent allocation functions and make them generalized to be able to
> > implement other allocation policy easily.
> 
> I went through the patches and haven't seen anything serious so will do
> another pass and then move it to misc-next as it's all a fairly
> straightforward.

Now pushed to misc-next. I made some changes but mostly updating
comments of the code that got moved. While it's ok to keep it as is I
take this opportunity to do that in one go instead of another patch.

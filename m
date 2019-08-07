Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC07848D6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHGJr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 05:47:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfHGJr2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 05:47:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F98EB0B6;
        Wed,  7 Aug 2019 09:47:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F512DA7D7; Wed,  7 Aug 2019 11:47:59 +0200 (CEST)
Date:   Wed, 7 Aug 2019 11:47:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 12/32] Btrfs: fix deadlock between fiemap
 and transaction commits
Message-ID: <20190807094759.GQ28208@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190806213522.19859-1-sashal@kernel.org>
 <20190806213522.19859-12-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806213522.19859-12-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 05:35:00PM -0400, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit a6d155d2e363f26290ffd50591169cb96c2a609e ]
> 
> Fixes: 03628cdbc64db6 ("Btrfs: do not start a transaction during fiemap")

The commit is a regression fix during the 5.2 cycle, how it could end up
in a 4.19 stable candidate?

$ git describe  03628cdbc64db6
v5.1-rc7-201-g03628cdbc64d

$ git describe --contains 03628cdbc64db6
v5.2-rc1~163^2~26

And it does not belong to 5.2 either, git cherry-pick on top of 5.2
fails.

I think such sanity check can be done automatically so the patches don't
accidentally land in trees where don't belong.

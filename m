Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38BC33F83C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 19:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCQSiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 14:38:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhCQSiu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 14:38:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8C50ABD7;
        Wed, 17 Mar 2021 18:38:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2355DA6E2; Wed, 17 Mar 2021 19:36:47 +0100 (CET)
Date:   Wed, 17 Mar 2021 19:36:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in
 range
Message-ID: <20210317183647.GW7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20210316132746.19979-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316132746.19979-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 01:27:46PM +0000, Sidong Yang wrote:
> When user assign qgroup with qgroup id that is too big to exceeds
> range and invade level value, and it works without any error. but
> this action would be make undefined error. this code make sure that
> qgroup id doesn't exceed range(0 ~ 2^48-1).

Should the level be also validate? The function parse_qgroupid does not
do full validation, so eg 0//0 would be parsed as a path and not as a
typo, level larger than 64K will be silently clamped.

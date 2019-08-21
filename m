Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8008497B40
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfHUNv0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 09:51:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbfHUNv0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 09:51:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D44D0B022
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 13:51:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D317EDA7DB; Wed, 21 Aug 2019 15:51:47 +0200 (CEST)
Date:   Wed, 21 Aug 2019 15:51:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: dev stats item key conversion per cpu type is
 not needed
Message-ID: <20190821135146.GD18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190821092634.6778-1-anand.jain@oracle.com>
 <20190821092634.6778-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821092634.6778-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 05:26:33PM +0800, Anand Jain wrote:
> %found_key is not used, drop it.

Patches that remove dead/unused code should say why, eg. in this case
the variable hasn't been used since the beginning, but in other cases it
may point to code that needs closer attention.

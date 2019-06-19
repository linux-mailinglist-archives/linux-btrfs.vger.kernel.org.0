Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4432A4C39A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 00:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSW1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 18:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfFSW1f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 18:27:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D488AC8C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 22:27:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57053DA897; Thu, 20 Jun 2019 00:28:21 +0200 (CEST)
Date:   Thu, 20 Jun 2019 00:28:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs-progs: Remove commented code
Message-ID: <20190619222820.GH8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190619140440.5550-1-nborisov@suse.com>
 <20190619140440.5550-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619140440.5550-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 05:04:38PM +0300, Nikolay Borisov wrote:
> This piece of code has been commented since 2009, given the number of
> changes that have happened it's unlikely it could be made to work or
> is needed at all. Just delete it.

I has been ifdefed out in the infamous monster commit that changed the
format (95d3f20b51e9b2ee2182231), so the removed code is basically the
v0 format (I haven't checked closely), and that's been removed recently.

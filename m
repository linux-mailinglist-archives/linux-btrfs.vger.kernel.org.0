Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48701162903
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 16:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgBRPAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 10:00:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBRPAy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 10:00:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8E14C1B0;
        Tue, 18 Feb 2020 15:00:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 314BBDA7BA; Tue, 18 Feb 2020 16:00:35 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:00:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4][v2] Error condition failure fixes
Message-ID: <20200218150035.GN2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200213154731.90994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213154731.90994-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 13, 2020 at 10:47:27AM -0500, Josef Bacik wrote:
> v1->v2:
> - Fixed the ins.objectid thing Nikolay pointed out, and reworked that patch a
>   bit to do the right thing in case of a add_extent_mapping() further down in
>   that function as well.
> 
> ------------------- Original email -----------------------------
> I've been running my bpf error injection stress script and been fixing what has
> fallen out.  I don't think I've fixed everything yet, but to reduce the noise
> from Dave's testing here's the current set of fixes I have.  These are based on
> misc-next from late last week, but should apply cleanly to the recent set.
> These aren't super important, but will cut down on the noise from things like
> generic/019 and generic/475.  Thanks,

The VM with 1G of memory does not complain anymore and completes the
whole fstests. Patchset moved from topic branch to misc-next and despite
the fixes are not considered serious I'll forward them to current rc.
Thanks.

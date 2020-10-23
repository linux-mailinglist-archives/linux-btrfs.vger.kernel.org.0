Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FBA297580
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbgJWRFh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 13:05:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375829AbgJWRFg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 13:05:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D13BDAC82;
        Fri, 23 Oct 2020 17:05:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7B85DA7F1; Fri, 23 Oct 2020 19:04:03 +0200 (CEST)
Date:   Fri, 23 Oct 2020 19:04:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
Subject: Re: [PATCH v9 0/3] readmirror feature (read_policy sysfs and
 in-memory only approach)
Message-ID: <20201023170403.GM6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603347462.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 22, 2020 at 03:43:34PM +0800, Anand Jain wrote:
> v9: C coding style fixes in 1/3 and 3/3

So the point of adding the sysfs knobs is to allow testing various
mirror selection strategies, what exactly was discussed in the past. Do
you have patches for that as well? It does not need to be final and
polished but at least give us something to test.

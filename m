Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24272205771
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgFWQor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 12:44:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732182AbgFWQoq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 12:44:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22191AEAF;
        Tue, 23 Jun 2020 16:44:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 921D9DA79B; Tue, 23 Jun 2020 18:44:33 +0200 (CEST)
Date:   Tue, 23 Jun 2020 18:44:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v3 02/16] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20200623164433.GN27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <1574678357-22222-3-git-send-email-anand.jain@oracle.com>
 <20200612105606.18210-1-anand.jain@oracle.com>
 <20200612153935.GU27795@twin.jikos.cz>
 <eba7d4f9-82b1-49c7-54c1-c4a6dcf905ac@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba7d4f9-82b1-49c7-54c1-c4a6dcf905ac@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 13, 2020 at 06:48:00AM +0800, Anand Jain wrote:
>   On a different topic. I checked with you before - by legacy send.c and
>   receive.c use stderr for verbosity. Is it a regression to change these
>   to stdout now?

If stdout is used to dump the stream data we cannot obviously print the
messages there. When the -f option is used, the stdout is available but
I'm not sure we want to switch the output descriptor based on an option.
For now I think it needs to stay.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B96CEACD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfJGRlP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 13:41:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbfJGRlP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 13:41:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8C98AF65;
        Mon,  7 Oct 2019 17:41:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A07BDA7FB; Mon,  7 Oct 2019 19:41:29 +0200 (CEST)
Date:   Mon, 7 Oct 2019 19:41:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: add verbose option to btrfs device scan
Message-ID: <20191007174129.GK2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 12:11:52PM +0800, Anand Jain wrote:
> To help debug device scan issues, add verbose option to btrfs device scan.

The common options like --verbose are going to be added into the global
command so I'd rather avoid adding them to new subcommands as this would
become unnecessary compatibility issue.

There's an pattern to follow, the output formats (--format). So add a
definition for global verbosity options, add new GETOPT_VAL global enum
values that do not clash with existing options, add relevant
HELPINFO_INSERT_ text string and use it in commands where needed.

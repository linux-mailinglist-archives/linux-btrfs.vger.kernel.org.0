Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB11A3878
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgDIQ5n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 12:57:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgDIQ5n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 12:57:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B0E2AB7F;
        Thu,  9 Apr 2020 16:57:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 688C8DA70B; Thu,  9 Apr 2020 18:57:05 +0200 (CEST)
Date:   Thu, 9 Apr 2020 18:57:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH 2/4] btrfs-progs: fix TEST_TOP path drop extra forward
 slash
Message-ID: <20200409165705.GG5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
 <1585879843-17731-3-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585879843-17731-3-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 10:10:41AM +0800, Anand Jain wrote:
> From
> TEST_TOP="$TOP/tests/"
> to
> TEST_TOP="$TOP/tests"

So this basically repeats the diff

> Affected test cases are:
> tests/clean-tests.sh
> tests/cli-tests.sh
> tests/convert-tests.sh
> tests/fsck-tests.sh
> tests/fuzz-tests.sh
> tests/misc-tests.sh
> tests/mkfs-tests.sh

And this repeats the diffstat.

The changelog should explain why the change is made, summarize some key
points, etc.

I'll apply this patch and write a changelog but please try to improve
that. What works is to postpone sending the patches and read them after
a day or two, if it still makes sense then send it. Second look reveals
all the typos and missing information.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C650325942E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgIAPgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 11:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgIAPgb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 11:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB0A9AC85;
        Tue,  1 Sep 2020 15:36:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA9D2DA7CF; Tue,  1 Sep 2020 17:35:18 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:35:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: do not create raid sysfs entries under
 chunk_mutex
Message-ID: <20200901153518.GH28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1598961912.git.josef@toxicpanda.com>
 <4bf816d4109f4fa812074124a7672db1c5cb851c.1598961912.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf816d4109f4fa812074124a7672db1c5cb851c.1598961912.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 01, 2020 at 08:09:02AM -0400, Josef Bacik wrote:
> While running xfstests I got the following lockdep splat

Do you know which test was that? The stacktraces don't match any of the
currently open issues.
